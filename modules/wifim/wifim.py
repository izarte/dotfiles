#!/usr/bin/python

"""WiFi Manager

Wrapper for NetworkManager nmcli command to make more user friendly and
faster the process of connecting to a wifi access point.

Execution:
    sudo ./PATH_TO_SCRIPT/wifim.py

Recommended execution:
    1. Place script on '/usr/local/bin' or on whatever path (but make
    sure that the new path is added to the PATH environment variable).
    2. Remove '.py' extentension.
    3. Call 'wifim' from whatever path with root privileges: sudo wifim

OS Dependencies:
    - NetworkManager
"""

import sys
import tty
import subprocess
from enum import Enum, auto, unique
from pathlib import Path

def check_root() -> bool:
    """Check if script is being executed with root privileges

    returns:
        - boolean as True in case the script is being executed with root
        privileges. False otherwise.
    """
    wifim_path = Path('/etc/wifim')

    try:
        wifim_path.mkdir()
    except PermissionError:
            return False
    wifim_path.rmdir()
    return True


def get_access_points() -> list:
    """
    List all available access points on range and allow user to
    select one using arrow keys.

    return:
        - list of N dictionaries containing data of each access pointself.
        N is the number of available access points.
    """
    cmd = 'nmcli -c no -t dev wifi list --rescan yes'
    process = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE)
    output, error = process.communicate()
    access_points = []
    for ap in output.decode().strip().split('\n'):
        ap_line = ap.replace('\\:', '#').split(':')
        ap_data = {
            Ap_fields.IN_USE: ap_line[0],
            Ap_fields.BSSID: ap_line[1].replace('#', ':'),
            Ap_fields.SSID: ap_line[2],
            Ap_fields.MODE: ap_line[3],
            Ap_fields.CHAN: ap_line[4],
            Ap_fields.RATE: ap_line[5],
            Ap_fields.SIGNAL: ap_line[6],
            Ap_fields.BARS: ap_line[7],
            Ap_fields.SECURITY: ap_line[8]
        }
        access_points.append(ap_data)
    return access_points


def select_access_point(access_points: list) -> dict:
    """Display and select given access points.

    The user would be able to select a displayed access point usingarrow
    the arrow keys

    params:
        - access_points: list of dictionaries with each
        access point data such as SSID, mode, etc.

    returns:
        - dict containing selected access point data.
    """
    selector = 0
    display_access_points(access_points, selector, False)
    tty.setcbreak(sys.stdin)

    while True:
        key = detect_key()
        if key == Key.OTHER:
            continue
        if key == Key.UP:
            selector -= 1
        if key == Key.DOWN:
            selector += 1
        if key == Key.ENTER:
            break
        selector = display_access_points(access_points, selector, True)
    print()
    return access_points[selector]


def display_access_points(access_points: list, selector: int, init: bool) -> int:
    """Display given access points with fixed alignment.

    Helper function for 'select_access_point'. This function displays given
    access points and appends a selector that represents which line the user
    currently selecting.
    If selector is out of bounds, the function will:
        - In case 'selector >= len(access_points)', selector will be 0
        - In case 'selector < 0', selector will be 'len(access_points) - 1'

    params:
        - access_points: list of dictionaries with each
        access point data such as SSID, mode, etc.
        - selector: int with value of the line which should be
        selected.
        - init: boolen as True if its the first time displaying
        access points. False otherwise.
    
    returns:
        - int with fixed selector value.
    """
    # delete n previously printed lines
    if init:
        for _ in range(len(access_points) - 1):
            sys.stdout.write('\x1b[1A\x1b[2K')

    if selector >= len(access_points): selector = 0
    if selector < 0: selector = len(access_points) - 1

    output = ''
    spaces_per_field = calculate_spaces(access_points)
    for i, ap in enumerate(access_points):
        if (i == selector):
            output += SELECTOR
        else:
            output += SELECTOR_EMPTY

        for x, (_, value) in enumerate(ap.items()):
            output += value
            for _ in range(spaces_per_field[i][x] + 1):
                output += ' '
        output += '\n'
    output = output[:-1]
    print(output, end='\r')
    return selector


def calculate_spaces(access_points: list) -> list:
    """Calculate how many spaces each access point field should have

    Depending of the length for each field, calculate how many spaces requires
    each field from each access point so all fields of all access point will be
    aligned with each otherself.

    params:
        - access_points: list containing dictionaries with each
        access point data such as SSID, mode, etc.

    returns:
        - list of lists. Each inner list contains how many spaces have
        each field.
    """
    fields_max_len = [0] * len(access_points[0].keys())
    for ap in access_points:
        for i, (_, value) in enumerate(ap.items()):
            if len(value) > fields_max_len[i]:
                fields_max_len[i] = len(value)
    spaces_per_field = [
        [0 for _ in range(len(access_points[0]))] for _ in range(len(access_points))
    ]
    for ap, fields_length in zip(access_points, spaces_per_field):
        for i, (_, value) in enumerate(ap.items()):
            fields_length[i] = fields_max_len[i] - len(value)
    return spaces_per_field


def detect_key() -> Enum:
    """Read stdin

    returns:
        - KEY enum:
            - If user presses up arrow key, return 'KEY.up'
            - If user presses down arrow key, return 'KEY.down'
            - If user presses enter key, return 'KEY.return'
            - If user presses other key not mentioned above, return 'KEY.other'
    """
    pressed = ord(sys.stdin.read(1))
    if pressed == 27:
        pressed = ord(sys.stdin.read(1))
        if pressed == 91:
            pressed = ord(sys.stdin.read(1))
            if pressed == 65:
                return Key.UP
            if pressed == 66:
                return Key.DOWN
            return Key.OTHER
    if pressed == 10:
        return Key.ENTER
    return Key.OTHER


def connect_to_access_point(access_point: dict) -> bool:
    """Connect to given access point

    params:
        - access_point: dict of the requested access point to connect to.
    
    returns:
        - boolean as True if the connection was successfull. False otherwise.
    """
    cmd = 'nmcli dev wifi connect {}'.format(
        access_point[Ap_fields.SSID]
    )

    if ('WPA' in access_point[Ap_fields.SECURITY]):
        password = input('password: ')
        print()
        cmd += ' password {}'.format(password)
    
    process = subprocess.run(cmd.split(), capture_output=True)
    if process.returncode:
        print(process.stderr.decode()[:-1])
        return False
    return True


@unique
class Ap_fields(Enum):
    IN_USE = 'IN-USE'
    BSSID = 'BSSID',
    SSID = 'SSID',
    MODE = 'MODE',
    CHAN = 'CHAN',
    RATE = 'RATE',
    SIGNAL = 'SIGNAL',
    BARS = 'BARS'
    SECURITY = 'SECURITY'


class Key(Enum):
    UP = auto()
    DOWN = auto()
    ENTER = auto()
    OTHER = auto()


def main() -> int:
    if check_root():
        print('Execute this command WITHOUT root privileges!')
        return 1
    access_points = get_access_points()
    access_point = select_access_point(access_points)
    success = connect_to_access_point(access_point)
    if success:
        print('Successfully connected to {}'.format(
            access_point[Ap_fields.SSID]
        ))
        return 0
    print('Could not connect to {}'.format(
        access_point[Ap_fields.SSID]
    ))


SELECTOR = ' > |'
SELECTOR_EMPTY = '   |'

if __name__ == '__main__':
    sys.exit(main())


import sys
import tty
tty.setcbreak(sys.stdin)
while True:
    output = ord(sys.stdin.read(1))
    print(output, type(output))

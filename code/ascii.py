import sys

l = int(input())
h = int(input())
t = str(input())

alph = [str(input()) for i in range(h)]

for i in range(h):
    for char in t:
        if char >= 'a' and char <= 'z':
            x = ord(char) - ord('a')
        elif char >= 'A' and char <= 'Z':
            x = ord(char) - ord('A')
        else:
            x = ord('z') - ord('a') + 1

        for j in range(l):
            print(alph[i][x * l + j], end="")

    print("")

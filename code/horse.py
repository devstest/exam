import sys
import math

n = int(input())

horses = []

for i in range(n):
    pi = int(input())
    horses.append(pi)
horses.sort()
min = None

for i in range(0, n - 1):
    diff = int(abs(horses[i] - horses[i + 1]))
    if min is None:
        min = diff

    if diff < min:
        min = diff

print (min)

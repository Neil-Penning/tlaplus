import concurrent.futures
import math
import os
import datetime
PRIMES = [
        1190611,
        1190611**2,
        2016634099,
        2016634099**2,
        612169,
        612173,
        612181,
        612193,
        612217,
        612223,
        612229,
    ]

def is_prime(n):
    print(f'is_prime({n}) with pid:{os.getpid()} called by parent process {os.getppid()}. ')
    if n < 2:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False

    sqrt_n = int(math.floor(math.sqrt(n)))
    for i in range(3, sqrt_n + 1, 2):
        if n % i == 0:
            print(f'is_prime({n}) returned False with pid:{os.getpid()}')
            return False
    print('intermediate result: %d is prime:' %  n)
    print(f'is_prime({n}) returned True with pid:{os.getpid()}')
    return True

def main():
    with concurrent.futures.ProcessPoolExecutor() as executor:
        for i, prime in enumerate(executor.map(is_prime, PRIMES)):
            print('main loop printed: %d is prime: %s' % (PRIMES[i], prime))

if __name__ == '__main__':
    main()

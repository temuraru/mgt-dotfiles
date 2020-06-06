#!/usr/bin/python3

import onetimepass as otp
import os, sys, time, datetime
import pyperclip


def otpDecrypt():
    key = sys.argv[1] if sys.argv[1:] else 'EMAGOTPSECRET'
    my_secret = os.getenv(key, 'Secret_not_found_in_ENV') # ex: 'MFRGGZDFMZTWQ2LK' - exported previously with (eg): `export OTPSECRET='N3V3R G0nn4 G1v3 Y0u Up'`
    computeToken(key, my_secret)

    # refresh the token (and put it in clipboard) every 30 seconds
    while True:    
        seconds = int(time.time())
        retry = 30 - seconds % 30
        now = datetime.datetime.now()
        print('Date:',now.strftime("%Y-%m-%d %H:%M:%S"),'Refreshing token in',retry,'seconds!', end = " ")
        retries = 0
        while retries < retry:
            print(retry - retries, end = " ", flush=True)
            retries += 1
            time.sleep(1)
        print() # just a new line visual separator
        computeToken(key, my_secret)


def computeToken(key, my_secret):
    print('=======================') # another new line visual separator
    my_token = otp.get_totp(my_secret)
    print('OTP token for key',key, ':', "{:06d}".format(my_token))
    # copy the token to clipboard for faster usage
    pyperclip.copy("{:06d}".format(my_token)) 


if __name__ == '__main__':
    otpDecrypt()
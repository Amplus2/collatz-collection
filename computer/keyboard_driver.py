#!/usr/bin/env python3
from gpiozero import Button
from time import sleep
from keyboard import Controller, Key

kbd = Controller()

def check_key(gpio, key):
    if gpio.is_pressed:
        print('pressing something')
        kbd.press(key)
    else:
        kbd.release(key)

up = Button(17)
down = Button(27)
space = Button(22)

while True:
    check_key(up, Key.up)
    check_key(down, Key.down)
    check_key(space, Key.space)
    sleep(1)

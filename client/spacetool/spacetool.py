# -*- coding: utf-8 -*-
import math
import datetime
#planet sizes in kilometers (diameter)
earthD = 12756.0
marsD = 6794.0
jupiterD = 142796.0
saturnD = 120200.0
uranusD = 52640.0
neptuneD = 48600.0
targetD = 0

print(datetime.timedelta(seconds=377560005))

def begin():
    global targetD
    print("This tool helps to calculate pass by times and planet sizes in field of vision in screen.")
    inputstr = raw_input("Select the planet: earth, mars, jupiter, saturn, uranus, neptune : ")

    if inputstr == "earth":
        targetD = earthD
        askValues()
    elif inputstr == "mars":
        targetD = marsD
        askValues()
    elif inputstr == "jupiter":
        targetD = jupiterD
        askValues()
    elif inputstr == "saturn":
        targetD = saturnD
        askValues()
    elif inputstr == "uranus":
        targetD = uranusD
        askValues()
    elif inputstr == "neptune":
        targetD = neptuneD
        askValues()
    else:
        print("No planet with that name. Exiting.")

def askValues():
    d = raw_input("Insert distance to the planet during pass by in perpendicular angle in kilometers: ")
    fov = raw_input("Insert the angle of the camera in degrees: ")
    fov = math.radians(float(fov))
    velocity = raw_input("Insert the velocity of the spaceship in km/s: ")
    velocity = float(velocity)

    #do all calculations:
    fovAtPlanet = calcFoVAtD(fov, d)
    passbytime = calcPassByTime(fovAtPlanet, velocity)
    sizeRatio = calcSizeRatio(fovAtPlanet, targetD)
    widthOnScreen = calcWidthOnScreen(sizeRatio)

    #print the results
    printTime(passbytime)
    print("The size of the planet on the screen will be: " + unicode(widthOnScreen) + "px")

    #start again
    begin()

def printTime(secs):
    print("The pass by will take: ")
    print(str(datetime.timedelta(seconds=secs)))

#calculates the width of the field of vision at the distance d
def calcFoVAtD(angle, distance):
    width = math.tan(float(angle)/2.0)*float(distance)
    return width*2

def calcPassByTime(width, velocity):
    t = round(width/velocity)
    return t

def calcSizeRatio(width, planetD):
    return float(float(planetD)/float(width))

def calcWidthOnScreen(ratio):
    screenWidth = raw_input("Insert the width of the window in pixels: ")
    print(ratio)
    screenWidth = float(screenWidth)
    return round( ratio*screenWidth)



begin()



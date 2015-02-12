# -*- coding: utf-8 -*-
from django.db import models

# Create your models here.
class Rocket(models.Model):
    nextDestination = models.CharField(max_length=200)
    velocity = models.FloatField(default=11)
    estimatedTravelTime = models.FloatField()
    distanceTraveled = models.FloatField(default=19e9)
    distanceFromSun = models.FloatField(default=149600000)  #distance of the Earth
    pushes = models.FloatField(default=100)
    mass = models.FloatField(default=200)                   #mass of the rocket
    distanceToTarget = models.FloatField(default=0);
    ETAString = models.CharField(max_length=200, default="")


    def __unicode__(self):  # Python 3: def __str__(self):
        return "rocket"

#tells how many pushes the ship got in last second
class PushModel(models.Model):
    amount = models.FloatField(default=0)
    force = models.FloatField(default=0)

#defines properties of the different celestial objects which can be encountered in the the solar system
class CelestialObjectModel(models.Model):
    name = models.CharField(max_length=200)
    type = models.CharField(max_length=200)
    description = models.TextField(default="")
    distanceFromSun = models.FloatField(max_length=200, default=0)
    distanceFromEarth = models.FloatField(max_length=200, default=0)
    passageDistance = models.FloatField(default=500000)

    def __unicode__(self):  # Python 3: def __str__(self):
        return self.name

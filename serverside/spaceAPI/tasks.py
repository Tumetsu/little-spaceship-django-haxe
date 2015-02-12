# -*- coding: utf-8 -*-
from celery.task.schedules import crontab
from celery.decorators import periodic_task
from datetime import timedelta

from celery.utils.log import get_task_logger
from datetime import datetime

from spaceAPI.models import Rocket, PushModel, CelestialObjectModel

 
 
logger = get_task_logger(__name__)



# A periodic task that will run every minute (the symbol "*" means every)
#@periodic_task(run_every=timedelta(seconds=1))
def scraper_example():
    logger.info("Start task")
    now = datetime.now()
    result = scraper_calc(now.day, now.minute)
    logger.info("Task finished: result = %i" % result)


#ajetaan minuutin valein
def scraper_calc(a, b):
    return a + b

@periodic_task(run_every=timedelta(seconds=1))
def update_RocketModel():
    pushmodel = PushModel.objects.get()  #get amount of the latest pushes
    rocket = Rocket.objects.get()
    rocket.pushes = pushmodel.amount
    rocket.velocity += (pushmodel.force / rocket.mass) / 1000.0    #F=ma, m/s to km/s
    logger.debug("Velocity boost: result = %i" % ((pushmodel.force / rocket.mass) / 1000.0))

    rocket.distanceTraveled = rocket.distanceTraveled + rocket.velocity
    rocket.distanceFromSun = rocket.distanceFromSun + rocket.velocity

    #calculate ETA to the target
    try:
        target = CelestialObjectModel.objects.get(name=rocket.nextDestination)
        dist = target.distanceFromSun - rocket.distanceFromSun   #distance to the target
        rocket.estimatedTravelTime = dist / rocket.velocity
        rocket.distanceToTarget = dist
        rocket.ETAString = timedelta(seconds=dist / rocket.velocity)

    except CelestialObjectModel.DoesNotExist:
        #we couldn't find the target Celestial-body, lets not modify the ETA
        pass

    #reset push model
    pushmodel.amount = 0
    pushmodel.force = 0
    pushmodel.save()

    rocket.save()
    #logger.info("Rocket updated")


#calculate the new time estimation to the next target
def calculateEstimation(previous):
    return previous - 10
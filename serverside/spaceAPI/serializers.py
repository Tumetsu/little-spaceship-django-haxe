# -*- coding: utf-8 -*-
from spaceAPI.models import Rocket, PushModel, CelestialObjectModel
from rest_framework import serializers
from django.views.decorators.csrf import csrf_exempt


class RocketSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Rocket
        fields = ('velocity', 'nextDestination', 'estimatedTravelTime', 'distanceTraveled', 'pushes', 'distanceToTarget', 'ETAString', 'distanceFromSun',)
        read_only_fields = ('velocity','nextDestination', 'estimatedTravelTime', 'distanceTraveled', 'pushes','distanceToTarget', 'ETAString',)

@csrf_exempt
class PushSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = PushModel
        fields = ('amount','force',)
        read_only_fields = ('force',)

class PlanetSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = CelestialObjectModel
        fields = ('name','type', 'passageDistance', 'distanceFromSun', )

class DistanceSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = CelestialObjectModel
        fields = ('name', 'distanceFromSun', )
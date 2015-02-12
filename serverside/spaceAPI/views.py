# -*- coding: utf-8 -*-
from django.shortcuts import render
from spaceAPI.models import Rocket, PushModel, CelestialObjectModel
from spaceAPI.serializers import *
from rest_framework import viewsets
from rest_framework.views import APIView
from rest_framework import authentication, permissions
from rest_framework.response import Response
from django.http import Http404
from django.db.models import F
from django.utils.decorators import method_decorator
from rest_framework.response import Response
from rest_framework.reverse import reverse
from rest_framework import filters



# Create your views here.

class RocketViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = Rocket.objects.all()
    serializer_class = RocketSerializer

class APIRoot(APIView):
    def get(self, request):
        return Response({
            'rocket': reverse('RocketView', request=request),
            'pushes': reverse('PushesView', request=request)
        })

class PlanetView(APIView):
    def get(self, request, planetName):
        try:
            planet = CelestialObjectModel.objects.get(name=planetName)
            serializer = PlanetSerializer(planet, many=False)
            return Response(serializer.data)
        except CelestialObjectModel.DoesNotExist:
            raise Http404

#get information of the planet in this distance from sun:
class PlanetInformation(APIView):
     def get(self, request):
        dist = request.GET.get("distanceFromSun")
        try:
            planet = CelestialObjectModel.objects.get(distanceFromSun=dist)
            serializer = PlanetSerializer(planet, many=False)
            return Response(serializer.data)
        except CelestialObjectModel.DoesNotExist:
            raise Http404



#returns a list of distances to the all celestial bodies in order.
#palauta useiden juttujen datat tällä:
#http://stackoverflow.com/questions/18702300/return-results-from-multiple-models-with-django-rest-framework
class InitView(APIView):
    def get(self, request):
        try:
            #compose the response from multiple models:
            wholeResponse = {}
            planets = CelestialObjectModel.objects.all()
            planetsSerialized = DistanceSerializer(planets.order_by('distanceFromSun'))
            wholeResponse['celestialObjects'] = planetsSerialized.data


            return Response(wholeResponse)
        except CelestialObjectModel.DoesNotExist:
            raise Http404


class RocketView(APIView):
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)
    def get(self, request, format=None):
        rocket = Rocket.objects.first()
        serializer = RocketSerializer(rocket, many=False)

        return Response(serializer.data) #headers={'Access-Control-Allow-Origin':'*'}


class PushesView(APIView):
    permission_classes = (permissions.AllowAny,)    #VAIHDA AUTENTIKOITUUN MYÖHEMMIN

    @csrf_exempt
    def dispatch(self, request, *args, **kwargs):
        return super(PushesView, self).dispatch(request, *args, **kwargs)

    @csrf_exempt
    def get(self, request, format=None):
        pushes = PushModel.objects.first()
        serializer = PushSerializer(pushes, many=False)
        return Response(serializer.data) #headers={'Access-Control-Allow-Origin':'*'}

    @csrf_exempt
    def post(self, request, format=None):
        entries = []
        entries.append(request.DATA)
        #increment the amount of pushes by value given in request atomically
        #PushModel.objects.filter().update(amount=(F('amount')+request.DATA["amount"]))

        #take json-array of the pushes and take the forces:

        pushList = request.DATA["pushes"]
        forceCount = 0
        for x in pushList:
            forceCount += x["push"]

        #TEE TÄHÄN SYÖTTEEN OIKEELLISUUSTARKISTUS!!!!!!!!!!!!!
        pushModel = PushModel.objects.first()
        pushModel.amount += len(pushList)
        pushModel.force += forceCount
        pushModel.save()
        #PushModel.objects.filter().update(amount=(F('amount')+len(pushList)))
        #PushModel.objects.filter().update(force=(F('force')+forceCount))
        return Response("SUCCESS")

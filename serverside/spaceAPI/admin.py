from django.contrib import admin
from spaceAPI.models import Rocket, PushModel, CelestialObjectModel

# Register your models here.
admin.site.register(Rocket)
admin.site.register(PushModel)
admin.site.register(CelestialObjectModel)
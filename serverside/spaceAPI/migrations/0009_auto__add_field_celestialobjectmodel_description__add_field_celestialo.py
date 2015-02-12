# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding field 'CelestialObjectModel.description'
        db.add_column(u'spaceAPI_celestialobjectmodel', 'description',
                      self.gf('django.db.models.fields.TextField')(default=''),
                      keep_default=False)

        # Adding field 'CelestialObjectModel.distanceFromEarth'
        db.add_column(u'spaceAPI_celestialobjectmodel', 'distanceFromEarth',
                      self.gf('django.db.models.fields.FloatField')(default=0, max_length=200),
                      keep_default=False)


    def backwards(self, orm):
        # Deleting field 'CelestialObjectModel.description'
        db.delete_column(u'spaceAPI_celestialobjectmodel', 'description')

        # Deleting field 'CelestialObjectModel.distanceFromEarth'
        db.delete_column(u'spaceAPI_celestialobjectmodel', 'distanceFromEarth')


    models = {
        u'spaceAPI.celestialobjectmodel': {
            'Meta': {'object_name': 'CelestialObjectModel'},
            'description': ('django.db.models.fields.TextField', [], {'default': "''"}),
            'distanceFromEarth': ('django.db.models.fields.FloatField', [], {'default': '0', 'max_length': '200'}),
            'distanceFromSun': ('django.db.models.fields.FloatField', [], {'default': '0', 'max_length': '200'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'type': ('django.db.models.fields.CharField', [], {'max_length': '200'})
        },
        u'spaceAPI.pushmodel': {
            'Meta': {'object_name': 'PushModel'},
            'amount': ('django.db.models.fields.FloatField', [], {'default': '0'}),
            'force': ('django.db.models.fields.FloatField', [], {'default': '0'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'})
        },
        u'spaceAPI.rocket': {
            'Meta': {'object_name': 'Rocket'},
            'distanceTraveled': ('django.db.models.fields.FloatField', [], {'default': '19000000000.0'}),
            'estimatedTravelTime': ('django.db.models.fields.FloatField', [], {}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'mass': ('django.db.models.fields.FloatField', [], {'default': '200'}),
            'nextDestination': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'pushes': ('django.db.models.fields.FloatField', [], {'default': '100'}),
            'velocity': ('django.db.models.fields.FloatField', [], {'default': '11'})
        }
    }

    complete_apps = ['spaceAPI']
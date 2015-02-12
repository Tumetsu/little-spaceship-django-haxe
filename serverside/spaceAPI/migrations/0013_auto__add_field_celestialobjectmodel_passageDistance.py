# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding field 'CelestialObjectModel.passageDistance'
        db.add_column(u'spaceAPI_celestialobjectmodel', 'passageDistance',
                      self.gf('django.db.models.fields.FloatField')(default=500000),
                      keep_default=False)


    def backwards(self, orm):
        # Deleting field 'CelestialObjectModel.passageDistance'
        db.delete_column(u'spaceAPI_celestialobjectmodel', 'passageDistance')


    models = {
        u'spaceAPI.celestialobjectmodel': {
            'Meta': {'object_name': 'CelestialObjectModel'},
            'description': ('django.db.models.fields.TextField', [], {'default': "''"}),
            'distanceFromEarth': ('django.db.models.fields.FloatField', [], {'default': '0', 'max_length': '200'}),
            'distanceFromSun': ('django.db.models.fields.FloatField', [], {'default': '0', 'max_length': '200'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'passageDistance': ('django.db.models.fields.FloatField', [], {'default': '500000'}),
            'type': ('django.db.models.fields.CharField', [], {'max_length': '200'})
        },
        u'spaceAPI.pushmodel': {
            'Meta': {'object_name': 'PushModel'},
            'amount': ('django.db.models.fields.FloatField', [], {'default': '0'}),
            'force': ('django.db.models.fields.FloatField', [], {'default': '0'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'})
        },
        u'spaceAPI.rocket': {
            'ETAString': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '200'}),
            'Meta': {'object_name': 'Rocket'},
            'distanceFromSun': ('django.db.models.fields.FloatField', [], {'default': '149600000'}),
            'distanceToTarget': ('django.db.models.fields.FloatField', [], {'default': '0'}),
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
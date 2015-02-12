# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding field 'PushModel.amount'
        db.add_column(u'spaceAPI_pushmodel', 'amount',
                      self.gf('django.db.models.fields.FloatField')(default=0),
                      keep_default=False)


    def backwards(self, orm):
        # Deleting field 'PushModel.amount'
        db.delete_column(u'spaceAPI_pushmodel', 'amount')


    models = {
        u'spaceAPI.pushmodel': {
            'Meta': {'object_name': 'PushModel'},
            'amount': ('django.db.models.fields.FloatField', [], {'default': '0'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'})
        },
        u'spaceAPI.rocket': {
            'Meta': {'object_name': 'Rocket'},
            'distanceTraveled': ('django.db.models.fields.FloatField', [], {'default': '19000000000.0'}),
            'estimatedTravelTime': ('django.db.models.fields.FloatField', [], {}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'nextDestination': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'pushes': ('django.db.models.fields.FloatField', [], {'default': '100'}),
            'velocity': ('django.db.models.fields.IntegerField', [], {'default': '11'})
        }
    }

    complete_apps = ['spaceAPI']
# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'PushModel'
        db.create_table(u'spaceAPI_pushmodel', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
        ))
        db.send_create_signal(u'spaceAPI', ['PushModel'])


    def backwards(self, orm):
        # Deleting model 'PushModel'
        db.delete_table(u'spaceAPI_pushmodel')


    models = {
        u'spaceAPI.pushmodel': {
            'Meta': {'object_name': 'PushModel'},
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
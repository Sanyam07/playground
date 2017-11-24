from django.db import models
from django.contrib.postgres.fields import JSONField

class JoystickDataModel(models.Model):
    id = models.AutoField(primary_key=True)
    data = JSONField('data')
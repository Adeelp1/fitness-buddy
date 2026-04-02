from django.contrib.auth.models import User as user_login
from django.db import models

# Create your models here.
class Trainers(models.Model):
    name = models.CharField(max_length=50)
    email = models.CharField(max_length=100)
    photo = models.CharField(max_length=200)
    p_no = models.CharField(max_length=200)
    place = models.CharField(max_length=100)
    post = models.CharField(max_length=100)
    pin = models.CharField(max_length=100)
    join_date = models.CharField(max_length=100)
    LOGIN = models.ForeignKey(user_login, on_delete=models.CASCADE)
    bio = models.CharField(max_length=500)

class Batch(models.Model):
    batch = models.CharField(max_length=100)
    from_time =  models.CharField(max_length=100)
    to_time =  models.CharField(max_length=100)

class Users(models.Model):
    name = models.CharField(max_length=50)
    email = models.CharField(max_length=100)
    phone = models.CharField(max_length=100)
    gender = models.CharField(max_length=10)
    photo = models.CharField(max_length=200)
    dob = models.CharField(max_length=100)
    bio = models.CharField(max_length=500)
    level = models.CharField(max_length=50)
    LOGIN = models.ForeignKey(user_login, on_delete=models.CASCADE)
    BATCH = models.ForeignKey(Batch, on_delete=models.CASCADE)

class Event(models.Model):
    title = models.CharField(max_length=100)
    description = models.CharField(max_length=1000)
    venue = models.CharField(max_length=100)
    date = models.CharField(max_length=100)
    time = models.CharField(max_length=100)

class AllocateBatchTrainer(models.Model):
    BATCH = models.ForeignKey(Batch, on_delete=models.CASCADE)
    TRAINER = models.ForeignKey(Trainers, on_delete=models.CASCADE)

class AllocateBatchUser(models.Model):
    BATCH_TRAINER = models.ForeignKey(AllocateBatchTrainer, on_delete=models.CASCADE)
    USER = models.ForeignKey(Users, on_delete=models.CASCADE)
    date = models.CharField(max_length=100)

class Payment(models.Model):
    USER = models.ForeignKey(Users, on_delete=models.CASCADE)
    date = models.CharField(max_length=100)
    amount = models.CharField(max_length=100)
    mode=models.CharField(max_length=200)

class WorkoutVideo(models.Model):
    ALLOCATE_BATCH_USER = models.ForeignKey(AllocateBatchUser, on_delete=models.CASCADE)
    video = models.CharField(max_length=800)
    title = models.CharField(max_length=200)
    date = models.CharField(max_length=100)

class Tips(models.Model):
    ALLOCATE_BATCH_USER = models.ForeignKey(AllocateBatchUser, on_delete=models.CASCADE)
    title = models.CharField(max_length=200)
    tips = models.CharField(max_length=100)
    date = models.CharField(max_length=100)

class DietPlanes(models.Model):
    ALLOCATE_BATCH_USER = models.ForeignKey(AllocateBatchUser, on_delete=models.CASCADE)
    food_name = models.CharField(max_length=100)
    details = models.CharField(max_length=200)
    time = models.CharField(max_length=100)
    day = models.CharField(max_length=100)

    

class Chat(models.Model):
    TRAINER = models.ForeignKey(Trainers, on_delete=models.CASCADE)
    USER = models.ForeignKey(Users, on_delete=models.CASCADE)
    date = models.CharField(max_length=100)
    type = models.CharField(max_length=100)
    message = models.CharField(max_length=1000)

class HealthDetails(models.Model):
    USER = models.ForeignKey(Users, on_delete=models.CASCADE)
    title = models.CharField(max_length=200)
    details = models.CharField(max_length=500)
    date = models.CharField(max_length=100)
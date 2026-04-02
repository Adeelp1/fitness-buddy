"""FitnessBuddy URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path

from myapp import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('admin_home',views.admin_home),
    path('',views.logins),
    path('logins_post', views.logins_post),
    path('logout', views.logout_view),
    path('forgotpassword',views.forgotpassword),
    path('forgotpasswordbuttonclick',views.forgotpasswordbuttonclick),
    path('otp',views.otp),
    path('otpbuttonclick',views.otpbuttonclick),
    path('forgotpswdpswed',views.forgotpswdpswed),
    path('forgotpswdpswedbuttonclick',views.forgotpswdpswedbuttonclick),
    path('forgotemail', views.forgotemail),
    path('forgotpass', views.forgotpass),
    path('batchAlocationTrainer/<id>', views.batchAlocationTrainer),
    path('viewAllocatedBatch', views.viewAllocatedBatch),
    path('removeAllocatedBatch/<id>', views.removeAllocatedBatch),
    path('AllocateUserToTrainer/<id>', views.AllocateUserToTrainer),
    path('addBatch', views.addBatch),
    path('addBatch_post', views.addBatch_post),
    path('viewBatch', views.viewBatch),
    path('ViewBatch_delete/<id>',views.ViewBatch_delete),
    path('editBatch/<id>', views.editBatch),
    path('editBatch_post/<id>', views.editBatch_post),
    path('change_password', views.changePassword),
    path('changePassword_post', views.changePassword_post),
    path('addEvent', views.addEvent),
    path('addEvent_post', views.addEvent_post),
    path('viewEvent', views.viewEvent),
    path('viewEvent_delete/<id>', views.viewEvent_delete),
    path('editEvent/<id>', views.editEvent),
    path('editEvent_post/<id>', views.editEvent_post),
    path('view_payment', views.viewPayment),
    path('addTrainer', views.addTrainer),
    path('addTrainer_post', views.addTrainer_post),
    path('editTrainer/<id>', views.editTrainer),
    path('editTrainer_post/<id>', views.editTrainer_post),
    path('userBatchAllocation', views.userBatchAllocation),
    path('viewAllocatedTrainer/<id>', views.viewAllocatedTrainer),
    path('viewTrainer',views.viewTrainer),
    path('viewTrainer_delete/<id>', views.viewTrainer_delete),
    path('viewUsers', views.viewUsers),
    path('change_password_post',views.change_password_post),
    path('change_password',views.change_password),
    path('allocate_batch_to_trainer/<id>', views.allocate_batch_to_trainer),
    path('allocate_user_to_trainer/<id>', views.allocate_user_to_trainer),
    path('deleteAllocatedTrainer/<id>', views.deleteAllocatedTrainer),
#     TRAINER
    path('trainer_home', views.trainer_home),
    path('provideDietPlans', views.provideDietPlans),
    path('add_diet_plans/<id>', views.add_diet_plans),
    path('add_diet_plans_post', views.add_diet_plans_post),
    path('delete_diet_plan/<id>', views.delete_diet_plan),
    path('tipsAdd/<id>', views.tipsAdd),
    path('tipsAdd_post/<id>', views.tipsAdd_post),
    path('tipsEdit', views.tipsEdit),
    path('tipsEdit_post', views.tipsEdit_post),
    path('tipsView', views.tipsView),
    path('deleteTips/<id>', views.deleteTips),
    path('viewAllocatedBatchTrainer',views.viewAllocatedBatchTrainer),
    path('viewChat',views.viewChat),
    path('viewHealthDetails',views.viewHealthDetails),
    path('viewMembers/<id>',views.viewMembers),
    path('viewProfile',views.viewProfile),
    path('workoutVideoAdd/<id>',views.workoutVideoAdd),
    path('workoutVideoAdd_post/<id>', views.workoutVideoAdd_post),
    path('workoutVideoEdit/<id>',views.workoutVideoEdit),
    path('workoutVideoEdit_post/<id>', views.workoutVideoEdit_post),
    path('workoutVideoView/<id>',views.workoutVideoView),
    path('deleteWorkoutVideo/<id>', views.deleteWorkoutVideo),
    path('chat/<u>', views.chat),
    path('chatsnd/<u>', views.chatsnd),
    path('chatrply', views.chatrply),
    path('change_trainer_password', views.change_trainer_password),
    path('change_trainer_password_post', views.change_trainer_password_post),
#     USER
    path('user_login', views.user_login),
    path('user_registration', views.user_registration),
    path('change_password_user', views.change_password_user),
    path('view_tips', views.view_tips),#adeel
    path('view_workout_video', views.view_workout_video),#adeel
    path('view_trainer', views.view_trainer),#adeel
    path('view_dietplans', views.view_dietplans),
    path('view_events', views.view_events),
    path('view_payments', views.view_payments),
    path('view_health_details', views.view_health_details),
    path('get_batches', views.get_batches),
    path('add_health_details',views.add_health_details),
    path('update_health_details',views.update_health_details),
    path('delete_health_details',views.delete_health_details),
    path('view_profile',views.view_profile),
    path('user_viewchat',views.user_viewchat),
    path('user_sendchat',views.user_sendchat),
    path('make_payment',views.make_payment),
    path('edit_profile',views.edit_profile),
]

urlpatterns += static(settings.MEDIA_URL,document_root =settings.MEDIA_ROOT)
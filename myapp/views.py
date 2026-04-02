import random
import smtplib
from datetime import datetime

from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.hashers import make_password, check_password
from django.contrib.auth.models import Group, User
from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect

from myapp.models import *

# Create your views here.

def logins(request):
    return render(request,"admin/login_page.html")

def logins_post(request):

    username = request.POST['textfield']
    password = request.POST['textfield2']

    user = authenticate(request, username=username, password=password)

    if user is not None:
        if user.is_superuser:
            login(request, user)
            return redirect('/admin_home')

        elif user.groups.filter(name="trainer").exists():
            login(request, user)
            request.session['tid'] = Trainers.objects.get(LOGIN_id=user.id).id
            return redirect('/trainer_home')

    return HttpResponse("<script>alert('Invalid username or password'); window.location='/';</script>")

def logout_view(request):
    logout(request)
    return HttpResponse("<script>window.location='/'</script>")

def forgotpassword(request):
    return render(request,"forgotpassword.html")
def forgotpasswordbuttonclick(request):
    email = request.POST['textfield']
    if User.objects.filter(username=email).exists():
        from email.mime.text import MIMEText
        from email.mime.multipart import MIMEMultipart

        # ✅ Gmail credentials (use App Password, not real password)
        sender_email = "fitnessbuddy.admin@gmail.com"
        receiver_email = email  # change to actual recipient
        app_password = "fqvi eujj wzpd ehmg"  # App Password from Google
        pwd = str(random.randint(1100,9999))  # Example password to send
        request.session['otp'] = pwd
        request.session['email'] = email

        # Setup SMTP
        server = smtplib.SMTP("smtp.gmail.com", 587)
        server.starttls()
        server.login(sender_email, app_password)

        # Create the email
        msg = MIMEMultipart("alternative")
        msg["From"] = sender_email
        msg["To"] = receiver_email
        msg["Subject"] = "Your OTP"

        # Plain text (backup)
        # text = f"""
        # Hello,

        # Your password for Smart Donation Website is: {pwd}

        # Please keep it safe and do not share it with anyone.
        # """

        # HTML (attractive)
        html = f"""
        <html>
          <body style="font-family: Arial, sans-serif; color: #333;">
            <h2 style="color:#2c7be5;">Wastemanagement</h2>
            <p>Hello,</p>
            <p>Your OTP is:</p>
            <p style="padding:10px; background:#f4f4f4; 
                      border:1px solid #ddd; 
                      display:inline-block;
                      font-size:18px;
                      font-weight:bold;
                      color:#2c7be5;">
              {pwd}
            </p>
            <p>Please keep it safe and do not share it with anyone.</p>
            <hr>
            <small style="color:gray;">This is an automated email from Wastemanagement System.</small>
          </body>
        </html>
        """

        # Attach both versions
        # msg.attach(MIMEText(text, "plain"))
        msg.attach(MIMEText(html, "html"))

        # Send email
        server.send_message(msg)
        print("✅ Email sent successfully!")

        # Close connection
        server.quit()
        return HttpResponse("<script>window.location='/otp'</script>")
    else:
        return HttpResponse("<script>alert('Email not found');window.location='/forgotpassword'</script>")


def otp(request):
    return render(request,"otp.html")
def otpbuttonclick(request):
    otp  = request.POST["textfield"]
    if otp == str(request.session['otp']):
        return HttpResponse("<script>window.location='/forgotpswdpswed'</script>")
    else:
        return HttpResponse("<script>alert('incorrect otp');window.location='/otp'</script>")

def forgotpswdpswed(request):
    return render(request,"forgotpswdpswed.html")
def forgotpswdpswedbuttonclick(request):
    np = request.POST["password"]
    User.objects.filter(username=request.session['email']).update(password=make_password(np))
    return HttpResponse("<script>alert('password has been changed');window.location='/' </script>")

# for mobile

def forgotemail(request):
    import random
    import smtplib
    email = request.POST['email']
    print(email)
    data = User.objects.filter(username = email)
    print(data)
    if data.exists():
        otp = str(random.randint(000000,999999))    
        print(otp)
        #*✨ Python Email Codeimport smtplib*

        from email.mime.text import MIMEText
        from email.mime.multipart import MIMEMultipart

        # ✅ Gmail credentials (use App Password, not real password)
        try:
            sender_email = "fitnessbuddy.user@gmail.com"
            receiver_email = email  # change to actual recipient
            app_password = "kwqv vpck ljrh nlhc"
            # Setup SMTP
            server = smtplib.SMTP("smtp.gmail.com", 587)
            server.starttls()
            server.login(sender_email, app_password)

            # Create the email
            msg = MIMEMultipart("alternative")
            msg["From"] = sender_email
            msg["To"] = receiver_email
            msg["Subject"] = "🔑 Forgot Password "

            # Plain text (backup)
            # text = f"""
            # Hello,

            # Your password for Smart Donation Website is: {pwd}

            # Please keep it safe and do not share it with anyone.
            # """

            # HTML (attractive)
            html =  f"""
                <!DOCTYPE html>
                <html>
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Password Reset OTP</title>
                </head>
                <body style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
                            line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
                    
                    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
                                padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
                        <h1 style="color: white; margin: 0; font-size: 28px;">
                            🔐 Smart Donation
                        </h1>
                    </div>
                    
                    <div style="background-color: #f9f9f9; padding: 40px 30px; border-radius: 0 0 10px 10px; 
                                border: 1px solid #eaeaea;">
                        
                        <h2 style="color: #2d3748; margin-top: 0;">Password Reset Request</h2>
                        
                        <p style="color: #4a5568; font-size: 16px;">
                            Hello,
                        </p>
                        
                        <p style="color: #4a5568; font-size: 16px;">
                            You requested to reset your password. Use the OTP below to proceed:
                        </p>
                        
                        <div style="background: white; border-radius: 8px; padding: 20px; 
                                    text-align: center; margin: 30px 0; border: 2px dashed #cbd5e0;">
                            <div style="font-size: 32px; font-weight: bold; letter-spacing: 10px; 
                                        color: #2c7be5; margin: 10px 0;">
                                {otp}
                            </div>
                            <div style="font-size: 14px; color: #718096; margin-top: 10px;">
                                (Valid for 10 minutes)
                            </div>
                        </div>
                        
                        <p style="color: #4a5568; font-size: 16px;">
                            Enter this code on the password reset page to complete the process.
                        </p>
                        
                        <div style="background-color: #fef3c7; border-left: 4px solid #d97706; 
                                    padding: 15px; margin: 25px 0; border-radius: 4px;">
                            <p style="color: #92400e; margin: 0; font-size: 14px;">
                                ⚠️ <strong>Security tip:</strong> Never share this OTP with anyone. 
                                Our team will never ask for your password or OTP.
                            </p>
                        </div>
                        
                        <p style="color: #718096; font-size: 14px;">
                            If you didn't request this password reset, please ignore this email or 
                            contact our support team if you have concerns.
                        </p>
                        
                        <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 30px 0;">
                        
                        <p style="text-align: center; color: #a0aec0; font-size: 12px;">
                            This is an automated email from Smart Donation System.<br>
                            © {datetime.now().year} Smart Donation. All rights reserved.
                        </p>
                        
                    </div>
                </body>
                </html>
                """

            # Attach both versions
            # msg.attach(MIMEText(text, "plain"))
            msg.attach(MIMEText(html, "html"))

            # Send email
            server.send_message(msg)
            print("✅ Email sent successfully!",otp)

            # Close connection
            server.quit()
        
        except Exception as e:
            print("❌ Error loading email credentials:", e)
            return JsonResponse({'status':"ok",'otpp':otp})
        
        return JsonResponse({'status':'ok','otpp':otp})
    return JsonResponse({'status':"not found"})

def forgotpass(request):
    email = request.POST['email']
    npass = request.POST['password']
    cpass = request.POST['confirmpassword']
    print(email,npass,cpass)
    if npass == cpass:
        User.objects.filter(username=email).update(password = make_password(npass))
        return JsonResponse({'status': 'ok'})
    return JsonResponse({'status':'invalid'})






# ADMIN MODULE

def admin_home(request):
    return render(request,"admin/index.html")


def viewTrainer(request):
    data = Trainers.objects.all()
    return render(request, "admin/view_trainer.html", {"data": data})

def viewTrainer_delete(request, id):
    Trainers.objects.get(id=id).delete()
    return HttpResponse("<script>alert('deleted'); window.location='/admin_home'</script>")

def addTrainer(request):
    return render(request, "admin/trainer_add.html")

def addTrainer_post(request):
    name = request.POST['textfield1']
    place = request.POST['textfield2']
    phone = request.POST['textfield3']
    email = request.POST['textfield4']
    post = request.POST['textfield5']
    pin = request.POST['textfield6']
    join_date = request.POST['textfield8']
    bio = request.POST['textfield9']
    image=request.FILES['photo']
    fs=FileSystemStorage()
    path=fs.save(image.name,image)
    if User.objects.filter(username=email).exists():
        return HttpResponse("<script>alert('exist'); window.location='admin_home'</script>")

    password=random.randint(0000000000,9999999999)
    print(password)

    obj1=User()
    obj1.username=email
    obj1.password=make_password(str(password))
    obj1.save()
    obj1.groups.add(Group.objects.get(name='trainer'))

    obj = Trainers()
    obj.name = name
    obj.place = place
    obj.p_no = phone
    obj.email = email
    obj.post = post
    obj.pin = pin
    obj.photo = fs.url(path)
    obj.join_date = join_date
    obj.bio = bio
    obj.LOGIN_id=obj1.id
    obj.save()

    return HttpResponse("<script>alert('added'); window.location='admin_home'</script>")


def editTrainer(request,id):
    data=Trainers.objects.get(id=id)
    return render(request, "admin/trainer_edit.html",{'data':data})

def editTrainer_post(request,id):
    name = request.POST['textfield1']
    place = request.POST['textfield2']
    phone = request.POST['textfield3']
    email = request.POST['textfield4']
    post = request.POST['textfield5']
    pin = request.POST['textfield6']
    if 'textfield7' in request.FILES:
        photo = request.FILES['textfield7']
        fs=FileSystemStorage()
        path=fs.save(photo.name,photo)
        Trainers.objects.filter(id=id).update(photo=fs.url(path))
    join_date = request.POST['textfield8']
    bio = request.POST['textfield9']
    if Trainers.objects.filter(name=name,
        email=email,
        p_no=phone,
        place=place,
        post=post,
        pin=pin,
        join_date=join_date,
        bio=bio).exists():
        return HttpResponse("<script> alert('Exist'); window.location='/viewTrainer'</script>")

    Trainers.objects.filter(id=id).update(
        name=name,
        email=email,
        p_no=phone,
        place=place,
        post=post,
        pin=pin,
        join_date=join_date,
        bio=bio
    )

    return HttpResponse("<script> alert('Edited'); window.location='/viewTrainer'</script>")




def batchAlocationTrainer(request, id):
    data = Batch.objects.all()
    request.session['trainerId'] = id
    return render(request, "admin/Batch_alocation_to_trainer.html", {"data": data})

def viewAllocatedBatch(request):
    data = AllocateBatchTrainer.objects.all()
    return render(request, "admin/Batch_remove_from_trainer.html", {"data": data})

def removeAllocatedBatch(request,id):
    batch = AllocateBatchTrainer.objects.get(id=id)
    batch.delete()

    return HttpResponse("<script>alert('batch removed');window.location='/batchRemoveFromTrainer';</script>")

def AllocateUserToTrainer(request, id):
    data = AllocateBatchTrainer.objects.all()
    request.session['userId'] = id
    return render(request, "admin/user_allocation_to_trainer.html", {"data": data})


def addBatch(request):
    return render(request, "admin/Batch_Management_add.html")

def addBatch_post(request):
    batch=request.POST['textfield1']
    from_time = request.POST['textfield2']
    to_time = request.POST['textfield3']

    if Batch.objects.filter(
        batch=batch,
        from_time=from_time,
        to_time=to_time
    ).exists():
        return HttpResponse("<script>alert('Batch already exists'); window.location='/addBatch'</script>")

    obj=Batch()
    obj.batch=batch
    obj.from_time = from_time
    obj.to_time = to_time
    obj.save()

    return HttpResponse("<script>alert('added'); window.location='/admin_home'</script>")


def viewBatch(request):
    data=Batch.objects.all()
    return render(request, "admin/Batch_Management_View.html",{"data":data})

def ViewBatch_delete(request,id):
    Batch.objects.get(id=id).delete()
    return HttpResponse("<script>alert('Deleted'); window.location='/admin_home'</script>")


def editBatch(request,id):
    data = Batch.objects.get(id=id)
    return render(request, "admin/Batch_Management_edit.html", {'data': data})

def editBatch_post(request,id):
    batch = request.POST['textfield1']
    from_time = request.POST['textfield2']
    to_time = request.POST['textfield3']

    if Batch.objects.filter(
        batch=batch,
        from_time=from_time,
        to_time=to_time
    ).exists():
        return HttpResponse("<script>alert('Batch already exists'); window.location='/editBatch/{id}'</script>")

    Batch.objects.filter(id=id).update(
        batch=batch,
        from_time=from_time,
        to_time=to_time
    )
    return HttpResponse("<script>alert('edited'); window.location='/admin_home'</script>")


def changePassword(request):
    return render(request, "admin/Change_password.html")

def changePassword_post(request): # .......................................................................................................
    return HttpResponse("Changed")


def addEvent(request):
    return render(request, "admin/Event_Management_add.html")

def addEvent_post(request):
    title = request.POST['textfield1']
    description = request.POST['textarea2']
    venue = request.POST['textfield3']
    date = request.POST['textfield4']
    time = request.POST['textfield5']

    if Event.objects.filter(
        title=title,
        description=description,
        venue=venue,
        date=date,
        time=time
    ).exists():
        return HttpResponse("<script>alert('Event already exists'); window.location='/addEvent'</script>")

    obj = Event()
    obj.title = title
    obj.description = description
    obj.venue = venue
    obj.date = date
    obj.time = time
    obj.save()

    return HttpResponse("added")


def viewEvent(request):
    data = Event.objects.all()
    return render(request, "admin/Event_Management_view.html", {"data": data})

def viewEvent_delete(request, id):
    Event.objects.get(id=id).delete()
    return HttpResponse("deleted")


def editEvent(request, id):
    data = Event.objects.get(id=id)
    return render(request, "admin/Event_Management_edit.html", {'data': data})

def editEvent_post(request, id):
    title = request.POST['textfield1']
    description = request.POST['textarea']
    venue = request.POST['textfield2']
    date = request.POST['textfield3']
    time = request.POST['textfield4']

    if Event.objects.filter(
        title=title,
        description=description,
        venue=venue,
        date=date,
        time=time
    ).exists():
        return HttpResponse("<script>alert('Event already exists'); window.location='/editEvent/{id}'</script>")

    Event.objects.filter(id=id).update(
        title=title,
        description=description,
        venue=venue,
        date=date,
        time=time
    )


    return HttpResponse("<script>alert('edited'); window.location='/admin_home'</script>")



def viewPayment(request):
    data = Payment.objects.all()
    return render(request, "admin/view_payment_report.html", {"data": data})

def userBatchAllocation(request):
    return render(request, "admin/User_batch_allocation.html")

def viewAllocatedTrainer(request, id):
    data = AllocateBatchUser.objects.filter(USER_id=id)
    return render(request, "admin/View_allocated_trainer.html", {"data": data, 'id': id})

def view_Batch(request):
    data=Batch.objects.all()
    return render(request, "admin/Batchview.html",{"data":data})

def viewUsers(request):
    data = Users.objects.all()
    return render(request, "admin/View_users.html", {"data":data})

def change_password(request):
    return render(request,'admin/Change_password.html')

def change_password_post(request):
    current=request.POST['textfield']
    new=request.POST['textfield2']
    confirm=request.POST['textfield3']
    if new!=confirm:
        return HttpResponse("<script>alert('password mismatch'); window.location='/admin_home'</script>")

    data=check_password(current,request.user.password)
    if data:
        user=request.user
        user.set_password(new)
        user.save()
        return HttpResponse("<script>alert('updated'); window.location='/admin_home'</script>")
    return HttpResponse("<script>alert('invalid'); window.location='/admin_home'</script>")

def allocate_batch_to_trainer(request, id):
    obj = AllocateBatchTrainer()
    obj.BATCH_id = id
    obj.TRAINER_id = request.session['trainerId']
    obj.save()
    return  HttpResponse("<script>alert('Allocated Successfully');window.location='/viewTrainer';</script>")

def allocate_user_to_trainer(request, id):
    obj = AllocateBatchUser()
    obj.BATCH_TRAINER_id = id
    obj.USER_id = request.session['userId']
    obj.date = datetime.now().date()
    obj.save()
    return HttpResponse("<script>alert('Allocated Successfully');window.location='/viewUsers';</script>")

def deleteAllocatedTrainer(request, id):
    BatchUser = AllocateBatchUser.objects.get(id=id)
    BatchUser.delete()

    return HttpResponse("<script>alert('Allocated trainer deleted');window.location='/viewUsers';</script>")





# TRAINER MODULE
def trainer_home(request):
    return render(request, 'trainer/index.html')

def provideDietPlans(request):
    data = DietPlanes.objects.all()
    return render(request, 'trainer/view_diet_plans.html', {"data": data})

def add_diet_plans_post(request):
    food_name = request.POST['food_name']
    details = request.POST['details']
    time = request.POST['time']
    day = request.POST['day']
    id = request.POST.get('id')

    if DietPlanes.objects.filter(
        food_name=food_name,
        details=details,
        time=time,
        day=day,
        ALLOCATE_BATCH_USER_id=id
    ).exists():
        return HttpResponse("<script>alert('Diet Plan already exists');window.location='/add_diet_plans/{id}';</script>")

    obj = DietPlanes()
    obj.ALLOCATE_BATCH_USER_id = id
    obj.food_name = food_name
    obj.details = details
    obj.time = time
    obj.day = day
    obj.save()

    return HttpResponse("<script>alert('Diet Plan Added');window.location='/provideDietPlans';</script>")

def add_diet_plans(request, id):
    # data = Users.objects.all()
    return render(request, 'trainer/add_diet_plnans.html', {"id":id})

def delete_diet_plan(request, id):
    DietPlanes.objects.get(id=id).delete()
    return HttpResponse("<script>alert('deleted'); window.location='/provideDietPlans';</script>")

def tipsAdd(request, id):
    return render(request, 'trainer/tips_add.html', {"id":id})

def tipsAdd_post(request, id):
    title = request.POST['textfield1']
    tips = request.POST['textfield2']
    date = request.POST['textfield3']

    if Tips.objects.filter(
        title=title,
        tips=tips,
        date=date,
        ALLOCATE_BATCH_USER_id=id
    ).exists():
        return HttpResponse("<script>alert('Tips already exists');window.location='/tipsAdd/{id}';</script>")

    obj = Tips()
    obj.ALLOCATE_BATCH_USER_id = id
    obj.title = title
    obj.tips = tips
    obj.date = date
    obj.save()

    return HttpResponse("<script>alert('Tips Added');window.location='/viewAllocatedBatchTrainer';</script>")

def tipsEdit(request, id):
    data = Tips.objects.get(id=id)
    return render(request, 'trainer/tips_edit.html', {"data": data})

def tipsEdit_post(request, id):
    title = request.POST['textfield1']
    tips = request.POST['textfield2']
    date = datetime.now().date()

    if Tips.objects.filter(
        title=title,
        tips=tips,
        date=date,
        ALLOCATE_BATCH_USER_id=id
    ).exists():
        return HttpResponse("<script>alert('Tips already exists');window.location='/tipsEdit/{id}';</script>")

    # update
    Tips.objects.filter(id=id).update(
        title = title,
        tips = tips,
        date = date
    )
    return HttpResponse("<script>alert('Tip edited');window.location='/tipsView';</script>")


def tipsView(request):
    data = Tips.objects.all()
    return render(request, 'trainer/tips_view.html', {"data": data})

def deleteTips(request, id):
    Tips.objects.get(id=id).delete()
    return HttpResponse("<script>alert('deleted'); window.location='/tipsView';</script>")


def viewAllocatedBatchTrainer(request):
    data = AllocateBatchTrainer.objects.filter(TRAINER_id=request.session['tid'])
    return render(request, 'trainer/view_allocated_batch.html', {"data": data})



def viewChat(request):
    data = Chat.objects.all()
    return render(request, 'trainer/view_chat.html', {"data": data})


def viewHealthDetails(request):
    data = HealthDetails.objects.all()
    return render(request, 'trainer/view_helth_details.html', {"data": data})


def viewMembers(request, id):
    data = AllocateBatchUser.objects.filter(BATCH_TRAINER_id=id)
    return render(request, 'trainer/view_members.html', {"data": data})


def viewProfile(request):
    return render(request, 'trainer/view_profile.html')


def workoutVideoAdd(request, id):
    return render(request, 'trainer/workout_video_add.html', {"id":id})

def workoutVideoAdd_post(request, id):
    video = request.FILES['textfield1']
    title = request.POST.get('textfield2')
    date = request.POST.get('textfield3')

    fs = FileSystemStorage()
    path = fs.save(video.name, video)
    video_url = fs.url(path)
    
    # if WorkoutVideo.objects.filter(
    #     video=video_url,
    #     title=title,
    #     date=date,
    #     ALLOCATE_BATCH_USER_id=id
    # ).exists():
    #     return HttpResponse("<script>alert('Workout video already exists');window.location='/workoutVideoAdd/{id}';</script>")

    obj = WorkoutVideo()
    obj.ALLOCATE_BATCH_USER_id = id
    obj.video = video_url
    obj.title = title
    obj.date = date
    obj.save()

    return HttpResponse("<script>alert('workout video added');window.location=`/trainer_home`;</script>")

def workoutVideoEdit(request, id):
    data = WorkoutVideo.objects.get(id=id)
    return render(request, 'trainer/workout_video_edit.html', {"data": data})

def workoutVideoEdit_post(request, id):
    video = request.FILES.get('textfield1')
    title = request.POST.get('textfield2')

    fs = FileSystemStorage()
    path = fs.save(video.name, video)
    video_url = fs.url(path)

    if WorkoutVideo.objects.filter(
        video=video_url,
        title=title,
        date=datetime.now().date(),
        ALLOCATE_BATCH_USER_id=id
    ).exists():
        return HttpResponse("<script>alert('Workout video already exists');window.location='/workoutVideoEdit/{id}';</script>")

    WorkoutVideo.objects.filter(id=id).update(
        video = video,
        title = title,
        date = datetime.now().date()
    )

    return HttpResponse("<script>alert('workout video edited');window.location='/workoutVideoView';</script>")

def workoutVideoView(request, id):
    data = WorkoutVideo.objects.filter(ALLOCATE_BATCH_USER=id)
    return render(request, 'trainer/workout_video_view.html', {"data": data})

def deleteWorkoutVideo(request, id):
    WorkoutVideo.objects.get(id=id).delete()
    return HttpResponse("<script>alert('deleted'); window.location='/workoutVideoView';</script>")


def chat(request, u):
    request.session['head'] = "CHAT"
    request.session['uid'] = u
    return render(request, 'trainer/chat.html', {'u': u})


def chatsnd(request, u):
    m = request.POST.get('m', '').strip()
    # Create and save chat message
    obj = Chat(
        date=datetime.now(),  # Added time
        type='trainer',
        TRAINER_id=request.session['tid'],
        USER_id=request.session['uid'],
        message=m
    )
    obj.save()

    return JsonResponse({"status": "ok", "message_id": obj.id})


def chatrply(request):
    last_id = request.POST.get('last_id', 0)
    try:
        last_id = int(last_id)
    except ValueError:
        last_id = 0

    # Get messages with proper ordering and filtering
    messages = Chat.objects.filter(
        TRAINER=request.session['tid'],
        USER=request.session['uid'],
        id__gt=last_id  # Only get messages newer than last_id
    ).order_by('id')  # Ensure chronological order

    v = []
    for i in messages:
        v.append({
            'id': i.id,  # Include message ID for tracking
            'type': i.type,
            'chat': i.message,
            'selimage': '',  # You can add actual image paths here
            'uimage': '',  # You can add actual image paths here
            'date': i.date,
        })

    return JsonResponse({
        "status": "ok",
        "data": v,
        "count": len(v),
        "last_id": messages.last().id if messages else last_id
    })

def change_trainer_password(request):
    return render(request, "trainer/Change_password.html")

def change_trainer_password_post(request):
    tid = request.session.get('tid')

    current_password = request.POST['current_password']
    new_password = request.POST['new_password']
    confirm_new_password = request.POST['confirm_new_password']

    if not tid:
        return HttpResponse("Session expired")

    lid = Trainers.objects.get(id=tid).LOGIN_id
    user = User.objects.get(id=lid)

    if not user.check_password(current_password):
        return HttpResponse("<script>alert('Current password is incorrect'); window.location='/change_trainer_password';</script>")

    if new_password != confirm_new_password:
        return HttpResponse("<script>alert('Passwords do not match'); window.location='/change_trainer_password';</script>")

    if not new_password:
        return HttpResponse("<script>alert('Password cannot be empty'); window.location='/change_trainer_password';</script>")

    user.set_password(new_password)
    user.save()

    return HttpResponse("<script>alert('Password changed successfully'); window.location='/';</script>")


# USER

def user_login(request):
    un = request.POST.get('username')
    pw = request.POST.get('password')
    print(un, pw)
    data = authenticate(request,username=un, password=pw)
    print(data)
    if data is not None:
        login(request,data)
        if data.groups.filter(name='user').exists():
            obj= Users.objects.get(LOGIN=data)
            uid=obj.id
            print(uid)
            return JsonResponse({'status':'ok','uid':str(uid)})
        return JsonResponse({'status':'invalid'})
    return JsonResponse({'status': 'invalid'})

def user_registration(request):
    name = request.POST['name']
    email = request.POST['email']
    phone = request.POST['phone']
    gender = request.POST['gender']
    photo = request.FILES['file']
    dob = request.POST['dob']
    bio = request.POST['bio']
    level = request.POST['level']
    batch_id = request.POST['batch']
    passwrd = request.POST['password']
    confirm_password = request.POST['confirm_password']

    if User.objects.filter(username=email).exists():
        return JsonResponse({'status':"Already Exists"})

    if passwrd!=confirm_password:
        return JsonResponse({'status': 'Password mismatch'})

    ob=User(username=email)
    ob.set_password(passwrd)
    ob.save()
    ob.groups.add(Group.objects.get(name='user'))

    fs=FileSystemStorage()
    path=fs.save(photo.name,photo)
    photo_url=fs.url(path)

    obj = Users()
    obj.name = name
    obj.email = email
    obj.phone = phone
    obj.gender = gender
    obj.photo = photo_url
    obj.dob = dob
    obj.bio = bio
    obj.level = level
    obj.BATCH_id = batch_id
    obj.LOGIN=ob
    obj.save()

    return JsonResponse({'status':'ok'})

# adeel
def view_tips(request):
    uid = request.POST['uid']
    # data = list(Tips.objects.filter(ALLOCATE_BATCH_USER=id).values("title", "tips", "date"))
    data = []
    for t in Tips.objects.filter(ALLOCATE_BATCH_USER__USER=uid):
        data.append({
            "id": t.id,
            # "allocateBatchUserId": t.ALLOCATE_BATCH_USER,
            "title": t.title,
            "tips": t.tips,
            "date": t.date
        })
    return JsonResponse({'status': 'ok', 'message': data})

# adeel
def view_workout_video(request):
    uid = request.POST['uid']
    data = []
    for t in WorkoutVideo.objects.filter(ALLOCATE_BATCH_USER__USER_id=uid):
        data.append({
            # "id": t.id,
            # "allocateBatchUserId": t.ALLOCATE_BATCH_USER,
            "video": t.video,
            "title": t.title,
            "date": t.date
        })
    
    return JsonResponse({'status': 'ok', 'message': data})

# adeel
def view_trainer(request):
    id = request.POST.get('uid')
    # res = AllocateBatchUser.objects.filter(BATCH_TRAINER__TRAINER__id=id)
    data = []
    for t in AllocateBatchUser.objects.filter(USER=id):
        trainer = t.BATCH_TRAINER.TRAINER
        data.append({
            # "id": t.id,
            # "login": t.LOGIN,
            "name": trainer.name,
            "email": trainer.email,
            "photo": trainer.photo,
            "phone": trainer.p_no,
            "place": trainer.place,
            "post": trainer.post,
            "pin": trainer.pin,
            "joinDate": trainer.join_date,
            "bio": trainer.bio,
            'tid':trainer.id
        })
    
    return JsonResponse({'status': 'ok', 'message': data})

def view_dietplans(request):
    uid = request.POST['uid']
    res=DietPlanes.objects.filter(ALLOCATE_BATCH_USER__USER_id=uid)
    data = []
    for t in res:
        data.append({
            "food_name": t.food_name,
            "details": t.details,
            "time": t.time,
            "day": t.day
        })

    return JsonResponse({'status': 'ok', 'message': data})

def view_events(request):
    uid = request.POST['uid']
    res = Event.objects.all()
    data = []

    for t in res:
        data.append({
            "title": t.title,
            "description": t.description,
            "venue": t.venue,
            "date": t.date,
            "time": t.time,
        })

    return JsonResponse({'status': 'ok', 'message': data})

def view_payments(request):
    uid = request.POST['uid']
    res = Payment.objects.filter(USER=uid)
    data = []

    for t in res:
        data.append({
            # "id": t.id,
            "date": t.date,
            "amount": t.amount,
        })

    return JsonResponse({'status': 'ok', 'data': data})

def view_health_details(request):
    uid = request.POST['uid']
    res = HealthDetails.objects.filter(USER=uid)
    data = []

    for t in res:
        data.append({
            "id":t.id,
            "title": t.title,
            "details": t.details,
            "date": t.date
        })

    return JsonResponse({'status': 'ok', 'message': data})

def get_batches(request):
    batches = Batch.objects.all()
    data = []
    for b in batches:
        data.append({
            "id": b.id,
            "batch": b.batch,
            "from_time": b.from_time,
            "to_time": b.to_time
        })
    return JsonResponse({'status': 'ok', 'batches': data})

def change_password_user(request):
    uid = request.POST.get('uid')
    print(uid)
    # current_password = request.POST['current_password']
    new_password = request.POST['new_password']
    confirm_new_password = request.POST['confirm_new_password']
    if new_password == confirm_new_password:
        lid = Users.objects.get(id=uid).LOGIN_id
        users = User.objects.get(id=lid)
        users.set_password(new_password)
        users.save()
        return JsonResponse({'status': 'ok'})
    return JsonResponse({'status': 'password mismatch'})



def user_sendchat(request):
    FROM_id = request.POST['from_id']
    TOID_id = request.POST['to_id']
    msg = request.POST['message']

    # print(FROM_id, TOID_id,"Lk")

    c = Chat()
    c.USER_id = FROM_id
    c.TRAINER_id = TOID_id
    c.message = msg
    c.date = datetime.now()
    c.type='user'
    c.save()

    return JsonResponse({'status': "ok"})

def user_viewchat(request):
    from_id = request.POST['from_id']
    to_id = request.POST['to_id']
    # print(to_id)

    l=[]
    data = Chat.objects.filter(USER_id=from_id,TRAINER_id=to_id).order_by('id')


    # data= Chat.objects.all()

    for res in data:
        l.append({'id':res.id,'from':res.USER.id,'to':res.TRAINER.id,'msg':res.message,'date':res.date,'type':res.type})

    return JsonResponse({'status':"ok",'data':l})




def add_health_details(request):
    uid=request.POST['uid']
    title=request.POST['title']
    details=request.POST['details']

    if HealthDetails.objects.filter(
        USER_id=uid,
        title=title,
        details=details,
        date=datetime.now().date()
    ).exists():
        return JsonResponse({'status': 'exists'})

    obj=HealthDetails()
    obj.USER_id=uid
    obj.title=title
    obj.details=details
    obj.date=datetime.now().date()
    obj.save()
    return JsonResponse({'status':'ok'})

def update_health_details(request):
    id = request.POST['id']
    title = request.POST['title']
    details = request.POST['details']

    if HealthDetails.objects.filter(
        id=id,
        title=title,
        details=details,
        date=datetime.now().date()
    ).exists():
        return JsonResponse({'status': 'exists'})

    HealthDetails.objects.filter(id=id).update(
        title=title,
        details=details,
        date=datetime.now().date()
    )

    return JsonResponse({'status': 'ok'})

def delete_health_details(request):
    id = request.POST['id']
    HealthDetails.objects.get(id=id).delete()

    return JsonResponse({'status': 'ok'})

def view_profile(request):
    uid = request.POST.get('uid')
    data = []
    for user in Users.objects.filter(id=uid):
        data.append({
            "id": user.id,
            # "login": t.LOGIN,
            "name": user.name,
            "email": user.email,
            "photo": user.photo,
            "phone": user.phone,
            "gender": user.gender,
            "dob": user.dob,
            "level": user.level,
            "bio": user.bio
        })

    return JsonResponse({'status': 'ok', 'message': data})


def make_payment(request):
    uid=request.POST['uid']
    mode=request.POST['mode']
    amount=request.POST['amount']
    obj=Payment()
    obj.USER_id=uid
    obj.date=datetime.now()
    obj.amount=amount
    obj.mode=mode
    obj.save()
    return JsonResponse({'status':'ok'})


def edit_profile(request):
    uid = request.POST['uid']
    name = request.POST['name']
    email = request.POST['email']
    phone = request.POST['phone']
    gender = request.POST['gender']
    dob = request.POST['dob']
    bio = request.POST['bio']
    level = request.POST['level']
    if 'photo' in request.FILES:
     photo = request.FILES['file']
     fs = FileSystemStorage()
     path = fs.save(photo.name, photo)
     Users.objects.filter(id=uid).update(photo=fs.url(path))
    Users.objects.filter(id=uid).update(name=name,email=email,gender=gender,phone=phone,dob=dob,bio=bio,level=level)




    return JsonResponse({'status': 'ok'})
from django.urls import path
from .api import LoginAPI, RegisterAPI

urlpatterns = [
    path("login/", LoginAPI.as_view()),
    path("register/", RegisterAPI.as_view())
]

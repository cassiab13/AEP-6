from django import views
from django.urls import path
from ..views import views

urlpatterns = [
    path('analyze/', views.analyze_message, name="analyze_message"),
]
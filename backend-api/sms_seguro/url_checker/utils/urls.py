from django import views
from django.urls import path
from ..views import views

urlpatterns = [
    path('analyze_message/', views.analyze_message, name='analyze_message'),
    path('list_messages/', views.list_messages, name='list_messages'),
]
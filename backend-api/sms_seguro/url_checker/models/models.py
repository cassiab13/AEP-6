from django.db import models

class Messages (models.Model):
    message_text = models.TextField()
    analyzed_at = models.DateTimeField(auto_now_add=True)

class UrlAnalysis (models.Model):
    message = models.ForeignKey(Messages, on_delete=models.CASCADE, related_name="urls")
    url = models.URLField()
    api_safe = models.BooleanField()
    rf_safe = models.BooleanField()
    analysis_id = models.CharField(max_length=255, null=True, blank=True)

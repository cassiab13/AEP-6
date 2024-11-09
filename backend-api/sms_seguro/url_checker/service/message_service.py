from ..models import Messages

class MessageService:
    
    @staticmethod
    def get_all_messages():
        return Messages.objects.all()
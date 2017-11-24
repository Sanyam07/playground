from rest_framework.response import Response
from rest_framework.views import APIView

from playground.joystick.models import JoystickDataModel


class JoystickDataReceiverView(APIView):
    def post(self, request):
        joystick_data = JoystickDataModel(data=request.data)
        joystick_data.save()
        return Response({"status": "success", "id": joystick_data.id})

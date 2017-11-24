from django.conf.urls import url

from playground.joystick.views import JoystickDataReceiverView

urlpatterns = [
    url(r'^receive/?', JoystickDataReceiverView.as_view()),
]

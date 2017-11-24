from django.conf.urls import url, include
from .joystick import urls as joystick_urls

urlpatterns = [
    url(r'^joystick/', include(joystick_urls)),
]

from django.conf.urls import patterns, include, url
from rest_framework import routers
from spaceAPI import views
from django.contrib import admin
admin.autodiscover()

router = routers.DefaultRouter()
router.register(r'rocket', views.RocketViewSet)

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'littlespaceship.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^admin/', include(admin.site.urls)),
    #url(r'^api/', include(router.urls)),
    (r'^api/$', views.APIRoot.as_view()),
    url (r'^api/rocket/$', views.RocketView.as_view(), name='RocketView'),
    url (r'^api/init/$', views.InitView.as_view(), name='InitView'),
    url (r'^api/celestial/(?P<planetName>\w+)/$', views.PlanetView.as_view(), name='PlanetView'),
    url (r'^api/planetinfo/$', views.PlanetInformation.as_view(), name='PlanetInformation'),
    url(r'^api/push/$', views.PushesView.as_view(), name='PushesView'),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    (r'^crossdomain.xml$',
    'flashpolicies.views.simple',
    {'domains': ['*']}),

)

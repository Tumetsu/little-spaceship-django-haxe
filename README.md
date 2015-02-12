# Little spaceship
![Mockup](http://i.imgur.com/58SQHTW.png)
![Screenshot](http://i.imgur.com/soXSd4p.png)
### What is this about
This is an unfinished experimental project of mine from Summer 2014. The basic idea was to create a web game/application about a spaceship travelling throught the solar-system. Client offers visitor a possibility to help the rocket by "pushing" it forward and accelerating it a bit. The catch is that the scale of the solar-system is realistic, as well as the travelling time/speed. **By gathering enough pushes from all visitors the rocket would gain more speed and hopefully eventually cross the solar-system and reach Voyager 1.** 

### Why?
I was simply curious about demonstrating the scale of the solar-system as well as creating something truly interesting and experimental. Also, I wanted to learn more about the following technologies:
- Django
- Django REST-framework
- [Haxe](http://haxe.org/)
- [Flambe](http://getflambe.com/)
- Vagrant

### Is it running somewhere right now?
No :( 
The project froze during the summer since I had serious trouble with local developmenttools on my Macbook Air which made the project really frustrating to work on it. It ran very well on top of uwsgi and nginx but I ended up removing it from DigitalOcean to save money. I still have vagrant-box with everything set-up so it shouldn't be too difficult to set it up if it ever comes to that. However, I have some other plans (see "The future?")

### Architecture
Basically the server side consists of Django with rest-framework providing the API for the client and [Celery](http://www.celeryproject.org/) to run scheduled tasks (updating the progress of the rocket). spaceAPI module's *tasks.py* contains relevant code for updating the rocket's model.

On client side I used awesome Haxe language and Flambe library to make a html5/Flash client. This was my first experiment with Flambe. It is quite nice component-based game library with really good performance on html5. 

### The future?
I'm considering reviving the project. I'll probably use Phaser.js for client side to avoid headache on OSX. The API also needs a redesign. Other than that I'd like to add following features:
- Twitter live-feed of the journey, for example while approaching a planet
- Game mechanics which grant player more pushing power
- Rankings of the top-contributers
- Educational aspect of the celestial objects
 
Only time will tell if I have time for those :/



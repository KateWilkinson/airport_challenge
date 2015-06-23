Airport Challenge
=================

We were asked to create a program to control the flow of planes into and out of an airport. This included landing and take off of plane objects, as well as traffic control and prevention of take off and landing in stormy weather.

We were given the below user stories to follow in order to implement our design.


As a pilot
So that I can arrive at my specified destination
I would like to land my plane at the appropriate airport

As a pilot
So that I can set off for my specified destination
I would like to be able to take off from the appropriate airport

As an air traffic controller
So that I can avoid collisions
I want to be able to prevent airplanes landing when the airport if full

As an air traffic controller
So that I can avoid accidents
I want to be able to prevent airplanes landing or taking off when the weather is stormy




The program I have written allows a plane object to be landed at the airport when there is capacity, and when the weather is not stormy. Similarly, a plane can take off given that there is a plane landed at the airport, and that the weather is not stormy.
A plane is instantiated with a 'flying' status. Once landed this becomes 'landed', and any specific plane object cannot be landed at the airport twice.

My approach to this task was test-driven. By scaffolding in irb and then creating unit tests in rspec, I was able to map out how my program should function.

To do:

Have another look at doubles and get tests working properly
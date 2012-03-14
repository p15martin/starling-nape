Introduction
============

This example is "forked" from the original version created by [Lee Brimelow](leebrimelow.com), and available for download on the [Adobe Gaming](http://gaming.adobe.com/getstarted/) site.

The goal of this fork is to make it easy for you to get the example running in Flash Builder using [AIR 3.2](http://labs.adobe.com/technologies/flashplatformruntimes/air3-2/) and [Flash Player 11.2](http://labs.adobe.com/technologies/flashplatformruntimes/flashplayer11-2/).

I also did a small amount of refactoring to aid readability of the code.


The example
-----------

The example itself shows how to use the [Nape](http://deltaluca.me.uk/) physics engine and the [Starling](http://gamua.com/starling/) 2D game framework, which is built on Stage3D to leverage the GPU.


Why?
----

The AIR SDK is dependent on the Flex SDK for the compiler. If you want to compile an AIR app, then you require Flex. If you want to use the AIR SDK in [Flash Builder](http://adobe.com/go/flashbuilder) then you need to manually merge the AIR SDK with the Flex SDK.

As a developer looking at this code for the first time I want to make it as easy as possible for you to read the code and run it.


Getting started
---------------

Assuming you have Git [installed](http://git-scm.com/), you can clone the repo as follows:

	git clone git@github.com:p15martin/starling-nape.git

[Install](https://github.com/p15martin/air-sdk-3_2) the AIR 3.2 SDK in Flash Builder.

Import the project (**File > Import > General > Existing Projects into Workspace**)


Things to note
--------------

The games is using [Hi-Res Stats](https://github.com/mrdoob/Hi-ReS-Stats) to provide performance stats such as the frames per second.

The application descriptor (**StarlingNape-app**) sets the render mode to **direct**: <renderMode>direct</renderMode>

The render mode enables Stage3D and GPU acceleration, if it's not set then you get a runtime exception saying, "Context 3D not available". Starling shows a message saying, "This application is not correctly embedded (wrong wmode value)".

If you are running in the browser, then set **wmode="direct"** in the HTML wrapper.


Resources
---------

[Code walkthrough](http://gotoandlearn.com/play.php?id=157)

[How Stage3D works](http://www.adobe.com/devnet/flashplayer/articles/how-stage3d-works.html)

[Introducing the Starling 2D framework](http://www.adobe.com/devnet/flashplayer/articles/introducing_Starling.html)

[Adobe Developer Connection, Stage 3D](http://www.adobe.com/devnet/flashplayer/stage3d.html)


Stage3D Examples
----------------

[Epic Citadel](http://www.unrealengine.com/flash/)
"hasEventListener" plugin for [jQuery](http://jquery.com/) 1.4.2+
================================

Description
------------
A jQuery plugin which tests if a jQuery element actually has a particular event listener bound.

Demo
-----
A quick demo is available here : [http://jsfiddle.net/sebastienp/eHGqB/](http://jsfiddle.net/sebastienp/eHGqB/)

Usage
------
* `$.hasEventListener(dom_element);` : true or false
* `$.hasEventListener(dom_element, "event");` : true or false
* `$.hasEventListener(dom_element, "event.namespace");` : true or false
* `$("selector:hasEventListener");` : jQuery chainable object
* `$("selector:hasEventListener(event)");` : jQuery chainable object
* `$("selector:hasEventListener(event.namespace)");` : jQuery chainable object
* `$("selector").hasEventListener();` : jQuery chainable object
* `$("selector").hasEventListener("event");` : jQuery chainable object
* `$("selector").hasEventListener("event.namespace");` : jQuery chainable object

Licence
--------
Copyright (c) 2010 Sebastien P.

[http://twitter.com/_sebastienp](http://twitter.com/_sebastienp)

MIT licensed.
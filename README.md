"hasEventListener" plugin for [jQuery](http://jquery.com/) (tested and working with 1.2.3+)
================================

Description
------------
A jQuery plugin which tests if a dom element actually has a particular event listener bound to it.
More infos ? [https://twitter.com/#!/search/_sebastienp%20hasEventListener](https://twitter.com/#!/search/_sebastienp%20hasEventListener)

Demo
-----
A quick demo is available here : [http://jsfiddle.net/sebastienp/eHGqB/](http://jsfiddle.net/sebastienp/eHGqB/)

1.0.5 Usage
------------
* `$.hasEventListener(dom_element);` --> Boolean
* `$.hasEventListener(dom_element, "event");` --> Boolean
* `$.hasEventListener(dom_element, "event.namespace");` --> Boolean
* `$("selector:hasEventListener");` --> jQuery object
* `$("selector:hasEventListener(event)");` --> jQuery object
* `$("selector:hasEventListener(event.namespace)");` --> jQuery object
* `$("selector").hasEventListener();` --> jQuery object
* `$("selector").hasEventListener("event");` --> jQuery object
* `$("selector").hasEventListener("event.namespace");` --> jQuery object

2.0.0 Roadmap
--------------
* `jQuery.hasEventListener(dom_element, [mode][type][namespace], [handler])` --> Boolean  
* `:hasEventListener[([mode][type][namespace])] Selector` --> jQuery object
* `.hasEventListener([mode][type][namespace], [handler])` --> jQuery object

Licence
--------
Copyright (c) 2011 Sebastien P.

[http://twitter.com/_sebastienp](http://twitter.com/_sebastienp)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
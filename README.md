"hasEventListener" plugin for [jQuery](http://jquery.com/) (version 1.2.3+ tested)
================================

Description
------------
A jQuery plugin which tests if a dom element actually has a particular event listener bound to it.
[More infos ?](https://twitter.com/#!/search/_sebastienp%20hasEventListener)

Demo
-----
A quick demo is available here : [http://jsfiddle.net/sebastienp/eHGqB/]()

Setup
------
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="utf-8"/>
            <title>Page title</title>
        </head>
        <body>
            <!-- Some HTML tags -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js"></script>
            <script scr="jquery.hasEventListener-2.0.0rc1.min.js"></script>
            <!-- Some other jQuery plugins and/or scripts, order is important ! -->
        </body>
    </html>

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
* 'jQuery.hasEventListener(dom_element, [mode][type][namespace], [handler])
  --> boolean

  mode : (String) "!live" or "!delegate", for live/delegated event presence test.
  type : (String) type of the event to test presence for. e.g. "click".
  namespace : (String) namespace of the event to test presence for. e.g. ".namespaced".
  handler : (Function) event handler to test presence for.'

* ':hasEventListener[([mode][type][namespace])] Selector
  --> jQuery object

  mode : (String) "!live" or "!delegate", for live/delegated event test.
  type : (String) type of the event to test presence for. e.g. "click".
  namespace : (String) namespace of the event to test presence for. e.g. ".namespaced".'

* '.hasEventListener([mode][type][namespace], [handler])
  --> jQuery object

  mode : (String) "!live" or "!delegate", for live/delegated event presence test.
  type : (String) type of the event to test presence for. e.g. "click".
  namespace : (String) namespace of the event to test presence for. e.g. ".namespaced".
  handler : (Function) event handler to test presence for.'

They talked about "hasEventListener"
-------------------------------------
* [http://sullerton.com/2011/01/jquery-haseventlistener-and-developer-collaboration]()
* [http://snipplr.com/view/48107/jquery-fancy-select-dropdown-menu]()

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
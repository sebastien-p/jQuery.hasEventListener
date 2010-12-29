/*

   Copyright (c) 2010 Sebastien P.

   http://twitter.com/_sebastienp
   http://github.com/sebastien-p/jquery.hasEventListener
   http://jsfiddle.net/sebastienp/eHGqB/

   MIT licensed.

   ---

   A jQuery plugin which tests if a jQuery element
   actually has a particular event listener bound.

   Usage :

   - $.hasEventListener(dom_element, "event"); // true or false
   - $.hasEventListener(dom_element, "event.namespace"); // true or false
   - $("selector:hasEventListener(event)"); // jQuery chainable object
   - $("selector:hasEventListener(event.namespace)"); // jQuery chainable object
   - $("selector").hasEventListener("event"); // jQuery chainable object
   - $("selector").hasEventListener("event.namespace"); // jQuery chainable object

*/


(function ($, TRUE) {

    "use strict";

    var reusable_string = "hasEventListener";

    $[reusable_string] = function (element, event_name) {

        var event_listeners = $.data(element, "events"),
        event_namespace,
        found_namespace,
        iterator;

        if (
            event_listeners &&
            (event_name = /^([a-z]+)(\.([\w\d\-]+))?$/.exec(event_name)) &&
            (event_listeners = event_listeners[event_name[1]])
        ) {

            if (
                (event_namespace = event_name[3])
            ) {

                iterator = event_listeners.length;

                while ((iterator -= 1) >= 0) {

                    if (
                        (found_namespace = event_listeners[iterator].namespace) &&
                        (found_namespace.split(".")[0] === event_namespace)
                    ) {

                        return TRUE;

                    }

                }

            } else {

                return TRUE;

            }

        }

        return false;

    };

    $.expr[":"][reusable_string] = function (element, index, match) {

        return $[reusable_string](element, match[3]);

    };

    $.fn[reusable_string] = function (event_name) {

        return this.filter(":" + reusable_string + "(" + event_name + ")");

    };

}(this.jQuery, true));
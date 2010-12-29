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


(function ($, TRUE, REUSABLE_STRING) {

    "use strict";

    /* $.hasEventListener(dom_element, event_name); */

    $[REUSABLE_STRING] = function (element, event_name) {

        var event_listeners = $.data(element, "events"),
        event_namespace,
        found_namespace,
        iterator;

        if (
            event_listeners &&
            // RegExp for "event" or "event.namespace" (az.azAZ09_-).
            (event_name = /^([a-z]+)(\.([\w\d\-]+))?$/.exec(event_name)) &&
            (event_listeners = event_listeners[event_name[1]])
        ) {

            if (
                (event_namespace = event_name[3])
            ) {

                iterator = event_listeners.length;

                // Loop to see if there is a matching namespace.
                while ((iterator -= 1) >= 0) {

                    if (
                        (found_namespace = event_listeners[iterator].namespace) &&
                        (found_namespace.split(".")[0] === event_namespace)
                    ) {

                        return TRUE;

                    }

                }

            } else {

                // There is no such event or event.namespaced bound.
                return TRUE;

            }

        }

        return false;

    };

    /* $("selector:hasEventListener(event_name)"); */

    $.expr[":"][REUSABLE_STRING] = function (element, index, match) {

        return $[REUSABLE_STRING](element, match[3]);

    };

    /* $("selector").hasEventListener(event_name); */

    $.fn[REUSABLE_STRING] = function (event_name) {

        return this.filter(":" + REUSABLE_STRING + "(" + event_name + ")");

    };

}(this.jQuery, true, "hasEventListener"));
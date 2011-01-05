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

   - $.hasEventListener(dom_element); // true or false
   - $.hasEventListener(dom_element, "event"); // true or false
   - $.hasEventListener(dom_element, "event.namespace"); // true or false

   - $("selector:hasEventListener"); // jQuery chainable object
   - $("selector:hasEventListener(event)"); // jQuery chainable object
   - $("selector:hasEventListener(event.namespace)"); // jQuery chainable object

   - $("selector").hasEventListener(); // jQuery chainable object
   - $("selector").hasEventListener("event"); // jQuery chainable object
   - $("selector").hasEventListener("event.namespace"); // jQuery chainable object

*/


(function ($, PLUGIN_NAME, TRUE) {

    "use strict";

    function is_plain_string(argument) {

        return !!(argument && ($.type(argument) === "string") && $.trim(argument));

    }


    /* $.hasEventListener(dom_element, event_name); */

    $[PLUGIN_NAME] = function (element, event_name) {

        var event_listeners = $.data(element, "events"),
        to_return = false,
        event_namespace,
        found_namespace,
        iterator;

        if (event_listeners) {

            if (
                is_plain_string(event_name) &&
                // RegExp for "event" or "event.namespace" (az.azAZ09_-).
                (event_name = /^([a-z]+)(\.([\w\d\-]+))?$/.exec(event_name))
            ) {

                if (
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

                                // There is a such event.namespaced bound.
                                to_return = TRUE;

                                break;

                            }

                        }

                    } else {

                        // There is a such event (not namespaced) bound.
                        to_return = TRUE;

                    }

                }

            } else {

                // There is at least one event bound.
                to_return = TRUE;

            }

        }

        // There is no such event or event.namespaced bound.
        return to_return;

    };


    /* $("selector:hasEventListener(event_name)"); */

    $.expr[":"][PLUGIN_NAME] = function (element, index, match) {

        return $[PLUGIN_NAME](element, match[3]);

    };


    /* $("selector").hasEventListener(event_name); */

    $.fn[PLUGIN_NAME] = function (event_name) {

        return this.filter(":" + PLUGIN_NAME + ((is_plain_string(event_name)) ? "(" + event_name + ")" : ""));

    };

}(this.jQuery, "hasEventListener", true));
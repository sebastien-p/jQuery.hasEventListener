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

   - $("selector").hasEventListener("event"); // true or false
   - $("selector").hasEventListener("event.namespace"); // true or false

*/


(function ($, TRUE) {

    "use strict";

    $.fn.hasEventListener = function (event_name) {

        var event_listeners = this.data("events"),
        to_return = false,
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

                to_return = TRUE;

            }

        }

        return to_return;

    };

}(this.jQuery, true));
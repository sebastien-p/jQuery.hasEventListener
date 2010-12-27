(function ($, TRUE) {

    "use strict";

    $.fn.hasEventListener = function (event_name) {

        event_name = /^([a-z]+)(\.([\w\d\-]+))?$/.exec(event_name);

        var event_listeners = this.data("events"),
        iterator,
        event_namespace,
        found_namespace;

        if (event_listeners && event_name) {

            event_namespace = event_name[3];
            event_listeners = event_listeners[event_name[1]];
            iterator = event_listeners.length;

            while ((iterator -= 1) >= 0) {

                if (event_namespace) {

                    found_namespace = event_listeners[iterator].namespace;

                    if (found_namespace && (found_namespace.split(".")[0] === event_namespace)) {

                        return TRUE;

                    }

                } else {

                    return TRUE;

                }

            }

        }

        return false;

    };

}(this.jQuery, true));
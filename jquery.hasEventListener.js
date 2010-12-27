(function ($, TRUE) {

    "use strict";

    $.fn.hasEventListener = function (event_name) {

        event_name = /^([a-z]+)(\.([\w\d\-]+))?$/.exec(event_name);

        var event_listeners = this.data("events"),
        iterator,// = -1,
        //array_length,
        event_namespace,
        event_type,
        found_namespace;

        if (event_listeners && event_name) {

            event_type = event_name[1];
            event_namespace = event_name[3];
            event_listeners = event_listeners[event_type];
            iterator = event_listeners.length + 1;//array_length = event_listeners.length;

            while (iterator -= 1) {//while ((iterator += 1) < array_length) {

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
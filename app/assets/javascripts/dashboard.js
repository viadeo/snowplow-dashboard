// Popup Chart Info
$(document).ready(function () {
  $("[rel=tooltip]").each(function (index) {
    return $(this).hover(
      function () { // Hover handlerIn
        var callback, el;
        el = $(this);
        callback = function (response) {
          return el.popover({
            content: response.last_update,
            title: el.attr('title'),
            html: true
          }).popover('show');
        };
        return $.get(el.attr('data-info-url'), '', callback, '');
      },
      function () { // Hover handlerOut
        $(this).popover('hide');
      }
    );
  });
});


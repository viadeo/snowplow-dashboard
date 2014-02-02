// Popup Chart Info
$(document).on('ready page:load', function () {
  $("[rel=tooltip]").each(function (index) {
    return $(this).hover(
      function () { // Hover handlerIn
        var callback, el;
        el = $(this);
        callback = function (response) {
          return el.popover({
            content: response,
            title: el.attr('title'),
            placement: 'left',
            container: 'body',
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


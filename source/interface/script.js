$(function() {
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item !== undefined && item.type === "post") {
            if (item.display === true) {
                var postElement = $('<div class="post"></div>');
                postElement.append('<h1><span id="bold">Life</span>invader</h1>');
                postElement.append('<p><span id="username">' + item.username + '</span> posted a status update</p>');
                postElement.append('<hr id="divider">');
                
                var sanitizedMessage = sanitizeMessage(item.message);
                postElement.append('<div id="content"><p><span id="post-content">' + sanitizedMessage + '</span></p></div>');
                postElement.append('<div class="time-left"></div>');
                
                $("#posts-container").prepend(postElement);
                if ($("#posts-container").children().length > 3) {
                    $("#posts-container").children().last().css("animation", "slideOutToRight 0.5s ease-in-out");
                    $("#posts-container").children().last().remove();
                }

                $(".time-left").each(function() {
                    var time = 15000 + ($(this).parent().find("#content").text().length * 100);
                    $(this).animate({
                        width: "0%"
                    }, time, function() {
                        $("#posts-container").children().last().css("animation", "slideOutToRight 0.5s ease-in-out");
                        setTimeout(function() {
                            $("#posts-container").children().last().remove();
                        }, 500);
                    });
                });
            } else {
                // Rest of your code...
            }
        }
    });
});

function sanitizeMessage(message) {
  const sanitizedMessage = message.replace(/<\/?[^>]+(>|$)/g, '');
  const escapedMessage = escapeHtmlEntities(sanitizedMessage);

  return escapedMessage;
}

function escapeHtmlEntities(text) {
  return text.replace(/&/g, '&amp;')
             .replace(/</g, '&lt;')
             .replace(/>/g, '&gt;')
             .replace(/"/g, '&quot;')
             .replace(/'/g, '&#039;');
}

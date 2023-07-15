$(function() {
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item !== undefined && item.type === "post") {
            if (item.display === true) {
                var postElement = $('<div class="post"></div>');
                postElement.append('<h1><span id="bold">Life</span>invader</h1>');
                postElement.append('<p><span id="username">' + item.username + '</span> posted a status update</p>');
                postElement.append('<hr id="divider">');
                postElement.append('<div id="content"><p><span id="post-content">' + item.message + '</span></p></div>');
                postElement.append('<div class="time-left"></div>');
                
                $("#posts-container").prepend(postElement);
                if ($("#posts-container").children().length > 3) {
                    // add the slideout animation
                    $("#posts-container").children().last().css("animation", "slideOutToRight 0.5s ease-in-out");
                    $("#posts-container").children().last().remove();
                }

                $(".time-left").each(function() {
                    $(this).animate({
                        width: "0%"
                    }, 15000, function() {
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
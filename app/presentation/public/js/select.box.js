$("select").on("click", function () {
    $(this).parent(".select-box").toggleClass("open");
});

$(document).mouseup(function (e) {
    var container = $(".select-box");

    if (container.has(e.target).length === 0) {
        container.removeClass("open");
    }
});


$(document).on("change", 'select', function () {

    var selection = $(this).find("option:selected").text();
    var labelFor = $(this).attr("id");
    var label = $("[for='" + labelFor + "']");

    label.find(".label-desc").html(selection);

}); 
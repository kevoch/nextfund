// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('ready page:load', function () {

    //Initialize tooltips
    $('.nav-tabs > li a[title]').tooltip();
    
    // //Wizard
    // $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {

    //     var $target = $(e.target);
    
    //     if ($target.parent().hasClass('disabled')) {
    //         return false;
    //     }
    // });

    $(".next-step").click(function (e) {
        var $active = $('.wizard .nav-tabs li.active');
        $active.next().removeClass('disabled');
        nextTab($active);

    });
    $(".prev-step").click(function (e) {

        var $active = $('.wizard .nav-tabs li.active');
        prevTab($active);

    });
});



function nextTab(elem) {
    $(elem).next().find('a[data-toggle="tab"]').click();
}
function prevTab(elem) {
    $(elem).prev().find('a[data-toggle="tab"]').click();
}


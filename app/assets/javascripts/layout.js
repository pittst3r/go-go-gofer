$(window).load(function() {
  $($("object.menu")[0].contentDocument).click(function() {
    $("header nav").slideToggle(100);
  });
});

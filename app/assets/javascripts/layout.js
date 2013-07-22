$(window).load(function() {
  
  $($("object.menu")[0].contentDocument).click(function() {
    $("header nav").slideToggle(100);
  });
  
  if ( $(".flash") ) {
    setTimeout(function() {
      $(".flash").slideUp(1000);
    }, 4000);
  }
  
});

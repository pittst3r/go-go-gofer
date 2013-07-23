$(window).load(function() {
  
  $("img.menu").click(function() {
    $("header nav").slideToggle(100);
  });
  
  if ( $(".flash") ) {
    setTimeout(function() {
      $(".flash").slideUp(1000);
    }, 4000);
  }
  
});

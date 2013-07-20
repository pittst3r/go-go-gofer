$(function() {
  
  $.fn.spin.presets.gofer = {
    lines: 8, // The number of lines to draw
    length: 3, // The length of each line
    width: 2, // The line thickness
    radius: 3, // The radius of the inner circle
    corners: 1, // Corner roundness (0..1)
    rotate: 0, // The rotation offset
    direction: 1, // 1: clockwise, -1: counterclockwise
    color: '#000', // #rgb or #rrggbb
    speed: 1, // Rounds per second
    trail: 60, // Afterglow percentage
    shadow: false, // Whether to render a shadow
    hwaccel: false, // Whether to use hardware acceleration
    className: 'spinner', // The CSS class to assign to the spinner
    zIndex: 2e9, // The z-index (defaults to 2000000000)
    top: 'auto', // Top position relative to parent in px
    left: 'auto' // Left position relative to parent in px
  };
  
  var $dashboardOrders = $("#orders.dashboard-pane"),
      $dashboardGoferRun = $("#your-gofer-run.dashboard-pane");
  
  // Dashboard orders pane
  if ( $dashboardOrders.length > 0 ) {
    
    // New order slide down
    $dashboardOrders.on("click", ".order.new.closed", function() {
      $(this).find("form").slideDown(100, function() {
        $(this).parents(".order").addClass("open");
        $(this).parents(".order").removeClass("closed");
        $(this).find("input[type='text']").first().focus();
      });
    });
    
    // New order slide up
    $dashboardOrders.on("blur", ".order.new", function() {
      if ( $(this).find("input[type='text']").val().length == 0 ) {
        $(this).find("form").slideUp(100, function() {
          $(this).parents(".order").removeClass("open");
          $(this).parents(".order").addClass("closed");
        });
      }
    });
    
    // New order form click bubble up prevention
    $dashboardOrders.on("click", ".order.new input", function(event) {
      event.stopPropagation();
    });
    
    // New order submission spinner
    $(document).ajaxSend(function(event, xhr, settings) {
      if ( settings.url.match(/\/orders$/) && settings.type == "POST" ) {
        $(".order.new").spin('gofer');
      }
    });
    
    // Clear new order form after submission and display new order
    $(document).ajaxComplete(function(event, xhr, settings) {
      if ( settings.url.match(/\/orders$/) && settings.type == "POST" ) {
        $(".order.new").spin(false);
        $(".order.new").find("input[type='text']").val("");
        $(".order.new form").slideToggle(200, function() {
          $(".order.new").first().toggleClass("open");
        });
      }
    });
    
    // Order deletion
    $dashboardOrders.on("click", ".order a[data-delete]", function(event) {
      event.preventDefault();
      event.stopPropagation();
      $(this).parents(".order").first().fadeTo(100, 0, function() {
        $(this).slideUp(100, function() {
          $(this).remove();
        });
      });
      $.ajax({
        url: $(this).attr("href"),
        type: "DELETE",
        dataType: "script"
      });
    });
    
    // Accept order
    $dashboardOrders.on("click", ".order", function(event) {
      var spinner;
      if ( !$(this).hasClass("new") ) {
        var $this = $(this),
            order_id = $this.data("id"),
            resource_url = "/orders/" + order_id + "/accept";
        $.ajax({
          url: resource_url,
          type: "PUT",
          dataType: "script",
          beforeSend: function() {
            $this.spin('gofer');
            $this.addClass("active");
          },
          success: function() {
            setTimeout(function() {
              $this.spin(false);
              $this.slideUp(100, function() {
                $this.remove();
              });
            }, 300);
          }
        });
      }
    });
    
  }
  
  if ( $dashboardGoferRun.length > 0 ) {
    
    $dashboardGoferRun.on("click", "button[data-clear]", function() {
      var $this = $(this),
          run_id = $this.data("clear")
          resource_url = "gofer_runs/" + run_id + "/clear";
      $.ajax({
        url: resource_url,
        type: "PUT",
        dataType: "script",
        success: function() {
          $dashboardGoferRun.find(".order").slideUp(100, function() {
            $(this).remove();
          });
        }
      });
    });
    
    $dashboardGoferRun.on("click", "button[data-close]", function() {
      var $this = $(this),
          run_id = $this.data("close")
          resource_url = "gofer_runs/" + run_id + "/close";
      $.ajax({
        url: resource_url,
        type: "PUT",
        dataType: "script",
        success: function() {
          $dashboardGoferRun.find("#controls").fadeOut(100, function() {
            $(this).remove();
            $dashboardGoferRun.find(".order").slideUp(100, function() {
              $(this).remove();
            });
            var $placeholder = $("<div class='order placeholder'><p>No current gofer run</p></div>").hide();
            $dashboardGoferRun.append($placeholder);
            $placeholder.fadeIn(100);
          });
        }
      });
    });
    
  }
  
});

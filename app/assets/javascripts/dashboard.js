$(function() {
  
  var $dashboardOrders = $("#orders.dashboard-pane"),
      $dashboardGoferRun = $("#your-gofer-run.dashboard-pane");
  
  // Dashboard orders pane
  if ( $dashboardOrders.length > 0 ) {
    
    // New order slide
    $dashboardOrders.on("click", ".order.new", function() {
      $(this).find("form").slideToggle(100, function() {
        $(this).parents(".order").toggleClass("open");
        $(this).find("input[type='text']").first().focus();
      });
    });
    
    // New order form click bubble up prevention
    $dashboardOrders.on("click", ".order.new input", function(event) {
      event.stopPropagation();
    });
    
    // Clear new order form after submission and display new order
    $(document).ajaxComplete(function(event, xhr, settings) {
      if ( settings.url.match(/\/orders$/) && settings.type == "POST" ) {
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
    
    $dashboardOrders.on("click", ".order", function(event) {
      if ( !$(this).hasClass("new") ) {
        var $this = $(this),
            order_id = $this.data("id"),
            resource_url = "/orders/" + order_id + "/accept";
        $.ajax({
          url: resource_url,
          type: "PUT",
          dataType: "script",
          beforeSend: function() {
            $this.addClass("active");
          },
          success: function() {
            setTimeout(function() {
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

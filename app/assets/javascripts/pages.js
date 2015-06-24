"use strict";

$(document).ready(function(){
  var menu = $('.shared-menu');
  var topBanner = $('.top-banner');
  var scheduleBtn = $('.schedule-btn');

  if(CURRENT_PAGE == 'dashboard'){
    setTimeout(function(){
      window.location.reload(1);
    }, 30000); //refresh every 30 seconds
  }

  /**
   * Loop through links
   * and make current page active
   */
  menu.find('li').each(function(){
    if( $(this).attr('class') == CURRENT_PAGE ){
      $(this).addClass('active');
    }
  });

  /**
   * Schedule button is clicked
   */
  scheduleBtn.on('click', function(e){
    e.preventDefault();
    $(this).attr('disabled','disabled');
    if(!$(this).hasClass('disabled')){
      var url = $(this).attr('href') + '/' + 'schedule/create';
      $.post(url, userData, function(response){
        $(this).removeAttr('disabled');
        response.status ? location.reload() : console.log(response.status);
      });
    }
  });
}); 
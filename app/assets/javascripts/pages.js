"use strict";

$(document).ready(function(){
  var menu = $('.shared-menu');
  var topBanner = $('.top-banner');
  var scheduleBtn = $('.schedule-btn');

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
    if(!$(this).hasClass('disabled')){
      var url = $(this).attr('href') + '/' + 'schedule/create';
      $.post(url, function(response){
        console.log(response);
      });
    }
  });

}); 
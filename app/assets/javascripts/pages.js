"use strict";

$(document).ready(function(){
  var menu = $('.shared-menu');
  var topBanner = $('.top-banner');

  /**
   * Loop through links
   * and make current page active
   */
  menu.find('li').each(function(){
    if( $(this).attr('class') == CURRENT_PAGE ){
      $(this).addClass('active');
    }
  });

}); 




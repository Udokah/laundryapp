"use strict";

  /**
   * Slack Class
   */
  var Slack = function(){
    this.state = this.clientId = null;
    this.uri = null;
    this.team = this.scope = null
  };

  Slack.prototype.params = function(){
    return {
      client_id : this.clientId,
      state     : this.state,
      team      : this.team,
      scope     : this.scope     
    };
  };

$(document).ready(function(){
  var menu = $('.shared-menu');
  var topBanner = $('.top-banner');
  var slackBtn = $('#slack-btn');

  var slack = new Slack();
  slack.clientId = slackBtn.attr('data-client-id');
  slack.state = slackBtn.attr('data-state');
  slack.team = slackBtn.attr('data-team');
  slack.scope = slackBtn.attr('data-scope');
  slack.uri = slackBtn.attr('data-uri');

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
   * Slack button is clicked
   */
  slackBtn.on('click', function(e){
    e.preventDefault();    
    window.location = slack.uri + "?" + $.param(slack.params());
  });

}); 




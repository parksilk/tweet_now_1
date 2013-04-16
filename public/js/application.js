$(document).ready(function() {
  var $dataDiv = $('#rainbow_cat');
  var $spinner = $dataDiv.find('img');
  $spinner.hide();

  $('#tweet_form').on('submit', function(e){
    e.preventDefault();
    var $form = $(this);

    $form.find('input[type=submit]').attr('disabled', true);
    $spinner.show();

    $.post($form.attr('action'), $form.serialize())
     .done(function(data) {
      $form.find('textarea[name="tweet"]').val("");
      $spinner.hide();
      $dataDiv.html("<p>Your tweet was posted.</p>");
      $form.find('input[type=submit]').removeAttr('disabled');
    });
  })
});


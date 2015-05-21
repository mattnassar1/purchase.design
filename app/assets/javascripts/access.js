var initAccess = function() {
	size();
	var columnWidth = $('.masonry .block:first-child').width();
	
	$('.masonry').masonry({
		itemSelector: '.block',
		columnWidth: columnWidth,
		gutterWidth: 40,
		isFitWidth: true,
		isResizable: true
	});

	$('select').change(function(e) {
		if($(this).val() === '') {
			$(this).css({'opacity':0.7});
		} else {
			$(this).css({'opacity':1});
		}
	});
	imagePreview();
}

function size() {
	$border = $('#border');
	var paddingTop = parseInt($border.css('paddingTop'));
	var paddingBottom = parseInt($border.css('paddingBottom'));
	var border = parseInt($border.css('borderWidth'))*2;
	var notice = $('.notice').innerHeight();
	var padding = paddingTop + paddingBottom + border + notice;
	$border.css({
		height:h() - padding
	});
}

function imagePreview() {
	$('input[type="file"]:not(.no_bg)').each(function() {
		$(this).on('change', function(event) {
			var position = $(this).attr('data-position');
			var input = $(this);
		    var files = event.target.files;
		    var file = files[0]
		    var reader = new FileReader();
		    reader.onload = function(file) {
		      img = file.target.result;
		      $(input).parent('.drop').css({'background-image':'url('+img+')'});
		      $('form#'+position).addClass('can_save');
		    }
		    reader.readAsDataURL(file);
		});
	});
}

$(initAccess);
$(document).on('page:load', initAccess);
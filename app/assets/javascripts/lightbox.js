jQuery(document).ready(function($) {
		$('.lightbox-trigger').click(function(e) {
			
			//prevent default action (hyperlink)
			//Get clicked link href
			var image_href = $(this).attr("src");
			var image_description = $(this).attr('description');
			var last_earned = $(this).attr('last_earned');
			var times_achieved = $(this).attr('times_achieved');
			
			/* 	
			If the lightbox window HTML already exists in document, 
			change the img src to to match the href of whatever link was clicked
			
			If the lightbox window HTML doesn't exists, create it and insert it.
			(This will only happen the first time around)
			*/
			
			if ($('#lightbox').length > 0) { // #lightbox exists
				
				//place href as img src value
				$('#content').html('<img src="' + image_href + '" />' + '<p><span class="badge-label"><b>Description:</b></span> ' + image_description + '</p><p><span class="badge-label"><b>Last Earned:</b></span> ' + last_earned + '</p><p><span class="badge-label"><b>Times Achieved:</b></span> ' + times_achieved + '</p>');
			   	
				//show lightbox window - you could use .show('fast') for a transition
				$('#lightbox').show();
			}
			
			else { //#lightbox does not exist - create and insert (runs 1st time only)
				//create HTML markup for lightbox window
				var lightbox = 
				'<div id="lightbox">' +
					'<div id="lightbox-content" class="debugger">' +
						'<div id="remove-button-container" class="debugger"><span class="glyphicon glyphicon-remove-circle debugger" aria-hidden="true" id="close-lightbox"></span></div>' +
						'<div id="content">' + //insert clicked link's href into img src
							'<img src="' + image_href + '" />' + '<p><span class="badge-label"><b>Description:</b></span> ' + image_description + '</p><p><span class="badge-label"><b>Last Earned:</b></span> ' + last_earned + '</p><p><span class="badge-label"><b>Times Achieved:</b></span> ' + times_achieved + '</p>'
						'</div>' +	
					'</div>' +	
				'</div>';
					
				//insert lightbox HTML into page
				$('body').append(lightbox);
			}
			
		});
		
		//Click anywhere on the page to get rid of lightbox window
		$('#close-lightbox').click(function() { //must use live, as the lightbox element is inserted into the DOM
			$('#lightbox').hide();
		});
});
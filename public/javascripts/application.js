// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
updatePhoto = function(url, updateDivId){
				new Ajax.Request(url,
				  {
				    method:'get',
				    onSuccess: function(transport){
				      document.getElementById(updateDivId).innerHTML = transport.responseText;
				      alert("Success! \n\n" + response);
				    },
				    onFailure: function(){ alert('Something went wrong...') },
					onLoading: function(){ document.getElementById('ajax-progress').style.display='block'; },
					onComplete: function(){ document.getElementById('ajax-progress').style.display='none'; }
					 
				  });

				}
			

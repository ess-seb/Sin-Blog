$(document).ready(function() {
	$(".del_com").click(function(e) {
		e.preventDefault()
		$.post($(this).attr("href"), function( data ) {
			// console.log('#' + data.id + "_comm")
			$('#' + data.id + "_comm").remove()
		});
	});
});
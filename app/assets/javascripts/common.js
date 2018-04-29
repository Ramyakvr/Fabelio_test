$(document).on('page:load',function(){
	formValidation();
});

function formValidation(){
	$('form').each(function () {
		$(this).validate();
	});
}

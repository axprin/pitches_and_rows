$(function(){
	$("#signupform").submit(function(e){
		e.preventDefault();
		var formData = $(this).serialize();
		$.ajax({
			type: "post",
			dataType: "json",
			url: "/users",
			data: formData,
			success: function(response){window.location.href = response.redirect;},
			error: function(response){
				$(".signup_errors").empty();
				var errors = $.parseJSON(response.responseText).errors;
				for(i = 0; i < errors.length; i++){
					$(".signup_errors").append("<li> " + errors[i] + "</li>");
				};
			}
		});
	});

	$("#editform").submit(function(e){
		e.preventDefault();
		var formData = $(this).serialize();
		var edit_url = "/users/" + $("#user_id").val();
		$.ajax({
			type: "put",
			dataType: "json",
			url: edit_url ,
			data: formData,
			success: function(response){
				var redirectUrl = response.redirect
				console.log(redirectUrl)
				window.location.href = redirectUrl
			},
			error: function(response){
				$(".edit_errors").empty();
				var errors = $.parseJSON(response.responseText).errors;
				for(i = 0; i < errors.length; i++){
					$(".edit_errors").append("<li> " + errors[i] + "</li>");
				};
			}
		});
	});
});
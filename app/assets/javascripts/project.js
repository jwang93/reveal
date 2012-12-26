function validateForm() {
	var x=document.forms["myForm"]["name"].value;
	if (x==null || x=="") {
  		alert("Please fill in your name");
  		return false;
  	}
}

$(document).ready(function(){
  $(".flip").click(function(){
    $(".panel").slideDown("slow");
  });
});


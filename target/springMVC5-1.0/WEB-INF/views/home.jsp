<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page session="false" %>
<html>
<head>
	<script src="${pageContext.request.contextPath}/resources/js/jquery/jquery2.1.4.min.js"></script>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<p> Go to the ServiceMap:   <input type="button" value="goMap" id="goMap"  />
</p>
<script>
	$( document ).ready(function() {
		$('#goMap').click(function () {
			//alert(location); //http://localhost:8080/
			//var map = location.toString().split("/");
			//alert(map[2]);
			window.location.replace('http://localhost:8080/map');
		});
	});
</script>
</body>
</html>

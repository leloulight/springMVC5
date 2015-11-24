<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="${pageContext.request.contextPath}/resources/js/jquery/jquery2.1.4.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" type="text/css" />
<title>Grafo Strade</title>
</head>
<body>
<P>  The time on the server is ${serverTime}. </P>
<p> Go to the ServiceMap:   <input type="button" value="goMap" id="goMap"  /></p>
<p> Go to the ServiceMap 2:   <input type="button" value="goMap" id="goMap13"  /></p>
<P> Go to Logback Logging details page:  <input type="button" value="gologBack" id="gologBack"  /></P>
<P> Go to to GTFS Map:  <input type="button" value="goGTFSMap" id="goGTFSMap"  /></P>
<%--<P> Go to to GTFS Map HTML:  <input type="button" value="goGTFSMapH" id="goGTFSMapH"  /></P>--%>
<script>
	$( document ).ready(function() {
		$('#goMap').click(function () {
			//alert(location); //http://localhost:8080/
			//var map = location.toString().split("/");
			//alert(map[2]);
			window.location.replace(location+'map');
		});

		$('#goMap13').click(function () {
			//alert(location); //http://localhost:8080/
			//var map = location.toString().split("/");
			//alert(map[2]);
			window.location.replace(location+'map13');
		});

		$('#goGTFSMap').click(function () {
			window.location.replace(location+'static/test/gtfs.html');
		});

        $('#goGTFSMapH').click(function () {
            window.location.replace(location+'/static/gtfsMap.html');
        });

		$('#gologBack').click(function () {
			//alert(location); //http://localhost:8080/
			//var map = location.toString().split("/");
			//alert(map[2]);
			window.location.replace(location+'lbClassicStatus');
		});


	});
</script>
<div class="wrapper">
<h1>GRAFO STRADE</h1>
<br />

<a href="http://www501.regione.toscana.it/" target="_blank">Osservatorio Trasporti Regione Toscana</a><br />
<br />
<br />
<div class="well">
	<h3>Query Wizard</h3>
	<form action="query.jsp" method="post">
	Via: <input type="text" name="via" id="via" />
	<br />
	Tipo di Servizio: 
	<select name="tipo" id="tipo">
		<option value="">Tutti i servizi</option>
		${MAIN}
	</select>
		<br />
	<input type="submit" value="Esegui Query">
	</form>
	
</div>


</div>
</body>
</html>
<%@page import="java.io.IOException"%>
<%@page import="org.openrdf.model.Value"%>
<%@ page import="java.util.*" %>
<%@ page import="org.openrdf.repository.Repository" %>
<%@ page import="org.openrdf.repository.http.HTTPRepository" %>

<%@ page import="java.util.List" %>
<%@ page import="org.openrdf.OpenRDFException" %>
<%@ page import="org.openrdf.repository.RepositoryConnection" %>
<%@ page import="org.openrdf.query.TupleQuery" %>
<%@ page import="org.openrdf.query.TupleQueryResult" %>
<%@ page import="org.openrdf.query.BindingSet" %>
<%@ page import="org.openrdf.query.QueryLanguage" %>
<%@ page import="java.io.File" %>
<%@ page import="java.net.URL" %>
<%@ page import="org.openrdf.rio.RDFFormat" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css" />
<title>Grafo Strade</title>
</head>
<body>
<div class="wrapper">
<h1>GRAFO STRADE</h1>
<br />

<a href="http://www501.regione.toscana.it/" target="_blank">Osservatorio Trasporti Regione Toscana</a><br />

<% String outputtext = "Hello, world2!<br />" ; %>

<!--  <%=outputtext  %>-->

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
		<%-- INVOKE MAIN --%>

		<%-- END INVOKE MAIN CODE --%>
	</select>
	<br />
	<input type="submit" value="Esegui Query">
	</form>
</div>


</div>
</body>
</html>
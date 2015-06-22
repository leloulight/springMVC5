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
<title>RISULTATI QUERY</title>
</head>
<body>
<div class="wrapper">
<h1>Risultato query</h1>

<div class="well">
	
		<% 

String sesameServer = "http://localhost:8080/openrdf-sesame/";
String repositoryID = "owlim";

Repository repo = new HTTPRepository(sesameServer, repositoryID);
repo.initialize();

String via = request.getParameter("via");
String tipo = request.getParameter("tipo");

if (tipo == ""){
	tipo = "?serviceCategory";
}
else{
	tipo = tipo.toString();
}


try {
	   RepositoryConnection con = repo.getConnection();
	   try {
		  String queryString = "PREFIX :<http://www.disit.dinfo.unifi.it/SiiMobility#> " + 
				  " PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#> " + 
				  " PREFIX vcard:<http://www.w3.org/2006/vcard/ns#> ";
			if (tipo == "?serviceCategory"){
				queryString = queryString + " SELECT DISTINCT ?orgName ?streetAddress ?serviceCategory WHERE { " + 
						" ?road :extendName '" + via.toUpperCase() + "'^^xsd:string . " + 
						" 	?service :isIn ?road . " + 
						" 	?road rdf:type :Road . " + 
						"  ?service vcard:organization-name ?orgName . " + 
						"  ?service vcard:street-address ?streetAddress . " + 
						"  ?service :serviceCategory " + tipo + " . " + 
						" } ";
			}
			else{
				queryString = queryString + " SELECT DISTINCT ?orgName ?streetAddress WHERE { " + 
						" ?road :extendName '" + via.toUpperCase() + "'^^xsd:string . " + 
						" 	?service :isIn ?road . " + 
						" 	?road rdf:type :Road . " + 
						"  ?service vcard:organization-name ?orgName . " + 
						"  ?service vcard:street-address ?streetAddress . " + 
						"  ?service :serviceCategory " + tipo + " . " + 
						" } ";
			}
	   
			
				  
				 
			  
			  
		  TupleQuery tupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString);

		  TupleQueryResult result = tupleQuery.evaluate();
		  try {
			  out.println("<table>");
			  out.println("<tr>");
			  out.println("<td>Nome Servizio</td>");
			  out.println("<td>Indirizzo</td>");
			  out.println("<td>Tipo Servizio</td>");
			  out.println("</tr>");
			  
			  while (result.hasNext()) {
				  
				  out.println("<tr>");
			  BindingSet bindingSet = result.next();
				
				Value valueOfOrgName = bindingSet.getValue("orgName");
				Value valueOfStreetAddress = bindingSet.getValue("streetAddress");
				Value valueOfServiceCategory = null;
				if (tipo == "?serviceCategory"){
					valueOfServiceCategory = bindingSet.getValue("serviceCategory");
				}
				
				
				 out.println("<td>" + valueOfOrgName.toString() + "</td>");
				  out.println("<td>" + valueOfStreetAddress.toString() + "</td>");
				  if (tipo == "?serviceCategory"){
				  out.println("<td>" + valueOfServiceCategory.toString() + "</td>");
				  }
				  else{
					  out.println("<td>" + tipo + "</td>");
				  }
				
				
				out.println("</tr>");
				}
			  out.println("</table>");
			  
		  }
		  finally {
		      result.close();
		      
		  }
	   }
	   finally {
	      con.close();
	   }
	}
	catch (OpenRDFException e) {
	   // handle exception
	   out.println(e.getMessage());
	}

%>


</div>

<a href="main.jsp" title="torna indietro">Torna indietro</a>
</div>
</body>
</html>
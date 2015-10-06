<%@page import="java.io.*"%>
<%@page import="org.openrdf.model.Value"%>
<%@ page import="java.util.*"%>
<%@ page import="org.openrdf.repository.Repository"%>
<%@ page import="org.openrdf.repository.http.HTTPRepository"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="org.openrdf.OpenRDFException"%>
<%@ page import="org.openrdf.repository.RepositoryConnection"%>
<%@ page import="org.openrdf.query.TupleQuery"%>
<%@ page import="org.openrdf.query.TupleQueryResult"%>
<%@ page import="org.openrdf.query.BindingSet"%>
<%@ page import="org.openrdf.query.QueryLanguage"%>
<%@ page import="java.io.File"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.openrdf.rio.RDFFormat"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <!--  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css" />
-->
<title>Riconciliazione Numeri Civici - Grafo Strade</title>
</head>
<body>
	<div class="wrapper">
		<h1>RICONCILIAZIONE NUMERI CIVICI - GRAFO STRADE</h1>
		<br />

		<% 
Connection conMySQL = null;
  Statement st = null;
  ResultSet rs = null;

  Connection conMySQL2 = null;
  Statement st2 = null;
  
  String url = "jdbc:mysql://localhost:3306/";
  String db = "tesi";
  String driver = "com.mysql.jdbc.Driver";
  String user = "ubuntu";
  String pass = "ubuntu";
 
String sesameServer = "http://192.168.0.205:8080/openrdf-sesame/";
String repositoryID = "siimobilityultimate";

Repository repo = new HTTPRepository(sesameServer, repositoryID);
repo.initialize();
RepositoryConnection con = null;

try {
	int i = 0;
	   con = repo.getConnection();
	   try {
		  String queryString = "PREFIX SiiMobility:<http://www.disit.dinfo.unifi.it/SiiMobility#> " + 
"PREFIX xsd:<http://www.w3.org/2001/XMLSchema#> " + 
"PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#> " + 
"SELECT DISTINCT ?ser ?road {" + 
"?ser rdf:type SiiMobility:Service . " + 
"?ser SiiMobility:hasAccess ?entry . " + 
"?nc SiiMobility:hasExternalAccess ?entry . " +
"?nc SiiMobility:belongTo ?road . " + 
"} ";
		  //out.println(queryString);
		  TupleQuery tupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
		  
		  TupleQueryResult result = tupleQuery.evaluate();
		  
		  BufferedWriter file = new BufferedWriter(new FileWriter("C:/grafo/riconciliazione-isin2.n3"));
		  try {
			  while (result.hasNext()) {
			  BindingSet bindingSet = result.next();
				
				String valueOfSer = bindingSet.getValue("ser").toString();
				String valueOfRoad = bindingSet.getValue("road").toString();
				
				file.write("<" + valueOfSer + "> SiiMobility:isIn <" + valueOfRoad + "> . \n");
			    //file.newLine();
			    
				
			} // fine while
			  file.close(); 
		  }
		  catch (OpenRDFException e) {
			   // handle exception
			   out.println(e.getMessage());
			   //out.println("<pre><code>" + queryString2 + "<code></pre>");
			 
			}
		 
		  finally {
		      result.close();
			}
	   }
	   finally {
	      con.close();
	   }
	   out.println("Servizi recuperati: " + Integer.toString(i));
	}
	catch (OpenRDFException e) {
	   // handle exception
	   out.println(e.getMessage());
	}
finally{
	
	con.close();
}
	



%>
	</div>
</body>
</html>
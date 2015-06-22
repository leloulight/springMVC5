<%@page import="java.io.IOException"%>
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


</head>
<body>
	<div class="wrapper">
		<h1>RICONCILIAZIONE NUMERI CIVICI - GRAFO STRADE</h1>
		<br />


		
<%
Connection conMySQL = null;
  Statement st = null;
  ResultSet rs = null;
 
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
conMySQL = DriverManager.getConnection(url + db, user, pass);

String query = "SELECT * FROM `riconciliazione_servizi_non_trovati` WHERE `NUMERO` LIKE '%-%' AND COD_TOP <> '' ORDER BY COMUNE, VIA, NUMERO";

// create the java statement
st = conMySQL.createStatement();

// execute the query, and get a java resultset
rs = st.executeQuery(query);

// iterate through the java resultset
while (rs.next())
{
 
	String id =  rs.getString("ID");
	String comune = rs.getString("COMUNE");
	String via = rs.getString("VIA");
	String numero = rs.getString("NUMERO");
	String servizio = rs.getString("COD_SER");
	String COD_TOP = "<" + rs.getString("COD_TOP") + ">";
	
	String[] arrayNumeri = numero.split("-");
	
	
try {
	
	int i = 0;
	   con = repo.getConnection();
	   try {
		 
				// NUOVA QUERY
				String filtroNumeri = "";
				for (int j = 0; j < arrayNumeri.length; j++){
					if (j == 0){
					filtroNumeri = filtroNumeri + "{ ?nc SiiMobility:extendNumber \"" + arrayNumeri[j] + "\"^^xsd:string . }"; 
					}
					else{
						filtroNumeri = filtroNumeri + " UNION { ?nc SiiMobility:extendNumber \"" + arrayNumeri[j] + "\"^^xsd:string . }";	
					}
				}
				
				
				String queryString2 = "PREFIX SiiMobility:<http://www.disit.dinfo.unifi.it/SiiMobility#> " + 
						"PREFIX xsd:<http://www.w3.org/2001/XMLSchema#> " + 
						"PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#> " + 
						"PREFIX vcard:<http://www.w3.org/2006/vcard/ns#> " + 
						"PREFIX foaf:<http://xmlns.com/foaf/0.1/> " + 
						"PREFIX dcterms:<http://purl.org/dc/terms/> " + 
						"SELECT distinct ?nc ?entry WHERE { " + 
						"	" + COD_TOP + " SiiMobility:hasStreetNumber ?nc .  " + 
						"	?nc SiiMobility:hasExternalAccess ?entry .  " + 
						filtroNumeri +
						"}";
						
				
			
				TupleQuery tupleQuery2 = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString2);
				TupleQueryResult result2 = tupleQuery2.evaluate();
				if (result2.hasNext()){
					//while (result2.hasNext()) {
				  		BindingSet bindingSet2 = result2.next();
				  		Value valueOfNC = bindingSet2.getValue("nc");
				  		Value valueOfEntry = bindingSet2.getValue("entry");
				  		via = via.replaceAll("'","''");
				  		comune = comune.replaceAll("'","''");
				  		i++;
				  		try {
					  		conMySQL = DriverManager.getConnection(url + db, user, pass);
					  		//conMySQL.setAutoCommit(false);// Disables auto-commit.
					  	  	st = conMySQL.createStatement();
					  		String sqlInsert = "INSERT INTO riconciliazione_test (COD_SER, COMUNE, VIA, NUMERO, COD_CIV, COD_ACC) VALUES " + 
					  			  "('" + servizio + "','" + comune + "', '" + via + "', '" + numero + "', '<" + valueOfNC.toString() + ">', '<" + valueOfEntry.toString() + ">')" + 
					  			  " ON DUPLICATE KEY UPDATE COMUNE=VALUES(COMUNE), VIA=VALUES(VIA), NUMERO=VALUES(NUMERO), COD_CIV=VALUES(COD_CIV), COD_ACC=VALUES(COD_ACC);";
					  		String sqlInsert2 = "DELETE FROM riconciliazione_servizi_non_trovati WHERE ID = " + id + ";";  
					  	
					  		st.addBatch(sqlInsert);
					  		st.addBatch(sqlInsert2);
					  	  	st.executeBatch();
					  	  	st.close();
					  		conMySQL.close();
					
				  	  	} 
				  		catch (Exception e) {
				  			out.println(e.getMessage());
				  	  	}
				  	}
			 // 	}
				}
				finally{
			
				}
			
			//	numeroServizi++;
			
			 // out.println("Numero Servizi: " + numeroServizi);
		  }
		  catch (OpenRDFException e) {
			   // handle exception
			   out.println(e.getMessage());
			   //out.println("<pre><code>" + queryString2 + "<code></pre>");
			   //out.println("Numero Servizi: " + numeroServizi);
			}
		  
		  finally {
		     // result.close();
			}
	   }
	
%>
	</div>
</body>
</html>
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

String query = "SELECT * from riconciliazione_servizi_non_trovati WHERE COD_TOP = '' ORDER BY COMUNE, VIA, NUMERO";

// create the java statement
st = conMySQL.createStatement();

// execute the query, and get a java resultset
rs = st.executeQuery(query);

// iterate through the java resultset
while (rs.next())
{
  	String via = rs.getString("VIA");
	String numero = rs.getString("NUMERO");
	String comune = rs.getString("COMUNE");
	String servizio = rs.getString("COD_SER");
	
try {
	
	int i = 0;
	   con = repo.getConnection();
	   try {
		 
				// NUOVA QUERY
				
				String ultimaParola = via.substring(via.lastIndexOf(" ")+1);
				if (ultimaParola.length() >= 2){
					// se l'ultima parola è più corta di due lettere ??	
				
				
		
				String queryString2 = "PREFIX SiiMobility:<http://www.disit.dinfo.unifi.it/SiiMobility#> " + 
				"PREFIX xsd:<http://www.w3.org/2001/XMLSchema#> " + 
				"PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#> " + 
				"PREFIX vcard:<http://www.w3.org/2006/vcard/ns#> " + 
				"PREFIX foaf:<http://xmlns.com/foaf/0.1/> " + 
				"PREFIX dcterms:<http://purl.org/dc/terms/> " + 
				"SELECT distinct ?strada ?nomeVia WHERE { " + 
				
				"{ " + 
				"	?strada SiiMobility:inMunicipalityOf ?comune .  " + 
				"	?comune foaf:name \"" + comune + "\"^^xsd:string .  " + 
				"	?strada SiiMobility:extendName ?nomeVia .  " + 
				"	FILTER contains(ucase(?nomeVia), \"" + ultimaParola + "\"^^xsd:string) . " + 
				//FILTER contains(lcase(?serviceAddr), lcase(?addr))
				"} " + 
				"UNION " + 
				"{ " + 
				"	?strada SiiMobility:inMunicipalityOf ?comune .  " + 
				"	?comune foaf:name \"" + comune + "\"^^xsd:string .  " + 
				"	?strada dcterms:alternative ?nomeVia .  " + 
				"	FILTER contains(ucase(?nomeVia), \"" + ultimaParola + "\"^^xsd:string) .  " + 
				"} " + 
				"}";
				
			
				TupleQuery tupleQuery2 = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString2);
				TupleQueryResult result2 = tupleQuery2.evaluate();
				via = via.replaceAll("'","''");
		  		numero = numero.replaceAll("'","''");
		  		comune = comune.replaceAll("'","''");
					if (result2.hasNext()){
						while (result2.hasNext()) {
					  		BindingSet bindingSet2 = result2.next();
					  		Value valueOfStrada = bindingSet2.getValue("strada");
					  		Value valueOfNomeVia = bindingSet2.getValue("nomeVia");
					  		
					  		String COD_TOP = valueOfStrada.toString();
					  		String NOME_STRADA = valueOfNomeVia.toString().replace("<http://www.w3.org/2001/XMLSchema#string>", "xsd:string");;
					  	
					  		NOME_STRADA = NOME_STRADA.replaceAll("'","''");
					  		
					  		
					  		NOME_STRADA = NOME_STRADA.toUpperCase();
							
					  		NOME_STRADA = NOME_STRADA.replace("^^XSD:STRING", "");
					  		NOME_STRADA = NOME_STRADA.replace("\"", "");
					  		Connection conMySQL2 = DriverManager.getConnection(url + db, user, pass);
						  	try {
						  		
						  		//conMySQL.setAutoCommit(false);// Disables auto-commit.
						  	  	Statement st2 = conMySQL2.createStatement();
						  		String sqlInsert = "INSERT INTO riconciliazione_servizi_ultima_parola (COD_SER, COMUNE, VIA, NUMERO, COD_TOP, NOME_STRADA) VALUES " + 
						  			  "('" + servizio + "','" + comune + "', '" + via + "', '" + numero + "', '" + COD_TOP + "', '" + NOME_STRADA + "')" + 
						  			  " ON DUPLICATE KEY UPDATE COMUNE=VALUES(COMUNE), VIA=VALUES(VIA), NUMERO=VALUES(NUMERO), NOME_STRADA=VALUES(NOME_STRADA);";
						  	  	st2.addBatch(sqlInsert);
						  	  	st2.executeBatch();
						  	  	st2.close();
						  		conMySQL2.close();
					
					  	  	} 
					  		catch (Exception e) {
					  			out.println(e.getMessage());
					  	  	}
						  	finally{
						  		conMySQL2.close();	
						  	}
					  	}
				  	}
				}	
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
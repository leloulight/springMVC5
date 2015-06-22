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
	
String query = "SELECT * from backupriconciliazione_servizi_non_trovati WHERE SUBSTRING_INDEX(`VIA`,' ',-1) REGEXP '[0-9]+' AND NUMERO = ''";

// create the java statement
st = conMySQL.createStatement();

// execute the query, and get a java resultset
rs = st.executeQuery(query);

// iterate through the java resultset
while (rs.next())
{
  
	String indirizzo = rs.getString("VIA");
	String comune = rs.getString("COMUNE");
	String servizio = rs.getString("COD_SER");
	String numero = indirizzo.substring(indirizzo.lastIndexOf(" ")+1);
	String via = indirizzo.replace(" " + numero, "");

try {
	
	
	
	int i = 0;
	   con = repo.getConnection();
	   try {
		 
				// NUOVA QUERY
				
				String filtroColore = "{?nc SiiMobility:classCode \"Nero\"^^xsd:string . } " +
							"UNION {?nc SiiMobility:classCode \"Privo colore\"^^xsd:string . } ";
				
				String queryString2 = "PREFIX SiiMobility:<http://www.disit.dinfo.unifi.it/SiiMobility#> " + 
				"PREFIX xsd:<http://www.w3.org/2001/XMLSchema#> " + 
				"PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#> " + 
				"PREFIX vcard:<http://www.w3.org/2006/vcard/ns#> " + 
				"PREFIX foaf:<http://xmlns.com/foaf/0.1/> " + 
				"PREFIX dcterms:<http://purl.org/dc/terms/> " + 
				"SELECT distinct ?nc ?entry WHERE { " + 
				
				"{ " + 
				"	?strada SiiMobility:inMunicipalityOf ?comune .  " + 
				"	?comune foaf:name \"" + comune + "\"^^xsd:string .  " + 
				"	?strada SiiMobility:extendName ?nomeVia .  " + 
				"	FILTER (ucase(?nomeVia) = \"" + via + "\"^^xsd:string) . " + 
				"	?strada SiiMobility:hasStreetNumber ?nc .  " + 
				"	?nc SiiMobility:hasExternalAccess ?entry .  " + 
				"	?nc SiiMobility:extendNumber \"" + numero + "\"^^xsd:string .  " + 
				filtroColore +
				"} " + 
				"UNION " + 
				"{ " + 
				"	?strada SiiMobility:inMunicipalityOf ?comune .  " + 
				"	?comune foaf:name \"" + comune + "\"^^xsd:string .  " + 
				"	?strada dcterms:alternative ?nomeAlternativo .  " + 
				"	FILTER (ucase(?nomeAlternativo) = \"" + via + "\"^^xsd:string) .  " + 
				"	?strada SiiMobility:hasStreetNumber ?nc .  " + 
				"	?nc SiiMobility:hasExternalAccess ?entry .  " + 
				"	?nc SiiMobility:extendNumber \"" + numero + "\"^^xsd:string .  " + 
				filtroColore + 
				"} " + 
				"}";
				
				
				
				//"?strada SiiMobility:inMunicipalityOf ?comune . " + 
				//"?comune foaf:name " + valueOfLoc + " . " + 
				//"?strada SiiMobility:extendName ?nomeVia . " + 
				//"?strada SiiMobility:hasStreetNumber ?nc . " + 
				//"?nc SiiMobility:hasExternalAccess ?entry . " + 
				//"?nc SiiMobility:extendNumber " + valueOfNumero + " . " + 
				//filtroColore + 
				//"<" + nuovoValueOfVia + ":> fts:matchIgnoreCase ?nomeVia. " + 
				//"<" + nuovoValueOfLoc + ":> fts:matchIgnoreCase ?nomeComune. " + 
				//"FILTER (lcase(?nomeComune) = " + valueOfLoc.toString() + ") . " + 
				//"FILTER (ucase(?nomeVia) = " + valueOfVia.toString() + ") . " + 
				//"FILTER (lcase(?numeroCivico) = " + valueOfNumero.toString() + ") . " +
				//"OPTIONAL { " + 
				//	"?strada dcterms:alternative ?nomeAlternativo . " +  
				//	"FILTER (ucase(?nomeAlternativo) = " + valueOfVia.toString() + ") . " + 
				//"} " + 
				//"}";
				//out.println(queryString2 + "\n\n\n");

				TupleQuery tupleQuery2 = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString2);
				TupleQueryResult result2 = tupleQuery2.evaluate();
			
					if (result2.hasNext()){
						while (result2.hasNext()) {
					  		BindingSet bindingSet2 = result2.next();
					  		Value valueOfNC = bindingSet2.getValue("nc");
					  		Value valueOfEntry = bindingSet2.getValue("entry");
					  		String numeroCivico = numero;
					  		numeroCivico = numeroCivico.replace("\"", "");
					  		numeroCivico = numeroCivico.replaceAll("'","''");
						  	
						  	via = via.replaceAll("'","''");
						  	
						  
						  	comune = comune.replaceAll("'","''");
						  	i++;
					  		try {
						  		conMySQL = DriverManager.getConnection(url + db, user, pass);
						  		//conMySQL.setAutoCommit(false);// Disables auto-commit.
						  	  	st = conMySQL.createStatement();
						  		String sqlInsert = "INSERT INTO riconciliazione_test (COD_SER, COMUNE, VIA, NUMERO, COD_CIV, COD_ACC) VALUES " + 
						  			  "('<" + servizio + ">','" + comune + "', '" + via + "', '" + numeroCivico + "', '<" + valueOfNC.toString() + ">', '<" + valueOfEntry.toString() + ">')" + 
						  			  " ON DUPLICATE KEY UPDATE COMUNE=VALUES(COMUNE), VIA=VALUES(VIA), NUMERO=VALUES(NUMERO), COD_CIV=VALUES(COD_CIV), COD_ACC=VALUES(COD_ACC);";
						  	  	st.addBatch(sqlInsert);
						  	  	st.executeBatch();
						  	  	st.close();
						  		conMySQL.close();
						 
					  	  	} 
					  		catch (Exception e) {
					  			out.println(e.getMessage());
					  	  	}
					  	}
				  	}
					else{
						
						// SE NON TROVO IL CIVICO ALMENO CERCO LA STRADA
						
						String queryString3 = "PREFIX SiiMobility:<http://www.disit.dinfo.unifi.it/SiiMobility#> " + 
				"PREFIX xsd:<http://www.w3.org/2001/XMLSchema#> " + 
				"PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#> " + 
				"PREFIX vcard:<http://www.w3.org/2006/vcard/ns#> " + 
				"PREFIX foaf:<http://xmlns.com/foaf/0.1/> " + 
				"PREFIX dcterms:<http://purl.org/dc/terms/> " + 
				"SELECT distinct ?strada WHERE { " + 
				"{ " + 
						
				"?strada SiiMobility:inMunicipalityOf ?comune . " + 
				"?comune foaf:name \"" + comune + "\"^^xsd:string . " + 
				"?strada SiiMobility:extendName ?nomeVia . " + 	
				"FILTER (ucase(?nomeVia) = \"" + via + "\"^^xsd:string) . " + 
				
				"} UNION { " + 
				
					"?strada SiiMobility:inMunicipalityOf ?comune . " + 
					"?comune foaf:name \"" + comune + "\"^^xsd:string . " + 
					"?strada dcterms:alternative ?nomeAlternativo . " + 	
					"FILTER (ucase(?nomeAlternativo) = \"" + via + "\"^^xsd:string) . " + 	
				"}" + 
				"}";
				
				TupleQuery tupleQuery3 = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString3);
				TupleQueryResult result3 = tupleQuery3.evaluate();
				String valueOfStrada = "";
				if (result3.hasNext()){
					while (result3.hasNext()) {
				  		BindingSet bindingSet3 = result3.next();
				  		valueOfStrada = bindingSet3.getValue("strada").toString();
					}
				}
						
						String numeroCivico = numero;
						numeroCivico = numeroCivico.replace("\"", "");
						numeroCivico = numeroCivico.replaceAll("'","''");
					  	via = via.replaceAll("'","''");
					  	comune = comune.replaceAll("'","''");
					  
						try {
					  		conMySQL = DriverManager.getConnection(url + db, user, pass);
					  		//conMySQL.setAutoCommit(false);// Disables auto-commit.
					  	  	st = conMySQL.createStatement();
					  		String sqlInsert = "INSERT INTO riconciliazione_servizi_non_trovati (COD_SER, COMUNE, VIA, NUMERO, COD_TOP) VALUES " + 
					  			  "('<" + servizio + ">','" + comune + "', '" + via + "', '" + numeroCivico + "', '" + valueOfStrada + "')" + 
					  			  " ON DUPLICATE KEY UPDATE COMUNE=VALUES(COMUNE), VIA=VALUES(VIA), NUMERO=VALUES(NUMERO), COD_TOP=VALUES(COD_TOP);";
					  	  	st.addBatch(sqlInsert);
					  	  	st.executeBatch();
					  	  	st.close();
					  		conMySQL.close();
						} 
						catch (Exception e) {
							out.println(e.getMessage());
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
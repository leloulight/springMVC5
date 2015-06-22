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
	
String query = "SELECT DISTINCT t1.COMUNE AS LOCALITA, t2.COMUNE AS COMUNE FROM `riconciliazione_servizi_non_trovati` t1 join localita_comuni t2 on t2.LOCALITA = t1.COMUNE " + 
"WHERE t1.COMUNE NOT IN " + 
"(SELECT DISTINCT DEN_UFF from tbl_elenco_comuni)";

// create the java statement
st = conMySQL.createStatement();

// execute the query, and get a java resultset
rs = st.executeQuery(query);

// iterate through the java resultset
while (rs.next())
{
  
  String localita = rs.getString("LOCALITA");
  String nuovo_comune = rs.getString("COMUNE");

try {
	
	
	
	int i = 0;
	   con = repo.getConnection();
	   try {
		  String queryString = "PREFIX SiiMobility:<http://www.disit.dinfo.unifi.it/SiiMobility#> " + 
"PREFIX xsd:<http://www.w3.org/2001/XMLSchema#> " + 
"PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#> " + 
"PREFIX vcard:<http://www.w3.org/2006/vcard/ns#> " + 
"PREFIX foaf:<http://xmlns.com/foaf/0.1/> " + 
"SELECT distinct  ?ser ?loc ?serviceAddr ?via ?numero {  " + 
"?ser rdf:type SiiMobility:Service . " + 
"?ser vcard:locality ?comune . " + 
"?ser vcard:street-address ?serviceAddr . " + 
"bind( IF(strbefore( ?serviceAddr, \",\" ) = \"\", ?serviceAddr, strbefore( ?serviceAddr, \",\" )) as ?via ) . " + 
"bind( strafter( ?serviceAddr, \", \" ) as ?numero ) . " + 
"FILTER NOT EXISTS {?ser SiiMobility:hasAccess ?inRoad .} " + 
"FILTER (ucase(?comune) = \"" + localita + "\"^^xsd:string) . " +
"} " + 
"ORDER BY ?loc ?via ?numero";
//"LIMIT 150 OFFSET " + Integer.toString(offset);

		  //out.println(queryString);
		  TupleQuery tupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
		  
		  TupleQueryResult result = tupleQuery.evaluate();
		  String queryString2 = "";
		  int numeroServizi = 0;
		  try {
			  while (result.hasNext()) {
			  BindingSet bindingSet = result.next();
				
				String valueOfSer = bindingSet.getValue("ser").toString().replace("<http://www.w3.org/2001/XMLSchema#string>", "xsd:string");
				//String valueOfLoc= bindingSet.getValue("loc").toString().replace("<http://www.w3.org/2001/XMLSchema#string>", "xsd:string");
				String valueOfLoc = "\"" + localita + "\"^^xsd:string";
				String valueOfVia= bindingSet.getValue("via").toString().replace("<http://www.w3.org/2001/XMLSchema#string>", "xsd:string");
				String valueOfNumero = bindingSet.getValue("numero").toString().replace("<http://www.w3.org/2001/XMLSchema#string>", "xsd:string");
				
				valueOfLoc = valueOfLoc.toUpperCase();
				valueOfVia = valueOfVia.toUpperCase();
				valueOfNumero = valueOfNumero.toUpperCase();
				
				valueOfLoc = valueOfLoc.replace(localita, nuovo_comune);
				
				valueOfVia = valueOfVia.replace("^^XSD:STRING", "^^xsd:string");
				valueOfLoc = valueOfLoc.replace("^^XSD:STRING", "^^xsd:string");
				valueOfNumero = valueOfNumero.replace("^^XSD:STRING", "^^xsd:string");
				
				if (!valueOfNumero.contains("xsd:string")){
					valueOfNumero = valueOfNumero + "xsd:string";
				}
				
				//valueOfVia = valueOfVia.replace("^^xsd:string", "");
				//valueOfVia = valueOfVia.replace("\"", "");
				//String[] arrayVia = valueOfVia.split(" ");
				//String nuovoValueOfVia = Arrays.toString(arrayVia).replace(", ", ":").replaceAll("[\\[\\]]", "");
			
				//valueOfLoc = valueOfLoc.replace("^^xsd:string", "");
				//valueOfLoc = valueOfLoc.replace("\"", "");
				//String[] arrayLoc = valueOfLoc.split(" ");
				//String nuovoValueOfLoc = Arrays.toString(arrayLoc).replace(", ", ":").replaceAll("[\\[\\]]", "");
				
				
				// RIMUOVO EVENTUALI PARENTESI ()
				if (valueOfNumero.indexOf(" (") != -1){
					int inizio = valueOfNumero.indexOf(" (");
					int fine = valueOfNumero.indexOf(")");
					if (fine != -1){
						valueOfNumero = valueOfNumero.replace(valueOfNumero.substring(inizio, fine + 1), "");
					}
					
				}
				//valueOfNumero = valueOfNumero.replaceAll("\\ (.*)","");
				
				// RIMUOVO OCCORRENZE DI -
				if (valueOfNumero.indexOf(" - ") != -1){
					int inizio = valueOfNumero.indexOf(" - ");
					int fine = valueOfNumero.indexOf("\"^^");
					valueOfNumero = valueOfNumero.replace(valueOfNumero.substring(inizio, fine), "");
				}
				
				// RIMUOVO OCCORRENZE DI -
				if (valueOfNumero.indexOf(" -") != -1){
					int inizio = valueOfNumero.indexOf(" -");
					int fine = valueOfNumero.indexOf("\"^^");
					valueOfNumero = valueOfNumero.replace(valueOfNumero.substring(inizio, fine), "");
				}
				
				
				String filtroColore = "";
				if (valueOfNumero.contains("R") || valueOfNumero.contains("/R"))
				{
					filtroColore = "?nc SiiMobility:classCode \"Rosso\"^^xsd:string .  ";
					//filtroNumero = "{?nc SiiMobility:extendNumber " + valueOfNumero + " . } " +
					//		"UNION {?nc SiiMobility:extendNumber " + valueOfNumero + " . } ";
					valueOfNumero = valueOfNumero.replace("/R", "");
					valueOfNumero = valueOfNumero.replace("R", "");
					
				}
				else{
					filtroColore = "{?nc SiiMobility:classCode \"Nero\"^^xsd:string . } " +
							"UNION {?nc SiiMobility:classCode \"Privo colore\"^^xsd:string . } ";
				}
				// NUOVA QUERY
				try {
				queryString2 = "PREFIX SiiMobility:<http://www.disit.dinfo.unifi.it/SiiMobility#> " + 
				"PREFIX xsd:<http://www.w3.org/2001/XMLSchema#> " + 
				"PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#> " + 
				"PREFIX vcard:<http://www.w3.org/2006/vcard/ns#> " + 
				"PREFIX foaf:<http://xmlns.com/foaf/0.1/> " + 
				"PREFIX dcterms:<http://purl.org/dc/terms/> " + 
				"SELECT distinct ?nc ?entry WHERE { " + 
				
				"{ " + 
				"	?strada SiiMobility:inMunicipalityOf ?comune .  " + 
				"	?comune foaf:name " + valueOfLoc + " .  " + 
				"	?strada SiiMobility:extendName ?nomeVia .  " + 
				"	FILTER (ucase(?nomeVia) = " + valueOfVia.toString() + ") . " + 
				"	?strada SiiMobility:hasStreetNumber ?nc .  " + 
				"	?nc SiiMobility:hasExternalAccess ?entry .  " + 
				"	?nc SiiMobility:extendNumber " + valueOfNumero + " .  " + 
				filtroColore +
				"} " + 
				"UNION " + 
				"{ " + 
				"	?strada SiiMobility:inMunicipalityOf ?comune .  " + 
				"	?comune foaf:name " + valueOfLoc + " .  " + 
				"	?strada dcterms:alternative ?nomeAlternativo .  " + 
				"	FILTER (ucase(?nomeAlternativo) = " + valueOfVia.toString() + ") .  " + 
				"	?strada SiiMobility:hasStreetNumber ?nc .  " + 
				"	?nc SiiMobility:hasExternalAccess ?entry .  " + 
				"	?nc SiiMobility:extendNumber " + valueOfNumero + " .  " + 
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
					  		String numeroCivico = valueOfNumero.toString().replace("^^xsd:string", "");
					  		numeroCivico = numeroCivico.replace("\"", "");
					  		numeroCivico = numeroCivico.replaceAll("'","''");
						  	String via = valueOfVia.replace("^^xsd:string", "");
						  	via = via.replace("\"", "");
						  	via = via.replaceAll("'","''");
						  	String comune = valueOfLoc.replace("^^xsd:string", "");
						  	comune = comune.replace("\"", "");
						  	comune = comune.replaceAll("'","''");
						  	i++;
					  		try {
						  		conMySQL = DriverManager.getConnection(url + db, user, pass);
						  		//conMySQL.setAutoCommit(false);// Disables auto-commit.
						  	  	st = conMySQL.createStatement();
						  		String sqlInsert = "INSERT INTO riconciliazione_test (COD_SER, COMUNE, VIA, NUMERO, COD_CIV, COD_ACC) VALUES " + 
						  			  "('<" + valueOfSer + ">','" + comune + "', '" + via + "', '" + numeroCivico + "', '<" + valueOfNC.toString() + ">', '<" + valueOfEntry.toString() + ">')" + 
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
				"?comune foaf:name " + valueOfLoc + " . " + 
				"?strada SiiMobility:extendName ?nomeVia . " + 	
				"FILTER (ucase(?nomeVia) = " + valueOfVia.toString() + ") . " + 
				
				"} UNION { " + 
				
					"?strada SiiMobility:inMunicipalityOf ?comune . " + 
					"?comune foaf:name " + valueOfLoc + " . " + 
					"?strada dcterms:alternative ?nomeAlternativo . " + 	
					"FILTER (ucase(?nomeAlternativo) = " + valueOfVia.toString() + ") . " + 	
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
						
						String numeroCivico = valueOfNumero.toString().replace("^^xsd:string", "");
						numeroCivico = numeroCivico.replace("\"", "");
						numeroCivico = numeroCivico.replaceAll("'","''");
					  	String via = valueOfVia.replace("^^xsd:string", "");
					  	via = via.replace("\"", "");
					  	via = via.replaceAll("'","''");
					  	String comune = valueOfLoc.replace("^^xsd:string", "");
					  	comune = comune.replace("\"", "");
					  	comune = comune.replaceAll("'","''");
					  
						try {
					  		conMySQL = DriverManager.getConnection(url + db, user, pass);
					  		//conMySQL.setAutoCommit(false);// Disables auto-commit.
					  	  	st = conMySQL.createStatement();
					  		nuovo_comune = nuovo_comune.replace("'", "''");
					  		String sqlInsert = "INSERT INTO riconciliazione_servizi_non_trovati (COD_SER, COMUNE, VIA, NUMERO, COD_TOP) VALUES " + 
					  			  "('<" + valueOfSer + ">','" + nuovo_comune + "', '" + via + "', '" + numeroCivico + "', '" + valueOfStrada + "')" + 
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
				catch (OpenRDFException e) {
					// handle exception
					out.println(e.getMessage());
					out.println(queryString2);
					out.println("Numero Servizi: " + numeroServizi);
				}
			
				numeroServizi++;
			} // fine while
			  out.println("Numero Servizi: " + numeroServizi);
		  }
		  catch (OpenRDFException e) {
			   // handle exception
			   out.println(e.getMessage());
			   out.println("<pre><code>" + queryString2 + "<code></pre>");
			   out.println("Numero Servizi: " + numeroServizi);
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
	
}


%>
	</div>
</body>
</html>
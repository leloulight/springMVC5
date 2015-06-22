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
"PREFIX geo:<http://www.w3.org/2003/01/geo/wgs84_pos#> " + 
"SELECT distinct  ?ser ?slat ?slong {  " + 
"?ser rdf:type SiiMobility:Service . " + 
"?ser geo:lat ?slat . " + 
"?ser geo:long ?slong . " +
"FILTER NOT EXISTS {?ser SiiMobility:isIn ?inRoad} " + 
"} ";
		  //out.println(queryString);
		  TupleQuery tupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
		  
		  TupleQueryResult result = tupleQuery.evaluate();
		  
		  
		  int numeroServizi = 0;
		  try {
			  while (result.hasNext()) {
			  BindingSet bindingSet = result.next();
				
				String valueOfSer = bindingSet.getValue("ser").toString();
				String valueOfSLat = bindingSet.getValue("slat").toString();
				String valueOfSLong = bindingSet.getValue("slong").toString();
				
				valueOfSLat = valueOfSLat.replace("\"^^<http://www.w3.org/2001/XMLSchema#float>", "");
				valueOfSLat = valueOfSLat.replace("\"^^<http://www.w3.org/2001/XMLSchema#decimal>", "");
				valueOfSLat = valueOfSLat.replace("\"", "");
				 
				valueOfSLong = valueOfSLong.replace("\"^^<http://www.w3.org/2001/XMLSchema#float>", "");
				valueOfSLong = valueOfSLong.replace("\"^^<http://www.w3.org/2001/XMLSchema#decimal>", "");
				valueOfSLong = valueOfSLong.replace("\"", "");
			
				 conMySQL = DriverManager.getConnection(url + db, user, pass);

				  String query = "SELECT URI_ACC FROM `riconciliazione_geocode` WHERE `URI_SER` = '" + valueOfSer + "'";

				  // create the java statement
				  st = conMySQL.createStatement();
				  // execute the query, and get a java resultset
				  rs = st.executeQuery(query);
				 
				  // iterate through the java resultset
				  if (rs.next())
				  {
				   
				  	String URI_ACC =  rs.getString("URI_ACC");
				  	st.close();
				  	conMySQL.close();
				  	if (URI_ACC.equals("")){
				  		/*try {
				  		
							String queryString2 = "PREFIX SiiMobility:<http://www.disit.dinfo.unifi.it/SiiMobility#> " + 
									"PREFIX geo:<http://www.w3.org/2003/01/geo/wgs84_pos#> " + 
									"	PREFIX xsd:<http://www.w3.org/2001/XMLSchema#> " + 
									"	PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#> " + 
									"	PREFIX omgeo:<http://www.ontotext.com/owlim/geo#> " + 
									"	SELECT distinct ?entry ?nc ?road ?com " + 
									"	WHERE { " + 
									"	?entry rdf:type SiiMobility:Entry . " + 
									"	?nc SiiMobility:hasExternalAccess ?entry . " + 		
									"	?nc SiiMobility:belongTo ?road . " + 
									"	?entry geo:lat ?elat . " + 
									"	 ?entry geo:long ?elong . " + 
									"	?road SiiMobility:inMunicipalityOf ?com . " +
									"	?entry omgeo:nearby(" + valueOfSLat + " " + valueOfSLong + "  \"0.2km\") . " + 
									" BIND( omgeo:distance(?elat, ?elong, " + valueOfSLat + ", " + valueOfSLong + ") AS ?distanza)	" + 
									"	} " +  
									"ORDER BY ?distanza " + 
									"LIMIT 1";
						
						
						TupleQuery tupleQuery2 = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString2);
						TupleQueryResult result2 = tupleQuery2.evaluate();
					
							if (result2.hasNext()){
							  		BindingSet bindingSet2 = result2.next();
							  		String valueOfNC = bindingSet2.getValue("nc").toString();
							  		String valueOfEntry = bindingSet2.getValue("entry").toString();
							  		String valueOfRoad = bindingSet2.getValue("road").toString();
							  		String valueOfCom = bindingSet2.getValue("com").toString();
							  		
							  		i++;
							  		try {
								  		conMySQL2 = DriverManager.getConnection(url + db, user, pass);
								  		//conMySQL.setAutoCommit(false);// Disables auto-commit.
								  	  	st2 = conMySQL2.createStatement();
								  		String sqlInsert2 = "INSERT INTO riconciliazione_geocode (URI_SER, URI_ACC, URI_CIV, URI_ROAD, URI_COM) VALUES " + 
								  			  "('" + valueOfSer + "','" + valueOfEntry + "', '" + valueOfNC + "', '" + valueOfRoad + "', '" + valueOfCom + "')" + 
								  			  " ON DUPLICATE KEY UPDATE URI_ACC=VALUES(URI_ACC), URI_CIV=VALUES(URI_CIV), URI_ROAD=VALUES(URI_ROAD), URI_COM=VALUES(URI_COM);";
								  	  	st2.addBatch(sqlInsert2);
								  	  	st2.executeBatch();
								  	  	st2.close();
								  		conMySQL2.close();
								 
							  	  	} 
							  		catch (Exception e) {
							  			out.println(e.getMessage());
							  	  	}
							  	
						  	}
							else{
								 conMySQL2 = DriverManager.getConnection(url + db, user, pass);
						  		//conMySQL.setAutoCommit(false);// Disables auto-commit.
						  	  	st2 = conMySQL2.createStatement();
						  		String sqlInsert2 = "INSERT INTO riconciliazione_geocode (URI_SER, URI_ACC) VALUES " + 
						  			  "('" + valueOfSer + "', '')" + 
						  			  " ON DUPLICATE KEY UPDATE URI_ACC=VALUES(URI_ACC);";
						  	  	st2.addBatch(sqlInsert2);
						  	  	st2.executeBatch();
						  	  	st2.close();
						  		conMySQL2.close(); 
							}
						
						}
						catch (OpenRDFException e) {
							// handle exception
							out.println(e.getMessage());
							//out.println(queryString2);
							out.println("Numero Servizi: " + numeroServizi);
						}
				  		*/
				  	}
				  	
				  }
				  else{
					  String queryString2 = "PREFIX SiiMobility:<http://www.disit.dinfo.unifi.it/SiiMobility#> " + 
								"PREFIX geo:<http://www.w3.org/2003/01/geo/wgs84_pos#> " + 
								"	PREFIX xsd:<http://www.w3.org/2001/XMLSchema#> " + 
								"	PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#> " + 
								"	PREFIX omgeo:<http://www.ontotext.com/owlim/geo#> " + 
								"	SELECT distinct ?entry ?nc ?road ?com " + 
								"	WHERE { " + 
								"	?entry rdf:type SiiMobility:Entry . " + 
								"	?nc SiiMobility:hasExternalAccess ?entry . " + 		
								"	?nc SiiMobility:belongTo ?road . " + 
								"	?entry geo:lat ?elat . " + 
								"	 ?entry geo:long ?elong . " + 
								"	?road SiiMobility:inMunicipalityOf ?com . " +
								"	?entry omgeo:nearby(" + valueOfSLat + " " + valueOfSLong + "  \"0.2km\") . " + 
								" BIND( omgeo:distance(?elat, ?elong, " + valueOfSLat + ", " + valueOfSLong + ") AS ?distanza)	" + 
								"	} " +  
								"ORDER BY ?distanza " + 
								"LIMIT 1";
					
				
					TupleQuery tupleQuery2 = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString2);
					TupleQueryResult result2 = tupleQuery2.evaluate();
				
						if (result2.hasNext()){
						  		BindingSet bindingSet2 = result2.next();
						  		String valueOfNC = bindingSet2.getValue("nc").toString();
						  		String valueOfEntry = bindingSet2.getValue("entry").toString();
						  		String valueOfRoad = bindingSet2.getValue("road").toString();
						  		String valueOfCom = bindingSet2.getValue("com").toString();
						  		
						  		i++;
						  		try {
							  		conMySQL2 = DriverManager.getConnection(url + db, user, pass);
							  		//conMySQL.setAutoCommit(false);// Disables auto-commit.
							  	  	st2 = conMySQL2.createStatement();
							  		String sqlInsert2 = "INSERT INTO riconciliazione_geocode (URI_SER, URI_ACC, URI_CIV, URI_ROAD, URI_COM) VALUES " + 
							  			  "('" + valueOfSer + "','" + valueOfEntry + "', '" + valueOfNC + "', '" + valueOfRoad + "', '" + valueOfCom + "')" + 
							  			  " ON DUPLICATE KEY UPDATE URI_ACC=VALUES(URI_ACC), URI_CIV=VALUES(URI_CIV), URI_ROAD=VALUES(URI_ROAD), URI_COM=VALUES(URI_COM);";
							  	  	st2.addBatch(sqlInsert2);
							  	  	st2.executeBatch();
							  	  	st2.close();
							  		conMySQL2.close();
							 
						  	  	} 
						  		catch (Exception e) {
						  			out.println(e.getMessage());
						  	  	}
						  	
					  	}
						else{
							 conMySQL2 = DriverManager.getConnection(url + db, user, pass);
					  		//conMySQL.setAutoCommit(false);// Disables auto-commit.
					  	  	st2 = conMySQL2.createStatement();
					  		String sqlInsert2 = "INSERT INTO riconciliazione_geocode (URI_SER, URI_ACC) VALUES " + 
					  			  "('" + valueOfSer + "', '')" + 
					  			  " ON DUPLICATE KEY UPDATE URI_ACC=VALUES(URI_ACC);";
					  	  	st2.addBatch(sqlInsert2);
					  	  	st2.executeBatch();
					  	  	st2.close();
					  		conMySQL2.close(); 
						}
				
				st.close();
			  	conMySQL.close();
			  }
				numeroServizi++;
			} // fine while
			  out.println("Numero Servizi: " + numeroServizi);
		  }
		  catch (OpenRDFException e) {
			   // handle exception
			   out.println(e.getMessage());
			   //out.println("<pre><code>" + queryString2 + "<code></pre>");
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
	



%>
	</div>
</body>
</html>
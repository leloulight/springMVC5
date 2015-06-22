<%@page import="java.io.IOException"%>
<%@page import="org.openrdf.model.Value"%>
<%@ page import="java.util.*"%>
<%@ page import="org.openrdf.repository.Repository"%>
<%@ page import="org.openrdf.repository.http.HTTPRepository"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="org.openrdf.query.BooleanQuery"%>
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css" />
<title>Riconciliazione Nomi Strade - Grafo Strade</title>
</head>
<body>

	<div class="wrapper">
		<h1>RICONCILIAZIONE NOMI STRADE - GRAFO STRADE</h1>
		<br />
		<%
			Connection conMySQL = null;
			Statement st = null;
			ResultSet rs = null;
			
			Connection conMySQL2 = null;
			Statement st2 = null;
			ResultSet rs2 = null;


			String url = "jdbc:mysql://localhost:3306/";
			String db = "tesi";
			String driver = "com.mysql.jdbc.Driver";
			String user = "ubuntu";
			String pass = "ubuntu";

			String sesameServer = "http://192.168.0.205:8080/openrdf-sesame/";
			String repositoryID = "siimobilityultimate";

			Repository repo = new HTTPRepository(sesameServer, repositoryID);
			repo.initialize();

			int sumcount = 0;

			
				Class.forName(driver).newInstance();
				conMySQL = DriverManager.getConnection(url + db, user, pass);
				String query = "select * from riconciliazione_strade";
				st = conMySQL.createStatement();
				rs = st.executeQuery(query);
				
				while (rs.next()) {
					for (int i = 2; i <= 7; i++){
						if (rs.getString(i).equals("") || rs.getString(i).equals("A") || rs.getString(i).equals("E") || rs.getString(i).equals("I") || 
								rs.getString(i).equals("O") || rs.getString(i).equals("U") || rs.getString(i).equals("V") || rs.getString(i).equals("S") || 
								rs.getString(i).equals(" ")){
							// non fare niente
						}
					    else{
							String daSostituire = rs.getString(i);
							for (int j = 2; j <= 7; j++){
								if (j == i){
									// non fare niente
								}
								else{
									if (rs.getString(j).equals("")){
										// non fare niente
									}
									else{
										String sostituisciCon = rs.getString(j);
										
										 RepositoryConnection con = repo.getConnection();
										 
										 String queryString = "PREFIX SiiMobility:<http://www.disit.dinfo.unifi.it/SiiMobility#> " +  
										 "PREFIX xsd:<http://www.w3.org/2001/XMLSchema#>  " + 
										 "PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#> " + 
										 "PREFIX dcterms:<http://purl.org/dc/terms/> " + 
										 "SELECT DISTINCT ?roadURI ?nomeStrada " + 
										 "WHERE { " + 
										 "?roadURI rdf:type SiiMobility:Road . " + 
										 "?roadURI SiiMobility:extendName ?nomeStrada .  " + 
										 //"?roadURI dcterms:alternative ?nomeAlternative .  " + 
										 "FILTER " + rs.getString(8) + "(ucase(?nomeStrada), \"" + daSostituire + "\"^^xsd:string ) . " + 
										 //"UNION {FILTER " + rs.getString(8) + "(ucase(?nomeAlternativo), \"" + daSostituire + "\"^^xsd:string ) . }" + 
										 "}";
							
									
										TupleQuery tupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
										 TupleQueryResult result = tupleQuery.evaluate();
										try{
										 while (result.hasNext()) {
											 try{
											  BindingSet bindingSet = result.next();
											  String valueOfRoadUri = bindingSet.getValue("roadURI").toString();
											  String valueOfNomeStrada = bindingSet.getValue("nomeStrada").toString().replace("<http://www.w3.org/2001/XMLSchema#string>", "xsd:string");
											  
											  String nuovoNomeStrada = valueOfNomeStrada.replace(daSostituire, sostituisciCon);
											  
											  // PRIMA CERCO NEL REPO -> SE LA TRIPLA C'E' GIA' NON LA RIGENERO
											  
											  String queryStringFind = "PREFIX SiiMobility:<http://www.disit.dinfo.unifi.it/SiiMobility#> " + 
													  "PREFIX xsd:<http://www.w3.org/2001/XMLSchema#>  " + 
														 " PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#> " + 
														  "PREFIX dcterms:<http://purl.org/dc/terms/> " + 
														  "ASK  {  " + 
														  " <" + valueOfRoadUri + "> rdf:type SiiMobility:Road .  " + 
														  "{  " + 
														 " <" + valueOfRoadUri + "> SiiMobility:extendName " + nuovoNomeStrada + " . " + 
														 " } " + 
														  "UNION " + 
														 " { " + 
														 " <" + valueOfRoadUri + "> dcterms:alternative " + nuovoNomeStrada + " . " + 
														 " } " + 
														 " }";
        										BooleanQuery booleanQuery = con.prepareBooleanQuery(QueryLanguage.SPARQL, queryStringFind);
        										boolean truth = booleanQuery.evaluate(); 
        										if (truth == true){
        										
        											// NON FARE NIENTE
        										}
        										else{
        							
											  
											  nuovoNomeStrada = nuovoNomeStrada.replaceAll("'","''");
											  valueOfNomeStrada = valueOfNomeStrada.replaceAll("'","''");
											  try {
											  		conMySQL2 = DriverManager.getConnection(url + db, user, pass);
											  		//conMySQL.setAutoCommit(false);// Disables auto-commit.
											  	  	st2 = conMySQL2.createStatement();
											  		String sqlInsert = "INSERT INTO riconciliazione_strade_nuovetriple (Soggetto, Oggetto, NOME_ORIGINALE) VALUES " + 
											  			  "('<" + valueOfRoadUri + ">','" + nuovoNomeStrada + "', '" + valueOfNomeStrada + "') " + 
											  			  "ON DUPLICATE KEY UPDATE Soggetto=VALUES(Soggetto), Oggetto=VALUES(Oggetto), NOME_ORIGINALE=VALUES(NOME_ORIGINALE);";
											  	  	st2.addBatch(sqlInsert);
											  	  	st2.executeBatch();
											  	  	st2.close();
											  		conMySQL2.close();
										  	  	} 
										  		catch (Exception e) {
										  			out.println(e.getMessage());
										  	  	}
											  
											 }
										 } // end try dentro ???
												 
											  catch (OpenRDFException e) {
													// handle exception
													out.println(e.getMessage());
											  }
										 } // end while ??
												
												 
										
									}		 
										 catch (OpenRDFException e) {
												// handle exception
												out.println(result.getBindingNames());
												out.println(e.getMessage());
										  }
									}
									
								}
									
								
								
							}
							
							
						}
						
					}
	
				}
			
		%>
	</div>
</body>
</html>
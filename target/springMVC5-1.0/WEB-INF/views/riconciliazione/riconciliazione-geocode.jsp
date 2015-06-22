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
<!DOCTYPE html>
<html>
  <head>
  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Geocoding service</title>
    
  </head>
  <body>
   
    <input type="button" onclick="iniziaGeocodeOSM();" value="Inizia GEOCODING OSM" />
    
    <input type="button" onclick="iniziaGeocodeGoogle();" value="Inizia GEOCODING Google" />
    
    
    <table id="triconc">
    	<tr>
    	<td>COD_SER</td>
    	<td>COMUNE</td>    	    	
    	<td>VIA</td>    	    	
    	<td>NUMERO</td>    	    	
    	<td>LAT</td>    	    	
    	<td>LONG</td>    	    	
    	  <td>LOC_TYPE</td>  
    	   	</tr>
    	
    	
    	<%
    		
    	Connection conMySQL = null;
    	  Statement st = null;
    	  ResultSet rs = null;
    	 
    	  String url = "jdbc:mysql://localhost:3306/";
    	  String db = "tesi";
    	  String driver = "com.mysql.jdbc.Driver";
    	  String user = "ubuntu";
    	  String pass = "ubuntu";
    	  
    	conMySQL = DriverManager.getConnection(url + db, user, pass);

    	String query = "SELECT * FROM `riconciliazione_servizi_non_trovati` WHERE NUMERO <> '0' AND NUMERO <> '' AND NUMERO NOT LIKE '%sn%' AND COD_TOP = '' AND COMUNE IN (SELECT DISTINCT DEN_UFF FROM tbl_elenco_comuni) AND VIA NOT LIKE '%-%' AND COD_SER NOT IN (SELECT DISTINCT COD_SER FROM  `riconciliazione_servizi_ultima_parola` ) AND COD_SER NOT IN (SELECT DISTINCT COD_SER FROM  `riconciliazione_coordinate` ) ORDER BY ID ASC";

    	// create the java statement
    	st = conMySQL.createStatement();

    	// execute the query, and get a java resultset
    	rs = st.executeQuery(query);

    	// iterate through the java resultset
    	while (rs.next())
    	{
    	 
    		String comune = rs.getString("COMUNE");
    		String via = rs.getString("VIA");
    		String numero = rs.getString("NUMERO");
    		String COD_SER = rs.getString("COD_SER");
    	
    		
    		out.println("<tr>");
    		out.println("<td>" + COD_SER.replace("<", "").replace(">", "") + "</td>");
    		out.println("<td>" + comune + "</td>");
    		out.println("<td>" + via + "</td>");
    		out.println("<td>" + numero + "</td>");
    		out.println("<td></td>");
    		out.println("<td></td>");
    		out.println("<td></td>");
    		
    		out.println("</tr>");
    	}
    	%>    	  
    	   	
 
    </table>
     <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    <script type="text/javascript">
    
    
    function iniziaGeocodeOSM() {
    	var arrayTab = [];
    	   $('#triconc > tbody  > tr').each(function() {
           		arrayTab.push(this); 
           });
    	   
    	   var i = 0;
    	   setInterval(function() {  
    	   
    		   var comune = arrayTab[i].cells[1].innerHTML;
        		var via = arrayTab[i].cells[2].innerHTML;
        		var numero = arrayTab[i].cells[3].innerHTML;
        		var arrayVia = [];
        		arrayVia = via.split(" ");
        		var arrayNumero = [];
        		arrayNumero = numero.split(" ");
        		var arrayComune = [];
        		arrayComune = comune.split(" ");
    		
        		via = arrayVia.join('+');
         		numero = arrayNumero.join('+');
         		comune = arrayComune.join('+');
         		
    		var search = via + "+" + numero + "," + comune;
    		$.getJSON('http://nominatim.openstreetmap.org/search?format=json&limit=1&q=' + search, function( data ) {
    	    	   //var items = [];
    	    	   $.each( data, function( key, val ) {
    	    		   arrayTab[i - 1].cells[4].innerHTML = val.lat;
    	    		   arrayTab[i - 1].cells[5].innerHTML = val.lon;
    	    	   });
    	       });
    		
   
    	   i++;
	}, 1000);
    }
    
    function iniziaGeocodeGoogle() {
        
    	var geocoder = new google.maps.Geocoder();
    	var arrayTab = [];
        $('#triconc > tbody  > tr').each(function() {
        	arrayTab.push(this); 
        });
        
        var i = 0;
        	
        	//var tabella = this;
        	setInterval(function() { 
     	  
     		var comune = arrayTab[i].cells[1].innerHTML;
     		var via = arrayTab[i].cells[2].innerHTML;
     		var numero = arrayTab[i].cells[3].innerHTML;
     		var arrayVia = [];
     		arrayVia = via.split(" ");
     		var arrayNumero = [];
     		arrayNumero = numero.split(" ");
     		var arrayComune = [];
     		arrayComune = comune.split(" ");
     		
     		via = arrayVia.join('+');
     		numero = arrayNumero.join('+');
     		comune = arrayComune.join('+');
     		
     		var search = via + "+" + numero + "," + comune;
     			  
     			
     			geocoder.geocode( { 'address': search}, function(results, status) {
     			    if (status == google.maps.GeocoderStatus.OK) {
     			    	if (results[0].geometry.location_type == 'ROOFTOP' || results[0].geometry.location_type == 'RANGE_INTERPOLATED'){
     			     console.log(results[0].geometry.location); 
     			    arrayTab[i - 1].cells[4].innerHTML = results[0].geometry.location.d;
     			   arrayTab[i - 1].cells[5].innerHTML = results[0].geometry.location.e;
     			  arrayTab[i - 1].cells[6].innerHTML = results[0].geometry.location_type;
     			    	}
     			    } else {
     			    	console.log('Geocode was not successful for the following reason: ' + status);
     			    }
     			  });
     			
    			i++;
        	}, 2500);
        
      
     }
 
    </script>
  </body>
</html>
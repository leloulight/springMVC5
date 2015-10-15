package com.github.p4535992.mvc.repository.impl;

import com.github.p4535992.extractor.estrattori.ExtractInfoWeb;
import com.github.p4535992.extractor.object.model.GeoDocument;
import com.github.p4535992.mvc.object.model.site.Marker;
import com.github.p4535992.util.database.sql.SQLHelper;
import com.github.p4535992.util.log.SystemLog;

import com.github.p4535992.util.repositoryRDF.sesame.Sesame28Kit;
import com.github.p4535992.mvc.object.model.site.MarkerInfo;
import com.github.p4535992.mvc.repository.dao.MapRepository;
import org.openrdf.repository.RepositoryConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

import java.sql.*;

/**
 * Created by 4535992 on 11/06/2015.
 * @author 4535992.
 * @version 2015-07-02.
 */
@SuppressWarnings("unused")
@Repository
@Scope("singleton")
public class MapRepositoryImpl implements MapRepository {


    private static String repositoryID;
    private static String dataDir;
    private org.openrdf.repository.RepositoryConnection repositoryConnection;
    private org.openrdf.repository.Repository repository;
    private static String sesameServer;

    @Autowired
    public MapRepositoryImpl(
            @Value("${sesameRepositoryID}") String repositoryID,
            @Value("${sesameDataDir}") String dataDir,
            @Value("${sesameServer}") String sesameServer){
        MapRepositoryImpl.repositoryID = repositoryID;
        MapRepositoryImpl.dataDir = dataDir;
        MapRepositoryImpl.sesameServer = sesameServer;
    }


    @Value("${db}")
    private String db;
    @Value("${url}")
    private String url;
    @Value("${user}")
    private String user;
    @Value("${pass}")
    private String pass;

    @Value("${dbServiceMap}")
    private String dbServiceMap;
    @Value("${urlServiceMap}")
    private String urlServiceMap;
    @Value("${userServiceMap}")
    private String userServiceMap;
    @Value("${passServiceMap}")
    private String passServiceMap;

    @Override
    public Marker createMarkerFromGeoDocument(String url){
        ExtractInfoWeb web = ExtractInfoWeb.getInstance(
                "com.mysql.jdbc.Driver","jdbc:mysql","localhost","3306","siimobility","siimobility","geodb");
        web.setGateWithSpring("spring/gate/gate-beans.xml","documentProcessor",this.getClass());
        //web.setConnectionToADatabase(false);
        GeoDocument geoDoc = web.ExtractGeoDocumentFromString(url,"geodocument_2015_09_18","geodocument_2015_09_18",false,false);
        Marker marker = new Marker();
        if(geoDoc.getLat()!=null)marker.setLatitude(geoDoc.getLat().toString().trim());
        if(geoDoc.getLng()!=null)marker.setLongitude(geoDoc.getLng().toString().trim());
        if(geoDoc.getUrl()!=null)marker.setUrl(geoDoc.getUrl().toString().trim());
        if(geoDoc.getEdificio()!=null)marker.setName(geoDoc.getEdificio().trim());

        MarkerInfo info = new MarkerInfo();
        if(geoDoc.getIndirizzo()!=null) info.setAddress(geoDoc.getIndirizzo().trim());
        if(geoDoc.getCity()!=null)info.setCity(geoDoc.getCity().trim());
        if(geoDoc.getProvincia()!=null)info.setProvince(geoDoc.getProvincia());
        if(geoDoc.getRegione()!=null)info.setRegion(geoDoc.getRegione().trim());
        if(geoDoc.getEmail()!=null)info.setEmail(geoDoc.getEmail().trim());
        if(geoDoc.getFax()!=null)info.setFax(geoDoc.getFax().trim());
        if(geoDoc.getTelefono()!=null)info.setPhone(geoDoc.getTelefono().trim());
        if(geoDoc.getIva()!=null)info.setIva(geoDoc.getIva().trim());
        if(geoDoc.getDescription()!=null)info.setDescription(geoDoc.getDescription().trim());

        marker.setMarkerInfo(info);
        return marker;

    }

    @Override
    public RepositoryConnection getSesameLocalConnection() {
        /*try {
            File dataDir2 = new File(dataDir + File.separator + repositoryID + File.separator);
            repository = new SailRepository( new MemoryStore(dataDir2) );
            repository.initialize();
            repositoryConnection = repository.getConnection();

        } catch (RepositoryException e) {
            e.printStackTrace();
        }*/
        Sesame28Kit sesame = Sesame28Kit.getInstance();
        sesame.connectToMemoryRepository(dataDir,repositoryID);
        return sesame.getRepositoryConnection();
    }

    @Override
    public RepositoryConnection getSesameRemoteConnection() {
        Sesame28Kit sesame = Sesame28Kit.getInstance();
        sesame.connectToHTTPRepository(sesameServer, repositoryID);
        return sesame.getRepositoryConnection();
    }

    private String testCategoryHTML;

    @Override
    public Connection getMySQLConnection(){
        Connection conMySQL = null;
        Statement st;
        ResultSet rs;
        Connection conMySQL2;
        Statement st2;
        ResultSet rs2;

        StringBuilder builder = new StringBuilder();
        try{
            conMySQL  = SQLHelper.getMySqlConnection(urlServiceMap,dbServiceMap,userServiceMap,passServiceMap);
            String query = "SELECT ID,NOME,COLORE,EN_NAME,CLASS FROM siimobility.tbl_service_category ORDER BY ID ASC";
            // create the java statement
            st = conMySQL.createStatement();
            // execute the query, and get a java resultset
            rs = st.executeQuery(query);

            // iterate through the java resultset
            while (rs.next()) {
                String id = rs.getString("ID");
                String nome = rs.getString("NOME");
                String colore = rs.getString("COLORE");
                String en_name = rs.getString("EN_NAME");
                String classe = rs.getString("CLASS");
                builder.append("<input type='checkbox' name='").append(en_name).append("' value='")
                        .append(en_name).append("' class='macrocategory' /> <span class='")
                        .append(classe).append(" macrocategory-label'>").append(nome)
                        .append("</span> <span class='toggle-subcategory' title='Mostra sottocategorie'>+</span>\n");
                builder.append("<div class='subcategory-content'>\n");

                conMySQL2 = SQLHelper.getMySqlConnection(urlServiceMap, dbServiceMap, userServiceMap, passServiceMap);
                String query2 = "SELECT * FROM siimobility.tbl_service_subcategory WHERE IDCATEGORY = " + id + " ORDER BY ID ASC";
                // create the java statement
                st2 = conMySQL2.createStatement();
                // execute the query, and get a java resultset
                rs2 = st2.executeQuery(query2);

                // iterate through the java resultset
                while (rs2.next()) {
                    String sub_nome = rs2.getString("NOME");
                    String sub_en_name = rs2.getString("EN_NAME");
                    String sub_numero = rs2.getString("NUMERO");

                    builder.append("<input type='checkbox' name='")
                            .append(sub_nome).append("' value='")
                            .append(sub_nome).append("' class='sub_")
                            .append(classe).append(" subcategory' />\n");
                    builder.append("<span class='")
                            .append(classe).append(" subcategory-label'>")
                            .append(sub_numero).append("- ")
                            .append(sub_nome).append("</span>\n");
                    builder.append("<br />\n");
                }
                builder.append("</div>\n");
                builder.append("<br />\n");

                st2.close();
                conMySQL2.close();
            }
            st.close();
            conMySQL.close();
        } catch (SQLException | IllegalAccessException | InstantiationException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally{
            testCategoryHTML = builder.toString();
        }
        return conMySQL;
    }

    @Override
    public String getResponseHTMLString() {
        getMySQLConnection();
        return testCategoryHTML;
    }

    /*public String invokeMain(){
        getSesameRemoteConnection();
        StringBuilder builder = new StringBuilder();
        try {
            try {
                String queryString = "PREFIX :<http://www.disit.dinfo.unifi.it/SiiMobility#> " +
                        "SELECT DISTINCT ?serviceCategory WHERE { " +
                        "?service :serviceCategory ?serviceCategory . " +
                        "} " +
                        "ORDER BY ?serviceCategory ";

                //  out.println(queryString);
                TupleQuery tupleQuery = repositoryConnection.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
                TupleQueryResult result = tupleQuery.evaluate();
                try {
                    while (result.hasNext()) {
                        BindingSet bindingSet = result.next();
                        org.openrdf.model.Value valueOfServiceCategory = bindingSet.getValue("serviceCategory");
                        builder.append("<option value='").append(valueOfServiceCategory.toString()
                                .replace("<http://www.w3.org/2001/XMLSchema#string>", "xsd:string"))
                                .append("'>").append(valueOfServiceCategory.toString()).append("</option>\n");
                    }
                }
                finally {
                    result.close();
                }
            }
            finally {
                repositoryConnection.close();
            }
        }
        catch (OpenRDFException e) {
            // handle exception
            builder.append(e.getMessage());
        }
        return builder.toString();
    }*/

    /*public String invokeQuery(){
        getSesameRemoteConnection();
        StringBuilder builder = new StringBuilder();

//        String via = request.getParameter("via");
//        String tipo = request.getParameter("tipo");
        String tipo = "";
        String via ="";
        if (StringKit.isNullOrEmpty(tipo)){
            tipo = "?serviceCategory";
        }
            String queryString =
                "PREFIX :<http://www.disit.dinfo.unifi.it/SiiMobility#>" +
                "PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#>" +
                "PREFIX vcard:<http://www.w3.org/2006/vcard/ns#> ";
        try {
            try {
                if (Objects.equals(tipo, "?serviceCategory")){
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
                TupleQuery tupleQuery = repositoryConnection.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
                TupleQueryResult result = tupleQuery.evaluate();
                try {
                    builder.append("<table>\n");
                    builder.append("<tr>\n");
                    builder.append("<td>Nome Servizio</td>\n");
                    builder.append("<td>Indirizzo</td>\n");
                    builder.append("<td>Tipo Servizio</td>\n");
                    builder.append("</tr>\n");

                    while (result.hasNext()) {

                        builder.append("<tr>\n");
                        BindingSet bindingSet = result.next();

                        org.openrdf.model.Value valueOfOrgName = bindingSet.getValue("orgName");
                        org.openrdf.model.Value valueOfStreetAddress = bindingSet.getValue("streetAddress");
                        org.openrdf.model.Value valueOfServiceCategory = null;
                        if (Objects.equals(tipo, "?serviceCategory")){
                            valueOfServiceCategory = bindingSet.getValue("serviceCategory");
                        }


                        builder.append("<td>").append(valueOfOrgName.toString()).append("</td>\n");
                        builder.append("<td>").append(valueOfStreetAddress.toString()).append("</td>\n");
                        if (Objects.equals(tipo, "?serviceCategory")){
                            if (valueOfServiceCategory != null) {
                                builder.append("<td>").append(valueOfServiceCategory.toString()).append("</td>\n");
                            }else{
                                builder.append("<td></td>\n");
                            }
                        }
                        else{
                            builder.append("<td>").append(tipo).append("</td>\n");
                        }
                        builder.append("</tr>\n");
                    }
                    builder.append("</table>\n");

                }
                finally {
                    result.close();

                }
            } catch (RepositoryException|QueryEvaluationException|MalformedQueryException e) {
                SystemLog.exception(e);
            } finally {
                repositoryConnection.close();
            }
        }
        catch (OpenRDFException e) {
            // handle exception
            builder.append(e.getMessage());
        }
        return builder.toString();
    }*/


}

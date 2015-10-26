package com.github.p4535992.mvc.controller;

import com.github.p4535992.mvc.object.model.site.Marker;
import com.github.p4535992.mvc.object.model.site.MarkerInfo;
import com.github.p4535992.mvc.service.dao.MapService;
import com.github.p4535992.util.html.JSoupKit;
import com.github.p4535992.util.log.SystemLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 4535992 on 11/06/2015.
 * @author 4535992.
 * @version 2015-07-02.
 */
@Controller
@PreAuthorize("hasRole('ROLE_USER')")
public class MapController {

    @Autowired
    MapService mapService;

    Marker marker;
    List<Marker> arrayMarker = new ArrayList<>();
    Integer indiceMarker = 0;

    /*@RequestMapping(value="/map",method= RequestMethod.GET)
    public String loadMap1(Model model){
        String html = mapService.getResponseHTMLString();
        return "riconciliazione2/mappa/map";
    }
    @RequestMapping(value="/map",method = RequestMethod.POST)
    public String result(@RequestParam(required=false, value="urlParam")String url,Model model){
        System.out.println("url: " + url);
        return "home";
    }*/


    @RequestMapping(value="/map",method= RequestMethod.GET)
    public String loadMap2(Model model){
        //String html = mapService.getResponseHTMLString();
        //Site siteForm = new Site();
        //model.addAttribute("siteForm",siteForm);
        if(!arrayMarker.isEmpty()) model.addAttribute("arrayMarker",arrayMarker);
        else model.addAttribute("arrayMarker",null);

        if(marker!=null)model.addAttribute("marker",marker);
        else model.addAttribute("marker",null);

        model.addAttribute("indiceMarker",indiceMarker);
        model.addAttribute("urlParam",null);

        String html = mapService.getResponseHTMLString();
        model.addAttribute("HTML",html);
        return "riconciliazione2/mappa/leafletMap";
    }


    /*@RequestMapping("*")
    public String hello(HttpServletRequest request,Model model) {
        System.out.println(request.getServletPath());
        String MAIN = mapService.homeMain();
        model.addAttribute("MAIN",MAIN);
        return "main";
    }*/

    @RequestMapping(value="/",method= RequestMethod.GET)
    public String homeMain(Model model){
        //String MAIN = mapService.homeMain();
        //model.addAttribute("MAIN",MAIN);
        return "main";
    }

    @RequestMapping(value="/main",method= RequestMethod.GET)
    public String homeMain2(Model model){
        //String MAIN = mapService.homeMain();
        //model.addAttribute("MAIN",MAIN);
        return "main";
    }

    @RequestMapping(value="/riconciliazione",method= RequestMethod.GET)
    public String riconciliazione(Model model){
        String RICONCILIAZIONE = mapService.riconciliazione();
        model.addAttribute("RICONCILIAZIONE", RICONCILIAZIONE);
        return "riconciliazione2/riconciliazione/riconciliazione";
    }

    @RequestMapping(value="/riconciliazione_alternative",method= RequestMethod.GET)
    public String riconciliazioneAlternative(Model model){
        String RICONCILIAZIONE_ALTERNATIVE = mapService.riconciliazioneAlternative();
        model.addAttribute("RICONCILIAZIONE_ALTERNATIVE", RICONCILIAZIONE_ALTERNATIVE);
        return "riconciliazione2/riconciliazione/riconciliazione-alternative";
    }

    @RequestMapping(value="/riconciliazione_bus",method= RequestMethod.GET)
    public String riconciliazioneBus(Model model){
        String RICONCILIAZIONE_BUS = mapService.riconciliazione_bus();
        model.addAttribute("RICONCILIAZIONE_BUS", RICONCILIAZIONE_BUS);
        return "riconciliazione2/riconciliazione/riconciliazione-bus";
    }

    @RequestMapping(value="/riconciliazione_comuni_sbagliati",method= RequestMethod.GET)
    public String riconciliazioneComuniSbagliati(Model model){
        String RICONCILIAZIONE_COMUNI_SBAGLIATI = mapService.riconciliazione_comuni_sbagliati();
        model.addAttribute("RICONCILIAZIONE_COMUNI_SBAGLIATI", RICONCILIAZIONE_COMUNI_SBAGLIATI);
        return "riconciliazione2/riconciliazione/riconciliazione-comuni-sbagliati";
    }

    @RequestMapping(value="/riconciliazione_contains",method= RequestMethod.GET)
    public String riconciliazioneContains(Model model){
        String RICONCILIAZIONE_CONTAINS = mapService.riconciliazione_contains();
        model.addAttribute("RICONCILIAZIONE_CONTAINS", RICONCILIAZIONE_CONTAINS);
        return "riconciliazione2/riconciliazione/riconciliazione-contains";
    }

    @RequestMapping(value="/riconciliazione_geocode",method= RequestMethod.GET)
    public String riconciliazioneGeocode(Model model){
        String RICONCILIAZIONE_GEOCODE = mapService.riconciliazione_geocode();
        model.addAttribute("RICONCILIAZIONE_GEOCODE", RICONCILIAZIONE_GEOCODE);
        return "riconciliazione2/riconciliazione/riconciliazione-geocode";
    }

    @RequestMapping(value="/riconciliazione_geocode_strada",method= RequestMethod.GET)
    public String riconciliazioneGeocodeStrada(Model model){
        String RICONCILIAZIONE_GEOCODE_STRADA = mapService.riconciliazione_geocode_strada();
        model.addAttribute("RICONCILIAZIONE_GEOCODE_STRADA", RICONCILIAZIONE_GEOCODE_STRADA);
        return "riconciliazione2/riconciliazione/riconciliazione-geocode-strada";
    }

    @RequestMapping(value="/riconciliazione_isin",method= RequestMethod.GET)
    public String riconciliazioneIsin(Model model){
        String RICONCILIAZIONE_ISIN = mapService.riconciliazione_isin();
        model.addAttribute("RICONCILIAZIONE_ISIN", RICONCILIAZIONE_ISIN);
        return "riconciliazione2/riconciliazione/riconciliazione-isin";
    }

    @RequestMapping(value="/riconciliazione_last_word",method= RequestMethod.GET)
    public String riconciliazioneLastWord(Model model){
        String RICONCILIAZIONE_LAST_WORD = mapService.riconciliazione_last_word();
        model.addAttribute("RICONCILIAZIONE_LAST_WORD", RICONCILIAZIONE_LAST_WORD);
        return "riconciliazione2/riconciliazione/riconciliazione-last-word";
    }

    @RequestMapping(value="/riconciliazione_senza_virgola",method= RequestMethod.GET)
    public String riconciliazioneSenzaVirgola(Model model){
        String RICONCILIAZIONE_SENZA_VIRGOLA = mapService.riconciliazione_senza_virgola();
        model.addAttribute("RICONCILIAZIONE_SENZA_VIRGOLA", RICONCILIAZIONE_SENZA_VIRGOLA);
        return "riconciliazione2/riconciliazione/riconciliazione-senza-virgola";
    }

    @RequestMapping(value="/riconciliazione_strade",method= RequestMethod.GET)
    public String riconciliazioneStrade(Model model){
        String RICONCILIAZIONE_STRADE = mapService.riconciliazione_strade();
        model.addAttribute("RICONCILIAZIONE_STRADE", RICONCILIAZIONE_STRADE);
        return "riconciliazione2/riconciliazione/riconciliazione-strade";
    }

    @RequestMapping(value="/riconciliazione_trattino",method= RequestMethod.GET)
    public String riconciliazioneTrattino(Model model){
        String RICONCILIAZIONE_TRATTINO = mapService.riconciliazione_trattino();
        model.addAttribute("RICONCILIAZIONE_TRATTINO", RICONCILIAZIONE_TRATTINO);
        return "riconciliazione2/riconciliazione/riconciliazione-trattino";
    }

    @RequestMapping(value="/gtfs",method= RequestMethod.GET)
      public String gtfs(Model model){
        return "riconciliazione2/mappa/gtfsMap";
    }

   /* @RequestMapping(value="/gtfshtml",method= RequestMethod.GET)
    public String gtfsHmtl(Model model){
        return "/gtfsMap";
    }*/

    //---------------------------------------------------------
    // NEW POST METHOD
    //---------------------------------------------------------


    @RequestMapping(value="/map3",method = RequestMethod.POST)
    public String result4(@RequestParam(required=false, value="urlParam")String url,
                          @ModelAttribute(value="markerParam")Marker markerFromJS){
        String[] splitter;
        if(url.contains(",")) {
            splitter = url.split(",");
            url = splitter[0];
        }

        System.out.println("url: " + url);
        marker = mapService.createMarkerFromGeoDocument(url);
        // = new Marker("City",url,"43.3555664", "11.0290384");
        //model.addAttribute("marker",marker); //no need is get from the HTTTP GET COMMAND
        arrayMarker.add(marker);
        indiceMarker++;
        return "redirect:/map";
    }

    @RequestMapping(value="/map4",method = RequestMethod.POST)
    public String result(@RequestParam(required=false, value="nameParam1")List<String> name,
                         @RequestParam(required=false, value="latParam1")List<String> lat,
                         @RequestParam(required=false, value="lngParam1")List<String> lng,
                         @RequestParam(required=false, value="descriptionParam1")List<String> description,
                         @RequestParam(required=false, value="supportUploaderParam") String fileUrl,
                         Model model) throws Exception {
        Marker mk;
        MarkerInfo mki =new MarkerInfo();
        for(int i = 0; i < name.size(); i++){
            //System.out.println("name: " + name.get(i) +",lat:"+lat.get(i)+",lng:"+lng.get(i)+",description:"+description.get(i));
            List<List<List<String>>> info = JSoupKit.TablesExtractor(description.get(i),false);
            for(List<List<String>> listOfList : info ){
                for(List<String> list : listOfList){
                    if(list.get(0).toLowerCase().contains("country")){ mki.setRegion(list.get(1)); continue;}
                    if(list.get(0).toLowerCase().contains("name")){ mki.setCity(list.get(1)); continue;}
                    if(list.get(0).toLowerCase().contains("city")){ mki.setCity(list.get(1)); continue;}
                    if(list.get(0).toLowerCase().contains("email")){ mki.setEmail(list.get(1)); continue;}
                    if(list.get(0).toLowerCase().contains("phone")){ mki.setPhone(list.get(1));continue;}
                    if(list.get(0).toLowerCase().contains("fax")){ mki.setFax(list.get(1));continue;}
                    mki.setDescription(list.get(0)+"="+list.get(1)+";");
                }
            }
            mk = new Marker(name.get(i),fileUrl,lat.get(i),lng.get(i),mki);
            arrayMarker.add(mk);
        }
        return "redirect:/map";
    }


    //----------------------------------------------
    //NEW METHOD FOR UPLOAD FILE
    //----------------------------------------------

    List<File> listFiles = new ArrayList<>();

    @RequestMapping(value="/fileupload",method=RequestMethod.POST )
    public @ResponseBody String uploadFile(@RequestParam("uploader") MultipartFile file){
        try{
            SystemLog.message("file is " + file.toString());
        }catch(Exception e){
            return "error occured "+e.getMessage();
        }
        return "redirect:/map";
    }

    /**
     * Upload single file using Spring Controller
     */
    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    public @ResponseBody String uploadFileHandler(@RequestParam("name") String name,
                             @RequestParam("file") MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                byte[] bytes = file.getBytes();
                // Creating the directory to store file
                String rootPath = System.getProperty("catalina.home");
                File dir = new File(rootPath + File.separator + "tmpFiles");
                if (!dir.exists()) dir.mkdirs();

                // Create the file on server
                File serverFile = new File(dir.getAbsolutePath() + File.separator + name);
                BufferedOutputStream stream = new BufferedOutputStream( new FileOutputStream(serverFile));
                stream.write(bytes);
                stream.close();
                SystemLog.message("Server File Location=" + serverFile.getAbsolutePath());
                SystemLog.message("You successfully uploaded file=" + name);
                listFiles.add(convertMultiPartFileToFile(file));
                return "redirect:/map";
            } catch (Exception e) {
                SystemLog.error("You failed to upload " + name + " => " + e.getMessage());
                return "redirect:/map";
            }
        } else {
            SystemLog.message("You failed to upload " + name + " because the file was empty.");
            return "redirect:/map";
        }
    }

    /**
     * Upload multiple file using Spring Controller
     */
    @RequestMapping(value = "/uploadMultipleFile", method = RequestMethod.POST)
    public @ResponseBody String uploadMultipleFileHandler(@RequestParam("name") String[] names,
                                     @RequestParam("file") MultipartFile[] files) throws IOException {
        if (files.length != names.length){
           SystemLog.warning("Mandatory information missing");
           return null;
        }
        String message = "";
        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            listFiles.add(convertMultiPartFileToFile(file));
            String name = names[i];
            try {
                byte[] bytes = file.getBytes();
                // Creating the directory to store file
                String rootPath = System.getProperty("catalina.home");
                File dir = new File(rootPath + File.separator + "tmpFiles");
                if (!dir.exists())dir.mkdirs();

                // Create the file on server
                File serverFile = new File(dir.getAbsolutePath()
                        + File.separator + name);
                BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
                stream.write(bytes);
                stream.close();
                SystemLog.message("Server File Location=" + serverFile.getAbsolutePath());
                message = message + "You successfully uploaded file=" + name
                        + "<br />";
            } catch (Exception e) {
                SystemLog.error("You failed to upload " + name + " => " + e.getMessage());
                return "redirect:/map";
            }
        }
        SystemLog.message(message);
        return "redirect:/map";
    }


    private File convertMultiPartFileToFile(MultipartFile file) throws IOException {
        File convFile = new File(file.getOriginalFilename());
        convFile.createNewFile();
        FileOutputStream fos = new FileOutputStream(convFile);
        fos.write(file.getBytes());
        fos.close();
        return convFile;
    }






}

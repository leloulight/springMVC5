package com.github.p4535992.mvc.object.model.site;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.List;

/**
 * Created by 4535992 on 26/11/2015.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class MarkerList {

    List<Marker> markers;

    public List<Marker> getMarkers() {
        return markers;
    }

    public void setPersons(List<Marker> markers) {
        this.markers= markers;
    }

}
package com.p4535992.mvc.object.model.site;

/**
 * Created by 4535992 on 18/06/2015.
 */
public class Marker {

    private String name;
    private String url;
    private String latitude;
    private String longitude;
    private MarkerInfo markerInfo;

    public Marker(){}

    public Marker(String name,String url,String latitude,String longitude){
        this.name = name;
        this.url = url;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public Marker(String name,String url,String latitude,String longitude,MarkerInfo markerInfo){
        this.name = name;
        this.url = url;
        this.latitude = latitude;
        this.longitude = longitude;
        this.markerInfo = markerInfo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public MarkerInfo getMarkerInfo() {
        return markerInfo;
    }

    public void setMarkerInfo(MarkerInfo markerInfo) {
        this.markerInfo = markerInfo;
    }

    @Override
    public String toString() {
        return "Marker{" +
                "name='" + name + '\'' +
                ", url='" + url + '\'' +
                ", latitude='" + latitude + '\'' +
                ", longitude='" + longitude + '\'' +
                ", markerInfo=" + markerInfo +
                '}';
    }
}

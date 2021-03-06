class Schedule < ApplicationRecord
  # defaults
 zoom =
   initialView: 15
   closeView: 18
 markers = []
 map = undefined

 constructor: (home) ->
   # set map center and view options
   lat = home["lat"]
   lon = home["lon"]
   myLatlng = new google.maps.LatLng(lat, lon)
   mapOptions =
     zoom: zoom.initialView
     center: myLatlng

   # create map
   map = new google.maps.Map(document.getElementById("map"), mapOptions)

 addMarker: (location, title) ->
   # create marker and add it to the array of markers
   marker = new google.maps.Marker(
     position: location,
     title: title,
     map: map
   )
   markers.push marker

   # add event listener - change zoom and center position on marker click
   google.maps.event.addListener marker, "click", ->
     map.setZoom zoom.closeView
     map.setCenter marker.getPosition()

 addMarkers: (markerList) ->
   # add all markers
   _.each markerList, (marker) =>
     position = new google.maps.LatLng marker["lat"], marker["lon"]
     title = "#{marker['full_address']}"
     @addMarker position, title

 drawMarkers: (map) ->
   # draw markers
   _.each markers, (marker) ->
     marker.setMap map
     # IMPORTANT: calling setMap method on marker will draw this marker, calling setMap with null parameter will erase it

 showMarkers: ->
   @setAllMap map

 hideMarkers: ->
   @setAllMap null

 removeListeners: ->
   _.each markers, (marker) ->
     google.maps.event.clearInstanceListeners(marker)

 deleteMarkers: ->
   @hideMarkers()
   @removeListeners()
   markers = []

app.google or= { classes: {} }
app.google.classes.Schedule = Schedule
end

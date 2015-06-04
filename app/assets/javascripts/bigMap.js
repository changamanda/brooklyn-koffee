$('#bigmap-canvas').ready(function(){
  var url = window.location.href + "/info";

  $.ajax({
    type: "GET",
    url: url,
    dataType: "json"
  }).done(function(response){
    initializeBig(response);
  });
});

var map;
var openwindow;

function initializeBig (response) {
  var lat = 40.6925077;
  var lng = -73.9686868;

  var myLatlng = new google.maps.LatLng(lat, lng);

  var mapOptions = {
    zoom: 13,
    center: myLatlng
  };
  map = new google.maps.Map(document.getElementById('bigmap-canvas'),
      mapOptions);

  addMarkerBig(map, response); 
  addStyleBig (map);
}

function addMarkerBig (map, response) {
  response['allShops'].forEach(function(spot, i){
    var name = spot['name'];
    var address = spot['address'];

    var query = "https://www.google.com/maps?q=" + address.replace(/\s/g, "+") + "+Brooklyn+NY";

    var contentString = '<h5>' + name + '</h5><p><a href="' + query + '" target = "_blank">' + address + '</a></p>';
    var infowindow = new google.maps.InfoWindow({
        content: contentString
    });

    var lat = response['allSpots'][i]['lat'];
    var lng = response['allSpots'][i]['lng'];
    var myLatlng = new google.maps.LatLng(lat, lng);

    var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: name
    });
    google.maps.event.addListener(marker, 'click', function() {
      if (openwindow) openwindow.close();
      openwindow = infowindow;
      infowindow.open(map, marker);
    });

    marker.setIcon('http://maps.google.com/mapfiles/ms/icons/blue-dot.png');
  }); 
}

function addStyleBig (map) {
  var styles = [{"featureType":"administrative","elementType":"all","stylers":[{"visibility":"on"},{"lightness":33}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#f2e5d4"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#c5dac6"}]},{"featureType":"poi.park","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":20}]},{"featureType":"road","elementType":"all","stylers":[{"lightness":20}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#c5c6c6"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#e4d7c6"}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#fbfaf7"}]},{"featureType":"water","elementType":"all","stylers":[{"visibility":"on"},{"color":"#acbcc9"}]}];
  map.setOptions({styles: styles});
}
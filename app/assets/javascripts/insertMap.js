$('#map-canvas').ready(function(){
  var url = window.location.href + "/info";

  $.ajax({
    type: "GET",
    url: url,
    dataType: "json"
  }).done(function(response){
    initialize(response);
  });
});

var map;
function initialize (object) {
  var lat = object['shop']['lat']
  var lng = object['shop']['lng']

  var myLatlng = new google.maps.LatLng(lat, lng);

  var mapOptions = {
    zoom: 14,
    center: myLatlng
  };
  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  add_marker(map, object, myLatlng); 
  add_style(map);
}

function add_marker (map, object, myLatlng) {
  var name = object['shop']['name'];
  var address = object['shop']['address'];

  var query = "https://www.google.com/maps?q=" + address.replace(/\s/g, "+") + "+Brooklyn+NY";

  var contentString = '<h5>' + name + '</h5><p><a href="' + query + '" target = "_blank">' + address + '</a></p>';
  var infowindow = new google.maps.InfoWindow({
      content: contentString
  });

  var marker = new google.maps.Marker({
    position: myLatlng,
    map: map,
    title: name
  });
  google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map, marker);
  });

  marker.setIcon('http://maps.google.com/mapfiles/ms/icons/blue-dot.png'); 
}

function add_style (map) {
  var styles = [{"featureType":"administrative","elementType":"all","stylers":[{"visibility":"on"},{"lightness":33}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#f2e5d4"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#c5dac6"}]},{"featureType":"poi.park","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":20}]},{"featureType":"road","elementType":"all","stylers":[{"lightness":20}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#c5c6c6"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#e4d7c6"}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#fbfaf7"}]},{"featureType":"water","elementType":"all","stylers":[{"visibility":"on"},{"color":"#acbcc9"}]}];
  map.setOptions({styles: styles});
}
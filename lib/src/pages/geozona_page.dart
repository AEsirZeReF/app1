import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
//
import 'package:geolocator/geolocator.dart';
//
class Geozona extends StatefulWidget {
  
  //Geozona({Key key}) : super(key: key);

  @override
  _GeozonaState createState() => _GeozonaState();
}
class _GeozonaState extends State<Geozona> {
  
  Position getPosition = new Position(latitude: -11.991778,longitude:  -77.058833);
   MapController map = new MapController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: help.tituloImagen,
        backgroundColor: help.blue,
        centerTitle: true,
      ),
      backgroundColor: help.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _crearListaContenido(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _crearBotonPosicion(),
          _crearBotonSiguiente()
        ],
      )
    );
  }

  
  List<Widget> _crearListaContenido(){
    return <Widget>[
      Text('CHECKPOINT VIRTUAL',style: help.subtitle,),
            SizedBox(height: 40.0,),
            Text('GEOZONA',style: help.estiloTexto,),
            SizedBox(height: 20,),
            Container(
              width: 390.0,
              height: 430.0,
              child: _crearMapa(),
            ),
    ];
  } 
  Widget _crearMapa(){
    return FlutterMap(
       mapController: map,
      options: MapOptions(
        center: LatLng(-11.991778, -77.058833),
        zoom: 15
      ),
      layers: [
        _cargarMapa(),
        _crearMarcadores(),
      ],
  );
  }
  TileLayerOptions _cargarMapa (){
    return TileLayerOptions(
      urlTemplate: 'https://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga',
      subdomains: ['a','b','c']
    );
  }
  MarkerLayerOptions _crearMarcadores(){
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: LatLng(getPosition.latitude,getPosition.longitude),
    
          builder: (context){
            return Container(
              child: Icon(Icons.location_on,size: 50,color: Colors.blue,),
            );
          }
        ),
      ]
      );
  }
  dynamic _getLocation (){
    final Geolocator geolocator = Geolocator()
                                  ..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
          getPosition = position;
          map.move(LatLng(getPosition.latitude,getPosition.longitude), 18);
          setState(() {});
        print(position);
        }).catchError((e) {
          print(e);
        });
  }
  Widget _crearBotonPosicion(){
    return RaisedButton( 
      onPressed:(){_getLocation();} ,
          color: help.white,
          hoverColor: help.white,
          textColor: help.blue,
          child: new Text('Mi Posición'),
    );
  }
   Widget _crearBotonSiguiente(){
    return RaisedButton( 
      onPressed:(){
        Navigator.pushNamed(context, '/scanner');
      } ,
          color: help.white,
          hoverColor: help.white,
          textColor: help.blue,
          child: new Text('Siguiente -->'),
    );
  }
  
}

















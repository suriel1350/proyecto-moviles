package com.learn2crack;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.media.audiofx.AcousticEchoCanceler;
import android.os.Build;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.FragmentActivity;
import android.os.Bundle;
import android.support.v4.content.ContextCompat;
import android.view.ContextThemeWrapper;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;

public class MapsActivity extends FragmentActivity implements OnMapReadyCallback, OnSuccessListener<Location>, OnCompleteListener<Location> {

    private GoogleMap mMap;
    private static final int REQUEST_PERMISSIONS_CODE = 1;
    private Button button;

    private FusedLocationProviderClient locationClient;
    private Location lastLocation;
    private LocationRequest locationRequest;
    private LocationCallBack locationCallBack;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_maps);
        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);
        try{
            locationClient = LocationServices.getFusedLocationProviderClient(this);
            locationClient.getLastLocation().addOnSuccessListener(this);
            locationRequest.setInterval(5000);
            locationRequest.setFastestInterval(1000);
            locationRequest.setPriority(LocationRequest.PRIORITY_BLANCED_POWER_ACCURACY);

            locationCallBack = new LocationCallBack(){
                @Override
                public void onLocationResult(LocationResult locationResult){
                    for(Location location : locationResult.getLocations()){
                        updateUI();
                    }
                }
                ;
            };
        } catch (SecurityException ex) {
            ex.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        button = (Button) findViewById(R.id.button4);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v){
                openProfile();
            }
        });

    }

     @Override
     public void onStart() {
        super.onStart();
        if(!checkPermissions()) {
            startLocationUpdates();
            requestPermissions();
        } else {
            getLastLocation();
            startLocationUpdates();
        }
     }

     @Override
     public void onPause() {
        stopLocationUpdates();
        super.onPause();
     }

     private void stopLocationUpdates() {
        locationClient.removeLocationUpdates(locationCallBack);
     }

     private void startLocationUpdates() {
        if (ActivityCompat.checkSelfPermission(this,
                Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED &&
                ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            return;
        }
        locationClient.requestLocationUpdates(locationRequest, locationCallBack, null);
     }

     private boolean checkPermissions(){
        int permissionState = ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION);
        return permissionState = PackageManager.PERMISSION_GRANTED;
     }

     private void startLocationPermissionRequest() {
         ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.ACCESS_COARSE_LOCATION}, REQUEST_PERMISSIONS_CODE);
     }

     private void requestPermissions() {
        boolean shouldProvideRationale = ActivityCompat.shouldShowRequestPermissionRationale(this, Manifest.permission.ACCESS_COARSE_LOCATION);
        if (shouldProvideRationale) {
            Toast.makeText(this, "Please, let me use your location", Toast.LENGTH_SHORT).show();
            startLocationPermissionRequest();
        } else {
            startLocationPermissionRequest();
        }
     }

     @Override
     public void OnRequestPermissionResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        if (requestCode == REQUEST_PERMISSIONS_CODE) {
            if (grantResults.length <= 0) {
                System.out.println("User interaction was cancelled");
            } else if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                getLastLocation();
            } else {
                Toast.makeText(this, "Application cannot work without ypur location.", Toast.LENGTH_LONG).show();
            }
        }
     }

    @Override
    public void onComplete(@NonNull Task<Location> task) {
        if(task.isSuccessful() && task.getResult() != null) {
            lastLocation = task.getResult();
            updateUI();
        }
    }

    @Override
    public void onSuccess(Location location) {
        if (location != null){
            lastLocation = location;
            LatLng loc = new LatLng(lastLocation.getLatitude(), lastLocation.getLongitude());
            if(mMap != null) {
                mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(loc, 16.0f));
            }
        }
    }

    @SuppressWarnings("MissingPermission")
    private void getLastLocation() {
        locationClient.getLastLocation().addOnCompleteListener(this);
    }

    private void updateUI() {
        if(lastLocation != null) {
            LatLng loc = new LatLng(lastLocation.getLatitude(), lastLocation.getLongitude());
            if(mMap != null) {
                mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(loc, 16.0f));
            }
        }
    }


    public void openProfile(){

        Intent intent = new Intent(MapsActivity.this, ProfileActivity.class);
        startActivity(intent);

    }

    /**
     * Manipulates the map once available.
     * This callback is triggered when the map is ready to be used.
     * This is where we can add markers or lines, add listeners or move the camera. In this case,
     * we just add a marker near Sydney, Australia.
     * If Google Play services is not installed on the device, the user will be prompted to install
     * it inside the SupportMapFragment. This method will only be triggered once the user has
     * installed Google Play services and returned to the app.
     */
    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;
        mMap.setMapType(GoogleMap.MAP_TYPE_HYBRID);

        //Initialize Google Play Services
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
                mMap.setMyLocationEnabled(true);
            }
        }
        else {
            mMap.setMyLocationEnabled(true);
        }

        //Markers
        LatLng nave31 = new LatLng(19.127080499678105, -98.26139961596073);
        LatLng nave82NSO = new LatLng(19.127956029601044, -98.2584424067154);
        LatLng nave80NSO = new LatLng(19.13089940000003, -98.25923230000001);
        LatLng nave84NSO = new LatLng(19.12908059999998, -98.25746470000007);
        LatLng nave83NSO = new LatLng(19.1267118, -98.25849870000002);
        LatLng est9NSO = new LatLng(19.125741200000007, -98.25937049999993);
        LatLng puerta5NSO = new LatLng(19.123986300000023, -98.25773570000001);
        LatLng puerta4NSO = new LatLng(19.12253679999998, -98.25631409999994);
        LatLng cubo8NSO = new LatLng(19.121515499999994, -98.25527069999998);
        LatLng cubo6NSO = new LatLng(19.120778000000005, -98.25453579999999);
        LatLng cubo3NSO = new LatLng(19.11952359999999, -98.25327779999998);
        LatLng puerta2NSO = new LatLng(19.11850990000001, -98.25227870000003);
        LatLng nave53NSO = new LatLng(19.117351099999976, -98.25114280000003);
        LatLng puerta8NSO = new LatLng(19.115924300000003, -98.24975549999999);

        // Add a marker in Sydney and move the camera
        LatLng sydney = new LatLng(19.122488352418138, -98.2570541);
        mMap.addMarker(new MarkerOptions().position(sydney).title("Marker in Sydney"));

        mMap.addMarker(new MarkerOptions().position(nave31).title("Nave 31"));
        mMap.addMarker(new MarkerOptions().position(nave82NSO).title("Nave 82 a NSO"));
        mMap.addMarker(new MarkerOptions().position(nave80NSO).title("Nave 80 a NSO"));
        mMap.addMarker(new MarkerOptions().position(nave84NSO).title("Nave 84 a NSO"));
        mMap.addMarker(new MarkerOptions().position(nave83NSO).title("Nave 83 a NSO"));
        mMap.addMarker(new MarkerOptions().position(est9NSO).title("Est.9 a NSO"));
        mMap.addMarker(new MarkerOptions().position(puerta5NSO).title("Puerta 5 NSO"));
        mMap.addMarker(new MarkerOptions().position(puerta4NSO).title("Puerta 4 NSO"));
        mMap.addMarker(new MarkerOptions().position(cubo8NSO).title("Cubo 8 NSO"));
        mMap.addMarker(new MarkerOptions().position(cubo6NSO).title("Cubo 6 NSO"));
        mMap.addMarker(new MarkerOptions().position(cubo3NSO).title("Cubo 3 NSO"));
        mMap.addMarker(new MarkerOptions().position(puerta2NSO).title("Puerta 2 NSO"));
        mMap.addMarker(new MarkerOptions().position(nave53NSO).title("Nave 53 a NSO"));
        mMap.addMarker(new MarkerOptions().position(puerta8NSO).title("Puerta 8 NSO"));

        mMap.moveCamera(CameraUpdateFactory.newLatLngZoom(sydney, 15.0f));
        //mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(location.getLatitude(), location.getLongitude()), 12.0f));

    }




}

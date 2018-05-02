package com.learn2crack;

import android.content.SharedPreferences;
import android.support.v4.app.FragmentActivity;
import android.os.Bundle;
import android.widget.Button;
import android.content.Intent;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.learn2crack.utils.Constants;

public class MapsActivity extends FragmentActivity implements OnMapReadyCallback {

    private GoogleMap mMap;
    private SharedPreferences mSharedPreferences;
    private Button mBtProfile;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_maps);
        initViews();

        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);
    }

    private void initViews() {


        mBtProfile = (Button) findViewById(R.id.btn_map_prof);
        mBtProfile.setOnClickListener(view -> goToProfile());
    }

    private void goToProfile() {

        Intent intent = new Intent(this, ProfileActivity.class);
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

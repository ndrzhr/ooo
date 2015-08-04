package com.ndrzhr.lbsreciever_datalogging;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.IBinder;
import android.util.Log;

/**
 * Created by ndrzhr on 6/14/15.
 */
public class LocationService extends Service {

    LocationManager lm;
    DBAdapter dbAdapter = new DBAdapter(this);
    ExternalStorage externalStorage = new ExternalStorage();

    LocationListener locationListener = new LocationListener() {
        @Override
        public void onLocationChanged(Location location) {
            dbAdapter.open();
            dbAdapter.insertLocation(location.getTime(), location.getAltitude(), location.getLongitude());
            externalStorage.writeToFile(location.getTime(),location.getAltitude(),location.getLongitude());
            dbAdapter.close();
        }

        @Override
        public void onStatusChanged(String provider, int status, Bundle extras) {

        }

        @Override
        public void onProviderEnabled(String provider) {

        }

        @Override
        public void onProviderDisabled(String provider) {

        }
    };


    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.d("+++", " service started " );

        if(lm == null) {
            lm = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
            lm.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, locationListener);
        }
        return START_STICKY;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        lm.removeUpdates(locationListener);
        Log.d("+++", "service destroyed");
    }
}

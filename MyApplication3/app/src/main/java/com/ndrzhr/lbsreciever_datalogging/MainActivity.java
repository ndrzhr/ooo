package com.ndrzhr.lbsreciever_datalogging;

import android.content.Intent;
import android.database.Cursor;
import android.os.AsyncTask;
import android.os.Environment;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;

import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.DefaultHttpClient;

import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.Socket;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;


public class MainActivity extends ActionBarActivity {
    public static final String SERVER_IP = "ndrzhr.selfip.com";
    public static final int SERVER_PORT = 8080;
    String message;
    Date d;
    SimpleDateFormat formatter;
    double lat;
    double lng;
    long time;
    String data = "";
    ExternalStorage externalStorage;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        DBAdapter dbAdapter = new DBAdapter(this);
        dbAdapter.open();
        //long rowID = dbAdapter.insertLocation(System.currentTimeMillis(), 123.123, 321.321);


        Cursor cursor = dbAdapter.getAllLocations();
        while (cursor.moveToNext()) {
            time = cursor.getLong(0);
            lat = cursor.getDouble(1);
            lng = cursor.getDouble(2);
            formatter = new SimpleDateFormat("dd/MMM/yyyy HH:hh:SS");
            d = new Date(time);
            data = "location: time: " + formatter.format(d) + ", lat: " + lat + ",lng: " + lng;
            Log.d("+++", data);
        }
        cursor.close();
        dbAdapter.close();



    }




    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    public void btnStartService(View view) {
        Intent intent = new Intent(this, LocationService.class);
        startService(intent);
    }

    public void btnStopService(View view) {
        Intent intent = new Intent(this, LocationService.class);
        stopService(intent);
    }


    public void btnSend(View view) {
        externalStorage  = new ExternalStorage();
        externalStorage.writeToFile(d.getTime(),lat,lng);


    }
}

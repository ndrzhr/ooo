package com.ndrzhr.gpstracker12;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.widget.Toast;

/**
 * Created by ndrzhr on 6/16/15.
 */
public class BootUpReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        Toast.makeText(context,"app started",Toast.LENGTH_SHORT).show();
        Intent gpsIntent = new Intent(context,GPSTracker.class);
        gpsIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(gpsIntent);

    }
}

package com.ndrzhr.lbsreciever_datalogging;

import android.os.Environment;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by ndrzhr on 6/16/15.
 */
public class ExternalStorage {

    //static Date d;
    //static SimpleDateFormat formatter;
    //static double lat;
   // static double lng;


    public static boolean carWriteOnExternalStorage(){

        // get the state of the external storage
        String state = Environment.getExternalStorageState();
        if (Environment.MEDIA_MOUNTED.equals(state)) {
            // if storage is mounted return true

            Log.i("++++", "sd card is mounted, :" +state);
            return true;
        }
        Log.i("++++", "sd card is Not mounted");
        return false;
    }

    public static void writeToFile(long d, double lat, double lng){

        if(carWriteOnExternalStorage()) {
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MMM/yyyy HH:hh:SS");
            try {
                File sdCard = Environment.getExternalStorageDirectory();

                // to this path add a new directory path
                File dir = new File(sdCard.getAbsolutePath() + "/lbs/");
                Log.i("++++", sdCard.getAbsolutePath());
                // create this directory if not already created
                dir.mkdir();

                // create the file in which we will write the contents
                    File file = new File(dir, "myFileName.txt");
                    FileOutputStream os = new FileOutputStream(file);


                String data = "\n location: time: " + formatter.format(d) + ", lat: " + lat + ",lng: " + lng;
                os.write(data.getBytes());
                os.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}


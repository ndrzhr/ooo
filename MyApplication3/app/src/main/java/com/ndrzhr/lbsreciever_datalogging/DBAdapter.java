package com.ndrzhr.lbsreciever_datalogging;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

/**
 * Created by ndrzhr on 6/14/15.
 */
public class DBAdapter {
    static final String DATABASE_NAME = "MyDB.db";
    static final String DATABASE_TABLE = "Locations";

    static final String KEY_LAT = "lat";
    static final String KEY_LNG = "lng";
    static final String KEY_TIME = "time";


    static  final int DATABASE_VERSION = 1;

    final Context context;

    DatabaseHelper DBHelper;
    SQLiteDatabase db;

    public DBAdapter(Context context) {
        this.context = context;
        DBHelper = new DatabaseHelper(context);
    }
    private static class DatabaseHelper extends SQLiteOpenHelper{

        public DatabaseHelper(Context context) {
            super(context, DATABASE_NAME, null, DATABASE_VERSION);
        }

        @Override
        public void onCreate(SQLiteDatabase db) {

            db.execSQL("CREATE TABLE " + DATABASE_TABLE + "("+KEY_TIME+
                    " INTEGER,"+KEY_LAT+" REAL,"+KEY_LNG+" REAL)");

        }

        @Override
        public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
            db.execSQL("DROP TABLE IF EXISTS" + DATABASE_NAME);
            onCreate(db);
        }
    }

    public void open() {
        db = DBHelper.getWritableDatabase();
    }
    public void  close() {
        DBHelper.close();
    }

    public long insertLocation(long time, double lat, double lng) {
        ContentValues values = new ContentValues();
        values.put(KEY_TIME, time);
        values.put(KEY_LAT, lat);
        values.put(KEY_LNG, lng);

        return db.insert(DATABASE_TABLE, null, values);
    }

    public Cursor getAllLocations(){
        return db.query(DATABASE_TABLE,new String[]{KEY_TIME,KEY_LAT,KEY_LNG}, null, null, null, null, null);

    }
}

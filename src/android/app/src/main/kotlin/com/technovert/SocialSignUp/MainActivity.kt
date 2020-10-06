package com.technovert.boilerplate

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.graphics.BlendMode
import android.graphics.BlendModeColorFilter
import android.graphics.drawable.Drawable
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.net.Uri
import android.os.Build
import android.view.Gravity
import android.view.LayoutInflater
import android.widget.TextView
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import io.flutter.plugin.common.EventChannel

class MainActivity: FlutterActivity(),EventChannel.StreamHandler, SensorEventListener {
    private val MethodChannel = "com.technovert.boilerplate/methodChannel";
    private val EventChannel = "com.technovert.boilerplate/eventChannel";
    lateinit var eventSink : EventChannel.EventSink
    lateinit var sensorManager: SensorManager
    lateinit var sensor:Sensor
    private var latestReading: Float = 0.0F;

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, MethodChannel).setMethodCallHandler { call, result ->
        onMethodCall(call, result)}
        val eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, EventChannel)
        eventChannel.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        //val locationManager = this.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        //val provider: LocationProvider = locationManager.getProvider(LocationManager.GPS_PROVIDER)
        eventSink = events!!;
    }

    override fun onCancel(arguments: Any?) {
       // eventSink;
    }

    fun initializeSensor() : Boolean{
        sensorManager = this.getSystemService(Context.SENSOR_SERVICE) as SensorManager;
        sensor = sensorManager.getDefaultSensor(Sensor.TYPE_AMBIENT_TEMPERATURE)
        sensorManager.registerListener(this, sensor,SensorManager.SENSOR_DELAY_NORMAL)
        return true;
    }

    private fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method)
        {
            "initializeSensor" -> result.success(initializeSensor())
            "share" -> {
                expectMapArguments(call);
                share(call.argument<String>("title"), call.argument<String>("text"), call.argument<String>("subject"));
                result.success(null)
            }
            "showToast" -> {
                var mToast: Toast
                expectMapArguments(call)
                val mMessage = call.argument<Any>("msg").toString()
                val length = call.argument<Any>("length").toString()
                val gravity = call.argument<Any>("gravity").toString()
                val bgcolor = call.argument<Number>("bgcolor")
                val textcolor = call.argument<Number>("textcolor")
                val textSize = call.argument<Number>("fontSize")
                val mGravity: Int
                mGravity = when (gravity) {
                    "top" -> Gravity.TOP
                    "center" -> Gravity.CENTER
                    else -> Gravity.BOTTOM
                }
                val mDuration: Int
                mDuration = if (length == "long") {
                    Toast.LENGTH_LONG
                } else {
                    Toast.LENGTH_SHORT
                }
                if (bgcolor != null || textcolor != null || textSize != null) {
                    val layout = (context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater).inflate(R.layout.toast_custom, null)
                    val text = layout.findViewById<TextView>(R.id.text)
                    text.text = mMessage
                    val gradientDrawable: Drawable = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                        context.getDrawable(R.drawable.corner)!!
                    } else {
                        context.resources.getDrawable(R.drawable.corner)
                    }
                    if (bgcolor != null) {
                        gradientDrawable.colorFilter = BlendModeColorFilter(bgcolor.toInt(), BlendMode.SRC)
                    }
                    text.background = gradientDrawable
                    if (textSize != null) {
                        text.textSize = textSize.toFloat()
                    }
                    if (textcolor != null) {
                        text.setTextColor(textcolor.toInt())
                    }
                    mToast = Toast(context)
                    mToast.duration = mDuration
                    mToast.view = layout
                } else {
                    mToast = Toast.makeText(context, mMessage, mDuration)
                }
                when (mGravity) {
                    Gravity.CENTER -> {
                        mToast.setGravity(mGravity, 0, 0)
                    }
                    Gravity.TOP -> {
                        mToast.setGravity(mGravity, 0, 100)
                    }
                    else -> {
                        mToast.setGravity(mGravity, 0, 100)
                    }
                }
                if (context is Activity) {
                    (context as Activity).runOnUiThread { mToast.show() }
                } else {
                    mToast.show()
                }
                result.success(true)
            }
            else ->  result.notImplemented()
        }
    }

    @Throws(java.lang.IllegalArgumentException::class)
    private fun expectMapArguments(call: MethodCall) {
        require(call.arguments is Map<*, *>) { "Map argument expected" }
    }


    private fun share(title: String?, text: String?, subject: String?) {
       // val isOfTypeImage : Boolean = (files!=null && files.isNotEmpty())
   // if (!((text != null && text.isNotEmpty() ) || isOfTypeImage) ) {
        if(text == null || text.isEmpty()){
      throw IllegalArgumentException("Non-empty text expected");
    }
    val shareIntent: Intent = Intent()
       // val action: String = if (isOfTypeImage && 1 < files?.size!!)  Intent.ACTION_SEND_MULTIPLE else Intent.ACTION_SEND
        shareIntent.setAction(Intent.ACTION_SEND);
    shareIntent.putExtra(Intent.EXTRA_TEXT, text);
    shareIntent.putExtra(Intent.EXTRA_SUBJECT, subject)
    shareIntent.setType("text/plain")
    /*if(isOfTypeImage)
    {
        if(1 < files?.size!!) {
            val images = ArrayList<Uri>()
            for (path: String in files!!) {
                val file = File(path)
                val uri: Uri = FileProvider.getUriForFile(this, BuildConfig.APPLICATION_ID, file)
                images.add(uri);
                shareIntent.putParcelableArrayListExtra(Intent.EXTRA_STREAM, images);
            }
        }else
            shareIntent.putExtra(Intent.EXTRA_STREAM, FileProvider.getUriForFile(this, BuildConfig.APPLICATION_ID, File(files?.get(0))))
        }
    else*/
   // shareIntent.putExtra(Intent.EXTRA_STREAM, text)
    var chooserIntent = Intent.createChooser(shareIntent, title);
    this.startActivity(chooserIntent);    
  }

    override fun onSensorChanged(event: SensorEvent?) {
        latestReading = event?.values?.get(0) !!
        if(eventSink!=null)
        {
            eventSink.success(latestReading);
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {

    }
}

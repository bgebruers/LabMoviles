package com.example.soporte

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import android.graphics.ImageFormat
import android.graphics.SurfaceTexture
import android.hardware.camera2.CameraCaptureSession
import android.hardware.camera2.CameraDevice
import android.hardware.camera2.CameraManager
import android.hardware.camera2.CaptureRequest
import android.media.Image
import android.media.ImageReader
import androidx.appcompat.app.AppCompatActivity
import android.widget.Button
import android.os.Bundle
import android.os.Environment
import android.os.Handler
import android.os.HandlerThread
import android.view.Surface
import android.view.TextureView
import android.widget.TextView
import android.widget.Toast
import java.io.File
import java.io.FileOutputStream

class Camara : AppCompatActivity() {

    lateinit var capReq: CaptureRequest.Builder
    lateinit var handler: Handler
    lateinit var handlerThread: HandlerThread
    lateinit var cameraManager: CameraManager
    lateinit var textureView: TextureView
    lateinit var cameraCaptureSession: CameraCaptureSession
    lateinit var cameraDevice: CameraDevice
    lateinit var captureRequest: CaptureRequest
    lateinit var imageReader: ImageReader



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_camara)

        get_Permission()

        textureView= findViewById(R.id.textureView)
        cameraManager = getSystemService(CAMERA_SERVICE) as CameraManager
        handlerThread = HandlerThread("videoThread")
        handlerThread.start()
        handler = Handler(handlerThread.looper)

        val bundle= intent.extras
        val idCam= bundle?.getInt("idCam")

        textureView.surfaceTextureListener=object:TextureView.SurfaceTextureListener{
            override fun onSurfaceTextureAvailable(p0: SurfaceTexture, p1: Int, p2: Int) {
                if (idCam != null) {
                    try{
                        open_camera(idCam)
                    }catch (e: Exception) {
                        Toast.makeText(
                            this@Camara,
                            "Error de camaras",
                            Toast.LENGTH_SHORT
                        ).show()
                    }
                }else{
                    Toast.makeText(this@Camara, "Error al iniciar la camara", Toast.LENGTH_SHORT).show()
                }
            }

            override fun onSurfaceTextureSizeChanged(p0: SurfaceTexture, p1: Int, p2: Int) {

            }

            override fun onSurfaceTextureDestroyed(p0: SurfaceTexture): Boolean {
                return false
            }

            override fun onSurfaceTextureUpdated(p0: SurfaceTexture) {
            }
        }


        imageReader = ImageReader.newInstance(720, 1280, ImageFormat.JPEG, 1)
        imageReader.setOnImageAvailableListener(object:ImageReader.OnImageAvailableListener{
            override fun onImageAvailable(p0: ImageReader?) {
                var image = p0?.acquireLatestImage()
                var buffer = image!!.planes[0].buffer
                var bytes = ByteArray(buffer.remaining())
                buffer.get(bytes)

                var file = File(getExternalFilesDir(Environment.DIRECTORY_PICTURES), "img.jpeg")
                var opStream = FileOutputStream(file)

                opStream.write(bytes)


                opStream.close()
                image.close()


                Toast.makeText(this@Camara, "image capture", Toast.LENGTH_SHORT).show()
            }
                                                                                             },handler)

        var volver:Button = findViewById(R.id.volver)
        volver.setBackgroundColor(Color.GRAY)
        volver.setOnClickListener {
            cameraDevice.close()
            var intent:Intent = Intent(this@Camara, MainActivity::class.java)
            startActivity(intent)

        }
    }

    @SuppressLint("MissingPermission")
    fun open_camera(idCam: Int){
        cameraManager.openCamera(cameraManager.cameraIdList[idCam], object:CameraDevice.StateCallback(){
            override fun onOpened(p0: CameraDevice) {
                cameraDevice = p0
                capReq = cameraDevice.createCaptureRequest(CameraDevice.TEMPLATE_PREVIEW)
                var surface = Surface(textureView.surfaceTexture)
                capReq.addTarget(surface)

                cameraDevice.createCaptureSession(listOf(surface, imageReader.surface), object:CameraCaptureSession.StateCallback(){
                    override fun onConfigured(p0: CameraCaptureSession) {
                        cameraCaptureSession = p0
                        cameraCaptureSession.setRepeatingRequest(capReq.build(),null, null)
                    }

                    override fun onConfigureFailed(p0: CameraCaptureSession) { }

                }, handler)


            }

            override fun onDisconnected(p0: CameraDevice) {
            }

            override fun onError(p0: CameraDevice, p1: Int) {
                Toast.makeText(this@Camara, "La camara no funciona correctamente", Toast.LENGTH_SHORT).show()
            }

        }, handler)
    }
    fun get_Permission(){
        var permissionList = mutableListOf<String>()
        if(checkSelfPermission(android.Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED)
            permissionList.add(android.Manifest.permission.CAMERA)
        if(checkSelfPermission(android.Manifest.permission.READ_EXTERNAL_STORAGE)!= PackageManager.PERMISSION_GRANTED)
            permissionList.add((android.Manifest.permission.READ_EXTERNAL_STORAGE))
        if(checkSelfPermission(android.Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED)
            permissionList.add(android.Manifest.permission.WRITE_EXTERNAL_STORAGE)
        if(permissionList.size > 0){
            requestPermissions(permissionList.toTypedArray(), 101)
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        grantResults.forEach {
            if(it != PackageManager.PERMISSION_GRANTED){
                get_Permission()
            }
        }
    }

}
package com.example.soporte

import android.content.Context
import android.graphics.Color
import android.hardware.camera2.CameraManager
import android.os.Bundle
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity

class linternaPrueba : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_linterna_prueba)

        val camaraManager: CameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager

        val btEncender: Button = findViewById(R.id.btnEnceder)
        btEncender.setBackgroundColor(Color.GRAY)
        val btApagar: Button = findViewById(R.id.btApagar)
        btApagar.setBackgroundColor(Color.GRAY)
        val btSalir: Button = findViewById(R.id.btSalir)
        btSalir.setBackgroundColor(Color.GRAY)

        btEncender.setOnClickListener{
            //ver tutorial de slack
            try {
                camaraManager.setTorchMode("0", true)
            }catch (e: Exception){
                Toast.makeText(this@linternaPrueba, "El flash no funciona correctamente", Toast.LENGTH_SHORT).show()

            }




            btEncender.setBackgroundColor(Color.GREEN)
            Toast.makeText(this, "Flash Encendio Correctamente", Toast.LENGTH_SHORT).show()
        }

        btApagar.setOnClickListener{
            camaraManager.setTorchMode("0", false)
            btEncender.setBackgroundColor(Color.GRAY)
        }

        btSalir.setOnClickListener{
            camaraManager.setTorchMode("0",false)
            finish()
        }

    }
}
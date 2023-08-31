package com.example.soporte

import android.content.Context
import android.content.Intent
import android.hardware.camera2.CameraManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val btlinterna: Button = findViewById(R.id.btLinterna)
        val btCamaraFrontal: Button = findViewById(R.id.btCamaraFrontal)
        val btCamara: Button = findViewById(R.id.btCamara)
        val btSalirApp: Button = findViewById(R.id.btSalirApp)

        btlinterna.setOnClickListener{
            val intent: Intent = Intent(this, linternaPrueba::class.java)
            startActivity(intent)
        }

        btCamara.setOnClickListener{
            val intent: Intent = Intent(this, Camara::class.java)
            startActivity(intent)
        }

        btCamaraFrontal.setOnClickListener{
            val intent: Intent = Intent(this, CamaraFrontal::class.java)
            startActivity(intent)
        }

        btSalirApp.setOnClickListener{
            finishAffinity()
        }



}
}

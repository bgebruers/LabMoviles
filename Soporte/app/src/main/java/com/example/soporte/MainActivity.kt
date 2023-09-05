package com.example.soporte

import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.hardware.camera2.CameraManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val btlinterna: Button = findViewById(R.id.btLinterna)
        btlinterna.setBackgroundColor(Color.GRAY)

        val btCamaraFrontal: Button = findViewById(R.id.btCamaraFrontal)
        btCamaraFrontal.setBackgroundColor(Color.GRAY)

        val btCamara: Button = findViewById(R.id.btCamara)
        btCamara.setBackgroundColor(Color.GRAY)

        val btGPS: Button = findViewById(R.id.btGPS)
        btGPS.setBackgroundColor(Color.GRAY)

        val btParlantes: Button = findViewById(R.id.btParlantes)
        btParlantes.setBackgroundColor(Color.GRAY)

        val btSalirApp: Button = findViewById(R.id.btSalirApp)
        btSalirApp.setBackgroundColor(Color.GRAY)



        btlinterna.setOnClickListener{
            val intent: Intent = Intent(this, linternaPrueba::class.java)
            startActivity(intent)
        }

        btCamara.setOnClickListener{
            val intent: Intent = Intent(this, Camara::class.java)
            intent.putExtra("idCam", 0)
            startActivity(intent)
        }

        btCamaraFrontal.setOnClickListener{
            val intent: Intent = Intent(this, Camara::class.java)
            intent.putExtra("idCam", 1)
            startActivity(intent)
        }

        btGPS.setOnClickListener{
            val intent: Intent = Intent(this, GPS::class.java)
            startActivity(intent)
        }

        btParlantes.setOnClickListener{
            val intent: Intent = Intent(this, Parlantes::class.java)
            startActivity(intent)
        }

        btSalirApp.setOnClickListener{
            finishAffinity()
        }



}
}

package com.example.soporte

import android.content.Intent
import android.graphics.Color
import android.media.MediaPlayer
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.Toast

class Parlantes : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_parlantes)

        val btnPlay: Button = findViewById(R.id.buttonPlay)
        btnPlay.setBackgroundColor(Color.GRAY)

        val back: Button = findViewById(R.id.buttonBack)
        back.setBackgroundColor(Color.GRAY)

        val stop: Button = findViewById(R.id.buttonStop)
        stop.setBackgroundColor(Color.GRAY)

        val mediaPlayer: MediaPlayer = MediaPlayer.create(this, R.raw.sound)
        var toggle = false
        btnPlay.setOnClickListener{
            if (!toggle){
                toggle = true
                Toast.makeText(
                    this@Parlantes,
                    "Parlantes funcionan de manera correcta",
                    Toast.LENGTH_SHORT
                ).show()
                mediaPlayer.start()
            }else{
                toggle = false
                mediaPlayer.pause()
            }
        }

        stop.setOnClickListener {
            mediaPlayer.pause()
        }

        back.setOnClickListener{
            val intent = Intent(this, MainActivity::class.java)
            mediaPlayer.stop()
            startActivity(intent)
        }
    }
}
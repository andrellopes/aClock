package dev.allc.a_clock

import android.os.Build
import android.os.Bundle
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
// Removidos imports do AdMob nativo
// import com.google.android.gms.ads.nativead.NativeAd
// import android.view.View
// import android.widget.LinearLayout
// import android.widget.TextView
// import android.widget.ImageView
// import android.graphics.Color
// import android.view.Gravity
// import com.google.android.gms.ads.nativead.NativeAdView

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // ✅ Edge-to-edge compatível com SDK 35 (Android 15)
        // FlutterActivity herda de Activity, não ComponentActivity
        // Então usamos WindowCompat que funciona para todas as versões
        WindowCompat.setDecorFitsSystemWindows(window, false)
        
        // ✅ Para SDK 35+, o edge-to-edge é ativado automaticamente
        // pelo sistema, apenas garantimos que os recuos sejam tratados corretamente
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Removido: registro do factory nativo para NativeAd
        // GoogleMobileAdsPlugin.registerNativeAdFactory(...)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        // Removido: unregister do factory nativo
        // GoogleMobileAdsPlugin.unregisterNativeAdFactory(...)
        super.cleanUpFlutterEngine(flutterEngine)
    }
}

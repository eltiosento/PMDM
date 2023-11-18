package com.example.whatsdam.model

import android.util.Log
import com.example.whatsdam.viewmodel.MissatgesViewModel

import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONObject
import java.io.BufferedReader
import java.io.InputStreamReader
import java.io.OutputStreamWriter
import java.io.PrintWriter
import java.net.InetSocketAddress
import java.net.ServerSocket
import java.net.Socket


object CommunicationManager {

    val port=9999
    var server="127.0.0.1"
    var listenPort:Int?=null

    public suspend fun sendServer(msg:String): JSONObject {
        Log.d("Debug [CommunicationManager]", "Sending Server: "+msg)
        return withContext(Dispatchers.IO) {
            var resposta: JSONObject? = null
            val socket = Socket()
            val socketAddr = InetSocketAddress(server, port)
            try {
                Log.d("Debug [CommunicationManager]", "Connecting to "+socketAddr.toString())
                socket.connect(socketAddr) // Connectem al servidor
                val inStream = socket.getInputStream()
                val outStream = socket.getOutputStream()
                val isr = InputStreamReader(inStream)
                val osw = OutputStreamWriter(outStream)
                val bReader = BufferedReader(isr)
                val pWriter = PrintWriter(osw)
                pWriter.println(msg)
                pWriter.flush()
                val linia = bReader.readLine()
                resposta = JSONObject(linia)
                pWriter.close()
                bReader.close()
                isr.close()
                osw.close()
                inStream.close()
                outStream.close()
                socket.close()
            } catch (e: Exception) {
                e.printStackTrace();
            }
            resposta!!
        }
    }

    suspend fun prepareListener() {
        lateinit var listener:ServerSocket
        while (listenPort==null) {
            Log.d("Debug [CommunicationManager]", "Assign ListenPort")
            try {
                listener = withContext(Dispatchers.IO) {
                    ServerSocket(0)
                }
                listenPort = listener.localPort
                Log.d("Debug [CommunicationManager]", "Setting listenPort to: " + listenPort)
            } catch (e: Exception) {
                e.printStackTrace()
            }
            withContext(Dispatchers.IO) {
                Thread.sleep(1000)
            }
        }

        @OptIn(DelicateCoroutinesApi::class)
        GlobalScope.launch(Dispatchers.IO) {
            try {
                while (true) {
                    val socket = listener.accept()
                    Log.d("Debug [CommunicationManager]", "S'ha rebut la connexió")
                    val inStream = socket?.getInputStream()
                    val isr = InputStreamReader(inStream)
                    val bf = BufferedReader(isr)
                    val linia = bf.readLine()
                    Log.d("Debug [CommunicationManager]", "linia: "+linia)
                    processNotification(linia)
                    val os = socket?.getOutputStream()
                    val osr = OutputStreamWriter(os)
                    val pw = PrintWriter(osr)
                    Log.d("Debug [CommunicationManager]","Responc {'status':'ok'}")
                    pw.println("{'status':'ok'}")
                    pw.flush()
                    pw.close()
                    osr.close()
                    os?.close()
                    bf.close()
                    isr.close()
                    inStream?.close()
                }
            } catch (e: java.lang.Exception) {
                e.printStackTrace()
            }
        }
    }

    fun processNotification(s:String) {
        val notification = JSONObject(s)
        when (notification.getString("type")) {
            "userlist" -> {

                
            }

            "message" -> {
                Log.d("Debug [CommunicationManager] ",notification.toString())
                Missatges.add(notification.getString("user"), notification.getString("content"))
            }
        }
    }


    suspend fun Login(username:String, server:String):JSONObject {

        prepareListener()

        Log.d("Debug [CommunicationManager]", "Validant: "+username+":"+server)

        try {
            this.server = server;
            val msgConnect = JSONObject()
            msgConnect.put("command", "register")
            msgConnect.put("user", username)
            msgConnect.put("listenPort", listenPort)
            Log.d("Debug [LoginViewModel]", msgConnect.toString())
            val resposta = sendServer(msgConnect.toString())
            Log.d("Debug [CommunicationManager]", resposta.toString())
            return resposta


        }catch (e:Exception){
            e.printStackTrace();
            return JSONObject().put("status","error").put("message", e.message.toString())
        }
    }
}

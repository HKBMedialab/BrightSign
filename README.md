# BrightSign
Autorun Files for BrightSign Media Player

---

One player will be the "Master" and all other players will be "Clients" that synchronize to the master. 

1.	Copy a video onto the root of the SD card for each player.		
2.	On the first player, drag the "autorun.brs" file from the "Master" folder onto the root of the SD card.
3.	On the second player, drag the "autorun.brs" file from the "Client 1" folder onto the root of the SD card.
4.	Continue for each player, using subsequent client numbers for each one.
5.	Plug in the ethernet cables between players.
6.	Plug in the power and they should play and loop in sync.
  
They should automatically negotiate the correct resolution and play whatever file is on the root of the SD card. If you need to alter that behavior you can edit the script, but most people don't need to do this!

To edit a script:
1.	Open BBEdit and drag a script file into the edit window.  Never edit the files with Apple TextEdit. They will break!
2.	Follow the directions at the top of each script file to manually set the filename, resolution, scaling mode, etc.
3.	Save the script as "autorun.brs" onto the root of the SD Card, along with the video file. Do not use .txt  as the extension. It must be called "autorun.brs"
  
---

_Additional Information in German:_
  
Die BrightSign MediaPlayer eignen sich um Multikanal-Videoarbeiten synchron zu zeigen.

Die 
Diese Dateien müssen “autorun.brs” heissen und kommen zusammen mit der Videodatei auf die entsprechende Speicherkarte. Darauf achten, dass die Speicherkarte mit der Master-Datei auch im Player mit der Bezeichnung Master verwendet wird.

Name der Videodatei ist egal, darf aber nicht mit einem Punkt beginnen und sollte enden mit “.mp4” oder “.ts”. Die Videos müssen exakt gleich lang sein.

Für ein optimales Ergebnis folgende Einstellungen verwenden:

- FullHD Auflösung: 1920 x 1080 Pixel (kann auch HD Ready 1280 x 720 sein!)
- Seitenverhältnis: 16:9
- Codec: H264
- Container: .mp4
- Bitrate: maximal 20 – 25 MBit/s; Konstante Bitrate

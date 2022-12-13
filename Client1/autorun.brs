'    _____ _      _____ ______ _   _ _______    __ 
'   / ____| |    |_   _|  ____| \ | |__   __|  /_ |
'  | |    | |      | | | |__  |  \| |  | |      | |
'  | |    | |      | | |  __| | . ` |  | |      | |
'  | |____| |____ _| |_| |____| |\  |  | |      | |
'   \_____|______|_____|______|_| \_|  |_|      |_|
'                                                  
' BrightSign Multi-Screen Ethernet Sync Script - v2019-04-05 - (CLIENT SCRIPT 1)
' Modified by Zach Poff (zachpoff.com) from scripts provided by BrightSign
' This script syncs multiple BrightSigns by sending messages over ethernet.

' ----------------------------------------------------
' STOP! YOU PROBABLY DON'T NEED TO EDIT THIS SCRIPT!!!
' If you need to make changes, use a code editor (like BBEdit). Apple's TextEdit will DAMAGE THE SCRIPT!
' ----------------------------------------------------

videoFile = "auto"
'    (use "auto" to automatically play the first or only movie on the SD card, otherwise insert the filename of your video "in quotes")

VideoMode = "auto"
'    (use "auto" to automatically negotiate the display resolution, or insert from list below "in quotes")

ScaleMode = 1
'	 (How should the video be scaled if it doesn't match the screen? ... Insert a number from list below, NOT in quotes)
'    0 = "Scale To Fit"				Scales the video to fill the window in both dimensions. The aspect ratio of the video is ignored, so the video may be stretched/squashed.
'    1 = "Letterboxed And Centered"	(recommended) Scales the video to fill the window in the longest dimension, adding letterbox/pillarbox if required to maintain video aspect ratio.
'    2 = "Fill Screen And Centered"	Scales the video to fill the window in the shortest dimension. The aspect ratio is maintained, so the long dimension may be cropped.
'    3 = "Centered"					Centers the window with no scaling.

ClientIP = "192.168.1.11"
'    (the IP address of this client, in quotes. Each client player needs a unique suffix,
'     but all players must have the same first 3 numbers.)
' 
'     example: 
'        master   = "192.168.1.10"
'        client 1 = "192.168.1.11"
'        client 2 = "192.168.1.12"
'        client 3 = "192.168.1.13" ... and so on ...

audioVolume = 15
'    (the volume of the audio output, in percent... 
'     These players have LOUD outputs so try 10-20 for sane headphone levels!)

' *** Scroll down to the "Setting Manual IP address" section if you
'     want to choose a different IP range or enable DHCP. 
'     Most people don't need to do this!


' VIDEO MODES
' -----------
' The list below shows resolutions supported by MOST players. For the exact resolutions that YOUR player supports, go here:
' https://brightsign.zendesk.com/hc/en-us/articles/218065627-Supported-video-output-resolutions

' Older players with VGA ports can display NTSC/PAL component/S-Video/composite(CVBS) via an adapter: 
' http://support.brightsign.biz/entries/22929977-Can-I-use-component-and-composite-video-with-BrightSign-players-
'    
'    via HDMI / Component:
'    ---------------------
'    ntsc-component
'    pal-component 
'    ntsc-m 
'    ntsc-m-jpn 
'    pal-i 
'    pal-bg 
'    pal-n 
'    pal-nc 
'    pal-m 
'    720x576x50p
'    720x480x59.94p
'    720x480x60p
'    1280x720x50p
'    1280x720x59.94p
'    1280x720x60p
'    1920x1080x50i
'    1920x1080x59.94i
'    1920x1080x60i
'    1920x1080x24p   (not backwards compatible)
'    1920x1080x29.97p
'    1920x1080x30p   (not backwards compatible)
'    1920x1080x50p
'    1920x1080x59.94p
'    1920x1080x60p

'    via HDMI / VGA:
'    ---------------
'    640x480x60p 
'    800x600x60p 
'    800x600x75p 
'    1024x768x60p 
'    1024x768x75p 
'    1280x768x60p 
'    1280x800x60p 
'    1360x768x60p 

'    4k output via HDMI (upscaled from HD content)
'    for HD222, HD1022, XD232, XD1032, XD1132 players
'    ---------------
'    3840x2160x24p
'    3840x2160x25p
'    3840x2160x29.97p
'    3840x2160x30p

' ----------------------------------------------------
' DON'T edit anything below this line.
' (unless you know exactly what you're doing)
' ----------------------------------------------------

'---- Find first playable file on SD card ----
DIM mylist[5]
list=ListDir("/")
countFound=0
for each file in list
	if ucase(right(file,3)) = "MOV" or ucase(right(file,3)) = "MP4" or ucase(right(file,3)) = "MPG" or ucase(right(file,3)) = "VOB" or ucase(right(file,2)) = "TS" then 
		if not left(file,1) = "." then 'reject dotfiles!
			mylist[countFound]=file
			countFound=countFound+1
		endif
	endif
next
if videoFile = "auto" then
	videoFile = mylist[0] 'choose first file found (in case of multiples)
endif

mode=CreateObject("roVideoMode")
mode.SetMode(VideoMode)


' Setting Manual IP address
' To use DHCP, add REM before each of the nc.SetIP* lines below.
' If you have already run the script, also remove REM from the
' nc.SetDHCP() line below to change from manual IP back 

nc = CreateObject("roNetworkConfiguration", 0)
REM nc.SetDHCP() 'to change from Manual IP back to DHCP

nc.SetIP4Address(ClientIP)
nc.SetIP4Netmask("255.255.255.0")
nc.SetIP4Broadcast("192.168.1.255")
nc.SetIP4Gateway("192.168.1.1")
nc.Apply()

receiver = CreateObject("roDatagramReceiver", 11167)

v = CreateObject("roVideoPlayer")
v.SetViewMode(ScaleMode)
v.SetVolume(audioVolume)
sleep(200)

v.PreloadFile(videoFile)

p = CreateObject("roMessagePort")

receiver.SetPort(p)

listen:
	msg = wait(2000,p)

	if type(msg) = "roDatagramEvent" then 

        command = left(msg, 3)

		if command = "pre" then
				v.PreloadFile(videoFile)
		elseif command = "ply" then
				v.Play()
		else
			print msg
		endif

	endif

	goto listen

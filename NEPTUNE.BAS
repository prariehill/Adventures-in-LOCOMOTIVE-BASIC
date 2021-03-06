10 REM *********************************************
20 REM              Neptunes' Caverns
30 REM Programmed by Steve Rodgers and Marcus Milton
40 REM  Adapted from BBC version by Timothy Surtell
50 REM Adapted for CPC from Carsten Dost aka SRS
60 REM *********************************************
70 REM NC200 Version
80 REM Downloaded from Tim's NC Users' Site
90 REM http://www.ncus.org.uk
100 REM Adapted for CPC from Carsten Dost aka SRS
110 REM http://www.cpcwiki.eu
120 GOSUB 1350:REM PROCinitialise
130 WHILE (wf=0 AND lf=0)
140   GOSUB 200:REM ***Input***
150   GOSUB 390:REM ***Sort***
160 WEND
170 GOSUB 1530:REM PROCend
180 END
190 REM ***Input***
200 REM DEF PROCinput
210 vb$="":no$=""
220 PRINT STRING$(80,"-"):INPUT"What do you do next ";r$:r$=UPPER$(r$)
230 IF r$="" THEN GOTO 220
240 FOR I=1 TO LEN(r$)
250   IF MID$(r$,I,1)=" " THEN vb$=LEFT$(r$,3):no$=MID$(r$,I+1,3):I=LEN(r$)
260 NEXT
270 IF vb$="GO " OR vb$="MOV" THEN vb$="GO":RETURN
280 IF no$<>"" THEN RETURN
290 r$=LEFT$(r$,3)
300 IF r$="N" THEN r$="NOR"
310 IF r$="S" THEN r$="SOU"
320 IF r$="E" THEN r$="EAS"
330 IF r$="W" THEN r$="WES"
340 IF r$="NOR" OR r$="SOU" OR r$="EAS" OR r$="WES" THEN vb$="GO":no$=r$:RETURN
350 IF r$="HEL" OR r$="INV" OR r$="LOO" THEN no$="DOO":vb$=r$:RETURN
360 PRINT "I don't understand that!"
370 GOTO 220
380 REM ***Sort***
390 REM PROCsort
400 vb=0:no=0:FOR I=1 TO vv
410   IF vb$=LEFT$(vb$(I),3) THEN vb=I:I=vv
420 NEXT
430 FOR I=1 TO nn
440   IF no$=mo$(I) THEN no=I:I=nn
450 NEXT
460 IF no=0 OR vb=0 THEN PRINT"I don't understand that!":RETURN
470 ON vb GOTO 480,530,530,620,620,740,740,820,870,990,990,1060,1120,1170,1220
480 REM ***Go***
490 IF no>4 THEN PRINT"Go where ?":RETURN
500 IF ex(cp,no)=0 THEN PRINT"There is no exit that way!":RETURN
510 IF cp=16 AND (no=1 OR no=4) AND ff=0 THEN lf=1:RETURN
520 cp=ex(cp,no):GOTO 1220
530 REM ***Get***
540 IF no=6 AND cp=13 THEN PRINT"It's too heavy!":RETURN
550 IF no<8 THEN PRINT"Don't be silly!":RETURN
560 IF ob(no-7)=99 AND no$<>"HAN" THEN PRINT"You've already got it!":RETURN
570 FOR I=7 TO 10
580   IF ob(I)=cp AND no=14 THEN no=I+7:hc=hc+1:I=10
590 NEXT
600 IF ob(no-7)=cp THEN PRINT"O.K":ob(no-7)=99:in=in+1:RETURN
610 PRINT "It isn't here!":RETURN
620 REM ***Drop***
630 IF cp=3 AND ob(1)=99 AND vb$="THR" THEN PRINT"The knife slams hard into the door.  You cannot remove it.":lo$(3)=lo$(3)+"  A knife is wedged into the door.":ob(1)=0:in=in-1:RETURN
640 IF cp=9 AND ob(1)=99 AND vb$="THR" THEN PRINT"The knife slams hard into the door.  You cannot remove it.":lo$(9)=lo$(9)+"  A knife is wedged into the door.":ob(1)=0:in=in-1:RETURN
650 IF cp=20 AND ob(1)=99 AND vb$="THR" AND ex(20,4)=0 THEN PRINT"The knife hits the octopus.  He only gets more angry.":lf=1:RETURN
660 IF no<8 THEN PRINT"Don't be silly!":RETURN
670 FOR I=7 TO 10
680   IF ob(I)=99 AND no=14 THEN no=I+7:hc=hc-1:I=10
690 NEXT
700 IF ob(no-7)<>99 THEN PRINT"You haven't got it!":RETURN
710 PRINT "O.K":ob(no-7)=cp:in=in-1
720 IF cp=19 AND no=13 THEN wf=1
730 RETURN
740 REM ***Cut***
750 IF ob(1)<>99 THEN PRINT"You've nothing sharp enough!":RETURN
760 IF no<>11 THEN PRINT"You can't cut that!":RETURN
770 IF cp<>5 THEN PRINT"You can't do that!":RETURN
780 IF cf=1 THEN PRINT"You've already done that!":RETURN
790 PRINT"The seaweed falls away to reveal an open window."
800 ob(4)=5:ex(5,2)=11:cf=1
810 lo$(5)=LEFT$(lo$(5),58)+"an open window in it.":RETURN
820 REM ***Wear***
830 IF ff=1 AND no$="FLI" THEN PRINT"You've already got them on!":RETURN
840 IF ob(2)=99 AND no$="FLI" THEN ff=1:ob(2)=0:PRINT"They fit nicely!":RETURN
850 IF no=14 AND hc>0 THEN PRINT"That's really silly!":RETURN
860 PRINT"You can't wear that!":RETURN
870 REM ***Give***
880 IF cp=10 AND no=11 THEN GOTO 920
890 IF cp=7 AND no=12 THEN GOTO 950
900 IF cp=20 THEN PRINT"That won't do any good!":RETURN
910 PRINT"Nothing here want's it!":RETURN
920 IF ob(4)<>99 THEN PRINT"You haven't got it!":RETURN
930 ob(4)=0:ob(3)=10
940 PRINT"They crowd around you and something glints in the corner.":RETURN
950 IF ob(5)<>99 THEN PRINT"You haven't got it!":RETURN
960 ob(5)=0:ex(7,2)=13
970 PRINT"The fish snatches a bone and retires to a corner."
980 lo$(7)="You are in a low cavern.  A dog fish is in a corner gnawing on a thigh bone.":RETURN
990 REM ***Unlock***
1000 IF ob(3)<>99 THEN PRINT"You haven't got a key!":RETURN
1010 IF no=5 AND (cp=3 OR cp=9) THEN PRINT"There isn't even a keyhole!":RETURN
1020 IF cp<>13 OR no<>6 THEN PRINT"You can't do that!":RETURN
1030 IF uf=1 THEN PRINT"It's already unlocked!":RETURN
1040 uf=1:ob(7)=13:PRINT"The key turns easily."
1050 lo$(13)="You are in a room that has a large open chest in the middle.":RETURN
1060 REM ***Use***
1070 IF cp<>20 OR no<>14 THEN PRINT"You can't do that here!":RETURN
1080 IF hc<4 THEN PRINT"You haven't got enough pairs!":RETURN
1090 PRINT"The octopus can't move.  He isn't amused!"
1100 FOR I=7 TO 10:ob(I)=0:NEXT
1110 hc=0:ex(20,4)=19:lo$(20)=LEFT$(lo$(20),57)+"A manacled octopus sitssulking.":RETURN
1120 REM ***Inventory***
1130 PRINT"You are carrying :-"'
1140 IF in=0 THEN PRINT"Nothing!":RETURN
1150 FOR I=1 TO 10:IF ob(I)=99 THEN PRINT"A ";ob$(I)
1160 NEXT:RETURN
1170 REM ***Help***
1180 PRINT"These are the words you may use :-"'
1190 PRINT"NORTH SOUTH EAST WEST MOVE ";:FOR I=1 TO 7:PRINT;vb$(I);" ";:NEXT:PRINT:FOR I=8 TO vv:PRINT;vb$(I);" ";:NEXT
1200 PRINT"(You need only type the first 3 letters)"
1210 RETURN
1220 REM ***Look***
1230 PRINT lo$(cp):IF cp=22 THEN lf=1:RETURN
1240 FOR I=1 TO 10
1250   IF I=5 AND cp=15 THEN GOTO 1270
1260   IF ob(I)=cp THEN PRINT"A ";ob$(I);" is here."
1270 NEXT
1280 PRINT "Exits : ";
1290 IF ex(cp,1)>0 THEN PRINT"North ";
1300 IF ex(cp,2)>0 THEN PRINT"South ";
1310 IF ex(cp,3)>0 THEN PRINT"East ";
1320 IF ex(cp,4)>0 THEN PRINT"West ";
1330 PRINT:RETURN
1340 REM ***Initialise***
1350 REM DEF PROCinitialise
1360 CLS:PRINT TAB(23);CHR$(24);"N e p t u n e ' s    C a v e r n s";CHR$(24);TAB(2);"Programmed by Steve Rodgers and Marcus Milton.                                  Adapted for NC100 by Timothy Surtell. Converted to CPC by Carsten Dost"
1370 PRINT "Press any key to start.  Type HELP for assistance at any time..."
1380 nn=14:vv=15:cp=3:in=1:hc=0:wf=0:lf=0:uf=0:ff=0:cf=0
1390 DIM lo$(24),ex(24,4),mo$(nn),vb$(vv),ob$(10),ob(10)
1400 FOR I=1 TO 24
1410   IF I=17 OR I=18 OR I=23 OR I=24 THEN lo$(I)=lo$(12):GOTO 1430
1420   READ d$:lo$(I)=d$
1430 NEXT
1440 FOR I=1 TO 24:FOR J=1 TO 4:READ ex(I,J):NEXT:NEXT
1450 FOR I=1 TO 10:READ ob$(I),ob(I):NEXT
1460 FOR I=1 TO nn:READ mo$(I):NEXT
1470 FOR I=1 TO vv:READ vb$(I):NEXT
1480 CALL &BB18:CLS:PRINT"The story so far..."
1490 PRINT "You have found the magic plug that belongs at the bottom of the sea, and you    decide to replace it at all costs before the water drains away. With your scuba gear you dive into the ocean and begin your adventure..."
1500 PRINT STRING$(80,"-")
1510 GOTO 1220:REM Look
1520 REM ***End***
1530 REM PROCend
1540 IF cp=22 THEN PRINT "With one swift bite, the shark bites off your head.";TAB(30);"T H E   E N D":END
1550 IF cp=20 THEN PRINT"The octopus picks you up and strangles you to death.";TAB(30);"T H E   E N D"':END
1560 IF cp=16 THEN PRINT"The spines on the sea-urchins are very poisonous! You die a horrible death!Next time take precautions!";TAB(30);"T H E   E N D":END
1570 PRINT"With a thunk the plug drops into the hole and the swirling waters grow still.CONGRATULATIONS!!!  You saved the seas!"''TAB(30)"T H E   E N D"':END
1580 REM ***Descriptions***
1590 DATA "You are on the seabed. The way west is blocked by a high coral reef."
1600 DATA "You are on the seabed. To the south a wall towers above you."
1610 DATA "You are in front of a wooden door set into a barnacled wall.  You can see no    handle."
1620 DATA "You are on the seabed. To the south a barnacled wall towers above you."
1630 DATA "You are on the seabed. To the south a barnacled wall has a square patch of sea- weed growing on it."
1640 DATA "You are on the seabed.To the south is a barnacled wall.A cliff blocks the  way."
1650 DATA "You are in a long, low cavern.At the far end a large dog-like fish is swimming  around."
1660 DATA "You are in a brightly lit chamber.  The walls, floor and ceiling all glow in theshimmering light."
1670 DATA "You are in a dimmly lit cavern with a huge door at the far end.  You can see no handle."
1680 DATA "You are in a room full of hungry sea-horses!  They nuzzle your hand in a       friendly manner."
1690 DATA "You are in a small square room.  The north wall has a small window in it,thoughwhich you can see the seabed."
1700 DATA "You are in an aMAZEingly square room.  The walls, floor and ceiling are all    square, as are all the exits."
1710 DATA "You are in a tiny room that is almost totally occupied by a chest, inscribed   with the initials 'D.J'."
1720 DATA "You are in a cold, murky room.  Grey mud swirls around you and you feel a slightcurrent to the east."
1730 DATA "You are in a gloomy and errie place.  All around you are the bones of long deadexplorers."
1740 DATA "You are in a square room.  The south exit has the words 'DO NOT ENTER' above itThe north and west doorways are crawling with sea-urchins."
1750 DATA "You are in a circular room with a very strong current that swirls around the   room and down a hole in the floor."
1760 DATA "You are in a corridor with a strong current going west.  Your way is blocked by the arms of a huge rainbow coloured octopus."
1770 DATA "You are in a shipwreaked captains cabin.  You feel the flow of water to the west."
1780 DATA "You see a rush of swirling water and face the jaws of a great white shark."
1790 REM ***Exits***
1800 DATA 0,0,2,0,0,0,3,1,0,0,4,2,0,0,5,3
1810 DATA 0,0,6,4,0,0,0,5,0,0,8,0,0,14,0,7
1820 DATA 0,15,0,0,0,16,0,0,5,17,12,0,0,18,12,11
1830 DATA 7,0,0,0,8,0,15,0,9,21,16,14,10,22,17,15
1840 DATA 11,23,18,16,12,24,18,17,0,0,20,0,0,0,21,0
1850 DATA 15,0,0,20,16,0,0,0,17,23,24,0,18,24,24,23
1860 REM ***Objects***
1870 DATA "KNIFE",2
1880 DATA "PAIR OF FLIPPERS",6
1890 DATA "KEY",0
1900 DATA "CLUMP OF SEAWEED",0
1910 DATA "MOULDY OLD BONE",15
1920 DATA "MAGIC PLUG",99
1930 DATA "YELLOW PAIR OF HANDCUFFS",0
1940 DATA "GREEN PAIR OF HANDCUFFS",9
1950 DATA "RED PAIR OF HANDCUFFS",17
1960 DATA "BLUE PAIR OF HANDCUFFS",11
1970 REM ***Nouns***
1980 DATA "NOR","SOU","EAS","WES","DOO","CHE","WIN","KNI","FLI","KEY","SEA","BON","PLU","HAN"
1990 REM ***Verbs***
2000 DATA "GO","TAKE","GET","DROP","THROW","CUT","CHOP","WEAR","GIVE","UNLOCK","OPEN","USE","INVENTORY","HELP","LOOK"
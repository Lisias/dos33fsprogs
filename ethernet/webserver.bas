1 REM *** Setup UTHERNET II - W5100
2 REM *** Assumes slot 5 ($C0D0)
3 SLOT=49360: REM *** $C0D0
4 MR=SLOT+4: REM *** MODE REGISTER C0D4
5 HA=SLOT+5:LA=SLOT+6: REM *** HIGH/LOW ADDR $C0D5,$C0D6
7 DP=SLOT+7: REM *** DATA PORT $C0D7
10 REM *** Init W5100
12 POKE MR,128 : REM RESET W5100
14 POKE MR,3 : REM AUTOINCREMENT
20 REM *** Setup MAC Address
21 REM *** 41:50:50:4c:45:32
22 POKE HA,0:POKE LA,9
23 POKE DP,65
23 POKE DP,80
23 POKE DP,80
23 POKE DP,76
23 POKE DP,69
23 POKE DP,50
30 REM *** Setup IP Address
31 REM *** 192.168.8.15
32 POKE LA,15
33 POKE DP,192
34 POKE DP,168
35 POKE DP,8
36 POKE DP,15
40 PRINT "UTHERNET II READY: 192.168.8.15"
100 REM *** Setup Socket
102 PRINT "** Setting up Socket 0"
105 POKE HA,0:POKE LA,26: REM RX MEMSIZE
110 POKE DP,3: REM 8kB RX buffer
115 POKE DP,3: REM 8kB TX buffer
200 REM *** Setup TCP MODE on SOCKET 0
205 POKE HA,4: POKE LA,0: REM *** 0x400 mode
210 POKE DP,65 : REM *** 0x41 MAC FILTER (non-promisc) TCP
300 REM ** Setup Source PORT
303 PRINT "** Setting up to use TCP port 80"
305 POKE HA,4: POKE LA,4: REM *** 0x404 port
310 POKE DP,0:POKE DP, 80: REM *** http port 80
400 REM *** OPEN socket
404 PRINT "** OPENing socket"
405 POKE HA,4: POKE LA,1: REM *** 0x401 command register
410 POKE DP, 1: REM *** OPEN
'
500 REM *** Check if opened
505 POKE HA,4: POKE LA,3: REM *** 0x403 status register
510 RE=PEEK(DP)
515 PRINT "** STATUS IS ";RE;
520 IF RE=19 THEN PRINT " OPENED":GOTO 600
530 IF RE=0 THEN PRINT " CLOSED, ERROR"
540 POKE HA,4: POKE LA,1: REM *** 0x401 command register
550 POKE DP, 16: REM *** CLOSE
560 END
'
600 REM *** Connection opened, Listen
605 POKE HA,4: POKE LA,1: REM *** 0x401 command register
610 POKE DP, 2: REM *** LISTEN
620 REM *** Check if successful
625 POKE HA,4: POKE LA,3: REM *** 0x403 status register
630 RE=PEEK(DP)
635 PRINT "** STATUS IS ";RE;
640 IF RE=20 THEN PRINT " LISTENING":GOTO 700
650 IF RE=0 THEN PRINT " CLOSED, ERROR"
655 PRINT "UNKNOWN"
660 POKE HA,4: POKE LA,1: REM *** 0x401 command register
670 POKE DP, 16: REM *** CLOSE
675 END
'
700 REM *** Wait for incoming connection
705 POKE HA,4: POKE LA,1: REM *** 0x401 command register
710 POKE DP, 2: REM *** LISTEN
720 REM *** Check if successful
725 POKE HA,4: POKE LA,3: REM *** 0x403 status register
730 RE=PEEK(DP)
740 IF RE=23 THEN GOTO 800
745 IF RE<>20 THEN PRINT "WAITING: STATUS=";RE
750 GOTO 700: REM *** Repeat until connected
'
800 PRINT "CONNECTED"
802 POKE HA,4: POKE LA,38: REM *** 0x426 Received Size
805 SH=PEEK(DP):SL=PEEK(DP)
810 SI=(SH*256)+SL
820 IF SI<>0 THEN GOTO 900
830 REM DELAY?
840 GOTO 800
'
900 POKE HA,4: POKE LA,40: REM *** 0x428 Received ptr
905 OL=PEEK(DP):OH=PEEK(DP)
910 RO=(OH*256)+OL
920 REM *** SHOULD MASK WITH 0x1ff but how?
930 RA=RO+24576:REM $6000
940 PRINT "READ OFFSET=";RO;" READ ADDRESS=";RA;" READ SIZE=";SI
'
1000 REM *** PRINT PACKET
1005 POKE HA,RA/256: POKE LA,RA-((RA/256)*256)
1010 FOR I=1 TO SI
1020 C=PEEK(DP)
1030 IF C<>13 THEN PRINT CHR$(C);
1040 NEXT I
'
2000 REM *** CLOSE



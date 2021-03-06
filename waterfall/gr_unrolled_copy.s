	;=========================================================
	; fast copy rows 22-36 from $C00 to $400
	;=========================================================
	;
	; 6 + 7*8*40 = 2246 cycles
	; 			6*7*40 = 1680 bytes of code?

gr_copy_row22:

;= y = 22 $5a8 $da8/$9a8 =========================
	; x=0,y=22
	lda	$da8
	sta	$5a8
	lda	$da9
	sta	$5a9
	lda	$daa
	sta	$5aa
	lda	$dab
	sta	$5ab
	lda	$dac
	sta	$5ac
	lda	$dad
	sta	$5ad
	lda	$dae
	sta	$5ae
	lda	$daf
	sta	$5af

	; x=8,y=22
	lda	$db0
	sta	$5b0
	lda	$db1
	sta	$5b1
	lda	$db2
	sta	$5b2
	lda	$db3
	sta	$5b3
	lda	$db4
	sta	$5b4
	lda	$db5
	sta	$5b5
	lda	$db6
	sta	$5b6
	lda	$db7
	sta	$5b7

	; x=16,y=22
	lda	$db8
	sta	$5b8
	lda	$db9
	sta	$5b9
	lda	$dba
	sta	$5ba
	lda	$dbb
	sta	$5bb
	lda	$dbc
	sta	$5bc
	lda	$dbd
	sta	$5bd
	lda	$dbe
	sta	$5be
	lda	$dbf
	sta	$5bf

	; x=24,y=22
	lda	$dc0
	sta	$5c0
	lda	$dc1
	sta	$5c1
	lda	$dc2
	sta	$5c2
	lda	$dc3
	sta	$5c3
	lda	$dc4
	sta	$5c4
	lda	$dc5
	sta	$5c5
	lda	$dc6
	sta	$5c6
	lda	$dc7
	sta	$5c7

	; x=32,y=22
	lda	$dc8
	sta	$5c8
	lda	$dc9
	sta	$5c9
	lda	$dca
	sta	$5ca
	lda	$dcb
	sta	$5cb
	lda	$dcc
	sta	$5cc
	lda	$dcd
	sta	$5cd
	lda	$dce
	sta	$5ce
	lda	$dcf
	sta	$5cf

;= y = 24 $628 $e28/$a28 =========================
	; x=0,y=24
	lda	$e28
	sta	$628
	lda	$e29
	sta	$629
	lda	$e2a
	sta	$62a
	lda	$e2b
	sta	$62b
	lda	$e2c
	sta	$62c
	lda	$e2d
	sta	$62d
	lda	$e2e
	sta	$62e
	lda	$e2f
	sta	$62f

	; x=8,y=24
	lda	$e30
	sta	$630
	lda	$e31
	sta	$631
	lda	$e32
	sta	$632
	lda	$e33
	sta	$633
	lda	$e34
	sta	$634
	lda	$e35
	sta	$635
	lda	$e36
	sta	$636
	lda	$e37
	sta	$637

	; x=16,y=24
	lda	$e38
	sta	$638
	lda	$e39
	sta	$639
	lda	$e3a
	sta	$63a
	lda	$e3b
	sta	$63b
	lda	$e3c
	sta	$63c
	lda	$e3d
	sta	$63d
	lda	$e3e
	sta	$63e
	lda	$e3f
	sta	$63f

	; x=24,y=24
	lda	$e40
	sta	$640
	lda	$e41
	sta	$641
	lda	$e42
	sta	$642
	lda	$e43
	sta	$643
	lda	$e44
	sta	$644
	lda	$e45
	sta	$645
	lda	$e46
	sta	$646
	lda	$e47
	sta	$647

	; x=32,y=24
	lda	$e48
	sta	$648
	lda	$e49
	sta	$649
	lda	$e4a
	sta	$64a
	lda	$e4b
	sta	$64b
	lda	$e4c
	sta	$64c
	lda	$e4d
	sta	$64d
	lda	$e4e
	sta	$64e
	lda	$e4f
	sta	$64f

;= y = 26 $6a8 $ea8/$aa8 =========================
	; x=0,y=26
	lda	$ea8
	sta	$6a8
	lda	$ea9
	sta	$6a9
	lda	$eaa
	sta	$6aa
	lda	$eab
	sta	$6ab
	lda	$eac
	sta	$6ac
	lda	$ead
	sta	$6ad
	lda	$eae
	sta	$6ae
	lda	$eaf
	sta	$6af

	; x=8,y=26
	lda	$eb0
	sta	$6b0
	lda	$eb1
	sta	$6b1
	lda	$eb2
	sta	$6b2
	lda	$eb3
	sta	$6b3
	lda	$eb4
	sta	$6b4
	lda	$eb5
	sta	$6b5
	lda	$eb6
	sta	$6b6
	lda	$eb7
	sta	$6b7

	; x=16,y=26
	lda	$eb8
	sta	$6b8
	lda	$eb9
	sta	$6b9
	lda	$eba
	sta	$6ba
	lda	$ebb
	sta	$6bb
	lda	$ebc
	sta	$6bc
	lda	$ebd
	sta	$6bd
	lda	$ebe
	sta	$6be
	lda	$ebf
	sta	$6bf

	; x=24,y=26
	lda	$ec0
	sta	$6c0
	lda	$ec1
	sta	$6c1
	lda	$ec2
	sta	$6c2
	lda	$ec3
	sta	$6c3
	lda	$ec4
	sta	$6c4
	lda	$ec5
	sta	$6c5
	lda	$ec6
	sta	$6c6
	lda	$ec7
	sta	$6c7

	; x=32,y=26
	lda	$ec8
	sta	$6c8
	lda	$ec9
	sta	$6c9
	lda	$eca
	sta	$6ca
	lda	$ecb
	sta	$6cb
	lda	$ecc
	sta	$6cc
	lda	$ecd
	sta	$6cd
	lda	$ece
	sta	$6ce
	lda	$ecf
	sta	$6cf

;= y = 28 $728 $f28/$b28 =========================
	; x=0,y=28
	lda	$f28
	sta	$728
	lda	$f29
	sta	$729
	lda	$f2a
	sta	$72a
	lda	$f2b
	sta	$72b
	lda	$f2c
	sta	$72c
	lda	$f2d
	sta	$72d
	lda	$f2e
	sta	$72e
	lda	$f2f
	sta	$72f

	; x=8,y=28
	lda	$f30
	sta	$730
	lda	$f31
	sta	$731
	lda	$f32
	sta	$732
	lda	$f33
	sta	$733
	lda	$f34
	sta	$734
	lda	$f35
	sta	$735
	lda	$f36
	sta	$736
	lda	$f37
	sta	$737

	; x=16,y=28
	lda	$f38
	sta	$738
	lda	$f39
	sta	$739
	lda	$f3a
	sta	$73a
	lda	$f3b
	sta	$73b
	lda	$f3c
	sta	$73c
	lda	$f3d
	sta	$73d
	lda	$f3e
	sta	$73e
	lda	$f3f
	sta	$73f

	; x=24,y=28
	lda	$f40
	sta	$740
	lda	$f41
	sta	$741
	lda	$f42
	sta	$742
	lda	$f43
	sta	$743
	lda	$f44
	sta	$744
	lda	$f45
	sta	$745
	lda	$f46
	sta	$746
	lda	$f47
	sta	$747

	; x=32,y=28
	lda	$f48
	sta	$748
	lda	$f49
	sta	$749
	lda	$f4a
	sta	$74a
	lda	$f4b
	sta	$74b
	lda	$f4c
	sta	$74c
	lda	$f4d
	sta	$74d
	lda	$f4e
	sta	$74e
	lda	$f4f
	sta	$74f

;= y = 30 $7a8 $fa8/$ba8 =========================
	; x=0,y=30
	lda	$fa8
	sta	$7a8
	lda	$fa9
	sta	$7a9
	lda	$faa
	sta	$7aa
	lda	$fab
	sta	$7ab
	lda	$fac
	sta	$7ac
	lda	$fad
	sta	$7ad
	lda	$fae
	sta	$7ae
	lda	$faf
	sta	$7af

	; x=8,y=30
	lda	$fb0
	sta	$7b0
	lda	$fb1
	sta	$7b1
	lda	$fb2
	sta	$7b2
	lda	$fb3
	sta	$7b3
	lda	$fb4
	sta	$7b4
	lda	$fb5
	sta	$7b5
	lda	$fb6
	sta	$7b6
	lda	$fb7
	sta	$7b7

	; x=16,y=30
	lda	$fb8
	sta	$7b8
	lda	$fb9
	sta	$7b9
	lda	$fba
	sta	$7ba
	lda	$fbb
	sta	$7bb
	lda	$fbc
	sta	$7bc
	lda	$fbd
	sta	$7bd
	lda	$fbe
	sta	$7be
	lda	$fbf
	sta	$7bf

	; x=24,y=30
	lda	$fc0
	sta	$7c0
	lda	$fc1
	sta	$7c1
	lda	$fc2
	sta	$7c2
	lda	$fc3
	sta	$7c3
	lda	$fc4
	sta	$7c4
	lda	$fc5
	sta	$7c5
	lda	$fc6
	sta	$7c6
	lda	$fc7
	sta	$7c7

	; x=32,y=30
	lda	$fc8
	sta	$7c8
	lda	$fc9
	sta	$7c9
	lda	$fca
	sta	$7ca
	lda	$fcb
	sta	$7cb
	lda	$fcc
	sta	$7cc
	lda	$fcd
	sta	$7cd
	lda	$fce
	sta	$7ce
	lda	$fcf
	sta	$7cf

;= y = 32 $450 $c50/$850 =========================
	; x=0,y=32
	lda	$c50
	sta	$450
	lda	$c51
	sta	$451
	lda	$c52
	sta	$452
	lda	$c53
	sta	$453
	lda	$c54
	sta	$454
	lda	$c55
	sta	$455
	lda	$c56
	sta	$456
	lda	$c57
	sta	$457

	; x=8,y=32
	lda	$c58
	sta	$458
	lda	$c59
	sta	$459
	lda	$c5a
	sta	$45a
	lda	$c5b
	sta	$45b
	lda	$c5c
	sta	$45c
	lda	$c5d
	sta	$45d
	lda	$c5e
	sta	$45e
	lda	$c5f
	sta	$45f

	; x=16,y=32
	lda	$c60
	sta	$460
	lda	$c61
	sta	$461
	lda	$c62
	sta	$462
	lda	$c63
	sta	$463
	lda	$c64
	sta	$464
	lda	$c65
	sta	$465
	lda	$c66
	sta	$466
	lda	$c67
	sta	$467

	; x=24,y=32
	lda	$c68
	sta	$468
	lda	$c69
	sta	$469
	lda	$c6a
	sta	$46a
	lda	$c6b
	sta	$46b
	lda	$c6c
	sta	$46c
	lda	$c6d
	sta	$46d
	lda	$c6e
	sta	$46e
	lda	$c6f
	sta	$46f

	; x=32,y=32
	lda	$c70
	sta	$470
	lda	$c71
	sta	$471
	lda	$c72
	sta	$472
	lda	$c73
	sta	$473
	lda	$c74
	sta	$474
	lda	$c75
	sta	$475
	lda	$c76
	sta	$476
	lda	$c77
	sta	$477

;= y = 34 $4d0 $cd0/$8d0 =========================
	; x=0,y=34
	lda	$cd0
	sta	$4d0
	lda	$cd1
	sta	$4d1
	lda	$cd2
	sta	$4d2
	lda	$cd3
	sta	$4d3
	lda	$cd4
	sta	$4d4
	lda	$cd5
	sta	$4d5
	lda	$cd6
	sta	$4d6
	lda	$cd7
	sta	$4d7

	; x=8,y=34
	lda	$cd8
	sta	$4d8
	lda	$cd9
	sta	$4d9
	lda	$cda
	sta	$4da
	lda	$cdb
	sta	$4db
	lda	$cdc
	sta	$4dc
	lda	$cdd
	sta	$4dd
	lda	$cde
	sta	$4de
	lda	$cdf
	sta	$4df

	; x=16,y=34
	lda	$ce0
	sta	$4e0
	lda	$ce1
	sta	$4e1
	lda	$ce2
	sta	$4e2
	lda	$ce3
	sta	$4e3
	lda	$ce4
	sta	$4e4
	lda	$ce5
	sta	$4e5
	lda	$ce6
	sta	$4e6
	lda	$ce7
	sta	$4e7

	; x=24,y=34
	lda	$ce8
	sta	$4e8
	lda	$ce9
	sta	$4e9
	lda	$cea
	sta	$4ea
	lda	$ceb
	sta	$4eb
	lda	$cec
	sta	$4ec
	lda	$ced
	sta	$4ed
	lda	$cee
	sta	$4ee
	lda	$cef
	sta	$4ef

	; x=32,y=34
	lda	$cf0
	sta	$4f0
	lda	$cf1
	sta	$4f1
	lda	$cf2
	sta	$4f2
	lda	$cf3
	sta	$4f3
	lda	$cf4
	sta	$4f4
	lda	$cf5
	sta	$4f5
	lda	$cf6
	sta	$4f6
	lda	$cf7
	sta	$4f7

	rts								; 6


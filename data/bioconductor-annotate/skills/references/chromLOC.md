# HowTo: Build and use chromosomal information

Jeff Gentry and Kritika Verma1

1Vignette translation from Sweave to R Markdown / HTML

#### October 29, 2025

# Contents

* [1 Overview](#overview)
* [2 The chromLocation class](#the-chromlocation-class)
* [3 Summary](#summary)

# 1 Overview

The annotate package provides a class that can be used to model
chromosomal information about a species, using one of the metadata
packages provided by Bioconductor. This class contains information about
the organism and its chromosomes and provides a standardized interface
to the information in the metadata packages for other software to
quickly extract necessary chromosomal information. An example of using
*chromLocation* objects in other software can be found with the
`alongChrom` function of the *[geneplotter](https://bioconductor.org/packages/3.22/geneplotter)* package in Bioconductor.

# 2 The chromLocation class

The *chromLocation* class is used to provide a structure for chromosomal data of
a particular organism. In this section, we will discuss the various slots of the
class and the methods for interacting with them. Before this though, we will
create an object of class *chromLocation* for demonstration purposes later. The
helper function `buildChromLocation` is used, and it takes as an argument the
name of a Bioconductor metadata package, which is itself used to extract the
data. For this vignette, we will be using the *[hgu95av2.db](https://bioconductor.org/packages/3.22/hgu95av2.db)*
package.

```
library("annotate")
z <- buildChromLocation("hgu95av2")
z
```

```
## Instance of a chromLocation class with the following fields:
##  Organism:  Homo sapiens
##  Data source:  hgu95av2
##  Number of chromosomes for this organism:  711
##  Chromosomes of this organism and their lengths in base pairs:
##       1 : 248956422
##       2 : 242193529
##       3 : 198295559
##       4 : 190214555
##       5 : 181538259
##       6 : 170805979
##       7 : 159345973
##       X : 156040895
##       8 : 145138636
##       9 : 138394717
##       11 : 135086622
##       10 : 133797422
##       12 : 133275309
##       13 : 114364328
##       14 : 107043718
##       15 : 101991189
##       16 : 90338345
##       17 : 83257441
##       18 : 80373285
##       20 : 64444167
##       19 : 58617616
##       Y : 57227415
##       22 : 50818468
##       21 : 46709983
##       8_KZ208915v1_fix : 6367528
##       15_ML143371v1_fix : 5500449
##       15_KI270905v1_alt : 5161414
##       15_KN538374v1_fix : 4998962
##       6_GL000256v2_alt : 4929269
##       6_GL000254v2_alt : 4827813
##       6_GL000251v2_alt : 4795265
##       6_GL000253v2_alt : 4677643
##       6_GL000250v2_alt : 4672374
##       6_GL000255v2_alt : 4606388
##       6_GL000252v2_alt : 4604811
##       17_KI270857v1_alt : 2877074
##       16_KI270853v1_alt : 2659700
##       15_KQ031389v1_alt : 2365364
##       5_MU273354v1_fix : 2101585
##       16_KV880768v1_fix : 1927115
##       16_KI270728v1_random : 1872759
##       17_GL000258v2_alt : 1821992
##       5_GL339449v2_alt : 1612928
##       1_MU273333v1_fix : 1572686
##       14_KI270847v1_alt : 1511111
##       17_KI270908v1_alt : 1423190
##       14_KI270846v1_alt : 1351393
##       15_MU273374v1_fix : 1154574
##       5_KI270897v1_alt : 1144418
##       7_KI270803v1_alt : 1111570
##       19_GL949749v2_alt : 1091841
##       19_KI270938v1_alt : 1066800
##       19_GL949750v2_alt : 1066390
##       19_GL949748v2_alt : 1064304
##       12_KZ208916v1_fix : 1046838
##       21_MU273391v1_fix : 1020778
##       19_GL949751v2_alt : 1002683
##       19_GL949746v1_alt : 987716
##       19_GL949752v1_alt : 987100
##       8_KI270821v1_alt : 985506
##       2_MU273342v1_fix : 955087
##       1_KI270763v1_alt : 911658
##       6_KI270801v1_alt : 870480
##       Y_MU273398v1_fix : 865743
##       1_MU273331v1_alt : 847441
##       19_GL949753v2_alt : 796479
##       19_GL949747v2_alt : 729520
##       14_MU273373v1_fix : 722645
##       14_KZ208920v1_fix : 690932
##       7_KZ208913v1_alt : 680662
##       5_KV575244v1_fix : 673059
##       8_KI270822v1_alt : 624492
##       X_MU273395v1_alt : 619716
##       7_KZ208912v1_fix : 589656
##       4_GL000257v2_alt : 586476
##       12_KI270904v1_alt : 572349
##       9_MU273366v1_fix : 569668
##       4_KI270925v1_alt : 555799
##       1_KV880763v1_alt : 551020
##       12_KN538369v1_fix : 541038
##       17_MU273380v1_fix : 538541
##       2_MU273338v1_alt : 535251
##       2_KQ983256v1_alt : 535088
##       21_ML143377v1_fix : 519485
##       1_MU273330v1_alt : 516764
##       5_MU273355v1_fix : 508332
##       2_MU273339v1_alt : 500581
##       19_ML143376v1_fix : 493165
##       2_MU273343v1_fix : 489404
##       9_MU273365v1_fix : 482250
##       2_KQ031384v1_fix : 481245
##       16_KZ559113v1_fix : 480415
##       15_KI270852v1_alt : 478999
##       3_MU273348v1_fix : 475876
##       3_MU273346v1_fix : 469342
##       7_KV880765v1_fix : 468267
##       1_KQ031383v1_fix : 467143
##       7_MU273358v1_alt : 464417
##       22_ML143378v1_fix : 461303
##       1_KN538360v1_fix : 460100
##       10_ML143354v1_fix : 454963
##       3_KN196475v1_fix : 451168
##       15_KI270727v1_random : 448248
##       9_KI270823v1_alt : 439082
##       11_MU273369v1_fix : 434831
##       2_MU273337v1_alt : 431782
##       15_KI270850v1_alt : 430880
##       8_MU273362v1_fix : 429744
##       1_KI270759v1_alt : 425601
##       4_KV766193v1_alt : 420675
##       10_KN538367v1_fix : 420164
##       3_KN538364v1_fix : 415308
##       22_ML143380v1_fix : 412368
##       3_KV766192v1_fix : 411654
##       13_ML143366v1_fix : 409912
##       12_GL877876v1_alt : 408271
##       18_KQ090028v1_fix : 407387
##       19_KQ458386v1_fix : 405389
##       X_ML143381v1_fix : 403128
##       14_ML143367v1_fix : 399183
##       15_ML143372v1_fix : 396515
##       Un_KI270442v1 : 392061
##       17_KI270862v1_alt : 391357
##       15_GL383555v2_alt : 388773
##       19_GL383573v1_alt : 385657
##       6_MU273357v1_alt : 383128
##       4_KI270896v1_alt : 378547
##       4_GL383528v1_alt : 376187
##       17_GL383563v3_alt : 375691
##       8_KI270810v1_alt : 374415
##       3_KQ031385v1_fix : 373699
##       17_MU273378v1_alt : 372839
##       19_KN196484v1_fix : 370917
##       15_ML143370v1_fix : 369264
##       1_GL383520v2_alt : 366580
##       2_KN538363v1_fix : 365499
##       5_KV575243v1_alt : 362221
##       13_KN538372v1_fix : 356766
##       20_MU273389v1_fix : 355731
##       1_KI270762v1_alt : 354444
##       1_KQ458383v1_alt : 349938
##       11_MU273370v1_fix : 344606
##       4_ML143345v1_fix : 341066
##       9_MU273364v1_fix : 340717
##       21_MU273390v1_fix : 336752
##       1_MU273332v1_alt : 335159
##       16_MU273377v1_fix : 334997
##       19_MU273384v1_fix : 333754
##       X_MU273397v1_alt : 330493
##       9_KN196479v1_fix : 330164
##       1_KZ208906v1_fix : 330031
##       15_KI270848v1_alt : 327382
##       17_KI270909v1_alt : 325800
##       14_KI270844v1_alt : 322166
##       6_KQ031387v1_fix : 320750
##       8_KI270900v1_alt : 318687
##       12_KQ759760v1_fix : 315610
##       10_GL383546v1_alt : 309802
##       4_MU273349v1_alt : 308682
##       13_KI270838v1_alt : 306913
##       3_KN196476v1_fix : 305979
##       8_KI270816v1_alt : 305841
##       1_KN538361v1_fix : 305542
##       11_KZ559108v1_fix : 305244
##       22_KI270879v1_alt : 304135
##       3_KZ559103v1_alt : 302885
##       5_MU273356v1_alt : 302485
##       11_KZ559110v1_alt : 301637
##       3_MU273347v1_fix : 301310
##       8_KI270813v1_alt : 300230
##       12_ML143361v1_fix : 297568
##       11_KI270831v1_alt : 296895
##       15_GL383554v1_alt : 296527
##       X_MU273396v1_alt : 294119
##       19_KV575249v1_alt : 293522
##       10_ML143355v1_fix : 292944
##       8_KI270811v1_alt : 292436
##       18_GL383567v1_alt : 289831
##       2_MU273340v1_alt : 284971
##       X_KI270880v1_alt : 284869
##       8_KI270812v1_alt : 282736
##       19_KI270921v1_alt : 282224
##       17_KV766196v1_fix : 281919
##       17_KI270729v1_random : 280839
##       11_KZ559109v1_fix : 279644
##       1_KQ983255v1_alt : 278659
##       17_JH159146v1_alt : 278131
##       10_KN196480v1_fix : 277797
##       17_KV766198v1_alt : 276292
##       4_ML143349v1_fix : 276109
##       X_KI270913v1_alt : 274009
##       20_MU273388v1_fix : 273725
##       6_KI270798v1_alt : 271782
##       7_KI270808v1_alt : 271455
##       16_ML143373v1_fix : 270967
##       11_ML143358v1_fix : 270122
##       6_KN196478v1_fix : 268330
##       16_KQ090027v1_alt : 267463
##       8_KV880767v1_fix : 265876
##       10_KQ090021v1_fix : 264545
##       14_ML143368v1_alt : 264228
##       22_KI270876v1_alt : 263666
##       15_KI270851v1_alt : 263054
##       11_MU273368v1_alt : 261194
##       22_KI270875v1_alt : 259914
##       1_KI270766v1_alt : 256271
##       7_ML143352v1_fix : 254759
##       1_MU273336v1_fix : 250447
##       19_KI270882v1_alt : 248807
##       3_KI270778v1_alt : 248252
##       17_KV766197v1_alt : 246895
##       6_KQ090016v1_fix : 245716
##       15_KI270849v1_alt : 244917
##       2_MU273344v1_fix : 244725
##       4_KI270786v1_alt : 244096
##       6_KZ208911v1_fix : 242796
##       19_KV575250v1_alt : 241058
##       12_KI270835v1_alt : 238139
##       4_KQ090015v1_alt : 236512
##       17_KI270858v1_alt : 235827
##       4_ML143344v1_fix : 235734
##       17_MU273379v1_fix : 234878
##       19_KI270867v1_alt : 233762
##       16_KI270855v1_alt : 232857
##       18_KZ559115v1_fix : 230843
##       4_KQ983257v1_fix : 230434
##       8_KI270926v1_alt : 229282
##       5_GL949742v1_alt : 226852
##       19_MU273386v1_fix : 226166
##       3_KI270780v1_alt : 224108
##       17_GL383565v1_alt : 223995
##       2_KI270774v1_alt : 223625
##       19_KV575256v1_alt : 223118
##       4_KI270790v1_alt : 220246
##       11_KI270927v1_alt : 218612
##       11_ML143359v1_fix : 217075
##       19_KI270932v1_alt : 215732
##       3_ML143343v1_alt : 215443
##       11_KI270903v1_alt : 214625
##       2_KI270894v1_alt : 214158
##       1_KQ458384v1_alt : 212205
##       1_MU273335v1_fix : 211934
##       12_KN196482v1_fix : 211377
##       14_GL000225v1_random : 211173
##       Un_KI270743v1 : 210658
##       1_MU273334v1_fix : 210426
##       11_KI270832v1_alt : 210133
##       7_KI270805v1_alt : 209988
##       Y_KZ208924v1_fix : 209722
##       4_GL000008v2_random : 209709
##       7_KI270809v1_alt : 209586
##       19_KI270887v1_alt : 209512
##       5_MU273353v1_fix : 208405
##       2_KN538362v1_fix : 208149
##       8_MU273363v1_fix : 207371
##       13_KN538371v1_fix : 206320
##       4_KI270789v1_alt : 205944
##       4_MU273351v1_fix : 205691
##       4_KQ983258v1_alt : 205407
##       3_KI270779v1_alt : 205312
##       19_KI270914v1_alt : 205194
##       18_KQ458385v1_alt : 205101
##       11_KQ759759v2_fix : 204999
##       19_KI270886v1_alt : 204239
##       11_KI270829v1_alt : 204059
##       15_MU273375v1_alt : 204007
##       11_KN538368v1_alt : 203552
##       14_GL000009v2_random : 201709
##       21_GL383579v2_alt : 201197
##       11_JH159136v1_alt : 200998
##       19_KI270930v1_alt : 200773
##       Un_KI270747v1 : 198735
##       18_GL383571v1_alt : 198278
##       19_KI270920v1_alt : 198005
##       3_KZ559102v1_alt : 197752
##       6_KI270797v1_alt : 197536
##       3_KI270935v1_alt : 197351
##       11_KQ759759v1_fix : 196940
##       17_KI270861v1_alt : 196688
##       15_KI270906v1_alt : 196384
##       10_MU273367v1_fix : 196262
##       5_KI270791v1_alt : 195710
##       3_KZ559105v1_alt : 195063
##       14_KI270722v1_random : 194050
##       12_ML143362v1_fix : 192531
##       16_GL383556v1_alt : 192462
##       13_KI270840v1_alt : 191684
##       14_GL000194v1_random : 191469
##       11_JH159137v1_alt : 191409
##       19_KI270917v1_alt : 190932
##       7_KI270899v1_alt : 190869
##       21_MU273392v1_fix : 189707
##       19_KI270923v1_alt : 189352
##       10_KI270825v1_alt : 188315
##       19_GL383576v1_alt : 188024
##       X_KV766199v1_alt : 188004
##       19_KI270922v1_alt : 187935
##       17_MU273382v1_fix : 187626
##       Un_KI270742v1 : 186739
##       1_KN196472v1_fix : 186494
##       22_KI270878v1_alt : 186262
##       19_KI270929v1_alt : 186203
##       11_KI270826v1_alt : 186169
##       6_KB021644v2_alt : 185823
##       17_GL000205v2_random : 185591
##       10_KQ090020v1_alt : 185507
##       1_KI270765v1_alt : 185285
##       19_KI270916v1_alt : 184516
##       19_KI270890v1_alt : 184499
##       3_KI270784v1_alt : 184404
##       12_GL383551v1_alt : 184319
##       20_KI270870v1_alt : 183433
##       Un_GL000195v1 : 182896
##       1_GL383518v1_alt : 182439
##       11_KQ090022v1_fix : 181958
##       22_KI270736v1_random : 181920
##       2_KZ208907v1_alt : 181658
##       10_KI270824v1_alt : 181496
##       11_KZ559111v1_alt : 181167
##       14_KI270845v1_alt : 180703
##       3_GL383526v1_alt : 180671
##       13_KI270839v1_alt : 180306
##       7_KQ031388v1_fix : 179932
##       22_KI270733v1_random : 179772
##       Un_GL000224v1 : 179693
##       10_GL383545v1_alt : 179254
##       Un_GL000219v1 : 179198
##       5_KI270792v1_alt : 179043
##       17_KI270860v1_alt : 178921
##       19_KV575252v1_alt : 178197
##       19_GL000209v2_alt : 177381
##       11_KI270830v1_alt : 177092
##       9_KI270719v1_random : 176845
##       4_ML143347v1_fix : 176674
##       Un_GL000216v2 : 176608
##       22_KI270928v1_alt : 176103
##       1_KI270712v1_random : 176043
##       3_KZ208909v1_alt : 175849
##       6_KI270800v1_alt : 175808
##       1_KI270706v1_random : 175055
##       12_KZ208918v1_alt : 174808
##       22_KQ458388v1_alt : 174749
##       2_MU273345v1_fix : 174385
##       2_KI270776v1_alt : 174166
##       18_KI270912v1_alt : 174061
##       3_KI270777v1_alt : 173649
##       5_GL383531v1_alt : 173459
##       3_JH636055v2_alt : 173151
##       14_KI270725v1_random : 172810
##       5_KI270796v1_alt : 172708
##       17_MU273383v1_fix : 172609
##       7_KZ559106v1_alt : 172555
##       14_KZ208919v1_alt : 171798
##       9_GL383541v1_alt : 171286
##       19_KV575259v1_alt : 171263
##       19_KI270885v1_alt : 171027
##       11_ML143360v1_fix : 170928
##       19_KI270919v1_alt : 170701
##       19_KI270889v1_alt : 170698
##       19_KI270891v1_alt : 170680
##       19_KI270915v1_alt : 170665
##       19_KI270933v1_alt : 170537
##       19_KI270883v1_alt : 170399
##       19_GL383575v2_alt : 170222
##       19_KV575247v1_alt : 170206
##       19_KI270931v1_alt : 170148
##       12_GL383550v2_alt : 169178
##       16_KQ031390v1_alt : 169136
##       13_KI270841v1_alt : 169134
##       Un_KI270744v1 : 168472
##       13_KQ090024v1_alt : 168146
##       19_KV575248v1_alt : 168131
##       18_KI270863v1_alt : 167999
##       18_GL383569v1_alt : 167950
##       12_GL877875v1_alt : 167313
##       21_KI270874v1_alt : 166743
##       19_KV575253v1_alt : 166713
##       3_KI270924v1_alt : 166540
##       1_KN196473v1_fix : 166200
##       1_KZ208904v1_alt : 166136
##       1_KI270761v1_alt : 165834
##       3_KQ031386v1_fix : 165718
##       3_KI270937v1_alt : 165607
##       11_ML143357v1_fix : 165419
##       8_KZ208914v1_fix : 165120
##       22_KI270734v1_random : 165050
##       18_GL383570v1_alt : 164789
##       5_KI270794v1_alt : 164558
##       4_GL383527v1_alt : 164536
##       Un_GL000213v1 : 164239
##       3_KI270936v1_alt : 164170
##       3_KZ559101v1_alt : 164041
##       19_KV575246v1_alt : 163926
##       9_KQ090018v1_alt : 163882
##       4_KQ090014v1_alt : 163749
##       3_KI270934v1_alt : 163458
##       18_KZ559116v1_alt : 163186
##       9_GL383539v1_alt : 162988
##       3_KI270895v1_alt : 162896
##       22_GL383582v2_alt : 162811
##       3_KI270782v1_alt : 162429
##       1_KI270892v1_alt : 162212
##       Un_GL000220v1 : 161802
##       2_KI270767v1_alt : 161578
##       2_KI270715v1_random : 161471
##       2_KI270893v1_alt : 161218
##       Un_GL000218v1 : 161147
##       19_KV575255v1_alt : 161095
##       18_GL383572v1_alt : 159547
##       19_KV575251v1_alt : 159285
##       8_KI270817v1_alt : 158983
##       4_KI270788v1_alt : 158965
##       13_ML143364v1_fix : 158944
##       Un_KI270749v1 : 158759
##       7_KI270806v1_alt : 158166
##       7_KI270804v1_alt : 157952
##       18_KI270911v1_alt : 157710
##       Un_KI270741v1 : 157432
##       17_KI270910v1_alt : 157099
##       19_KI270884v1_alt : 157053
##       8_KV880766v1_fix : 156998
##       19_KV575258v1_alt : 156965
##       22_KN196485v1_alt : 156562
##       22_KQ458387v1_alt : 155930
##       19_GL383574v1_alt : 155864
##       19_KI270888v1_alt : 155532
##       3_GL000221v1_random : 155397
##       17_KV575245v1_fix : 154723
##       11_GL383547v1_alt : 154407
##       12_KZ559112v1_alt : 154139
##       2_KI270716v1_random : 153799
##       22_KN196486v1_alt : 153027
##       12_GL383553v2_alt : 152874
##       6_KI270799v1_alt : 152148
##       22_KI270731v1_random : 150754
##       Un_KI270751v1 : 150742
##       8_MU273359v1_fix : 150302
##       Un_KI270750v1 : 148850
##       13_KN538373v1_fix : 148762
##       2_ML143341v1_fix : 145975
##       19_KV575260v1_alt : 145691
##       8_KI270818v1_alt : 145606
##       22_KQ759761v1_alt : 145162
##       17_MU273381v1_fix : 144689
##       X_KI270881v1_alt : 144206
##       21_KI270873v1_alt : 143900
##       2_GL383521v1_alt : 143390
##       7_KV880764v1_fix : 142129
##       8_KI270814v1_alt : 141812
##       1_KQ458382v1_alt : 141019
##       11_KV766195v1_fix : 140877
##       X_MU273394v1_fix : 140567
##       2_KZ208908v1_alt : 140361
##       1_KZ208905v1_alt : 140355
##       6_KV766194v1_fix : 139427
##       5_KN196477v1_alt : 139087
##       12_GL383552v1_alt : 138655
##       Un_KI270519v1 : 138126
##       2_KI270775v1_alt : 138019
##       17_ML143374v1_fix : 137908
##       19_MU273385v1_fix : 137818
##       17_KI270907v1_alt : 137721
##       Un_GL000214v1 : 137718
##       8_KI270901v1_alt : 136959
##       2_KI270770v1_alt : 136240
##       5_KZ208910v1_alt : 135987
##       16_KI270854v1_alt : 134193
##       9_KQ090019v1_alt : 134099
##       8_KI270819v1_alt : 133535
##       17_GL383564v2_alt : 133151
##       2_KI270772v1_alt : 133041
##       8_KI270815v1_alt : 132244
##       5_KI270795v1_alt : 131892
##       5_KI270898v1_alt : 130957
##       20_GL383577v2_alt : 128386
##       1_KI270708v1_random : 127682
##       7_KI270807v1_alt : 126434
##       5_KI270793v1_alt : 126136
##       4_ML143348v1_fix : 125549
##       6_GL383533v1_alt : 124736
##       2_GL383522v1_alt : 123821
##       13_KQ090025v1_alt : 123480
##       19_KI270918v1_alt : 123111
##       11_MU273371v1_fix : 122722
##       1_KN196474v1_fix : 122022
##       12_GL383549v1_alt : 120804
##       2_KI270769v1_alt : 120616
##       2_MU273341v1_fix : 120381
##       4_KI270785v1_alt : 119912
##       12_KI270834v1_alt : 119498
##       7_GL383534v2_alt : 119183
##       20_KI270869v1_alt : 118774
##       17_KZ559114v1_alt : 116753
##       21_GL383581v2_alt : 116689
##       4_MU273350v1_fix : 113364
##       3_KI270781v1_alt : 113034
##       17_KI270730v1_random : 112551
##       Un_KI270438v1 : 112505
##       4_KI270787v1_alt : 111943
##       18_KI270864v1_alt : 111737
##       2_KI270771v1_alt : 110395
##       1_GL383519v1_alt : 110268
##       2_KI270768v1_alt : 110099
##       1_KI270760v1_alt : 109528
##       12_KQ090023v1_alt : 109323
##       3_KI270783v1_alt : 109187
##       11_KN196481v1_fix : 108875
##       17_KI270859v1_alt : 108763
##       8_MU273361v1_fix : 106905
##       11_KI270902v1_alt : 106711
##       3_KZ559104v1_fix : 105527
##       18_GL383568v1_alt : 104552
##       12_MU273372v1_fix : 104537
##       22_KI270737v1_random : 103838
##       13_KI270843v1_alt : 103832
##       8_KZ559107v1_alt : 103072
##       22_KI270877v1_alt : 101331
##       5_GL383530v1_alt : 101241
##       Y_KN196487v1_fix : 101150
##       22_KQ759762v2_fix : 101040
##       22_KQ759762v1_fix : 101037
##       19_KV575257v1_alt : 100553
##       11_KI270721v1_random : 100316
##       19_KV575254v1_alt : 99845
##       22_KI270738v1_random : 99375
##       15_ML143369v1_fix : 97763
##       22_GL383583v2_alt : 96924
##       2_GL582966v2_alt : 96131
##       Un_KI270748v1 : 93321
##       18_KZ208922v1_fix : 93070
##       Un_KI270435v1 : 92983
##       5_GL000208v1_random : 92689
##       Un_KI270538v1 : 91309
##       4_KQ090013v1_alt : 90922
##       17_GL383566v1_alt : 90219
##       5_ML143350v1_fix : 89956
##       16_GL383557v1_alt : 89672
##       19_MU273387v1_alt : 89211
##       17_JH159148v1_alt : 88070
##       16_MU273376v1_fix : 87715
##       12_KN538370v1_fix : 86533
##       10_KN538366v1_fix : 85284
##       2_ML143342v1_fix : 84043
##       5_GL383532v1_alt : 82728
##       21_KI270872v1_alt : 82692
##       6_KQ090017v1_alt : 82315
##       Un_KI270756v1 : 79590
##       16_KZ208921v1_alt : 78609
##       6_KI270758v1_alt : 76752
##       12_KI270833v1_alt : 76061
##       6_KI270802v1_alt : 75005
##       21_GL383580v2_alt : 74653
##       22_KB663609v1_alt : 74013
##       22_KI270739v1_random : 73985
##       6_ML143351v1_fix : 73265
##       9_GL383540v1_alt : 71551
##       Un_KI270757v1 : 71251
##       2_KI270773v1_alt : 70887
##       17_JH159147v1_alt : 70345
##       X_MU273393v1_fix : 68810
##       X_ML143383v1_fix : 68192
##       11_KI270827v1_alt : 67707
##       1_KI270709v1_random : 66860
##       Un_KI270746v1 : 66486
##       13_ML143365v1_fix : 65394
##       12_KZ208917v1_fix : 64689
##       16_KI270856v1_alt : 63982
##       21_GL383578v2_alt : 63917
##       Un_KI270753v1 : 62944
##       19_KI270868v1_alt : 61734
##       9_GL383542v1_alt : 60032
##       16_KQ090026v1_alt : 59016
##       20_KI270871v1_alt : 58661
##       17_ML143375v1_fix : 56695
##       12_KI270836v1_alt : 56134
##       4_ML143346v1_fix : 53476
##       19_KI270865v1_alt : 52969
##       1_KI270764v1_alt : 50258
##       Y_KZ208923v1_fix : 48370
##       11_ML143356v1_fix : 45257
##       1_KZ559100v1_fix : 44955
##       Un_KI270589v1 : 44474
##       14_KI270726v1_random : 43739
##       19_KI270866v1_alt : 43156
##       22_KI270735v1_random : 42811
##       1_KI270711v1_random : 42210
##       Un_KI270745v1 : 41891
##       1_KI270714v1_random : 41717
##       22_KI270732v1_random : 41543
##       1_KI270713v1_random : 40745
##       Un_KI270754v1 : 40191
##       1_KI270710v1_random : 40176
##       12_KI270837v1_alt : 40090
##       9_KI270717v1_random : 40062
##       14_KI270724v1_random : 39555
##       8_MU273360v1_fix : 39290
##       9_KI270720v1_random : 39050
##       14_KI270723v1_random : 38115
##       9_KI270718v1_random : 38054
##       Un_KI270317v1 : 37690
##       13_KI270842v1_alt : 37287
##       Y_KI270740v1_random : 37240
##       Un_KI270755v1 : 36723
##       8_KI270820v1_alt : 36640
##       13_KN196483v1_fix : 35455
##       5_MU273352v1_fix : 34400
##       1_KI270707v1_random : 32032
##       Un_KI270579v1 : 31033
##       X_ML143382v1_fix : 28824
##       Un_KI270752v1 : 27745
##       9_ML143353v1_fix : 25408
##       Un_KI270512v1 : 22689
##       Un_KI270322v1 : 21476
##       X_ML143385v1_fix : 17435
##       M : 16569
##       Un_GL000226v1 : 15008
##       X_ML143384v1_fix : 14678
##       10_KN538365v1_fix : 14347
##       Un_KI270311v1 : 12399
##       22_ML143379v1_fix : 12295
##       Un_KI270366v1 : 8320
##       Un_KI270511v1 : 8127
##       Un_KI270448v1 : 7992
##       Un_KI270521v1 : 7642
##       13_ML143363v1_fix : 7309
##       Un_KI270581v1 : 7046
##       Un_KI270582v1 : 6504
##       Un_KI270515v1 : 6361
##       Un_KI270588v1 : 6158
##       Un_KI270591v1 : 5796
##       Un_KI270522v1 : 5674
##       Un_KI270507v1 : 5353
##       Un_KI270590v1 : 4685
##       Un_KI270584v1 : 4513
##       Un_KI270320v1 : 4416
##       Un_KI270382v1 : 4215
##       Un_KI270468v1 : 4055
##       Un_KI270467v1 : 3920
##       Un_KI270362v1 : 3530
##       Un_KI270517v1 : 3253
##       Un_KI270593v1 : 3041
##       Un_KI270528v1 : 2983
##       Un_KI270587v1 : 2969
##       Un_KI270364v1 : 2855
##       Un_KI270371v1 : 2805
##       Un_KI270333v1 : 2699
##       Un_KI270374v1 : 2656
##       Un_KI270411v1 : 2646
##       Un_KI270414v1 : 2489
##       Un_KI270510v1 : 2415
##       Un_KI270390v1 : 2387
##       Un_KI270375v1 : 2378
##       Un_KI270420v1 : 2321
##       Un_KI270509v1 : 2318
##       Un_KI270315v1 : 2276
##       Un_KI270302v1 : 2274
##       Un_KI270518v1 : 2186
##       Un_KI270530v1 : 2168
##       Un_KI270304v1 : 2165
##       Un_KI270418v1 : 2145
##       Un_KI270424v1 : 2140
##       Un_KI270417v1 : 2043
##       Un_KI270508v1 : 1951
##       Un_KI270303v1 : 1942
##       Un_KI270381v1 : 1930
##       Un_KI270529v1 : 1899
##       Un_KI270425v1 : 1884
##       Un_KI270396v1 : 1880
##       Un_KI270363v1 : 1803
##       Un_KI270386v1 : 1788
##       Un_KI270465v1 : 1774
##       Un_KI270383v1 : 1750
##       Un_KI270384v1 : 1658
##       Un_KI270330v1 : 1652
##       Un_KI270372v1 : 1650
##       Un_KI270548v1 : 1599
##       Un_KI270580v1 : 1553
##       Un_KI270387v1 : 1537
##       Un_KI270391v1 : 1484
##       Un_KI270305v1 : 1472
##       Un_KI270373v1 : 1451
##       Un_KI270422v1 : 1445
##       Un_KI270316v1 : 1444
##       Un_KI270338v1 : 1428
##       Un_KI270340v1 : 1428
##       Un_KI270583v1 : 1400
##       Un_KI270334v1 : 1368
##       Un_KI270429v1 : 1361
##       Un_KI270393v1 : 1308
##       Un_KI270516v1 : 1300
##       Un_KI270389v1 : 1298
##       Un_KI270466v1 : 1233
##       Un_KI270388v1 : 1216
##       Un_KI270544v1 : 1202
##       Un_KI270310v1 : 1201
##       Un_KI270412v1 : 1179
##       Un_KI270395v1 : 1143
##       Un_KI270376v1 : 1136
##       Un_KI270337v1 : 1121
##       Un_KI270335v1 : 1048
##       Un_KI270378v1 : 1048
##       Un_KI270379v1 : 1045
##       Un_KI270329v1 : 1040
##       Un_KI270419v1 : 1029
##       Un_KI270336v1 : 1026
##       Un_KI270312v1 : 998
##       Un_KI270539v1 : 993
##       Un_KI270385v1 : 990
##       Un_KI270423v1 : 981
##       Un_KI270392v1 : 971
##       Un_KI270394v1 : 970
```

Once we have an object of the *chromLocation* class, we can now access
its various slots to get the information contained within it. There are
six slots in this class:

```
organism:       This lists the organism that this object is describing.
dataSource:     Where this data was acquired from.
chromLocs:      A list with an element for every unique chromosome
                name, where each element contains a named vector where
                the names are probe IDs and the values describe the
                location of that probe on the chromosome.  Negative
                values indicate that the location is on the antisense
                strand.
probesToChrom:  A hash table which will translate a probe ID to the
                chromosome it belongs to.
chromInfo:      A numerical vector representing each chromosome, where
                the names are the names of the chromosomes and the
                values are the lengths of those chromosomes.
geneSymbols:    An environment that maps a probe ID to the appropriate
                gene symbol.
```

There is a basic ‘get’ type method for each of these slots, all with the same
name as the respective slot. In the following example, we will demonstrate these
basic methods. For the `probesToChrom` and `geneSymbols` methods, the return
value is an environment which maps a probe ID to other values, we will be using
the probe ID ‘32972\_at’, which was selected at random for these examples. We are
showing only part of the `chromLocs` method’s output as it is quite long in its
entirety.

```
organism(z)
```

```
## [1] "Homo sapiens"
```

```
dataSource(z)
```

```
## [1] "hgu95av2"
```

```
## The chromLocs list is extremely large. Let's only
## look at one of the elements.
names(chromLocs(z))
```

```
##   [1] "1"                    "10"                   "11"
##   [4] "12"                   "13"                   "14"
##   [7] "15"                   "16"                   "17"
##  [10] "18"                   "19"                   "2"
##  [13] "20"                   "21"                   "22"
##  [16] "22_KI270879v1_alt"    "3"                    "4"
##  [19] "5"                    "6"                    "7"
##  [22] "8"                    "9"                    "X"
##  [25] "Y"                    "14_KZ208920v1_fix"    "17_KV766198v1_alt"
##  [28] "7_KZ208912v1_fix"     "17_KI270857v1_alt"    "20_KI270869v1_alt"
##  [31] "10_KQ090021v1_fix"    "17_KV575245v1_fix"    "19_KI270867v1_alt"
##  [34] "2_KN538363v1_fix"     "16_KI270853v1_alt"    "15_KI270849v1_alt"
##  [37] "1_KQ458383v1_alt"     "8_KZ208914v1_fix"     "11_KQ759759v1_fix"
##  [40] "2_GL383522v1_alt"     "13_KI270842v1_alt"    "17_GL383564v2_alt"
##  [43] "6_GL000251v2_alt"     "8_KZ208915v1_fix"     "19_KQ458386v1_fix"
##  [46] "11_KN196481v1_fix"    "11_KI270831v1_alt"    "6_GL000254v2_alt"
##  [49] "6_GL000256v2_alt"     "20_KI270870v1_alt"    "19_KI270866v1_alt"
##  [52] "8_KI270822v1_alt"     "8_KI270819v1_alt"     "17_GL383563v3_alt"
##  [55] "2_KZ208908v1_alt"     "1_GL383519v1_alt"     "19_KN196484v1_fix"
##  [58] "4_GL000257v2_alt"     "2_KI270776v1_alt"     "14_KI270846v1_alt"
##  [61] "22_KI270875v1_alt"    "19_KI270868v1_alt"    "8_KI270821v1_alt"
##  [64] "16_KZ559113v1_fix"    "11_KI270721v1_random" "9_KN196479v1_fix"
##  [67] "7_KI270803v1_alt"     "15_KI270850v1_alt"    "17_JH159146v1_alt"
##  [70] "12_KN538369v1_fix"    "8_KI270816v1_alt"     "14_KI270847v1_alt"
##  [73] "16_KQ090026v1_alt"    "16_KV880768v1_fix"    "11_KI270832v1_alt"
##  [76] "17_KI270861v1_alt"    "12_KN538370v1_fix"    "11_KZ559109v1_fix"
##  [79] "3_KN196475v1_fix"     "7_KZ208913v1_alt"     "22_KQ759762v1_fix"
##  [82] "11_KZ559110v1_alt"    "1_KZ208904v1_alt"     "5_KI270791v1_alt"
##  [85] "8_KI270814v1_alt"     "18_KQ090028v1_fix"    "9_GL383540v1_alt"
##  [88] "6_KQ090016v1_fix"     "4_GL383527v1_alt"     "7_KI270808v1_alt"
##  [91] "7_KV880765v1_fix"     "5_KV575244v1_fix"     "3_KN538364v1_fix"
##  [94] "17_KI270862v1_alt"    "19_GL383574v1_alt"    "22_KI270877v1_alt"
##  [97] "12_KZ208916v1_fix"    "17_KI270860v1_alt"    "1_KI270762v1_alt"
## [100] "4_KQ090015v1_alt"     "7_KI270809v1_alt"     "10_KI270825v1_alt"
## [103] "1_GL383518v1_alt"     "11_KI270830v1_alt"    "11_KI270903v1_alt"
## [106] "17_KI270909v1_alt"    "8_KI270813v1_alt"     "21_KI270873v1_alt"
## [109] "5_KI270795v1_alt"     "5_KI270898v1_alt"     "7_KI270806v1_alt"
## [112] "6_GL000255v2_alt"     "3_KZ559103v1_alt"     "12_GL877876v1_alt"
## [115] "12_KI270904v1_alt"    "20_KI270871v1_alt"    "15_KN538374v1_fix"
## [118] "15_KI270905v1_alt"    "17_KI270908v1_alt"    "17_GL000258v2_alt"
## [121] "11_KI270927v1_alt"    "6_KI270801v1_alt"     "5_GL339449v2_alt"
## [124] "10_GL383546v1_alt"    "11_KZ559111v1_alt"    "13_KN538371v1_fix"
## [127] "19_GL949746v1_alt"    "19_GL949752v1_alt"    "19_KI270938v1_alt"
## [130] "19_GL949747v2_alt"    "19_GL949753v2_alt"    "2_KQ983256v1_alt"
## [133] "1_KI270763v1_alt"     "22_KI270734v1_random" "12_GL877875v1_alt"
## [136] "15_KQ031389v1_alt"    "1_KV880763v1_alt"     "1_KQ458384v1_alt"
## [139] "2_GL582966v2_alt"     "12_KI270833v1_alt"    "6_GL000252v2_alt"
## [142] "1_KN196474v1_fix"     "19_KI270865v1_alt"    "16_KI270855v1_alt"
## [145] "16_KQ090027v1_alt"    "3_KI270782v1_alt"     "8_KI270817v1_alt"
## [148] "2_KI270768v1_alt"     "11_KI270902v1_alt"    "13_KI270838v1_alt"
## [151] "4_KI270896v1_alt"     "4_KQ983257v1_fix"     "4_KQ983258v1_alt"
## [154] "2_KI270769v1_alt"     "15_KI270851v1_alt"    "21_GL383581v2_alt"
## [157] "16_KI270854v1_alt"    "3_KV766192v1_fix"     "6_GL000250v2_alt"
## [160] "19_GL383575v2_alt"    "9_KI270823v1_alt"     "22_KN196485v1_alt"
## [163] "22_KI270928v1_alt"    "22_GL383582v2_alt"    "22_KB663609v1_alt"
## [166] "21_KI270872v1_alt"    "5_KI270897v1_alt"     "22_KI270876v1_alt"
## [169] "1_KN196473v1_fix"     "6_GL000253v2_alt"     "8_KI270900v1_alt"
## [172] "8_KI270926v1_alt"     "8_KI270818v1_alt"     "8_KI270812v1_alt"
## [175] "3_KQ031385v1_fix"     "2_KI270774v1_alt"     "18_KI270863v1_alt"
## [178] "19_GL383573v1_alt"    "7_GL383534v2_alt"     "6_KZ208911v1_fix"
## [181] "10_KN196480v1_fix"    "12_KI270837v1_alt"    "6_KI270758v1_alt"
## [184] "15_KI270848v1_alt"    "1_GL383520v2_alt"     "22_KQ458387v1_alt"
## [187] "22_KN196486v1_alt"    "22_KQ759761v1_alt"    "22_KQ458388v1_alt"
## [190] "19_GL949748v2_alt"    "19_GL949749v2_alt"    "19_GL949750v2_alt"
## [193] "19_GL949751v2_alt"    "7_KQ031388v1_fix"     "5_KV575243v1_alt"
## [196] "19_KV575250v1_alt"    "19_KI270922v1_alt"    "19_KV575258v1_alt"
## [199] "19_KI270920v1_alt"    "19_KI270917v1_alt"    "19_KI270923v1_alt"
## [202] "19_KI270929v1_alt"    "19_KI270921v1_alt"    "17_KI270910v1_alt"
## [205] "3_KI270934v1_alt"     "3_KI270895v1_alt"     "3_KI270779v1_alt"
## [208] "3_KI270936v1_alt"     "3_KI270935v1_alt"     "3_KI270924v1_alt"
## [211] "3_KI270937v1_alt"     "19_GL000209v2_alt"    "19_KI270882v1_alt"
## [214] "19_KI270883v1_alt"    "19_KI270884v1_alt"    "19_KI270885v1_alt"
## [217] "19_KI270886v1_alt"    "19_KI270887v1_alt"    "19_KI270888v1_alt"
## [220] "19_KI270889v1_alt"    "19_KI270890v1_alt"    "19_KI270891v1_alt"
## [223] "19_KI270914v1_alt"    "19_KI270915v1_alt"    "19_KI270916v1_alt"
## [226] "19_KI270918v1_alt"    "19_KI270919v1_alt"    "19_KI270930v1_alt"
## [229] "19_KI270931v1_alt"    "19_KI270932v1_alt"    "19_KI270933v1_alt"
## [232] "19_KV575246v1_alt"    "19_KV575247v1_alt"    "19_KV575248v1_alt"
## [235] "19_KV575249v1_alt"    "19_KV575251v1_alt"    "19_KV575252v1_alt"
## [238] "19_KV575253v1_alt"    "19_KV575254v1_alt"    "19_KV575255v1_alt"
## [241] "19_KV575256v1_alt"    "19_KV575257v1_alt"    "19_KV575259v1_alt"
## [244] "19_KV575260v1_alt"
```

```
chromLocs(z)[["Y"]]
```

```
##   31534_at   31911_at   32864_at 32991_f_at   35885_at   36321_at   40030_at
##    2935380   13703898   -2786854   -6865917   12701230   12662366    7273971
##   41214_at 34172_s_at   34215_at   34753_at   37583_at   37583_at   38182_at
##    2841601    1591603    1591603   57067864  -19703864  -19705414   19567357
##   38182_at   40097_at   40097_at   40435_at 40436_g_at   41108_at     938_at
##   19567357   20575710   20575775   -1386151   -1386151    -304749   57184215
##   31411_at   31411_at   31411_at   34477_at   34477_at   34477_at    1185_at
##   22984262   24618003  -25030900  -13248378  -13323033  -13297508    1336784
##    1185_at   35073_at   35073_at   36553_at   36553_at   36554_at   36554_at
##    1336615     624343     624343   -1403138   -1403138   -1403138   -1403138
##   39168_at   39168_at   41138_at   41138_at   38355_at   38355_at   38355_at
##   -2486434   -2486413    2691294    2691294   12905704   12904785   12904857
##   38355_at   38355_at 32930_f_at 32930_f_at 32930_f_at 32930_f_at 32930_f_at
##   12903998   12904867   14524528   14622020   14522615   14523745   14524573
## 32930_f_at 35447_s_at 35447_s_at 35447_s_at 33665_s_at 33665_s_at 33665_s_at
##   14523504    1595454    1615132    1615058    1268813    1268813    1268813
## 33665_s_at
##    1268813
```

```
get("32972_at", probesToChrom(z))
```

```
## [1] "X"
```

```
chromInfo(z)
```

```
##                    1                    2                    3
##            248956422            242193529            198295559
##                    4                    5                    6
##            190214555            181538259            170805979
##                    7                    X                    8
##            159345973            156040895            145138636
##                    9                   11                   10
##            138394717            135086622            133797422
##                   12                   13                   14
##            133275309            114364328            107043718
##                   15                   16                   17
##            101991189             90338345             83257441
##                   18                   20                   19
##             80373285             64444167             58617616
##                    Y                   22                   21
##             57227415             50818468             46709983
##     8_KZ208915v1_fix    15_ML143371v1_fix    15_KI270905v1_alt
##              6367528              5500449              5161414
##    15_KN538374v1_fix     6_GL000256v2_alt     6_GL000254v2_alt
##              4998962              4929269              4827813
##     6_GL000251v2_alt     6_GL000253v2_alt     6_GL000250v2_alt
##              4795265              4677643              4672374
##     6_GL000255v2_alt     6_GL000252v2_alt    17_KI270857v1_alt
##              4606388              4604811              2877074
##    16_KI270853v1_alt    15_KQ031389v1_alt     5_MU273354v1_fix
##              2659700              2365364              2101585
##    16_KV880768v1_fix 16_KI270728v1_random    17_GL000258v2_alt
##              1927115              1872759              1821992
##     5_GL339449v2_alt     1_MU273333v1_fix    14_KI270847v1_alt
##              1612928              1572686              1511111
##    17_KI270908v1_alt    14_KI270846v1_alt    15_MU273374v1_fix
##              1423190              1351393              1154574
##     5_KI270897v1_alt     7_KI270803v1_alt    19_GL949749v2_alt
##              1144418              1111570              1091841
##    19_KI270938v1_alt    19_GL949750v2_alt    19_GL949748v2_alt
##              1066800              1066390              1064304
##    12_KZ208916v1_fix    21_MU273391v1_fix    19_GL949751v2_alt
##              1046838              1020778              1002683
##    19_GL949746v1_alt    19_GL949752v1_alt     8_KI270821v1_alt
##               987716               987100               985506
##     2_MU273342v1_fix     1_KI270763v1_alt     6_KI270801v1_alt
##               955087               911658               870480
##     Y_MU273398v1_fix     1_MU273331v1_alt    19_GL949753v2_alt
##               865743               847441               796479
##    19_GL949747v2_alt    14_MU273373v1_fix    14_KZ208920v1_fix
##               729520               722645               690932
##     7_KZ208913v1_alt     5_KV575244v1_fix     8_KI270822v1_alt
##               680662               673059               624492
##     X_MU273395v1_alt     7_KZ208912v1_fix     4_GL000257v2_alt
##               619716               589656               586476
##    12_KI270904v1_alt     9_MU273366v1_fix     4_KI270925v1_alt
##               572349               569668               555799
##     1_KV880763v1_alt    12_KN538369v1_fix    17_MU273380v1_fix
##               551020               541038               538541
##     2_MU273338v1_alt     2_KQ983256v1_alt    21_ML143377v1_fix
##               535251               535088               519485
##     1_MU273330v1_alt     5_MU273355v1_fix     2_MU273339v1_alt
##               516764               508332               500581
##    19_ML143376v1_fix     2_MU273343v1_fix     9_MU273365v1_fix
##               493165               489404               482250
##     2_KQ031384v1_fix    16_KZ559113v1_fix    15_KI270852v1_alt
##               481245               480415               478999
##     3_MU273348v1_fix     3_MU273346v1_fix     7_KV880765v1_fix
##               475876               469342               468267
##     1_KQ031383v1_fix     7_MU273358v1_alt    22_ML143378v1_fix
##               467143               464417               461303
##     1_KN538360v1_fix    10_ML143354v1_fix     3_KN196475v1_fix
##               460100               454963               451168
## 15_KI270727v1_random     9_KI270823v1_alt    11_MU273369v1_fix
##               448248               439082               434831
##     2_MU273337v1_alt    15_KI270850v1_alt     8_MU273362v1_fix
##               431782               430880               429744
##     1_KI270759v1_alt     4_KV766193v1_alt    10_KN538367v1_fix
##               425601               420675               420164
##     3_KN538364v1_fix    22_ML143380v1_fix     3_KV766192v1_fix
##               415308               412368               411654
##    13_ML143366v1_fix    12_GL877876v1_alt    18_KQ090028v1_fix
##               409912               408271               407387
##    19_KQ458386v1_fix     X_ML143381v1_fix    14_ML143367v1_fix
##               405389               403128               399183
##    15_ML143372v1_fix        Un_KI270442v1    17_KI270862v1_alt
##               396515               392061               391357
##    15_GL383555v2_alt    19_GL383573v1_alt     6_MU273357v1_alt
##               388773               385657               383128
##     4_KI270896v1_alt     4_GL383528v1_alt    17_GL383563v3_alt
##               378547               376187               375691
##     8_KI270810v1_alt     3_KQ031385v1_fix    17_MU273378v1_alt
##               374415               373699               372839
##    19_KN196484v1_fix    15_ML143370v1_fix     1_GL383520v2_alt
##               370917               369264               366580
##     2_KN538363v1_fix     5_KV575243v1_alt    13_KN538372v1_fix
##               365499               362221               356766
##    20_MU273389v1_fix     1_KI270762v1_alt     1_KQ458383v1_alt
##               355731               354444               349938
##    11_MU273370v1_fix     4_ML143345v1_fix     9_MU273364v1_fix
##               344606               341066               340717
##    21_MU273390v1_fix     1_MU273332v1_alt    16_MU273377v1_fix
##               336752               335159               334997
##    19_MU273384v1_fix     X_MU273397v1_alt     9_KN196479v1_fix
##               333754               330493               330164
##     1_KZ208906v1_fix    15_KI270848v1_alt    17_KI270909v1_alt
##               330031               327382               325800
##    14_KI270844v1_alt     6_KQ031387v1_fix     8_KI270900v1_alt
##               322166               320750               318687
##    12_KQ759760v1_fix    10_GL383546v1_alt     4_MU273349v1_alt
##               315610               309802               308682
##    13_KI270838v1_alt     3_KN196476v1_fix     8_KI270816v1_alt
##               306913               305979               305841
##     1_KN538361v1_fix    11_KZ559108v1_fix    22_KI270879v1_alt
##               305542               305244               304135
##     3_KZ559103v1_alt     5_MU273356v1_alt    11_KZ559110v1_alt
##               302885               302485               301637
##     3_MU273347v1_fix     8_KI270813v1_alt    12_ML143361v1_fix
##               301310               300230               297568
##    11_KI270831v1_alt    15_GL383554v1_alt     X_MU273396v1_alt
##               296895               296527               294119
##    19_KV575249v1_alt    10_ML143355v1_fix     8_KI270811v1_alt
##               293522               292944               292436
##    18_GL383567v1_alt     2_MU273340v1_alt     X_KI270880v1_alt
##               289831               284971               284869
##     8_KI270812v1_alt    19_KI270921v1_alt    17_KV766196v1_fix
##               282736               282224               281919
## 17_KI270729v1_random    11_KZ559109v1_fix     1_KQ983255v1_alt
##               280839               279644               278659
##    17_JH159146v1_alt    10_KN196480v1_fix    17_KV766198v1_alt
##               278131               277797               276292
##     4_ML143349v1_fix     X_KI270913v1_alt    20_MU273388v1_fix
##               276109               274009               273725
##     6_KI270798v1_alt     7_KI270808v1_alt    16_ML143373v1_fix
##               271782               271455               270967
##    11_ML143358v1_fix     6_KN196478v1_fix    16_KQ090027v1_alt
##               270122               268330               267463
##     8_KV880767v1_fix    10_KQ090021v1_fix    14_ML143368v1_alt
##               265876               264545               264228
##    22_KI270876v1_alt    15_KI270851v1_alt    11_MU273368v1_alt
##               263666               263054               261194
##    22_KI270875v1_alt     1_KI270766v1_alt     7_ML143352v1_fix
##               259914               256271               254759
##     1_MU273336v1_fix    19_KI270882v1_alt     3_KI270778v1_alt
##               250447               248807               248252
##    17_KV766197v1_alt     6_KQ090016v1_fix    15_KI270849v1_alt
##               246895               245716               244917
##     2_MU273344v1_fix     4_KI270786v1_alt     6_KZ208911v1_fix
##               244725               244096               242796
##    19_KV575250v1_alt    12_KI270835v1_alt     4_KQ090015v1_alt
##               241058               238139               236512
##    17_KI270858v1_alt     4_ML143344v1_fix    17_MU273379v1_fix
##               235827               235734               234878
##    19_KI270867v1_alt    16_KI270855v1_alt    18_KZ559115v1_fix
##               233762               232857               230843
##     4_KQ983257v1_fix     8_KI270926v1_alt     5_GL949742v1_alt
##               230434               229282               226852
##    19_MU273386v1_fix     3_KI270780v1_alt    17_GL383565v1_alt
##               226166               224108               223995
##     2_KI270774v1_alt    19_KV575256v1_alt     4_KI270790v1_alt
##               223625               223118               220246
##    11_KI270927v1_alt    11_ML143359v1_fix    19_KI270932v1_alt
##               218612               217075               215732
##     3_ML143343v1_alt    11_KI270903v1_alt     2_KI270894v1_alt
##               215443               214625               214158
##     1_KQ458384v1_alt     1_MU273335v1_fix    12_KN196482v1_fix
##               212205               211934               211377
## 14_GL000225v1_random        Un_KI270743v1     1_MU273334v1_fix
##               211173               210658               210426
##    11_KI270832v1_alt     7_KI270805v1_alt     Y_KZ208924v1_fix
##               210133               209988               209722
##  4_GL000008v2_random     7_KI270809v1_alt    19_KI270887v1_alt
##               209709               209586               209512
##     5_MU273353v1_fix     2_KN538362v1_fix     8_MU273363v1_fix
##               208405               208149               207371
##    13_KN538371v1_fix     4_KI270789v1_alt     4_MU273351v1_fix
##               206320               205944               205691
##     4_KQ983258v1_alt     3_KI270779v1_alt    19_KI270914v1_alt
##               205407               205312               205194
##    18_KQ458385v1_alt    11_KQ759759v2_fix    19_KI270886v1_alt
##               205101               204999               204239
##    11_KI270829v1_alt    15_MU273375v1_alt    11_KN538368v1_alt
##               204059               204007               203552
## 14_GL000009v2_random    21_GL383579v2_alt    11_JH159136v1_alt
##               201709               201197               200998
##    19_KI270930v1_alt        Un_KI270747v1    18_GL383571v1_alt
##               200773               198735               198278
##    19_KI270920v1_alt     3_KZ559102v1_alt     6_KI270797v1_alt
##               198005               197752               197536
##     3_KI270935v1_alt    11_KQ759759v1_fix    17_KI270861v1_alt
##               197351               196940               196688
##    15_KI270906v1_alt    10_MU273367v1_fix     5_KI270791v1_alt
##               196384               196262               195710
##     3_KZ559105v1_alt 14_KI270722v1_random    12_ML143362v1_fix
##               195063               194050               192531
##    16_GL383556v1_alt    13_KI270840v1_alt 14_GL000194v1_random
##               192462               191684               191469
##    11_JH159137v1_alt    19_KI270917v1_alt     7_KI270899v1_alt
##               191409               190932               190869
##    21_MU273392v1_fix    19_KI270923v1_alt    10_KI270825v1_alt
##               189707               189352               188315
##    19_GL383576v1_alt     X_KV766199v1_alt    19_KI270922v1_alt
##               188024               188004               187935
##    17_MU273382v1_fix        Un_KI270742v1     1_KN196472v1_fix
##               187626               186739               186494
##    22_KI270878v1_alt    19_KI270929v1_alt    11_KI270826v1_alt
##               186262               186203               186169
##     6_KB021644v2_alt 17_GL000205v2_random    10_KQ090020v1_alt
##               185823               185591               185507
##     1_KI270765v1_alt    19_KI270916v1_alt    19_KI270890v1_alt
##               185285               184516               184499
##     3_KI270784v1_alt    12_GL383551v1_alt    20_KI270870v1_alt
##               184404               184319               183433
##        Un_GL000195v1     1_GL383518v1_alt    11_KQ090022v1_fix
##               182896               182439               181958
## 22_KI270736v1_random     2_KZ208907v1_alt    10_KI270824v1_alt
##               181920               181658               181496
##    11_KZ559111v1_alt    14_KI270845v1_alt     3_GL383526v1_alt
##               181167               180703               180671
##    13_KI270839v1_alt     7_KQ031388v1_fix 22_KI270733v1_random
##               180306               179932               179772
##        Un_GL000224v1    10_GL383545v1_alt        Un_GL000219v1
##               179693               179254               179198
##     5_KI270792v1_alt    17_KI270860v1_alt    19_KV575252v1_alt
##               179043               178921               178197
##    19_GL000209v2_alt    11_KI270830v1_alt  9_KI270719v1_random
##               177381               177092               176845
##     4_ML143347v1_fix        Un_GL000216v2    22_KI270928v1_alt
##               176674               176608               176103
##  1_KI270712v1_random     3_KZ208909v1_alt     6_KI270800v1_alt
##               176043               175849               175808
##  1_KI270706v1_random    12_KZ208918v1_alt    22_KQ458388v1_alt
##               175055               174808               174749
##     2_MU273345v1_fix     2_KI270776v1_alt    18_KI270912v1_alt
##               174385               174166               174061
##     3_KI270777v1_alt     5_GL383531v1_alt     3_JH636055v2_alt
##               173649               173459               173151
## 14_KI270725v1_random     5_KI270796v1_alt    17_MU273383v1_fix
##               172810               172708               172609
##     7_KZ559106v1_alt    14_KZ208919v1_alt     9_GL383541v1_alt
##               172555               171798               171286
##    19_KV575259v1_alt    19_KI270885v1_alt    11_ML143360v1_fix
##               171263               171027               170928
##    19_KI270919v1_alt    19_KI270889v1_alt    19_KI270891v1_alt
##               170701               170698               170680
##    19_KI270915v1_alt    19_KI270933v1_alt    19_KI270883v1_alt
##               170665               170537               170399
##    19_GL383575v2_alt    19_KV575247v1_alt    19_KI270931v1_alt
##               170222               170206               170148
##    12_GL383550v2_alt    16_KQ031390v1_alt    13_KI270841v1_alt
##               169178               169136               169134
##        Un_KI270744v1    13_KQ090024v1_alt    19_KV575248v1_alt
##               168472               168146               168131
##    18_KI270863v1_alt    18_GL383569v1_alt    12_GL877875v1_alt
##               167999               167950               167313
##    21_KI270874v1_alt    19_KV575253v1_alt     3_KI270924v1_alt
##               166743               166713               166540
##     1_KN196473v1_fix     1_KZ208904v1_alt     1_KI270761v1_alt
##               166200               166136               165834
##     3_KQ031386v1_fix     3_KI270937v1_alt    11_ML143357v1_fix
##               165718               165607               165419
##     8_KZ208914v1_fix 22_KI270734v1_random    18_GL383570v1_alt
##               165120               165050               164789
##     5_KI270794v1_alt     4_GL383527v1_alt        Un_GL000213v1
##               164558               164536               164239
##     3_KI270936v1_alt     3_KZ559101v1_alt    19_KV575246v1_alt
##               164170               164041               163926
##     9_KQ090018v1_alt     4_KQ090014v1_alt     3_KI270934v1_alt
##               163882               163749               163458
##    18_KZ559116v1_alt     9_GL383539v1_alt     3_KI270895v1_alt
##               163186               162988               162896
##    22_GL383582v2_alt     3_KI270782v1_alt     1_KI270892v1_alt
##               162811               162429               162212
##        Un_GL000220v1     2_KI270767v1_alt  2_KI270715v1_random
##               161802               161578               161471
##     2_KI270893v1_alt        Un_GL000218v1    19_KV575255v1_alt
##               161218               161147               161095
##    18_GL383572v1_alt    19_KV575251v1_alt     8_KI270817v1_alt
##               159547               159285               158983
##     4_KI270788v1_alt    13_ML143364v1_fix        Un_KI270749v1
##               158965               158944               158759
##     7_KI270806v1_alt     7_KI270804v1_alt    18_KI270911v1_alt
##               158166               157952               157710
##        Un_KI270741v1    17_KI270910v1_alt    19_KI270884v1_alt
##               157432               157099               157053
##     8_KV880766v1_fix    19_KV575258v1_alt    22_KN196485v1_alt
##               156998               156965               156562
##    22_KQ458387v1_alt    19_GL383574v1_alt    19_KI270888v1_alt
##               155930               155864               155532
##  3_GL000221v1_random    17_KV575245v1_fix    11_GL383547v1_alt
##               155397               154723               154407
##    12_KZ559112v1_alt  2_KI270716v1_random    22_KN196486v1_alt
##               154139               153799               153027
##    12_GL383553v2_alt     6_KI270799v1_alt 22_KI270731v1_random
##               152874               152148               150754
##        Un_KI270751v1     8_MU273359v1_fix        Un_KI270750v1
##               150742               150302               148850
##    13_KN538373v1_fix     2_ML143341v1_fix    19_KV575260v1_alt
##               148762               145975               145691
##     8_KI270818v1_alt    22_KQ759761v1_alt    17_MU273381v1_fix
##               145606               145162               144689
##     X_KI270881v1_alt    21_KI270873v1_alt     2_GL383521v1_alt
##               144206               143900               143390
##     7_KV880764v1_fix     8_KI270814v1_alt     1_KQ458382v1_alt
##               142129               141812               141019
##    11_KV766195v1_fix     X_MU273394v1_fix     2_KZ208908v1_alt
##               140877               140567               140361
##     1_KZ208905v1_alt     6_KV766194v1_fix     5_KN196477v1_alt
##               140355               139427               139087
##    12_GL383552v1_alt        Un_KI270519v1     2_KI270775v1_alt
##               138655               138126               138019
##    17_ML143374v1_fix    19_MU273385v1_fix    17_KI270907v1_alt
##               137908               137818               137721
##        Un_GL000214v1     8_KI270901v1_alt     2_KI270770v1_alt
##               137718               136959               136240
##     5_KZ208910v1_alt    16_KI270854v1_alt     9_KQ090019v1_alt
##               135987               134193               134099
##     8_KI270819v1_alt    17_GL383564v2_alt     2_KI270772v1_alt
##               133535               133151               133041
##     8_KI270815v1_alt     5_KI270795v1_alt     5_KI270898v1_alt
##               132244               131892               130957
##    20_GL383577v2_alt  1_KI270708v1_random     7_KI270807v1_alt
##               128386               127682               126434
##     5_KI270793v1_alt     4_ML143348v1_fix     6_GL383533v1_alt
##               126136               125549               124736
##     2_GL383522v1_alt    13_KQ090025v1_alt    19_KI270918v1_alt
##               123821               123480               123111
##    11_MU273371v1_fix     1_KN196474v1_fix    12_GL383549v1_alt
##               122722               122022               120804
##     2_KI270769v1_alt     2_MU273341v1_fix     4_KI270785v1_alt
##               120616               120381               119912
##    12_KI270834v1_alt     7_GL383534v2_alt    20_KI270869v1_alt
##               119498               119183               118774
##    17_KZ559114v1_alt    21_GL383581v2_alt     4_MU273350v1_fix
##               116753               116689               113364
##     3_KI270781v1_alt 17_KI270730v1_random        Un_KI270438v1
##               113034               112551               112505
##     4_KI270787v1_alt    18_KI270864v1_alt     2_KI270771v1_alt
##               111943               111737               110395
##     1_GL383519v1_alt     2_KI270768v1_alt     1_KI270760v1_alt
##               110268               110099               109528
##    12_KQ090023v1_alt     3_KI270783v1_alt    11_KN196481v1_fix
##               109323               109187               108875
##    17_KI270859v1_alt     8_MU273361v1_fix    11_KI270902v1_alt
##               108763               106905               106711
##     3_KZ559104v1_fix    18_GL383568v1_alt    12_MU273372v1_fix
##               105527               104552               104537
## 22_KI270737v1_random    13_KI270843v1_alt     8_KZ559107v1_alt
##               103838               103832               103072
##    22_KI270877v1_alt     5_GL383530v1_alt     Y_KN196487v1_fix
##               101331               101241               101150
##    22_KQ759762v2_fix    22_KQ759762v1_fix    19_KV575257v1_alt
##               101040               101037               100553
## 11_KI270721v1_random    19_KV575254v1_alt 22_KI270738v1_random
##               100316                99845                99375
##    15_ML143369v1_fix    22_GL383583v2_alt     2_GL582966v2_alt
##                97763                96924                96131
##        Un_KI270748v1    18_KZ208922v1_fix        Un_KI270435v1
##                93321                93070                92983
##  5_GL000208v1_random        Un_KI270538v1     4_KQ090013v1_alt
##                92689                91309                90922
##    17_GL383566v1_alt     5_ML143350v1_fix    16_GL383557v1_alt
##                90219                89956                89672
##    19_MU273387v1_alt    17_JH159148v1_alt    16_MU273376v1_fix
##                89211                88070                87715
##    12_KN538370v1_fix    10_KN538366v1_fix     2_ML143342v1_fix
##                86533                85284                84043
##     5_GL383532v1_alt    21_KI270872v1_alt     6_KQ090017v1_alt
##                82728                82692                82315
##        Un_KI270756v1    16_KZ208921v1_alt     6_KI270758v1_alt
##                79590                78609                76752
##    12_KI270833v1_alt     6_KI270802v1_alt    21_GL383580v2_alt
##                76061                75005                74653
##    22_KB663609v1_alt 22_KI270739v1_random     6_ML143351v1_fix
##                74013                73985                73265
##     9_GL383540v1_alt        Un_KI270757v1     2_KI270773v1_alt
##                71551                71251                70887
##    17_JH159147v1_alt     X_MU273393v1_fix     X_ML143383v1_fix
##                70345                68810                68192
##    11_KI270827v1_alt  1_KI270709v1_random        Un_KI270746v1
##                67707                66860                66486
##    13_ML143365v1_fix    12_KZ208917v1_fix    16_KI270856v1_alt
##                65394                64689                63982
##    21_GL383578v2_alt        Un_KI270753v1    19_KI270868v1_alt
##                63917                62944                61734
##     9_GL383542v1_alt    16_KQ090026v1_alt    20_KI270871v1_alt
##                60032                59016                58661
##    17_ML143375v1_fix    12_KI270836v1_alt     4_ML143346v1_fix
##                56695                56134                53476
##    19_KI270865v1_alt     1_KI270764v1_alt     Y_KZ208923v1_fix
##                52969                50258                48370
##    11_ML143356v1_fix     1_KZ559100v1_fix        Un_KI270589v1
##                45257                44955                44474
## 14_KI270726v1_random    19_KI270866v1_alt 22_KI270735v1_random
##                43739                43156                42811
##  1_KI270711v1_random        Un_KI270745v1  1_KI270714v1_random
##                42210                41891                41717
## 22_KI270732v1_random  1_KI270713v1_random        Un_KI270754v1
##                41543                40745                40191
##  1_KI270710v1_random    12_KI270837v1_alt  9_KI270717v1_random
##                40176                40090                40062
## 14_KI270724v1_random     8_MU273360v1_fix  9_KI270720v1_random
##                39555                39290                39050
## 14_KI270723v1_random  9_KI270718v1_random        Un_KI270317v1
##                38115                38054                37690
##    13_KI270842v1_alt  Y_KI270740v1_random        Un_KI270755v1
##                37287                37240                36723
##     8_KI270820v1_alt    13_KN196483v1_fix     5_MU273352v1_fix
##                36640                35455                34400
##  1_KI270707v1_random        Un_KI270579v1     X_ML143382v1_fix
##                32032                31033                28824
##        Un_KI270752v1     9_ML143353v1_fix        Un_KI270512v1
##                27745                25408                22689
##        Un_KI270322v1     X_ML143385v1_fix                    M
##                21476                17435                16569
##        Un_GL000226v1     X_ML143384v1_fix    10_KN538365v1_fix
##                15008                14678                14347
##        Un_KI270311v1    22_ML143379v1_fix        Un_KI270366v1
##                12399                12295                 8320
##        Un_KI270511v1        Un_KI270448v1        Un_KI270521v1
##                 8127                 7992                 7642
##    13_ML143363v1_fix        Un_KI270581v1        Un_KI270582v1
##                 7309                 7046                 6504
##        Un_KI270515v1        Un_KI270588v1        Un_KI270591v1
##                 6361                 6158                 5796
##        Un_KI270522v1        Un_KI270507v1        Un_KI270590v1
##                 5674                 5353                 4685
##        Un_KI270584v1        Un_KI270320v1        Un_KI270382v1
##                 4513                 4416                 4215
##        Un_KI270468v1        Un_KI270467v1        Un_KI270362v1
##                 4055                 3920                 3530
##        Un_KI270517v1        Un_KI270593v1        Un_KI270528v1
##                 3253                 3041                 2983
##        Un_KI270587v1        Un_KI270364v1        Un_KI270371v1
##                 2969                 2855                 2805
##        Un_KI270333v1        Un_KI270374v1        Un_KI270411v1
##                 2699                 2656                 2646
##        Un_KI270414v1        Un_KI270510v1        Un_KI270390v1
##                 2489                 2415                 2387
##        Un_KI270375v1        Un_KI270420v1        Un_KI270509v1
##                 2378                 2321                 2318
##        Un_KI270315v1        Un_KI270302v1        Un_KI270518v1
##                 2276                 2274                 2186
##        Un_KI270530v1        Un_KI270304v1        Un_KI270418v1
##                 2168                 2165                 2145
##        Un_KI270424v1        Un_KI270417v1        Un_KI270508v1
##                 2140                 2043                 1951
##        Un_KI270303v1        Un_KI270381v1        Un_KI270529v1
##                 1942                 1930                 1899
##        Un_KI270425v1        Un_KI270396v1        Un_KI270363v1
##                 1884                 1880                 1803
##        Un_KI270386v1        Un_KI270465v1        Un_KI270383v1
##                 1788                 1774                 1750
##        Un_KI270384v1        Un_KI270330v1        Un_KI270372v1
##                 1658                 1652                 1650
##        Un_KI270548v1        Un_KI270580v1        Un_KI270387v1
##                 1599                 1553                 1537
##        Un_KI270391v1        Un_KI270305v1        Un_KI270373v1
##                 1484                 1472                 1451
##        Un_KI270422v1        Un_KI270316v1        Un_KI270338v1
##                 1445                 1444                 1428
##        Un_KI270340v1        Un_KI270583v1        Un_KI270334v1
##                 1428                 1400                 1368
##        Un_KI270429v1        Un_KI270393v1        Un_KI270516v1
##                 1361                 1308                 1300
##        Un_KI270389v1        Un_KI270466v1        Un_KI270388v1
##                 1298                 1233                 1216
##        Un_KI270544v1        Un_KI270310v1        Un_KI270412v1
##                 1202                 1201                 1179
##        Un_KI270395v1        Un_KI270376v1        Un_KI270337v1
##                 1143                 1136                 1121
##        Un_KI270335v1        Un_KI270378v1        Un_KI270379v1
##                 1048                 1048                 1045
##        Un_KI270329v1        Un_KI270419v1        Un_KI270336v1
##                 1040                 1029                 1026
##        Un_KI270312v1        Un_KI270539v1        Un_KI270385v1
##                  998                  993                  990
##        Un_KI270423v1        Un_KI270392v1        Un_KI270394v1
##                  981                  971                  970
```

```
get("32972_at", geneSymbols(z))
```

```
## [1] "NOX1"
```

Another method which can be used to access information about the particular
*chromLocation* object is the `nChrom` method, which will list how many
chromosomes this organism has:

```
nChrom(z)
```

```
## [1] 711
```

# 3 Summary

The *chromLocation* class has a simple design, but can be powerful if one wants
to store the chromosomal data contained in a Bioconductor package into a single
object. These objects can be created once and then passed around to multiple
functions, which can cut down on computation time to access the desired
information from the package. These objects allow access to basic but also
important information, and provide a standard interface for writers of other
software to access this information.
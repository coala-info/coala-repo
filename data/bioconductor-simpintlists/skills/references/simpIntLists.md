simpIntLists Package

November 4, 2025

R topics documented:

.

.

.

.

.

.

. .

. .

1
simpIntLists-package .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3
ArabidopsisBioGRIDInteractionEntrezId . . . . . . . . . . . . . . . . . . . . . . . . .
5
ArabidopsisBioGRIDInteractionOfficial
. . . . . . . . . . . . . . . . . . . . . . . . . .
6
ArabidopsisBioGRIDInteractionUniqueId . . . . . . . . . . . . . . . . . . . . . . . . .
8
C.ElegansBioGRIDInteractionEntrezId . . . . . . . . . . . . . . . . . . . . . . . . . .
C.ElegansBioGRIDInteractionOfficial
. . . . . . . . . . . . . . . . . . . . . . . . . . . 10
C.ElegansBioGRIDInteractionUniqueId . . . . . . . . . . . . . . . . . . . . . . . . . . 12
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
findInteractionList .
FruitFlyBioGRIDInteractionEntrezId . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
FruitFlyBioGRIDInteractionOfficial
. . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
FruitFlyBioGRIDInteractionUniqueId . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
HumanBioGRIDInteractionEntrezId . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
HumanBioGRIDInteractionOfficial . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
HumanBioGRIDInteractionUniqueId . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
MouseBioGRIDInteractionEntrezId . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
MouseBioGRIDInteractionOfficial . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
MouseBioGRIDInteractionUniqueId . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
S.PombeBioGRIDInteractionEntrezId . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
S.PombeBioGRIDInteractionOfficial . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
S.PombeBioGRIDInteractionUniqueId . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
YeastBioGRIDInteractionEntrezId . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
YeastBioGRIDInteractionOfficial . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
YeastBioGRIDInteractionUniqueId . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41

Index

45

simpIntLists-package

The package contains BioGRID interactions for various organisms in
a simple format

Description

The package contains BioGRID interactions for arabidopsis(thale cress), c.elegans, fruit fly, human,
mouse, yeast( budding yeast ) and S.pombe (fission yeast) . Entrez ids, official names and unique
ids can be used to find proteins.

1

simpIntLists-package

Package:
Type:
Version:
Date:
License:
LazyLoad:

simpIntLists
Package
1.0
2011-01-18
GPL version 2 or newer
yes

2

Details

Author(s)

Kircicegi KORKMAZ, Volkan ATALAY, Rengul CETIN ATALAY Maintainer: Kircicegi KORK-
MAZ <e102771@ceng.metu.edu.tr>

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> library(simpIntLists)
> i<-findInteractionList("arabidopsis", "EntrezId")
> i[1:5]

[[1]]
[[1]]$name
[1] 828230

[[1]]$interactors
[1] 832208 821860

5888 842783 834532

[[2]]
[[2]]$name
[1] 832208

[[2]]$interactors
[1] 828230 821455 852713 831710 821860

5888

11144

[[3]]
[[3]]$name
[1] 821860

[[3]]$interactors
[1] 828230 831710 832208

[[4]]
[[4]]$name

ArabidopsisBioGRIDInteractionEntrezId

3

[1] 836259

[[4]]$interactors

[1] 818903 825075 836259 819292 835842 816408 843133 836132 837479 819311

[11] 825382 816538 839341 819296 838883 832518 821807 822061

[[5]]
[[5]]$name
[1] 818903

[[5]]$interactors

[1] 836259 834983 836248 837479 814686 825075 816394 837483 839300 821251

> data(ArabidopsisBioGRIDInteractionUniqueId)
> ArabidopsisBioGRIDInteractionUniqueId[30:32]

[[1]]
[[1]]$name
[1] "At2g18790"

[[1]]$interactors

[1] "At5g57360" "At1g09530" "At1g09570" "At2g25930" "At3g59060" "At5g02810"
[7] "At4g17230" "At5g49230" "At5g59560" "At2g02950" "At5g61270" "At1g76500"
[13] "At1g10470" "At1g04400" "At2g18790" "At5g63310" "At2g20180" "At2g43010"
[19] "At5g35840" "At4g16250" "At4g18130" "At2g32950" "At1g22280" "At1g04240"
[25] "At1g52240"

[[2]]
[[2]]$name
[1] "At1g09530"

[[2]]$interactors

[1] "At2g18790" "At5g61380" "At3g59060" "At5g02810" "At5g61270" "At2g43010"
[7] "At2g01570" "At1g09570" "At1g02340" "At1g14920" "At1g66350" "At3g03450"

[13] "At5g17490" "At1g09530"

[[3]]
[[3]]$name
[1] "At2g46970"

[[3]]$interactors
[1] "At5g61380"

ArabidopsisBioGRIDInteractionEntrezId

BioGRID interactions for thale cress (Arabidopsis thaliana), entrez
ids are used as identifiers

4

Description

ArabidopsisBioGRIDInteractionEntrezId

This data set contains a list of interactions for thale cress (Arabidopsis thaliana). The interactions
are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, Entrez ids
are used.

Usage

data(ArabidopsisBioGRIDInteractionEntrezId)

Format

The format is: List of 2118 A list containing the interactions. For each gene/protein, there is an
entry in the list with "name" containing name of the gene/protein and "interactors" containing the
list of genes/proteins interacting with it. example: $ :List of 2 ..$ name : int 828230 ..$ interactors:
int [1:12] 832208 821860 821860 832208 832208 821860 832208 5888 842783 834532 ...

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(ArabidopsisBioGRIDInteractionEntrezId)
> ArabidopsisBioGRIDInteractionEntrezId[1:5]

[[1]]
[[1]]$name
[1] 828230

[[1]]$interactors
[1] 832208 821860

5888 842783 834532

[[2]]
[[2]]$name
[1] 832208

[[2]]$interactors
[1] 828230 821455 852713 831710 821860

5888

11144

[[3]]
[[3]]$name
[1] 821860

[[3]]$interactors
[1] 828230 831710 832208

ArabidopsisBioGRIDInteractionOfficial

5

[[4]]
[[4]]$name
[1] 836259

[[4]]$interactors

[1] 818903 825075 836259 819292 835842 816408 843133 836132 837479 819311

[11] 825382 816538 839341 819296 838883 832518 821807 822061

[[5]]
[[5]]$name
[1] 818903

[[5]]$interactors

[1] 836259 834983 836248 837479 814686 825075 816394 837483 839300 821251

ArabidopsisBioGRIDInteractionOfficial

BioGRID interactions for thale cress (Arabidopsis thaliana), official
names are used as identifiers

Description

This data set contains a list of interactions for thale cress (Arabidopsis thaliana). The interactions
are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, official
names are used.

Usage

data(ArabidopsisBioGRIDInteractionOfficial)

Format

The format is: List of 2109 A list containing the interactions. For each gene/protein, there is an
entry in the list with "name" containing name of the gene/protein and "interactors" containing the
list of genes/proteins interacting with it. example: $ :List of 2 ..$ name : chr "BRCA2(IV)" ..$
interactors: chr [1:12] "ATRAD51" "DMC1" "DMC1" "ATRAD51" ...

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

6

Examples

ArabidopsisBioGRIDInteractionUniqueId

> data(ArabidopsisBioGRIDInteractionOfficial)
> ArabidopsisBioGRIDInteractionOfficial[1:5]

[[1]]
[[1]]$name
[1] "BRCA2(IV)"

[[1]]$interactors
[1] "ATRAD51"

"DMC1"

[[2]]
[[2]]$name
[1] "ATRAD51"

"RAD51"

"ATDSS1(I)" "ATDSS1(V)"

[[2]]$interactors
[1] "BRCA2(IV)" "ATRAD54"

"RAD54"

"BRCA2B"

"DMC1"

"RAD51"

[[3]]
[[3]]$name
[1] "DMC1"

[[3]]$interactors
[1] "BRCA2(IV)" "BRCA2B"

"ATRAD51"

[[4]]
[[4]]$name
[1] "TOC1"

[[4]]$interactors

[1] "PIF4" "PIL6" "TOC1"
[10] "PIL1" "PIL2" "PIL5"

"APRR9" "ZTL"
"LHY"

"CCA1"

"LKP2"
"GI"

"FKF1"
"APRR5" "TIC"

"APRR3" "PIF3"
"ABI3"

[[5]]
[[5]]$name
[1] "PIF4"

[[5]]$interactors

[1] "TOC1" "HRB1" "PIF7" "PIF3" "RGA1" "PIL6" "PHYB" "PHYA" "HFR1" "RGL2"

ArabidopsisBioGRIDInteractionUniqueId

BioGRID interactions for thale cress (Arabidopsis thaliana), unique
ids are used as identifiers

ArabidopsisBioGRIDInteractionUniqueId

7

Description

This data set contains a list of interactions for thale cress (Arabidopsis thaliana). The interactions
are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, unique ids
(systematic names) are used.

Usage

data(ArabidopsisBioGRIDInteractionUniqueId)

Format

The format is: List of 2106 A list containing the interactions. For each gene/protein, there is an
entry in the list with "name" containing name of the gene/protein and "interactors" containing the
list of genes/proteins interacting with it. example: $ :List of 2 ..$ name : chr "At4g00020" ..$
interactors: chr [1:12] "At5g20850" "At3g22880" "At3g22880" "At5g20850" ...

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(ArabidopsisBioGRIDInteractionUniqueId)
> ArabidopsisBioGRIDInteractionUniqueId[1:5]

[[1]]
[[1]]$name
[1] "At4g00020"

[[1]]$interactors
[1] "At5g20850" "At3g22880" "At1g64750" "At5g45010"

[[2]]
[[2]]$name
[1] "At5g20850"

[[2]]$interactors
[1] "At4g00020"
[6] "RP1-199H16.4"

[[3]]
[[3]]$name
[1] "At3g22880"

"At3g19210"

"YGL163C"

"At5g01630"

"At3g22880"

[[3]]$interactors
[1] "At4g00020" "At5g01630" "At5g20850"

8

C.ElegansBioGRIDInteractionEntrezId

[[4]]
[[4]]$name
[1] "At5g61380"

[[4]]$interactors

[1] "At2g43010" "At3g59060" "At5g61380" "At2g46790" "At5g57360" "At2g18915"
[7] "At1g68050" "At5g60100" "At1g09530" "At2g46970" "At3g62090" "At2g20180"
[13] "At1g01060" "At2g46830" "At1g22770" "At5g24470" "At3g22380" "At3g24650"

[[5]]
[[5]]$name
[1] "At2g43010"

[[5]]$interactors

[1] "At5g61380" "At5g49230" "At5g61270" "At1g09530" "At2g01570" "At3g59060"
[7] "At2g18790" "At1g09570" "At1g02340" "At3g03450"

C.ElegansBioGRIDInteractionEntrezId

BioGRID interactions for C.elegans (Caenorhabditis elegans), entrez
ids are used as identifiers

Description

This data set contains a list of interactions for C.elegans (Caenorhabditis elegans). The interactions
are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, Entrez ids
are used.

Usage

data(C.ElegansBioGRIDInteractionEntrezId)

Format

The format is: List of 3573 A list containing the interactions. For each gene/protein, there is an
entry in the list with "name" containing name of the gene/protein and "interactors" containing the
list of genes/proteins interacting with it. example: $ :List of 2 ..$ name : int 177286 ..$ interactors:
int [1:4] 179791 178104 180982 178104

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

C.ElegansBioGRIDInteractionEntrezId

9

Examples

> data(C.ElegansBioGRIDInteractionEntrezId)
> C.ElegansBioGRIDInteractionEntrezId[1:5]

[[1]]
[[1]]$name
[1] 177286

[[1]]$interactors
[1] 179791 178104 180982

[[2]]
[[2]]$name
[1] 179791

[[2]]$interactors
[1] 177286 179941 171934 175195

[[3]]
[[3]]$name
[1] 178104

[[3]]$interactors

[1] 177286 174090 180611
[10] 180724 176061 176068
[19] 266854 175464 174044
[28] 179959 180980 180982
[37] 181082 184508 174350
[46] 172520 181274 177546
[55] 174693 181407 181013
[64] 179732 172374 186632
[73] 177956 176430 266820
[82] 177329 174107 174106
[91] 178788 173863 178845
[100] 189253 171849 173149
[109] 171654 173229 175126
[118] 177659 172504 178555
[127] 178120 179276 174685

175428
179736
172327
172088
174392
172399
172582
174091
173180
171801
178001
180357
181194
175890
181408
181539
176137
180032
188569
172233
173143
172747
189590 3565921
173854
175504
175921
187716
174782
172243

172249
179425
175638
173920
172524
179217
171607
173338
174323
172414
178296
189992
181291
175074
174788

175117
181055
181557
181098
172826
173345
174771
172353
178113
172856
179213
176667
178846
174121
182980

175909 174484
174137 179204
174721 179338
181263 180622
172832 172195
180961 175545
179770 176992
176060 177373
175621 174317
172532 173137
174830 3565510
173078 175089
174462 171840
181545 191690
188620 181456

[[4]]
[[4]]$name
[1] 179437

[[4]]$interactors
[1] 179795 180819 175638 178732

[[5]]
[[5]]$name

10

C.ElegansBioGRIDInteractionOfficial

[1] 179795

[[5]]$interactors
[1] 179437 171715

C.ElegansBioGRIDInteractionOfficial

BioGRID interactions for C.elegans (Caenorhabditis elegans), official
names are used as identifiers

Description

This data set contains a list of interactions for C.elegans (Caenorhabditis elegans). The interactions
are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, official
names are used.

Usage

data(C.ElegansBioGRIDInteractionOfficial)

Format

The format is: List of 3557 A list containing the interactions. For each gene/protein, there is an
entry in the list with "name" containing name of the gene/protein and "interactors" containing the
list of genes/proteins interacting with it. example: $ :List of 2 ..$ name : chr "soc-2" ..$ interactors:
chr [1:4] "W07G4.5" "let-60" "bar-1" "let-60"

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(C.ElegansBioGRIDInteractionOfficial)
> C.ElegansBioGRIDInteractionOfficial[1:5]

[[1]]
[[1]]$name
[1] "soc-2"

[[1]]$interactors
[1] "W07G4.5" "let-60" "bar-1"

[[2]]
[[2]]$name
[1] "W07G4.5"

C.ElegansBioGRIDInteractionOfficial

11

[[2]]$interactors
[1] "soc-2" "pas-1" "ftn-2" "gei-4"

[[3]]
[[3]]$name
[1] "let-60"

[[3]]$interactors

[1] "soc-2"
[7] "mog-4"
[13] "pnk-1"
[19] "dsh-2"
[25] "eor-2"
[31] "cyc-1"
[37] "ksr-1"
[43] "sur-6"
[49] "lin-3"
[55] "unc-53"
[61] "F54D5.5" "nid-1"
"sel-7"
[67] "scd-1"
"mua-3"
[73] "epi-1"
"emb-5"
[79] "par-5"
"unc-40"
[85] "ver-2"
"T27F7.1"
[91] "lin-40"
"lin-29"
[97] "sel-9"
"chk-1"
[103] "vps-4"
[109] "Y65B4A.3" "vps-28"
[115] "sos-1"
"let-23"
[121] "nhr-269" "T26A5.8"
[127] "let-653" "nhr-44"
[133] "hlh-12"

"frm-8"
"rgl-1"
"icd-1"
"pdi-2"
"mel-11"
"let-756"
"sem-5"
"rop-1"
"let-502"
"prx-5"
"sma-6"
"sel-8"
"hda-1"
"unc-130"
"mdf-1"
"kin-9"
"vps-32.1" "mog-5"
"F22G12.4" "F23C8.6"
"zyg-9"
"efn-3"
"plc-1"
"lrp-1"
"atp-3"
"cco-1"
"unc-6"
"sur-2"
"mom-2"
"pha-4"
"hmg-1.2"
"dpy-22"
"dpy-7"
"sdz-19"
"lin-25"
"mei-2"
"egl-18"
"cdc-25.1" "mup-4"
"hmp-2"
"ceh-26"
"smo-1"
"rme-2"
"mig-5"
"mom-5"
"glh-1"
"unc-62"
"aph-1"
"W03F8.10" "W06F12.3" "pop-1"
"hsf-1"
"Y47G6A.5" "pie-1"
"ZK546.14" "egl-15"
"pat-3"
"unc-52"
"pbrm-1"
"C09G4.2"
"sop-3"
"his-24"
"egl-27"
"ace-4"
"din-1"
"rnt-1"
"ptp-3"
"ptr-24"

"W05B10.4" "lin-35"
"lin-39"
"cgh-1"
"rol-3"
"tra-2"
"pal-1"
"cye-1"
"bar-1"
"lam-2"
"ddr-2"
"daf-12"
"ego-1"
"itr-1"
"mpk-1"
"mex-3"
"ver-4"
"lag-1"
"dab-1"
"kin-30"
"dpy-10"
"dpy-2"
"gld-1"
"par-6"
"W02A11.2" "mex-5"
"gsk-3"
"lin-7"

"srh-215"

"F33E11.2"
"ins-22"
"trr-1"

[[4]]
[[4]]$name
[1] "gna-1"

[[4]]$interactors
[1] "B0365.1" "dlg-1"

"pal-1"

"W02G9.3"

[[5]]
[[5]]$name
[1] "B0365.1"

[[5]]$interactors
[1] "gna-1" "dyb-1"

12

C.ElegansBioGRIDInteractionUniqueId

C.ElegansBioGRIDInteractionUniqueId

BioGRID interactions for C.elegans (Caenorhabditis elegans), unique
ids are used as identifiers

Description

This data set contains a list of interactions for C.elegans (Caenorhabditis elegans). The interactions
are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, unique
ids(systematic names) are used.

Usage

data(C.ElegansBioGRIDInteractionUniqueId)

Format

The format is: List of 3571 A list containing the interactions. For each gene/protein, there is an
entry in the list with "name" containing name of the gene/protein and "interactors" containing the
list of genes/proteins interacting with it. example: $ :List of 2 ..$ name : chr "AC7.2" ..$ interactors:
chr [1:4] "W07G4.5" "ZK792.6" "C54D1.6" "ZK792.6"

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(C.ElegansBioGRIDInteractionUniqueId)
> C.ElegansBioGRIDInteractionUniqueId[1:5]

[[1]]
[[1]]$name
[1] "AC7.2"

[[1]]$interactors
[1] "W07G4.5" "ZK792.6" "C54D1.6"

[[2]]
[[2]]$name
[1] "W07G4.5"

[[2]]$interactors
[1] "AC7.2"

"C15H11.7" "D1037.3"

"W07B3.2"

findInteractionList

13

[[3]]
[[3]]$name
[1] "ZK792.6"

[[3]]$interactors

[1] "AC7.2"
[6] "C32F10.2"

"C56C10.8"
"C04H5.6"
"C07H6.7"
"C15F1.3"
"C34C6.6"
"C50F4.11"
"C56C10.3"
"F13B9.5"
"F26A3.3"
"F31B12.1"
"F39B2.4"
"F46C8.6"
"F54F3.1"
"H20J18.1"
"K08B4.1"
"M01B2.1"
"T11F8.3"
"T21G5.3"
"T27F7.1"
"W02D7.7"
"Y18D10A.5"

"F28B4.2"
"C05D11.4"
"C10G11.5"
"C16D9.2"
"C37A2.4"
"C53A5.3"
"EEED8.5"
"F15A2.5"
"F26E4.1"
"F33D4.2"
"F41C6.1"
"F47A4.2"
"F55A8.1"
"K04G11.2"
"K08C7.3"
"M110.5"
"T14B4.6"
"T23D8.1"
"T28F12.2"
"W03C9.4"
"Y34D9A.10"

[11] "C07H6.5"
[16] "C14F5.5"
[21] "C32D5.2"
[26] "C47G2.2"
[31] "C54G4.8"
[36] "F11D5.3"
[41] "F23C8.6"
[46] "F29D11.1"
[51] "F38E1.7"
[56] "F45E6.6"
[61] "F54D5.5"
[66] "F59F3.5"
[71] "K07D8.1"
[76] "K12H4.1"
[81] "T05C12.6"
[86] "T19B4.7"
[91] "T27C4.4"
[96] "W02A2.7"
[101] "W10C8.2"
[106] "Y49E10.14" "Y53C10A.12" "Y54G11A.10" "Y65B4A.3"
[111] "ZC101.2"
[116] "ZK1067.1"
[121] "R08H2.9"
[126] "M04D8.2"
[131] "F07A11.6"

"H09G03.2"
"C06C3.1"
"C10H11.9"
"C27A2.6"
"C38D4.6"
"C54D1.5"
"F08F1.1"
"F22B5.7"
"F26E4.9"
"F36H1.4"
"F43C1.2"
"F47D12.4"
"F56H9.5"
"K05C4.6"
"K08E5.3"
"M117.2"
"T14B4.7"
"T23G11.3"
"VF36H2L.1"
"W03F8.10"
"Y39H10A.7"

"ZK1058.2"
"Y71F9B.10"
"T26A5.8"
"C29E6.1"
"C47D12.1"

"ZK546.14"
"C09G4.2"
"Y48B6A.7"
"T19A5.4"
"C28C12.8"

"F58A3.2"
"C26C6.1"
"C04A2.3"
"C09D8.1"
"T20B3.3"

"W05B10.4"
"C07A12.4"
"C12D8.11"
"C32A3.1"
"C44H4.7"
"C54D1.6"
"F11A1.3"
"F22G12.4"
"F27C1.7"
"F38A6.1"
"F45E10.1"
"F53G12.5"
"F57B10.12"
"K06A5.7"
"K12C11.2"
"T04A8.14"
"T17A3.8"
"T26E3.3"
"W02A11.2"
"W06F12.3"
"Y47G6A.5"
"Y87G2A.10"
"T28F12.3"
"F33E11.2"
"M163.3"
"B0414.2"
"F46G10.5"

[[4]]
[[4]]$name
[1] "B0024.12"

[[4]]$interactors
[1] "B0365.1" "C25F6.2" "C38D4.6" "W02G9.3"

[[5]]
[[5]]$name
[1] "B0365.1"

[[5]]$interactors
[1] "B0024.12" "F47G6.1"

14

findInteractionList

findInteractionList

Find BioGRID interaction list for a given organism an identifier type

Description

Find BioGRID interaction list for a given organism an identifier type

Usage

findInteractionList(organism, idType)

Arguments

organism

Organism name. Can be one of ’arabidopsis’, ’c.elegans’, ’fruitFly’, ’human’,
’mouse’, ’yeast’, ’s.pombe’.

idType

Type of identifier used. Can be one of ’EntrezId’, ’Official’ and ’UniqueId’

Value

List containing the interactions. For each gene/protein, there is an entry in the list with "name"
containing name of the gen/protein and "interactors" containing the list of genes/proteins interacting
with it.

Examples

> l <- findInteractionList("arabidopsis", "EntrezId")
> l[1:5]

[[1]]
[[1]]$name
[1] 828230

[[1]]$interactors
[1] 832208 821860

5888 842783 834532

[[2]]
[[2]]$name
[1] 832208

[[2]]$interactors
[1] 828230 821455 852713 831710 821860

5888

11144

[[3]]
[[3]]$name
[1] 821860

[[3]]$interactors
[1] 828230 831710 832208

FruitFlyBioGRIDInteractionEntrezId

15

[[4]]
[[4]]$name
[1] 836259

[[4]]$interactors

[1] 818903 825075 836259 819292 835842 816408 843133 836132 837479 819311

[11] 825382 816538 839341 819296 838883 832518 821807 822061

[[5]]
[[5]]$name
[1] 818903

[[5]]$interactors

[1] 836259 834983 836248 837479 814686 825075 816394 837483 839300 821251

FruitFlyBioGRIDInteractionEntrezId

BioGRID interactions for Fruit fly (Drosophila melanogaster), entrez
ids are used as identifiers

Description

This data set contains a list of interactions for Fruit fly (Drosophila melanogaster) The interactions
are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, Entrez ids
are used.

Usage

data(FruitFlyBioGRIDInteractionEntrezId)

Format

The format is: A list containing the interactions. For each gene/protein, there is an entry in
the list with "name" containing name of the gene/protein and "interactors" containing the list of
genes/proteins interacting with it. example: List of 7578 $ :List of 2 ..$ name :
int 43383 ..$
interactors: int [1:18] 37006 40877 46391 32132 43584 3355072 39452 40887 40889 47186 ...

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

16

Examples

FruitFlyBioGRIDInteractionEntrezId

> data(FruitFlyBioGRIDInteractionEntrezId)
> FruitFlyBioGRIDInteractionEntrezId[1:5]

[[1]]
[[1]]$name
[1] 43383

[[1]]$interactors

[1]
[10]

37006
47186

40877
50457

46391
42986

32132
38941

43584 3355072
318573
33013

39452
43358

40887
39349

40889

42987
39377
117294

31298
41587
32994
37371 3355072
40560
32487
39808
34245
32490
32446

40687
36645
39801
42267
47894
32724
35353

32501
35256
32953
35810
42324
44027
40135

48317
40739
31275
48572
31283
38844
43386

33214
31300
40482
43997
39862
39703
32602

[[2]]
[[2]]$name
[1] 37006

[[2]]$interactors

[1]
[10]
[19]
[28]
[37]
[46]
[55]
[64]

32074
43383
31657
31291
39251
33841
40529
31106
42215 326157
41840
37849
36789
34132
40485
40483

32502
34708
44548
41734
38981
33268
37982
47877

[[3]]
[[3]]$name
[1] 41450

[[3]]$interactors
[1] 35735 43981 49228

[[4]]
[[4]]$name
[1] 35735

[[4]]$interactors
[1] 41450 40116 37022 40678 32312

[[5]]
[[5]]$name
[1] 43384

[[5]]$interactors

[1] 35808 31396 33031 43142 43727 42221 39972 31441 39643 40544 40605 35851

FruitFlyBioGRIDInteractionOfficial

17

FruitFlyBioGRIDInteractionOfficial

BioGRID interactions for Fruit fly (Drosophila melanogaster), official
names are used as identifiers

Description

This data set contains a list of interactions for Fruit fly (Drosophila melanogaster) The interactions
are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, official
names are used.

Usage

data(FruitFlyBioGRIDInteractionOfficial)

Format

The format is: List of 7577 A list containing the interactions. For each gene/protein, there is an
entry in the list with "name" containing name of the gene/protein and "interactors" containing the
list of genes/proteins interacting with it. example: $ :List of 2 ..$ name : chr "fkh" ..$ interactors:
chr [1:18] "CG6459" "CG10032" "CG11899" "CkIIbeta" ...

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(FruitFlyBioGRIDInteractionOfficial)
> FruitFlyBioGRIDInteractionOfficial[1:5]

[[1]]
[[1]]$name
[1] "fkh"

[[1]]$interactors

[1] "CG6459"
"CG10032"
[7] "CG17666" "Mst84Dc"

[13] "CG7081"

"CG9572"

"CG11899"
"Mst84Da"
"CG31054"

"CkIIbeta" "CG15529"
"CG34168"
"mus205"
"byn"
"CG4849"

"CG41099"
"ssh"

[[2]]
[[2]]$name
[1] "CG6459"

[[2]]$interactors

[1] "fkh"

"CG11756"

"CG12708"

"Nmnat"

"ng2"

18

FruitFlyBioGRIDInteractionUniqueId

"CG15646"
"Sir2"
"Rm62"
"Dsp1"
"CG14454"
"CG41099"
"koko"
"hbn"
"Hsc70-4"
"sbb"
"CG9083"
"CG9986"

"ttk"
"yps"
"ng1"
"vfl"
"CG14641"
"Xrp1"
"CG8683"
"CG3517"
"aru"
"CG7546"
"RpL37a"
"U2af50"

[6] "RpL13A"
[11] "CG4617"
[16] "CG10263"
[21] "lola"
[26] "CG14418"
[31] "CG15649"
[36] "jbug"
[41] "CG32944"
[46] "RpL39"
[51] "B-H1"
[56] "CG8435"
[61] "CG9368"
[66] "tws"

[[3]]
[[3]]$name
[1] "Tango9"

"CG4116"

"RpLP1"
"granny-smith" "BEAF-32"
"H2.0"
"CG13041"
"sta"
"CG18449"
"CG32352"
"CG3598"
"Borr"
"Eig71Ec"
"CG9213"
"CG12546"

"Sod"
"RpS10b"
"CG14840"
"Hsp60B"
"CG42299"
"zetaCOP"
"CG4998"
"Btk29A"
"CG9335"
"CG14452"

[[3]]$interactors
[1] "phr"

"DIP1"

"mod(mdg4)"

[[4]]
[[4]]$name
[1] "phr"

[[4]]$interactors
[1] "Tango9" "CG9472" "Ir54a"

"noi"

"Tango13"

[[5]]
[[5]]$name
[1] "Noa36"

[[5]]$interactors

[1] "CG11635" "CG3062"
[8] "Cdk7"

"CG6945" "Syt14"

"opa"

"ptc"

"CG12679" "CG14546" "CG1792"

"CG31122" "Ccn"

FruitFlyBioGRIDInteractionUniqueId

BioGRID interactions for Fruit fly (Drosophila melanogaster), unique
ids (systematic names) are used as identifiers

Description

This data set contains a list of interactions for Fruit fly (Drosophila melanogaster) The interactions
are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, unique ids
(systematic names) are used.

FruitFlyBioGRIDInteractionUniqueId

19

Usage

data(FruitFlyBioGRIDInteractionUniqueId)

Format

The format is: A list containing the interactions. For each gene/protein, there is an entry in
the list with "name" containing name of the gene/protein and "interactors" containing the list of
genes/proteins interacting with it. example: List of 7563 $ :List of 2 ..$ name : chr "Dmel_CG10002"
..$ interactors: chr [1:18] "Dmel_CG6459" "Dmel_CG10032" "Dmel_CG11899" "Dmel_CG15224"
...

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(FruitFlyBioGRIDInteractionUniqueId)
> FruitFlyBioGRIDInteractionUniqueId[1:5]

[[1]]
[[1]]$name
[1] "Dmel_CG10002"

[[1]]$interactors

[1] "Dmel_CG6459" "Dmel_CG10032" "Dmel_CG11899" "Dmel_CG15224" "Dmel_CG15529"
[6] "Dmel_CG41099" "Dmel_CG17666" "Dmel_CG17945" "Dmel_CG17946" "Dmel_CG1925"

[11] "Dmel_CG34168" "Dmel_CG6238"
[16] "Dmel_CG4849" "Dmel_CG7260"

"Dmel_CG7081"

"Dmel_CG9572"

"Dmel_CG31054"

[[2]]
[[2]]$name
[1] "Dmel_CG6459"

[[2]]$interactors

[1] "Dmel_CG10002" "Dmel_CG11756" "Dmel_CG12708" "Dmel_CG13645" "Dmel_CG14266"
[6] "Dmel_CG1475" "Dmel_CG15646" "Dmel_CG1856"
"Dmel_CG5654"

"Dmel_CG4116"
[11] "Dmel_CG4617" "Dmel_CG5216"
"Dmel_CG10159"
[16] "Dmel_CG10263" "Dmel_CG10279" "Dmel_CG10781" "Dmel_CG11607" "Dmel_CG11793"
[21] "Dmel_CG12052" "Dmel_CG12223" "Dmel_CG12701" "Dmel_CG13041" "Dmel_CG14206"
[26] "Dmel_CG14418" "Dmel_CG14454" "Dmel_CG14641" "Dmel_CG14792" "Dmel_CG14840"
[31] "Dmel_CG15649" "Dmel_CG41099" "Dmel_CG17836" "Dmel_CG18449" "Dmel_CG2830"
[36] "Dmel_CG30092" "Dmel_CG31232" "Dmel_CG8683"
[41] "Dmel_CG32944" "Dmel_CG33152" "Dmel_CG3517"
"Dmel_CG4276"
[46] "Dmel_CG3997" "Dmel_CG4264"
"Dmel_CG7546"
[51] "Dmel_CG5529" "Dmel_CG5580"
"Dmel_CG9091"
[56] "Dmel_CG8435" "Dmel_CG9083"

"Dmel_CG32352" "Dmel_CG42299"
"Dmel_CG3598"
"Dmel_CG4454"
"Dmel_CG7608"
"Dmel_CG9213"

"Dmel_CG3948"
"Dmel_CG4998"
"Dmel_CG8049"
"Dmel_CG9335"

"Dmel_CG4087"
"Dmel_CG7340"

20

HumanBioGRIDInteractionEntrezId

[61] "Dmel_CG9368" "Dmel_CG9986"
[66] "Dmel_CG6235"

"Dmel_CG9998"

"Dmel_CG12546" "Dmel_CG14452"

[[3]]
[[3]]$name
[1] "Dmel_CG10007"

[[3]]$interactors
[1] "Dmel_CG11205" "Dmel_CG17686" "Dmel_CG32491"

[[4]]
[[4]]$name
[1] "Dmel_CG11205"

[[4]]$interactors
[1] "Dmel_CG10007" "Dmel_CG9472"

"Dmel_CG14487" "Dmel_CG2925"

"Dmel_CG32632"

[[5]]
[[5]]$name
[1] "Dmel_CG10009"

[[5]]$interactors

[1] "Dmel_CG11635" "Dmel_CG3062"
[6] "Dmel_CG31122" "Dmel_CG32183" "Dmel_CG3319"

"Dmel_CG12679" "Dmel_CG14546" "Dmel_CG1792"
"Dmel_CG6945" "Dmel_CG9778"

[11] "Dmel_CG1133" "Dmel_CG2411"

HumanBioGRIDInteractionEntrezId

BioGRID interactions for human (Homo sapiens), entrez ids are used
as identifiers

Description

This data set contains a list of interactions for human (Homo sapiens). The interactions are taken
from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, Entrez ids are used.

Usage

data(HumanBioGRIDInteractionEntrezId)

Format

The format is: A list containing the interactions. For each gene/protein, there is an entry in
the list with "name" containing name of the gene/protein and "interactors" containing the list of
genes/proteins interacting with it. example: List of 10213 $ :List of 2 ..$ name :
int 6416 ..$
interactors: int [1:25] 2318 192176 2318 2318 9043 5599 5871 5609 1326 207 ...

HumanBioGRIDInteractionOfficial

21

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(HumanBioGRIDInteractionEntrezId)
> HumanBioGRIDInteractionEntrezId[1]

[[1]]
[[1]]$name
[1] 6416

[[1]]$interactors

[1]
[11]

2318 192176
4216
4294

9043
409

5599
10746

5871
4214

5609
4868

1326

207

23162

4296

HumanBioGRIDInteractionOfficial

BioGRID interactions for human (Homo sapiens), official names are
used as identifiers

Description

This data set contains a list of interactions for human (Homo sapiens). The interactions are taken
from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, official names ids
are used.

Usage

data(HumanBioGRIDInteractionOfficial)

Format

The format is: A list containing the interactions. For each gene/protein, there is an entry in
the list with "name" containing name of the gene/protein and "interactors" containing the list of
genes/proteins interacting with it. example: List of 10098 $ :List of 2 ..$ name : chr "MAP2K4" ..$
interactors: chr [1:25] "FLNC" "Flna" "FLNC" "FLNC" ...

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

22

Examples

> data(HumanBioGRIDInteractionOfficial)
> HumanBioGRIDInteractionOfficial[1]

HumanBioGRIDInteractionUniqueId

[[1]]
[[1]]$name
[1] "MAP2K4"

[[1]]$interactors

[1] "FLNC"
[7] "MAP3K8"

[13] "ARRB2"

"Flna"
"AKT1"
"MAP3K2"

"MAPK8"

"SPAG9"
"MAPK8IP3" "MAP3K11"
"MAP3K1"

"NPHS1"

"MAP4K2"
"MAP3K10"

"MAP2K7"
"MAP3K4"

HumanBioGRIDInteractionUniqueId

BioGRID interactions for human (Homo sapiens), unique ids (system-
atic names) are used as identifiers

Description

This data set contains a list of interactions for human (Homo sapiens). The interactions are taken
from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, unique ids (system-
atic names) are used.

Usage

data(HumanBioGRIDInteractionUniqueId)

Format

The format is: List of 2785 A list containing the interactions. For each gene/protein, there is an
entry in the list with "name" containing name of the gene/protein and "interactors" containing the
list of genes/proteins interacting with it. example: $ :List of 2 ..$ name : chr "-" ..$ interactors: chr
"-"

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(HumanBioGRIDInteractionUniqueId)
> HumanBioGRIDInteractionUniqueId[1]

MouseBioGRIDInteractionEntrezId

23

[[1]]
[[1]]$name
[1] "-"

[[1]]$interactors
[1] "-"

MouseBioGRIDInteractionEntrezId

BioGRID interactions for Mouse (Mus musculus), entrez ids are used
as identifiers

Description

This data set contains a list of interactions for Mouse (Mus musculus). The interactions are taken
from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, Entrez ids are used.

Usage

data(MouseBioGRIDInteractionEntrezId)

Format

The format is: A list containing the interactions. For each gene/protein, there is an entry in
the list with "name" containing name of the gene/protein and "interactors" containing the list of
genes/proteins interacting with it. example: List of 2361 $ :List of 2 ..$ name : int 4087 ..$ interac-
tors: int [1:28] 75141 19376 69159 72433 69288 54126 78294 57443 18412 52432 ...

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(MouseBioGRIDInteractionEntrezId)
> MouseBioGRIDInteractionEntrezId[1:5]

[[1]]
[[1]]$name
[1] 4087

[[1]]$interactors

72433
[1] 75141 19376 69159
[11] 26397 74137 16589
73341
[21] 80981 16801 71713 108960

69288
50780
16909

54126
16876
17126

78294
66854
17127

57443
66894
66603

18412 52432
80837 11854

24

MouseBioGRIDInteractionOfficial

[[2]]
[[2]]$name
[1] 75141

[[2]]$interactors
[1] 4087 4088 4089 7046

90

658 57154 64750

[[3]]
[[3]]$name
[1] 19376

[[3]]$interactors
[1] 4087 4089 7046

[[4]]
[[4]]$name
[1] 69159

[[4]]$interactors
[1] 4087 7046

90 658

[[5]]
[[5]]$name
[1] 72433

[[5]]$interactors
[1] 4087 4088 4089 7046

658

MouseBioGRIDInteractionOfficial

BioGRID interactions for Mouse (Mus musculus), official names ids
are used as identifiers

Description

This data set contains a list of interactions for Mouse (Mus musculus). The interactions are taken
from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, official names are
used.

Usage

data(MouseBioGRIDInteractionOfficial)

Format

The format is: A list containing the interactions. For each gene/protein, there is an entry in
the list with "name" containing name of the gene/protein and "interactors" containing the list of
genes/proteins interacting with it. example: List of 2354 $ :List of 2 ..$ name : chr "SMAD2" ..$
interactors: chr [1:28] "Rasd2" "Rab34" "Rhebl1" "Rab38" ...

MouseBioGRIDInteractionOfficial

25

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(MouseBioGRIDInteractionOfficial)
> MouseBioGRIDInteractionOfficial[1:5]

[[1]]
[[1]]$name
[1] "SMAD2"

[[1]]$interactors

[1] "Rasd2"
[8] "Fbxo3"

[15] "Rgs3"
[22] "Arhgef1" "Cdc40"

"Rhebl1"
"Rab34"
"Sqstm1" "Ppp2r2d" "Map2k3"
"Trim35"
"Lhx9"
"Irak2"

"Wwp2"
"Lmo2"

"Rab38"

"Rhobtb1" "Arhgef7" "Rps27a"
"Uhmk1"
"Nuak2"
"Rhod"
"Rhoj"
"Smad3"
"Smad2"

"Arhgef6"
"Arl4d"
"Sip1"

[[2]]
[[2]]$name
[1] "Rasd2"

[[2]]$interactors
[1] "SMAD2" "SMAD3" "SMAD4"

"TGFBR1" "ACVR1"

"BMPR1B" "SMURF1" "SMURF2"

[[3]]
[[3]]$name
[1] "Rab34"

[[3]]$interactors
[1] "SMAD2" "SMAD4" "TGFBR1"

[[4]]
[[4]]$name
[1] "Rhebl1"

[[4]]$interactors
[1] "SMAD2" "TGFBR1" "ACVR1"

"BMPR1B"

[[5]]
[[5]]$name
[1] "Rab38"

26

MouseBioGRIDInteractionUniqueId

[[5]]$interactors
[1] "SMAD2" "SMAD3" "SMAD4"

"TGFBR1" "BMPR1B"

MouseBioGRIDInteractionUniqueId

BioGRID interactions for Mouse (Mus musculus), unique ids (system-
atic names) are used as identifiers

Description

This data set contains a list of interactions for Mouse (Mus musculus). The interactions are taken
from BioGRID version 3.1.72, January 2011 release. For gene/protein entries, Entrez ids are used.

Usage

data(MouseBioGRIDInteractionUniqueId)

Format

The format is: A list containing the interactions. For each gene/protein, there is an entry in
the list with "name" containing name of the gene/protein and "interactors" containing the list of
genes/proteins interacting with it. example:

List of 648 $ :List of 2 ..$ name : chr "-" ..$ interactors: chr "-"

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(MouseBioGRIDInteractionUniqueId)
> MouseBioGRIDInteractionUniqueId[1:5]

[[1]]
[[1]]$name
[1] "-"

[[1]]$interactors
[1] "-"

[[2]]
[[2]]$name
[1] "-"

[[2]]$interactors
[1] "-"

S.PombeBioGRIDInteractionEntrezId

27

[[3]]
[[3]]$name
[1] "RP11-96L7.1"

[[3]]$interactors

"RP23-382C19.6" "RP23-465A12.1" "RP24-196O13.1"

[1] "RP23-31C9.4"
[5] "RP23-271L22.3" "RP24-189G18.2" "RP23-145E1.5"
[9] "RP23-47P18.14" "RP23-42H18.3"
[13] "RP23-467E19.1" "RP23-450P9.2"
[17] "RP23-185A18.1" "RP23-457P12.1" "RP23-273O7.1"
[21] "RP23-211K16.1" "RP23-372E6.1"
[25] "RP23-125A1.5" "RP23-419G21.5" "RP23-407I21.7" "RP23-25D18.1"
[29] "RP23-185A18.5" "RP23-234K24.1" "RP23-92B18.5"
"RP23-38K18.3"
[33] "RP23-220K22.2" "RP23-261L3.4"

"RP23-27I6.6"
"RP23-358G23.4" "RP23-19I2.1"
"RP23-378G22.2" "RP23-209C6.3"
"RP23-348N2.1"

"RP23-446O17.1" "RP23-319B15.1"

"MNCb-2778"

[[4]]
[[4]]$name
[1] "RP23-31C9.4"

[[4]]$interactors
[1] "RP11-96L7.1"

[[5]]
[[5]]$name
[1] "RP23-382C19.6"

[[5]]$interactors
[1] "RP11-96L7.1"

S.PombeBioGRIDInteractionEntrezId

BioGRID interactions for fission yeast (Schizosaccharomyces pombe),
entrez ids are used as identifiers

Description

This data set contains a list of interactions for fission yeast (Schizosaccharomyces pombe). The
interactions are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries,
Entrez ids are used.

Usage

data(S.PombeBioGRIDInteractionEntrezId)

28

Format

S.PombeBioGRIDInteractionEntrezId

The format is: A list containing the interactions. For each gene/protein, there is an entry in
the list with "name" containing name of the gene/protein and "interactors" containing the list of
genes/proteins interacting with it. example: List of 2110 $ :List of 2 ..$ name : int 2539495 ..$
interactors: int [1:10] 2541652 2542008 2539252 2541055 2542677 2543539 2541652 2540024
2539649 2542008

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(S.PombeBioGRIDInteractionEntrezId)
> S.PombeBioGRIDInteractionEntrezId[1:5]

[[1]]
[[1]]$name
[1] 2539495

[[1]]$interactors
[1] 2541652 2542008 2539252 2541055 2542677 2543539 2540024 2539649

[[2]]
[[2]]$name
[1] 2541652

[[2]]$interactors

[1] 2539495 2539442 2543239 2541818 2542151 2540329 2542677 2542200 2542632
[10] 2539123 2538951 2540810 2542861 2540258 2539869 2540363 2542804 2540283
[19] 2539572 2542140 3361487 2541982 2541293 2542972 2539027 2541055 2541209
[28] 2542558 2541372 2539781 2541867 2539244 2540473

[[3]]
[[3]]$name
[1] 2540719

[[3]]$interactors

[1] 2543289 2539087 2538959 2541512 2539686 2542266 2542313 2539527 2543204
[10] 3361533 2541051 2540345 2540627 2540255 2542374 2543580 2543281 2542757
[19] 2543222 2539090 2539209 2541643 2541746 2543544 2542558 2541159 2540630
[28] 2539838 2543387 2540917 2540470 2541165 2540633 2542824 2539933 2540020
[37] 2542150 2541194 2539881 2540589 2539285 2543685 2541620 2540719 2543240
[46] 2540992 2543639 2539164 2539737 2540234 2542366 2543577 2540352 2540244
[55] 2540348 2540911 2541120 2541209 2541270 3361323 2541580 2542007 2542207
[64] 2542967 2543164 2543436 2541849 2541088 3361306 2540601 2538775 2538706

S.PombeBioGRIDInteractionOfficial

29

[73] 2542226 2541604

[[4]]
[[4]]$name
[1] 2543289

[[4]]$interactors

[1] 2540719 2543629 2542083 2540255 2539627 2541849 2543164 2539527 2543204
[10] 2542374 2543580 2543281 2539090 2539209 2542757 2541746 2542313 2543387
[19] 2540627 2543240 2538959 2540470 2539933 2540020 2539881 2542029 2541536
[28] 2541628 2541580 2542207 2542558 2541941 2542007 2541656 2543510 2543452
[37] 2543577 2543319 2542198 2543668 2543372 2540023 2539613 2539911 2539960
[46] 2540115 2539714 2540352 2540436 2540348 2540353 3361323 2540945 2541101
[55] 2541088 2541120 2540735 2541135 2541270 2541251 2538930 2538913 2539375
[64] 2539497 2542023 2541834 2540244 2539130 2538926 2541512 2542677 2543078
[73] 2540887 2540911 2543436 2539041 2540582 2540589 2539087 2540728

[[5]]
[[5]]$name
[1] 2539087

[[5]]$interactors

[1] 2540719 2540470 2542266 2538959 2542029 2543666 2541643 2540992 2543281
[10] 2541512 2539686 2543240 2539527 2543606 2540627 2539869 2539123 2540255
[19] 2539090 2542313 2540032 2541849 2542558 2539164 2542083 2541695 2542632
[28] 2543323 2540630 2540620 2542749 2539004 2541620 2540917 2541710 2542824
[37] 2541165 2539933 2540020 2542150 2541194 2540728 3361323 2539285 2542844
[46] 2542252 2538689 2541159 2540013 2543407 2539627 2542366 2540352 2541120
[55] 2542007 2542207 2542967 2543436 2542196 2539402 2539208 2542503 2542542
[64] 2541270 2542226 2539499 2539641 2543237 2541265 2543289 2539087 2539894
[73] 2538775 2542703

S.PombeBioGRIDInteractionOfficial

BioGRID interactions for fission yeast (Schizosaccharomyces pombe),
official names are used as identifiers

Description

This data set contains a list of interactions for fission yeast (Schizosaccharomyces pombe). The
interactions are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries,
official names are used.

Usage

data(S.PombeBioGRIDInteractionOfficial)

30

Format

S.PombeBioGRIDInteractionOfficial

The format is: A list containing the interactions. For each gene/protein, there is an entry in
the list with "name" containing name of the gene/protein and "interactors" containing the list of
genes/proteins interacting with it. example: List of 2110 $ :List of 2 ..$ name : chr "ptc1" ..$
interactors: chr [1:10] "sty1" "ptc3" "ptc2" "wis1" ...

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(S.PombeBioGRIDInteractionOfficial)
> S.PombeBioGRIDInteractionOfficial[1:5]

[[1]]
[[1]]$name
[1] "ptc1"

[[1]]$interactors
[1] "sty1" "ptc3" "ptc2"

"wis1"

"pyp1"

"hsp90" "ppb1"

"pck2"

[[2]]
[[2]]$name
[1] "sty1"

[[2]]$interactors

[1] "ptc1"
[6] "atf1"
[11] "ssp1"
[16] "atf21"
[21] "crm1"
[26] "wis1"
[31] "sck2"

[[3]]
[[3]]$name
[1] "rad3"

"cut1"
"pyp1"
"cyr1"
"hal4"
"cmk2"
"mcs4"
"asp1"

"sod2"
"pyp2"
"msa1"
"leu1"
"cdc37"
"rad1"
"tor1"

"csx1"
"pub1"
"wee1"
"cdc25"
"cdc2"
"ste11"
"pap1"
"tpx1"
"sin1"
"srk1"
"SPBP8B7.28c" "pka1"

[[3]]$interactors

"nse6"
[1] "rad26" "chk1" "cds1"
"cdc20" "cdc6"
[10] "meu13" "rad13" "uve1"
"rad17" "hus1"
[19] "slp1" "pku70" "tel1"
"hsk1"
"orc1"
[28] "cdc23" "mcl1" "skp1"
"sap1"
[37] "rec12" "psf2" "top3"
"mad2"
"cdc10" "hst4"
[46] "crb2" "tel2" "cdc21" "nrm1"

"pof3" "cid13"
"rhp18" "cdc45" "taz1"
"rhp51" "rad4" "rad32"
"cdt2"
"orc2"
"rad1"
"mcm7"
"rad9"
"spp2" "pcn1"
"hob1"
"srw1"
"rad3" "mrc1"
"rhp55" "rqh1"
"csn1" "fbh1"
"srs2"

S.PombeBioGRIDInteractionOfficial

31

[55] "exo1" "nse5" "rhp14" "mcs4"
[64] "rhp41" "rad2" "tlg2"
[73] "hta2" "mek1"

"cdc17" "pob3"

"ctf18" "swi3"
"nbs1"

"pli1"
"trt1"

"rhp57" "ddb1"
"ctp1"
"ssb3"

[[4]]
[[4]]$name
[1] "rad26"

[[4]]$interactors

[1] "rad3"
[5] "cdc27"
[9] "cid13"
[13] "pku70"
[17] "taz1"
[21] "cds1"
[25] "top3"
[29] "pli1"
[33] "rhp57"
[37] "srs2"
[41] "ase1"
[45] "pho2"
[49] "ngg1"
[53] "rtt109"
[57] "tas3"
[61] "dcr1"
[65] "ufd2"
[69] "SPCC306.07c"
[73] "swi10"
[77] "nda3"

[[5]]
[[5]]$name
[1] "chk1"

[[5]]$interactors

"pol1"
"cdc17"
"cdt2"
"tel1"
"mcl1"
"orc1"
"rad24"
"ddb1"
"pcf3"
"trm10"
"SPBC11C11.10"
"rap1"
"exo1"
"ptn1"
"SPBC839.03c"
"ccr4"
"gda1"
"nse6"
"nse5"
"mad2"

"cdc1"
"cdc6"
"rad2"
"pof3"
"rhp51"
"rad4"
"rad32"
"hus1"
"cdc20"
"mrc1"
"spp2"
"pcn1"
"SPAC1071.02"
"pds5"
"rad1"
"tfs1"
"nth1"
"ssu72"
"mfh1"
"rdp1"
"SPBC11C11.11c" "amo1"
"csn1"
"SPBC1861.07"
"swi3"
"SPBC2F12.12c"
"rhp14"
"pob3"
"SPBC947.10"
"ctf18"
"alp14"
"mug154"
"SPCC1919.03c"
"fbh1"
"dcc1"
"pyp1"
"caf1"
"tlg2"
"swi1"
"chk1"

[1] "rad3"
[6] "cdr1"
[11] "rhp18"
[16] "cdc2"
[21] "top1"
[26] "cdc22"
[31] "rhp54"
[36] "srw1"
[41] "psf2"
[46] "rad25"
[51] "cdc27"
[56] "ddb1"
[61] "cek1"
[66] "hta1"
[71] "chk1"

"orc1"
"rad17"
"mrc1"
"wee1"
"cdc17"
"cdc25"
"mus81"
"hsk1"
"swi1"
"sum3"
"hst4"
"rhp41"
"dcp2"
"cut2"
"rid1"

"cdc45"
"crb2"
"pof3"
"cdc6"
"rad1"
"spp1"
"rqh1"
"spp2"
"swi3"
"orc2"
"csn1"
"tlg2"
"rfp1"
"mus7"
"ssb3"

"cds1"
"rad4"
"rad31"
"pku70"
"cdc21"
"mcm7"
"skp1"
"pcn1"
"sap1"
"cdc18"
"rhp14"
"hus5"
"ctf18"
"tra1"
"pot1"

"rad24"
"nse6"
"cdc20"
"taz1"
"cdc1"
"mcm2"
"msc1"
"rec12"
"crb3"
"cdc24"
"rhp57"
"SPCC613.03"
"hta2"
"rad26"

32

S.PombeBioGRIDInteractionUniqueId

S.PombeBioGRIDInteractionUniqueId

BioGRID interactions for fission yeast (Schizosaccharomyces pombe),
unique ids (systematic names) are used as identifiers

Description

This data set contains a list of interactions for fission yeast (Schizosaccharomyces pombe). The
interactions are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries,
unique ids (systematic names) are used.

Usage

data(S.PombeBioGRIDInteractionUniqueId)

Format

The format is: A list containing the interactions. For each gene/protein, there is an entry in
the list with "name" containing name of the gene/protein and "interactors" containing the list of
genes/proteins interacting with it. example: List of 2097 $ :List of 2 ..$ name : chr "SPCC4F11.02"
..$ interactors: chr [1:10] "SPAC24B11.06c" "SPAC2G11.07c" "SPCC1223.11" "SPBC409.07c" ...

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(S.PombeBioGRIDInteractionUniqueId)
> S.PombeBioGRIDInteractionUniqueId[1:5]

[[1]]
[[1]]$name
[1] "SPCC4F11.02"

[[1]]$interactors
[1] "SPAC24B11.06c" "SPAC2G11.07c"
[5] "SPAC26F1.10c" "SPAC926.04c"

"SPCC1223.11"
"SPBP4H10.04"

"SPBC409.07c"
"SPBC12D12.04c"

[[2]]
[[2]]$name
[1] "SPAC24B11.06c"

[[2]]$interactors

[1] "SPCC4F11.02"
[5] "SPAC17A2.09c" "SPBC29B5.01"

"SPCC5E4.04"

"SPAC977.10"
"SPAC26F1.10c"

"SPAC11G7.02"
"SPAC19D5.01"

S.PombeBioGRIDInteractionUniqueId

33

[9] "SPAC24H6.05"

"SPCC18B5.03"

[13] "SPAC13G7.13c" "SPBC32C12.02"
[17] "SPAC29A4.16"
[21] "SPAC1805.17"
[25] "SPCC1322.08"
[29] "SPBP8B7.28c"
[33] "SPBC30D10.10c"

"SPBC1A4.02c"
"SPAC23A1.06c"
"SPBC409.07c"
"SPBC106.10"

"SPCC297.03"
"SPBC11B10.09"
"SPCC576.03c"
"SPBC9B6.10"
"SPBC887.10"
"SPAC22E12.14c" "SPCC1672.06c"

"SPBC19C7.03"
"SPBC2F12.09c"
"SPAC1783.07c"
"SPAPYUG7.02c"
"SPAC1952.07"

[[3]]
[[3]]$name
[1] "SPBC216.05"

[[3]]$interactors
[1] "SPAC9E9.08"
[5] "SPBC1734.06"
[9] "SPAC821.04c"

"SPCC1259.13"
"SPAC17D4.02"
"SPAC222.15"
[13] "SPBC25H2.13c" "SPBC336.04"
[17] "SPAC23C4.18c" "SPAC13C5.07"
[21] "SPCC23B6.03c" "SPAC14C4.13"
[25] "SPAC1952.07"
"SPBC685.09"
[29] "SPAPB1E7.02c" "SPBC409.05"
[33] "SPBC21D10.12" "SPAC144.13c"
"SPBC725.13c"
[37] "SPAC17A5.11"
[41] "SPCC1672.02c" "SPAC3C7.03c"
[45] "SPAC694.06c"
[49] "SPBC16A3.07c" "SPBC336.12c"
[53] "SPBC215.03c"
[57] "SPBC649.03"
[61] "SPAC1687.05"
[65] "SPAC3G6.06c"
[69] "SPBC6B1.09c"
[73] "SPAC19G12.06c" "SPAC14C4.03"

"SPBC336.01"
"SPBC887.10"
"SPAC20H4.07"
"SPAC823.05c"
"SPBC29A3.14c"

"SPBC342.05"

"SPAC11E3.08c"

"SPCC18B5.11c"
"SPAC16A10.07c" "SPCC338.16"
"SPBC3E7.08c"
"SPBC19C7.09c"
"SPAC17H9.19c"
"SPAC644.14c"
"SPAC821.08c"
"SPCC126.02c"
"SPAC664.07c"
"SPAC20G4.04c"
"SPBC25D12.03c" "SPBC1347.10"
"SPBC776.12c"
"SPBC29A10.15"
"SPBC16D10.09"
"SPBC17D11.06"
"SPBC20F10.06"
"SPBC16G5.12c"
"SPBC216.05"
"SPAC2G11.12"
"SPCC16A11.17"
"SPAC458.03"
"SPAC4H3.05"
"SPAC1783.04c"
"SPBC651.10"
"SPBC29A10.05"
"SPBC30D10.04"
"SPBC902.02c"
"SPAC12B10.12c"
"SPAC17H9.10c"
"SPBC609.05"
"SPAC20G8.01"
"SPCC338.08"
"SPCC23B6.05c"

[[4]]
[[4]]$name
[1] "SPAC9E9.08"

[[4]]$interactors
"SPAC3H5.06c"
[1] "SPBC216.05"
[5] "SPBC1734.02c" "SPAC20G8.01"
"SPAC17H9.19c"
[9] "SPAC821.04c"
[13] "SPCC126.02c"
"SPCC23B6.03c"
[17] "SPAC16A10.07c" "SPAPB1E7.02c"
[21] "SPCC18B5.11c" "SPBC29A10.15"
[25] "SPBC16G5.12c" "SPAC8E11.02c"
"SPAC17H9.10c"
[29] "SPAC1687.05"
"SPAC25H1.06"
[33] "SPAC20H4.07"
[37] "SPAC4H3.05"
"SPAC6B12.09"
[41] "SPAPB1A10.09" "SPBC11C11.10"
[45] "SPBC15D4.15"

"SPBC1778.02"

"SPAC27E2.05"
"SPAC3G6.06c"
"SPAC644.14c"
"SPAC13C5.07"
"SPBC25H2.13c"
"SPBC17D11.06"
"SPAC1071.02"
"SPAC1952.07"
"SPAC30D11.07"
"SPAC6F12.09"
"SPBC11C11.11c" "SPBC15D4.10c"
"SPBC1861.07"

"SPBC336.04"
"SPCC338.16"
"SPAC23C4.18c"
"SPAC20G4.04c"
"SPAC694.06c"
"SPBC16D10.09"
"SPAC110.02"
"SPAC20H4.03c"
"SPAC3G9.04"
"SPAC9.05"

"SPBC215.03c"

34

YeastBioGRIDInteractionEntrezId

[49] "SPBC28F2.10c" "SPBC29A10.05"
[53] "SPBC342.06c"
[57] "SPBC83.03c"
[61] "SPCC188.13c"
[65] "SPAC20H4.10"
[69] "SPCC306.07c"
[73] "SPBC4F6.15c"
[77] "SPBC26H8.07c" "SPBC20F10.06"

"SPBC609.02"
"SPBC839.03c"
"SPCC31H12.08c" "SPCC4G3.11"
"SPBC336.01"
"SPAC824.08"
"SPAC26F1.10c"
"SPAC11E3.08c"
"SPAC823.05c"
"SPBC651.10"
"SPCC1259.13"

"SPBC2F12.12c"
"SPBC609.05"
"SPBC902.02c"

"SPBC30D10.04"
"SPBC649.03"
"SPBC947.10"
"SPCC895.07"
"SPCC1919.03c"
"SPAC31A2.15c"
"SPCC18.06c"
"SPBC216.06c"

[[5]]
[[5]]$name
[1] "SPCC1259.13"

[[5]]$interactors
[1] "SPBC216.05"
[5] "SPAC8E11.02c" "SPAC644.06c"
[9] "SPAC23C4.18c" "SPAC11E3.08c"

"SPBC29A10.15"

"SPAC1F7.05"

"SPAC4C5.04"
"SPBC336.04"

[13] "SPCC338.16"
[17] "SPCC18B5.03"
[21] "SPBC1703.14c" "SPAC20G8.01"
[25] "SPAC27E2.05"
[29] "SPBC25D12.03c" "SPBC4.04c"
[33] "SPAC2G11.12"
[37] "SPBC776.12c"
[41] "SPBC725.13c"
[45] "SPAC13G7.08c" "SPAC17A2.13c"
[49] "SPBC14C8.07c" "SPAC8F11.07c"
[53] "SPBC215.03c"
[57] "SPAC12B10.12c" "SPAC823.05c"
[61] "SPCC1450.11c" "SPAC19A8.12"
[65] "SPAC19G12.06c" "SPCC622.08c"
[69] "SPBP16F5.03c" "SPAC9E9.08"
[73] "SPCC23B6.05c" "SPAC26H5.06"

"SPBC409.05"
"SPBC17D11.06"
"SPBC216.06c"

"SPBC649.03"

"SPCC18B5.11c"
"SPBC342.05"
"SPAC694.06c"
"SPBC11B10.09"
"SPAC16A10.07c"
"SPCC16A11.17"
"SPAC6B12.10c"

"SPAC17D4.02"
"SPAC14C4.13"
"SPBC1734.06"
"SPBC25H2.13c"
"SPCC126.02c"
"SPAC1952.07"
"SPAC24H6.05"
"SPAC15A10.03c" "SPCC4G3.05c"
"SPAC144.13c"
"SPAC343.11c"
"SPAC17A5.11"
"SPBC16D10.09"
"SPCC1672.02c"
"SPBC30D10.04"
"SPBC685.09"
"SPCC1795.11"
"SPAC1783.04c"
"SPBC1734.02c"
"SPAC17H9.10c"
"SPAC20H4.07"
"SPCC613.03"
"SPAC30D11.13"
"SPBC902.02c"
"SPAC19A8.10"
"SPAC6B12.02c"
"SPBC14C8.01c"
"SPBC1709.12"
"SPCC1259.13"

YeastBioGRIDInteractionEntrezId

BioGRID interactions for budding yeast (Saccharomyces cerevisiae),
entrez ids are used as identifiers

Description

This data set contains a list of interactions for budding yeast (Saccharomyces cerevisiae). The
interactions are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries,
Entrez ids are used.

Usage

data(YeastBioGRIDInteractionEntrezId)

YeastBioGRIDInteractionEntrezId

35

Format

The format is: A list containing the interactions. For each gene/protein, there is an entry in
the list with "name" containing name of the gene/protein and "interactors" containing the list of
genes/proteins interacting with it. example: List of 6049 $ :List of 2 ..$ name : int 850504 ..$ inter-
actors: int [1:887] 852545 853814 856220 853086 850749 853986 856848 851407 856518 854317
...

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(YeastBioGRIDInteractionEntrezId)
> YeastBioGRIDInteractionEntrezId[1:5]

[[1]]
[[1]]$name
[1] 850504

[[1]]$interactors

[1] 852545 853814 856220 853086 850749 853986 856848 851407 856518 854317
[11] 856918 852261 855083 851447 851403 852100 851770 855499 855180 853112
[21] 856522 853348 851797 853452 852611 850520 854913 854418 856418 851204
[31] 851562 850893 855584 850676 851934 855974 852532 854966 855834 853364
[41] 852728 856490 855136 850504 855117 851029 855450 851996 855765 854353
[51] 854289 850423 851051 854504 854150 855616 852885 855841 855478 851707
[61] 852971 855728 850346 856702 854549 851771 851148 851376 852122 850450
[71] 852499 856862 851372 854668 855506 855836 856584 855302 855645 850320
[81] 851798 856899 856425 851997 854079 850400 851644 853668 852095 851737
[91] 856050 851891 851087 856249 855454 850367 854200 854822 854777 855048
[101] 855503 850534 855094 855665 855449 850980 853144 851752 852577 854042
[111] 856557 851048 852782 850863 853155 855238 851788 856481 853318 850973
[121] 854694 851984 850711 856463 851191 850897 851731 855473 852969 852028
[131] 852392 855922 855428 852864 854204 850440 852222 852557 850728 856061
[141] 850966 851832 856191 851967 852713 853301 853136 852053 855217 855515
[151] 853568 852406 852547 856696 852772 853862 850741 854309 856301 851412
[161] 853638 852424 850782 852427 852415 856924 851676 853728 851962 855613
[171] 855586 851217 852418 850456 851441 851336 851776 851844 852810 852804
[181] 853178 856409 854713 853260 853226 853743 853870 850706 851002 854992
[191] 854902 855589 855552 855496 855788 854035 854509 856186 851212 852265
[201] 852191 852332 852461 852477 850349 850427 851484 851478 851421 851419
[211] 851339 851596 851612 851618 851672 851904 851905 851921 852064 856686
[221] 856739 856759 856860 856921 852822 852931 852977 852984 853065 856382
[231] 856375 856435 856614 854762 854756 854706 854652 853279 853250 853544
[241] 853864 853811 853782 853957 853970 850712 850763 850811 850898 850923
[251] 851084 851085 854980 855173 855226 855483 855475 855466 854179 854232
[261] 854470 856040 856156 856158 856204 851220 851250 852254 852341 852370

36

YeastBioGRIDInteractionEntrezId

[271] 852431 852518 852582 850360 851558 851491 851442 851591 851625 851646
[281] 851722 851887 852050 852130 856715 856689 856659 856892 850593 852848
[291] 852799 852774 852768 852716 852675 852644 852903 852980 853030 853077
[301] 853170 856404 856458 856512 856552 856576 854812 854804 854773 854686
[311] 854672 854647 853366 853303 853217 853491 853566 853868 853825 850684
[321] 850776 850840 850933 851135 854879 855086 855088 855101 855122 855169
[331] 855364 855727 855569 855557 855529 855462 855772 855773 854142 854099
[341] 854208 854370 854420 854460 854505 854542 856105 856103 855954 855903
[351] 855844 856134 856148 856227 855224 852869 850998 855532 854481 853202
[361] 851768 853438 854456 856422 856607 850554 854284 851318 852755 396422
[371] 851244 851213 852303 852405 852469 850441 851494 851542 851706 851764
[381] 851831 851869 851929 851935 852837 852882 852968 853020 853110 856358
[391] 856364 856399 854718 854725 854771 854818 853276 853281 853350 853538
[401] 853581 853636 853732 853763 853836 853890 853916 850683 850654 850768
[411] 850800 850887 854915 854949 855085 855096 855154 855186 855634 855644
[421] 855647 855710 854195 854391 854449 854531 855835 856071 856309 852563
[431] 851978 852023 856867 856908 852708 856583 854819 853322 853433 853471
[441] 853721 850810 850999 851086 851088 851130 855143 855575 854086 854087
[451] 854294 856016 856019 856188 856212 852444 852519 852035 852099 852136
[461] 856796 856802 856835 856873 856903 856923 853209 851209 852348 852377
[471] 852459 851423 851454 851727 856895 852661 852826 852870 853196 856511
[481] 856514 856556 854809 853280 853966 850639 850658 850778 850843 851042
[491] 851055 851100 851126 854939 854953 855003 855126 855254 855568 855581
[501] 855603 855787 854159 854361 855875 855964 856051 856276 852229 852276
[511] 850451 851378 851758 851950 856909 852609 852702 852796 852839 853026
[521] 853031 856445 853313 850745 851164 854871 855264 855345 855360 855639
[531] 855656 854066 854247 854371 854383 854500 856037 856135 856170 856173
[541] 856210 856293 851223 851259 851289 852368 852436 852454 851452 851704
[551] 851834 852002 856827 852659 852670 852854 852861 852972 852993 852997
[561] 853089 856415 856530 856545 853305 853347 853375 853502 853583 853818
[571] 853876 853920 853928 853929 850668 850677 850752 851132 855012 855339
[581] 855709 854153 854252 854261 854280 854300 854443 855917 855919 855920
[591] 855929 855958 856081 856123 856128 853783 851263 851334 856547 854664
[601] 853587 856311 851520 850633 851635 851115 855565 854937 850620

[[2]]
[[2]]$name
[1] 852545

[[2]]$interactors

[1] 850504 856425 852515 855346 854322 854856 853568 850777 853423 855355

[11] 855644 854090 853061 854076 852403 854900

[[3]]
[[3]]$name
[1] 853814

[[3]]$interactors

[1] 850504 853958 855101 851782 851579 853010 852819 853674 854984 853909
[11] 851919 853719 853041 854662 852787 855625 854542 854778 853817 856648

YeastBioGRIDInteractionOfficial

37

[21] 852794 855892 851708

[[4]]
[[4]]$name
[1] 856220

[[4]]$interactors

[1] 850504 855450 852724 853017 852732 856457 851025 855219 854335 854904
[11] 856901 850713 855676 852649 852879 851770 850505 855687 856321 855830
[21] 850998 854123 855512 851369 852709 856909

[[5]]
[[5]]$name
[1] 853086

[[5]]$interactors

[1] 850504 855450 851748 855405 856767 852329 856398 855449 856413 855224
[11] 856195 853529 852874 856478 855836 850620 852951 855441 852883 850790
[21] 855242 850745 855029 852872 856418 850554 850521 851659 853207

YeastBioGRIDInteractionOfficial

BioGRID interactions for budding yeast (Saccharomyces cerevisiae),
official names are used as identifiers

Description

This data set contains a list of interactions for budding yeast (Saccharomyces cerevisiae). The
interactions are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries,
Entrez ids are used.

Usage

data(YeastBioGRIDInteractionOfficial)

Format

The format is: A list containing the interactions. For each gene/protein, there is an entry in
the list with "name" containing name of the gene/protein and "interactors" containing the list of
genes/proteins interacting with it. example: List of 6032 $ :List of 2 ..$ name : chr "ACT1" ..$
interactors: chr [1:887] "ALG7" "ASK1" "COG4" "ERG1" ...

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

38

Examples

> data(YeastBioGRIDInteractionOfficial)
> YeastBioGRIDInteractionOfficial[1:5]

YeastBioGRIDInteractionOfficial

[[1]]
[[1]]$name
[1] "ACT1"

[[1]]$interactors

[1] "ALG7"
[7] "LSM4"
[13] "RNA14"
[19] "SWP1"
[25] "DOC1"
[31] "NHP10"
[37] "SWC5"
[43] "MYO5"
[49] "SSK2"
[55] "HTZ1"
[61] "TWF1"
[67] "CRN1"
[73] "GCS1"
[79] "TPM1"
[85] "MDM20"
[91] "SUR1"
[97] "SHE4"
[103] "ABF2"
[109] "CHK1"
[115] "PFK1"
[121] "HOS4"
[127] "ENT5"
[133] "CAF40"
[139] "RIC1"
[145] "RAD54"
[151] "SOD1"
[157] "IES3"
[163] "NYV1"
[169] "EAF1"
[175] "NUP84"
[181] "BUD32"
[187] "VPS1"
[193] "PSD1"
[199] "CCR4"
[205] "STP22"
[211] "PPH22"
[217] "SUM1"
[223] "YCK3"
[229] "RTS3"
[235] "YIL055C"
[241] "RPL14A"
[247] "BUD20"
[253] "TSA1"

"ASK1"
"NOP14"
"RRP42"
"YPP1"
"EPL1"
"PWP1"
"VPS71"
"ACT1"
"LAS17"
"YAF9"
"HRB1"
"DLD2"
"TPM2"
"SRO9"
"FEN1"
"SUR2"
"PAN1"
"ARP5"
"INO4"
"CIK1"
"LSM6"
"RPA49"
"GET1"
"ELC1"
"RPB4"
"CMD1"
"ARP8"
"SHE3"
"NOP15"
"RPL35A"
"YSC84"
"PSR2"
"CNM67"
"FUS3"
"BUD31"
"PST2"
"MRPL35"
"GRX4"
"STE20"
"XBP1"
"DEF1"
"YPS1"
"RPL13B"

"COG4"
"ORC6"
"SAS10"
"YHR122W"
"ERG13"
"SRV2"
"IQG1"
"AIP1"
"PFY1"
"SWC4"
"GBP2"
"SMT3"
"IES2"
"TCP1"
"IPT1"
"SUR4"
"CAP2"
"SEC2"
"SPO12"
"UME6"
"UBR2"
"PAC10"
"CKB2"
"YPT6"
"TOS2"
"ISW1"
"BSP1"
"TEF2"
"EAF7"
"REF2"
"PRK1"
"ATP14"
"POP2"
"RPL23A"
"RPL31A"
"YDR042C"
"TSA2"
"RAD6"
"PRS3"
"IMP2"
"VMA5"
"COQ9"
"MRPS17"

"ERG1"
"PNO1"
"SLD5"
"PHS1"
"ESA1"
"COF1"
"ARP4"
"BUD6"
"YIH1"
"RVB2"
"VAC8"
"ABP1"
"HSP82"
"BEM2"
"SAC1"
"NAT3"
"HOF1"
"MCM5"
"NUP2"
"LRP1"
"SSF1"
"RAD30"
"PAT1"
"MNN10"
"SSN2"
"EAF5"
"CCT4"
"BMH1"
"TPD3"
"RKM4"
"PFD1"
"PPZ1"
"YOL114C"
"TCM62"
"RPP1A"
"YDR049W"
"CUP5"
"KSS1"
"VMA10"
"FMP33"
"NUP133"
"BUR2"
"KEX2"

"FRS1"
"RAD3"
"SLY1"
"GCD6"
"MYO1"
"SWR1"
"INO80"
"BNI1"
"VRP1"
"SLA2"
"SCP1"
"BEM1"
"OYE2"
"SLT2"
"VPS52"
"PIK1"
"MGS1"
"SMI1"
"SRM1"
"LSM1"
"CLN3"
"RXT2"
"SHP1"
"OPY2"
"SPT21"
"MLC1"
"YKT6"
"BMH2"
"GRS1"
"RPB9"
"RCY1"
"RPL6A"
"VMA4"
"EXO5"
"PPH21"
"GRX3"
"ISC1"
"PIL1"
"SET5"
"RPL39"
"MLP1"
"SSQ1"
"VPS75"

"HRT1"
"RFT1"
"SSU72"
"CYR1"
"MYO4"
"TAF14"
"YNG2"
"RVS167"
"MYO2"
"SAC6"
"RVB1"
"RSP5"
"TIF11"
"SAC7"
"SAC3"
"RVS161"
"IES1"
"SUP35"
"SEC10"
"SEC22"
"YKE2"
"TCO89"
"MTC4"
"SEM1"
"RTT106"
"CAP1"
"VMA2"
"SHE2"
"CDC50"
"RPL7A"
"SBA1"
"FYV6"
"NOT5"
"FZO1"
"RPL35B"
"GIC2"
"PHM8"
"DBF2"
"DFG10"
"EAF6"
"SNF7"
"ARC18"
"GIS2"

YeastBioGRIDInteractionOfficial

39

[259] "RTS1"
[265] "YPR089W"
[271] "HSL7"
[277] "IWR1"
[283] "DOT1"
[289] "QCR6"
[295] "EMP24"
[301] "COQ6"
[307] "EPS1"
[313] "PRY1"
[319] "VPS24"
[325] "GIM5"
[331] "DIA1"
[337] "MRPS12"
[343] "YOR246C"
[349] "ATG5"
[355] "HSC82"
[361] "CCT6"
[367] "RPT5"
[373] "MNN2"
[379] "MTC5"
[385] "RIM8"
[391] "SPO11"
[397] "YJL163C"
[403] "PGM1"
[409] "MMM1"
[415] "RIM9"
[421] "APJ1"
[427] "CIN2"
[433] "YER130C"
[439] "BBC1"
[445] "VID22"
[451] "RGA1"
[457] "PYC2"
[463] "UBP9"
[469] "MUM2"
[475] "UBP3"
[481] "BZZ1"
[487] "RTT109"
[493] "VIP1"
[499] "YCK2"
[505] "NEW1"
[511] "FIG2"
[517] "KEM1"
[523] "PBS2"
[529] "ELP6"
[535] "PTP2"
[541] "SYT1"
[547] "YBR139W"
[553] "IES5"
[559] "PCP1"
[565] "RPS21B"

"MSA1"
"DEP1"
"ATG12"
"VPS54"
"EUG1"
"MIG1"
"PDE1"
"ARD1"
"TIR3"
"TIF2"
"ATG10"
"AEP1"
"MRP7"
"RSM19"
"RDL2"
"RPL7B"
"YGL015C"
"CCT3"
"CWC2"
"AIM3"
"PLP1"
"ERP6"
"SOD2"
"HSP150"
"MTC2"
"SIC1"
"YMR074C"
"HDA1"
"PMA2"
"SPT2"
"TMA22"
"BER1"
"RLM1"
"SNX41"
"YER134C"
"TEC1"
"NCS6"
"MTC6"
"ALT1"
"RPS1B"
"AAH1"
"UME1"
"YDL176W"
"GUP1"
"ERG3"
"MKT1"
"LDB19"
"MMS1"
"ICS2"
"SKI8"
"VMA21"
"SAP185"

"UAF30"
"SPC72"
"PAF1"
"PST1"
"GIM4"
"YGL081W"
"VMA7"
"GIC1"
"NOT3"
"YJL213W"
"CSF1"
"SOV1"
"GIM3"
"TLG2"
"SNC2"
"SSO1"
"GCD7"
"PLP2"
"NAB2"
"SEC66"
"PEX5"
"PEX8"
"ICE2"
"BCK1"
"IXR1"
"CCW12"
"YMR124W"
"DFG16"
"HDA3"
"HUR1"
"CMC1"
"ASC1"
"ELP3"
"PAC11"
"YER158C"
"TOS1"
"ERV14"
"URM1"
"STM1"
"SUR7"
"NCS2"
"YPL056C"
"SDH4"
"DST1"
"ECM7"
"FKH2"
"YPL068C"
"MDM10"
"PHO2"
"KEX1"
"PBP1"
"YJL070C"

"VPS28"
"RPL19B"
"YCP4"
"TPS2"
"RIP1"
"VPS73"
"NNF2"
"YHR112C"
"QDR1"
"PET191"
"PEP3"
"VPS20"
"IBD2"
"THI20"
"PDE2"
"EAF3"
"SRP1"
"RPN1"
"VCL"
"PTC6"
"PMP3"
"YGR122W"
"SDS3"
"HOC1"
"VPS51"
"MMR1"
"RIM13"
"RUD3"
"RGD1"
"STB5"
"SRN2"
"LSM7"
"TKL1"
"AGE1"
"ECM32"
"YDL133W"
"PUF4"
"YJL160C"
"MID2"
"ERG6"
"BRE5"
"YPR153W"
"YPS7"
"YGR125W"
"CUE4"
"YOL087C"
"YME1"
"SSA1"
"SWF1"
"CGR1"
"RPS27B"
"VPS55"

"YPR045C"
"ECM33"
"CBS1"
"SSD1"
"PEA2"
"AIM14"
"CLC1"
"ATG7"
"BNR1"
"DID4"
"VPS36"
"CIN4"
"ATX1"
"SLK19"
"LSP1"
"DBF20"

"RPL43A"
"RFS1"
"PTC1"
"MKC7"
"VMA8"
"CUE3"
"SYF2"
"MRPL6"
"FLX1"
"VPS25"
"BNA5"
"MTG1"
"CHS1"
"WHI2"
"SNF8"
"VMA13"
"YOR304C-A" "ZUO1"
"RPN10"
"PEX22"
"PEX19"
"PEX3"
"FYV8"
"APQ12"
"STE24"
"UTH1"
"TUB3"
"RHO2"
"RIM20"
"VPS74"
"AIM21"
"SEC72"
"HST1"
"YPR097W"
"RRT13"
"MAL12"
"QRI7"
"SCW4"
"SRL3"
"FKS1"
"MUB1"
"PFA4"
"PIN4"
"RAD4"
"YGR130C"
"MRE11"
"DIA2"
"BRR1"
"FLO1"
"VHS1"
"PIB2"
"ARP1"
"JHD2"

"RPN11"
"ATS1"
"RPN4"
"MSN5"
"RIM101"
"MPH1"
"PEX1"
"FPS1"
"SPC2"
"EOS1"
"CIN1"
"ERD1"
"RPE1"
"ROM2"
"RTG1"
"RTC2"
"YER071C"
"LTE1"
"NUM1"
"UBA4"
"SPA2"
"IKI3"
"SCJ1"
"IES4"
"SLA1"
"YGL242C"
"FSH1"
"DYN3"
"LIP5"
"ARO7"
"ECM8"
"SHE9"
"SLX9"
"CHS7"
"ELM1"

40

YeastBioGRIDInteractionOfficial

[571] "MEH1"
[577] "YLR063W"
[583] "OST3"
[589] "RTT10"
[595] "DSS4"
[601] "RPS5"
[607] "YNL157W"

"PET10"
"PUN1"
"ARF3"
"CTI6"
"SMY1"
"SEC23"
"ORC1"

"DYN1"
"YPT7"
"AZF1"
"NIP100"
"NUP60"
"SIR2"
"UBI4"

"RHO4"
"JNM1"
"VPS17"
"KES1"
"NUS1"
"HSP104"

"YLL058W"
"YNL022C"
"PAC1"
"SKS1"
"RPC10"
"AIM7"

"LDB18"
"MDM12"
"MRN1"
"YPR013C"
"CCT2"
"BDF1"

[[2]]
[[2]]$name
[1] "ALG7"

[[2]]$interactors

[1] "ACT1" "SLT2" "SDS24" "ADE4"
[10] "GAS1" "EOS1" "MET22" "CHO2"

"RPB2"
"AVO1"

"GTT1"
"SOD1"
"PHO88" "HMG1"

"GAA1" "VPS53"

[[3]]
[[3]]$name
[1] "ASK1"

[[3]]$interactors

[1] "ACT1"
[9] "RPS17A" "SPC34" "DAD4"
"CSE4"

[17] "PDE2"

"DAD2"

"BCY1"

"VPS20"

"SPC19"
"HSK3"
"CIN8"

"DAD1"
"CBF2"
"MAD1"

"DAM1"
"TID3"
"IPL1"

"RPL17A"

"DUO1"
"SPC105" "RAS2"
"FIN1"

[[4]]
[[4]]$name
[1] "COG4"

[[4]]$interactors

[1] "ACT1"
"BNI1"
[8] "YMR181C" "GET4"
"SLY1"
"SSB2"

[15] "COG7"
[22] "SMC5"

[[5]]
[[5]]$name
[1] "ERG1"

[[5]]$interactors

"PEX14"
"COG8"
"YPT1"
"SSB1"

"COG2"
"COG3"
"COG6"
"PMR1"

"TIP20"
"SED5"
"QCR2"
"RAD4"

"VMA22"
"COG5"
"RBD2"

"NKP2"
"COG1"
"GCD7"

[1] "ACT1"
[8] "SEC2"
[15] "HSP82"
[22] "ERG3"
[29] "MAL11"

"SEC7"

"BNI1"
"YHR020W" "HSC82"
"ERG25"
"UBI4"
"ERG4"
"ERG5"

"YNL311C" "ERG28"
"TEF1"
"ERG24"
"MYO1"

"TOR1"
"ERG26"
"RPN11"

"ERG11"

"FAT1"
"YGL010W" "IRE1"
"ERG2"
"ERG27"
"SSS1"
"BUD27"

YeastBioGRIDInteractionUniqueId

41

YeastBioGRIDInteractionUniqueId

BioGRID interactions for budding yeast (Saccharomyces cerevisiae),
unique ids (systematic names) are used as identifiers

Description

This data set contains a list of interactions for budding yeast (Saccharomyces cerevisiae). The
interactions are taken from BioGRID version 3.1.72, January 2011 release. For gene/protein entries,
unique ids (systematic names) are used.

Usage

data(YeastBioGRIDInteractionUniqueId)

Format

The format is: A list containing the interactions. For each gene/protein, there is an entry in
the list with "name" containing name of the gene/protein and "interactors" containing the list of
genes/proteins interacting with it. example: List of 5931 $ :List of 2 ..$ name : chr "YFL039C" ..$
interactors: chr [1:887] "YBR243C" "YKL052C" "YPR105C" "YGR175C" ...

Source

http://thebiogrid.org/download.php

References

Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Reposi-
tory for Interaction Datasets. Nucleic Acids Res. Jan1; 34:D535-9

Examples

> data(YeastBioGRIDInteractionUniqueId)
> YeastBioGRIDInteractionUniqueId[1:5]

[[1]]
[[1]]$name
[1] "YFL039C"

[[1]]$interactors
[1] "YBR243C"
[7] "YER112W"
[13] "YMR061W"
[19] "YMR149W"
[25] "YGL240W"
[31] "YDL002C"
[37] "YBR231C"
[43] "YMR109W"
[49] "YNR031C"
[55] "YOL012C"
[61] "YGR080W"

"YKL052C"
"YDL148C"
"YDL111C"
"YGR198W"
"YFL024C"
"YLR196W"
"YML041C"
"YFL039C"
"YOR181W"
"YNL107W"
"YNL004W"

"YPR105C"
"YHR118C"
"YDL153C"
"YHR122W"
"YML126C"
"YNL138W"
"YPL242C"
"YMR092C"
"YOR122C"
"YGR002C"
"YCL011C"

"YGR175C"
"YOR145C"
"YDR489W"
"YJL097W"
"YOR244W"
"YLL050C"
"YJL081C"
"YLR319C"
"YCR059C"
"YPL235W"
"YEL013W"

"YLR060W"
"YER171W"
"YDR189W"
"YDR211W"
"YHR023W"
"YDR334W"
"YGL150C"
"YNL271C"
"YLR337C"
"YNL243W"
"YOR367W"

"YOL133W"
"YBL020W"
"YNL222W"
"YJL005W"
"YAL029C"
"YPL129W"
"YHR090C"
"YDR388W"
"YOR326W"
"YDR129C"
"YDR190C"

42

YeastBioGRIDInteractionUniqueId

[67] "YLR429W"
[73] "YDL226C"
[79] "YNL079C"
[85] "YOL076W"
[91] "YPL057C"
[97] "YOR035C"
[103] "YMR072W"
[109] "YBR274W"
[115] "YGR240C"
[121] "YIL112W"
[127] "YDR153C"
[133] "YNL288W"
[139] "YLR039C"
[145] "YGL163C"
[151] "YJR104C"
[157] "YLR052W"
[163] "YLR093C"
[169] "YDR359C"
[175] "YDL116W"
[181] "YGR262C"
[187] "YKR001C"
[193] "YNL169C"
[199] "YAL021C"
[205] "YCL008C"
[211] "YDL188C"
[217] "YDR310C"
[223] "YER123W"
[229] "YGR161C"
[235] "YIL055C"
[241] "YKL006W"
[247] "YLR074C"
[253] "YML028W"
[259] "YOR014W"
[265] "YPR089W"
[271] "YBR133C"
[277] "YDL115C"
[283] "YDR440W"
[289] "YFR033C"
[295] "YGL200C"
[301] "YGR255C"
[307] "YIL005W"
[313] "YJL079C"
[319] "YKL041W"
[325] "YML094W"
[331] "YMR316W"
[337] "YNR036C"
[343] "YOR246C"
[349] "YPL149W"
[355] "YMR186W"
[361] "YDR188W"
[367] "YOR117W"
[373] "YBR108W"

"YDL178W"
"YIL138C"
"YCL037C"
"YCR034W"
"YDR297W"
"YIR006C"
"YNL059C"
"YOL108C"
"YMR198W"
"YDR378C"
"YNL248C"
"YGL020C"
"YPL046C"
"YJL140W"
"YBR109C"
"YOR141C"
"YBR130C"
"YNL110C"
"YDL191W"
"YHR016C"
"YLR019W"
"YNL225C"
"YBL016W"
"YCR063W"
"YDR032C"
"YDR322W"
"YER174C"
"YHL007C"
"YIL101C"
"YKL054C"
"YLR120C"
"YMR142C"
"YOR066W"
"YAL013W"
"YBR217W"
"YDR027C"
"YDR518W"
"YGL035C"
"YGL248W"
"YHR013C"
"YIL011W"
"YJL138C"
"YLL042C"
"YMR064W"
"YNL005C"
"YNR037C"
"YOR286W"
"YPL198W"
"YGL015C"
"YJL014W"
"YDL209C"
"YBR171W"

"YDR510W"
"YNL215W"
"YDR212W"
"YDR072C"
"YLR372W"
"YIL034C"
"YNL272C"
"YHR152W"
"YDR207C"
"YLR024C"
"YGR078C"
"YOR039W"
"YLR262C"
"YGR221C"
"YBR245C"
"YPR171W"
"YBR118W"
"YNL136W"
"YDR195W"
"YIL095W"
"YLR295C"
"YNR052C"
"YBL087C"
"YDL075W"
"YDR042C"
"YDR453C"
"YGL058W"
"YHL011C"
"YIL154C"
"YKL080W"
"YLR201C"
"YMR188C"
"YOR295W"
"YAL047C"
"YBR279W"
"YDR055W"
"YEL003W"
"YGL081W"
"YGR020C"
"YHR061C"
"YIL038C"
"YJL213W"
"YLR087C"
"YMR066W"
"YNL153C"
"YOL018C"
"YOR327C"
"YPL232W"
"YLR291C"
"YOR281C"
"YGL122C"
"YCR079W"

"YER125W"
"YBR200W"
"YCR088W"
"YMR260C"
"YHR179W"
"YPL240C"
"YDR389W"
"YHR030C"
"YER155C"
"YDR159W"
"YDR484W"
"YKL212W"
"YCR009C"
"YNL267W"
"YPR131C"
"YFL013C"
"YNL218W"
"YMR032W"
"YDR172W"
"YGR229C"
"YLR274W"
"YLR166C"
"YGL097W"
"YLR335W"
"YLR268W"
"YJL124C"
"YHR081W"
"YLR200W"
"YAL040C"
"YHR066W"
"YPL180W"
"YBR095C"
"YDR419W"
"YBR255W"
"YBL058W"
"YCR077C"
"YDR363W-A"
"YPR075C"
"YDR245W"
"YNL206C"
"YMR179W"
"YDR443C"
"YKL007W"
"YGL106W"
"YEL018W"
"YBR127C"
"YKL196C"
"YDL143W"
"YKL130C"
"YDR099W"
"YER177W"
"YCR094W"
"YBR121C"
"YAL016W"
"YGL076C"
"YGL070C"
"YDR257C"
"YKL117W"
"YJL204C"
"YJL179W"
"YNL133C"
"YML073C"
"YML016C"
"YPR072W"
"YOR332W"
"YOL114C"
"YBR179C"
"YBR163W"
"YBR044C"
"YDL136W"
"YDL134C"
"YDL081C"
"YDR309C"
"YDR098C"
"YDR049W"
"YER037W"
"YER019W"
"YEL027W"
"YGR092W"
"YGR040W"
"YGR086C"
"YIL049W"
"YHR039C-A" "YHR207C"
"YJR082C"
"YJL189W"
"YJL161W"
"YLR025W"
"YKR095W"
"YKR082W"
"YLR370C"
"YLR369W"
"YLR226W"
"YNL255C"
"YNL246W"
"YNL238W"
"YPR045C"
"YPR043W"
"YPL065W"
"YBR078W"
"YBR052C"
"YBL027W"
"YDL069C"
"YDL006W"
"YCR004C"
"YDR293C"
"YDR144C"
"YDR074W"
"YER149C"
"YEL051W"
"YEL024W"
"YGL160W"
"YGL110C"
"YGL104C"
"YGR167W"
"YGR129W"
"YGR089W"
"YHR171W"
"YHR147C"
"YHR112C"
"YIL159W"
"YIL134W"
"YIL120W"
"YKL002W"
"YJR102C"
"YJR034W"
"YLR417W"
"YLR231C"
"YLR148W"
"YMR138W"
"YMR097C"
"YMR077C"
"YNL259C"
"YNL192W"
"YNL164C"
"YOR195W"
"YOR043W"
"YOL055C"
"YPL004C"
"YPL002C"
"YOR360C"
"YPR036W"
"YPR023C"
"YPR111W"
"YOR304C-A" "YGR285C"
"YNL189W"
"YFR004W"
"YHR200W"
"YHR027C"
"YBR015C"
"YAL020C"
"YAL055W"
"YDR128W"
"YDL020C"
"YDL065C"

YeastBioGRIDInteractionUniqueId

43

"YDR276C"
"YGR122W"
"YIL084C"
"YJR075W"
"YKR020W"
"YLR190W"
"YMR154C"
"YOR216C"
"YBR260C"
"YHR178W"
"YLR119W"
"YNL147W"
"YPR074C"
"YDR524C"
"YER176W"
"YDL133W"
"YGL014W"
"YJL160C"
"YLR332W"
"YML008C"
"YNR051C"
"YPR153W"
"YDR349C"
"YGR125W"
"YML101C"
"YOL087C"
"YPR024W"
"YAL005C"
"YDR126W"
"YGL029W"
"YHR021C"
"YJR044C"
"YKR055W"
"YMR294W"
"YOR132W"
"YPL145C"
"YDL193W"
"YLL026W"

"YDR335W"
"YDR329C"
"YHL027W"
"YGR196C"
"YIR002C"
"YIL040W"
"YKL197C"
"YJR117W"
"YLL043W"
"YKR042W"
"YML055W"
"YML124C"
"YNL080C"
"YNL090W"
"YOR349W"
"YOR275C"
"YDR414C"
"YDR372C"
"YJL121C"
"YIR003W"
"YLR371W"
"YLR292C"
"YOL067C"
"YOL068C"
"YBR147W"
"YPR097W"
"YER071C"
"YER066W"
"YAL024C"
"YGR292W"
"YDR150W"
"YDL104C"
"YHR111W"
"YGR279C"
"YLL021W"
"YKR091W"
"YLR384C"
"YLR342W"
"YMR214W"
"YMR100W"
"YOR189W"
"YOL003C"
"YBL007C"
"YBL051C"
"YGL242C"
"YER162C"
"YHR049W"
"YGR130C"
"YMR299C"
"YMR224C"
"YOR196C"
"YOR080W"
"YPR060C"
"YPR057W"
"YBR076W"
"YAR050W"
"YDR393W"
"YDR247W"
"YGR081C"
"YGL023C"
"YHR142W"
"YHR129C"
"YKL048C"
"YJR119C"
"YLL049W"
"YLL058W"
"YOL009C"
"YNL022C"
"YPL184C"
"YOR269W"
"YPL026C"
"YPR013C"
"YHR143W-A" "YIL142W"
"YLR399C"
"YDR063W"

"YGL045W"
"YHL022C"
"YJL163C"
"YKL127W"
"YLL006W"
"YMR063W"
"YNL077W"
"YPL241C"
"YER130C"
"YJL020C"
"YLR373C"
"YOR127W"
"YBR218C"
"YER098W"
"YBR057C"
"YER151C"
"YHR114W"
"YLL002W"
"YLR410W"
"YNL154C"
"YPL226W"
"YCR089W"
"YGL173C"
"YJL128C"
"YMR312W"
"YOR208W"
"YPR095C"
"YBR139W"
"YER092W"
"YGR101W"
"YJL136C"
"YKR007W"
"YLR063W"
"YOR085W"
"YPL183C"
"YPR017C"
"YJR123W"
"YNL157W"

"YDR244W"
"YGR077C"
"YIL090W"
"YJL095W"
"YKL032C"
"YLR110C"
"YMR124W"
"YOR030W"
"YPR179C"
"YGL168W"
"YKL137W"
"YMR116C"
"YPL086C"
"YDR488C"
"YER158C"
"YBR162C"
"YGL054C"
"YIL008W"
"YLR150W"
"YML052W"
"YNL119W"
"YPL056C"
"YDR178W"
"YGL043W"
"YLR443W"
"YNL068C"
"YPL068C"
"YAL010C"
"YDL106C"
"YGL203C"
"YGR178C"
"YJL070C"
"YKR054C"
"YML001W"
"YOR113W"
"YPL174C"
"YAR002W"
"YDL042C"
"YLL039C"

[379] "YDR183W"
[385] "YGL002W"
[391] "YHR008C"
[397] "YJL159W"
[403] "YKL098W"
[409] "YLR079W"
[415] "YMR074C"
[421] "YNL021W"
[427] "YPL036W"
[433] "YER161C"
[439] "YJR014W"
[445] "YLR412W"
[451] "YPL089C"
[457] "YDR425W"
[463] "YER134C"
[469] "YBR083W"
[475] "YGL211W"
[481] "YHR151C"
[487] "YLR089C"
[493] "YML063W"
[499] "YNL141W"
[505] "YPL139C"
[511] "YDL176W"
[517] "YGL084C"
[523] "YLR056W"
[529] "YNL085W"
[535] "YOR322C"
[541] "YPR164W"
[547] "YBR157C"
[553] "YGL213C"
[559] "YGR105W"
[565] "YJL098W"
[571] "YKR046C"
[577] "YLR414C"
[583] "YOR094W"
[589] "YPL181W"
[595] "YKL079W"
[601] "YPR181C"
[607] "YML065W"

[[2]]
[[2]]$name
[1] "YBR243C"

[[2]]$interactors

[1] "YFL039C" "YHR030C" "YBR214W" "YMR300C" "YOR151C" "YIR038C" "YJR104C"
[8] "YLR088W" "YJL029C" "YMR307W" "YNL080C" "YOL064C" "YGR157W" "YOL078W"

[15] "YBR106W" "YML075C"

[[3]]

44

YeastBioGRIDInteractionUniqueId

[[3]]$name
[1] "YKL052C"

[[3]]$interactors

[1] "YFL039C"
[7] "YGL061C"
[13] "YGR140W"
[19] "YKL049C"

"YKR083C"
"YKL180W"
"YIL144W"
"YEL061C"

"YMR077C"
"YML024W"
"YGL093W"
"YGL086W"

"YDR201W"
"YKR037C"
"YNL098C"
"YPL209C"

[[4]]
[[4]]$name
[1] "YPR105C"

[[4]]$interactors

"YGR113W"

"YDR016C"
"YDR320C-A" "YKL138C-A"
"YOR360C"
"YDR130C"

"YIL033C"

[1] "YFL039C" "YNL271C" "YGL153W" "YGR120C" "YGL145W" "YHR060W" "YLR315W"
[8] "YMR181C" "YOR164C" "YML071C" "YER157W" "YLR026C" "YNL051W" "YGL223C"
[15] "YGL005C" "YDR189W" "YFL038C" "YNL041C" "YPR191W" "YPL246C" "YLR291C"
[22] "YOL034W" "YNL209W" "YDL229W" "YGL167C" "YER162C"

[[5]]
[[5]]$name
[1] "YGR175C"

[[5]]$interactors

[1] "YFL039C" "YNL271C" "YDR170C" "YNL311C" "YER044C" "YBR041W" "YHR007C"
[8] "YNL272C" "YHR020W" "YMR186W" "YPR080W" "YJR066W" "YGL010W" "YHR079C"
[15] "YPL240C" "YLL039C" "YGR060W" "YNL280C" "YGL001C" "YLR100W" "YMR202W"
[22] "YLR056W" "YMR015C" "YGL012W" "YHR023W" "YFR004W" "YFL023W" "YDR086C"
[29] "YGR289C"

Index

∗ datasets

∗ file
ArabidopsisBioGRIDInteractionEntrezId,

findInteractionList, 14

3

∗ package

ArabidopsisBioGRIDInteractionOfficial,

simpIntLists-package, 1

5

6

8

10

12

15

17

3

5

6

8

10

12

ArabidopsisBioGRIDInteractionUniqueId,

ArabidopsisBioGRIDInteractionEntrezId,

C.ElegansBioGRIDInteractionEntrezId,

ArabidopsisBioGRIDInteractionOfficial,

C.ElegansBioGRIDInteractionOfficial,

ArabidopsisBioGRIDInteractionUniqueId,

C.ElegansBioGRIDInteractionUniqueId,

C.ElegansBioGRIDInteractionEntrezId,

FruitFlyBioGRIDInteractionEntrezId,

C.ElegansBioGRIDInteractionOfficial,

FruitFlyBioGRIDInteractionOfficial,

C.ElegansBioGRIDInteractionUniqueId,

FruitFlyBioGRIDInteractionUniqueId,

18

HumanBioGRIDInteractionEntrezId,

findInteractionList, 13
FruitFlyBioGRIDInteractionEntrezId,

20

15

HumanBioGRIDInteractionOfficial,

FruitFlyBioGRIDInteractionOfficial,

21

17

HumanBioGRIDInteractionUniqueId,

FruitFlyBioGRIDInteractionUniqueId,

22

MouseBioGRIDInteractionEntrezId,

23

MouseBioGRIDInteractionOfficial,

24

MouseBioGRIDInteractionUniqueId,

26

S.PombeBioGRIDInteractionEntrezId,

27

S.PombeBioGRIDInteractionOfficial,

29

S.PombeBioGRIDInteractionUniqueId,

32

YeastBioGRIDInteractionEntrezId,

34

18

HumanBioGRIDInteractionEntrezId,

20

HumanBioGRIDInteractionOfficial,

21

HumanBioGRIDInteractionUniqueId,

22

MouseBioGRIDInteractionEntrezId,

23

MouseBioGRIDInteractionOfficial,

24

MouseBioGRIDInteractionUniqueId,

26

YeastBioGRIDInteractionOfficial,

S.PombeBioGRIDInteractionEntrezId,

37

27

YeastBioGRIDInteractionUniqueId,

S.PombeBioGRIDInteractionOfficial,

41

29

45

46

INDEX

S.PombeBioGRIDInteractionUniqueId,

32

simpIntLists

(simpIntLists-package), 1

simpIntLists-package, 1

YeastBioGRIDInteractionEntrezId,

34

YeastBioGRIDInteractionOfficial,

37

YeastBioGRIDInteractionUniqueId,

41


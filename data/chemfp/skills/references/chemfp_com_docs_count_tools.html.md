[chemfp.com](https://chemfp.com/)

[chemfp documentation](index.html)

* [Installing chemfp](installing.html)
* [Command-line examples for binary fingerprints](tools.html)
* Command-line examples for sparse count fingerprints
  + [Sparse fingerprints quick start](#sparse-fingerprints-quick-start)
  + [What are sparse count fingerprints?](#what-are-sparse-count-fingerprints)
  + [The FPC format](#the-fpc-format)
  + [The two count Tanimoto similarities](#the-two-count-tanimoto-similarities)
    - [Vector Tanimoto](#vector-tanimoto)
    - [Multiset Tanimoto](#multiset-tanimoto)
    - [History](#history)
  + [Generate sparse count fingerprints with RDKit](#generate-sparse-count-fingerprints-with-rdkit)
    - [Generate Morgan count fingerprints from ChEBI](#generate-morgan-count-fingerprints-from-chebi)
  + [Count fingerprint search with the RDKit API](#count-fingerprint-search-with-the-rdkit-api)
  + [Convert sparse count fingerprints to binary](#convert-sparse-count-fingerprints-to-binary)
  + [fpc2fps “fold” method](#fpc2fps-fold-method)
    - [How does folding work?](#how-does-folding-work)
    - [Folding in action](#folding-in-action)
  + [fpc2fps “rdkit-countsim” method](#fpc2fps-rdkit-countsim-method)
    - [How does count simulation work?](#how-does-count-simulation-work)
    - [Count simulation in action](#count-simulation-in-action)
  + [fpc2fps “superimpose” method](#fpc2fps-superimpose-method)
    - [How does superimpose work?](#how-does-superimpose-work)
    - [Superimposed fingerprints in action](#superimposed-fingerprints-in-action)
  + [fpc2fps “scaled” method](#fpc2fps-scaled-method)
    - [How does scaled work?](#how-does-scaled-work)
    - [Scaled fingerprints in action](#scaled-fingerprints-in-action)
  + [fpc2fps “seq” method](#fpc2fps-seq-method)
    - [How does scaled work?](#id13)
  + [fpc2fps “scaled-seq” method](#fpc2fps-scaled-seq-method)
    - [How does scaled-seq work?](#how-does-scaled-seq-work)
  + [Convert binary fingerprints to count](#convert-binary-fingerprints-to-count)
* [The chemfp command-line tools](tool_help.html)
* [Getting started with the API](getting_started_api.html)
* [Fingerprint family and type examples](fingerprint_types.html)
* [Toolkit API examples](toolkit.html)
* [Text toolkit examples](text_toolkit.html)
* [chemfp API](chemfp_api.html)
* [Licenses](licenses.html)
* [What’s new in chemfp 5.1](whats_new_in_51.html)
* [What’s new in chemfp 5.0](whats_new_in_50.html)
* [What’s new in chemfp 4.2](whats_new_in_42.html)
* [What’s new in chemfp 4.1](whats_new_in_41.html)
* [What’s new in chemfp 4.0](whats_new_in_40.html)

[chemfp documentation](index.html)

* Command-line examples for sparse count fingerprints

---

# Command-line examples for sparse count fingerprints[](#command-line-examples-for-sparse-count-fingerprints "Link to this heading")

The sections in this chapter show examples of using [the chemfp
command-line tools](tool_help.html#tool-help) to generate and work with sparse count
fingerprint files. Examples of using the command-line tools for binary
fingerprints are in [its own chapter](tools.html#using-tools).

Chemfp 5.0 added initial support for sparse count fingerprints.
Previous versions only supported binary fingerprints. Even with
version 5.0 sparse count fingerprint support is focused on
command-line tools to generate and convert sparse count fingerprints
to binary fingerprints.

In particular, chemfp 5.0 does not support direct similarity search of
sparse count fingerprints. See below for examples of how to convert
them to binary fingerprints for use with simsearch.

This chapter will start with the [basics of count fingerprints](#what-are-sparse-fingerprints), the [FPC format](#fpc-format-intro), and some details about [count fingerprint
similarity](#the-two-tanimotos) before getting to examples of the
command-line tools for [generating count fingerprints with RDKit](#chemfp-rdkit2fpc-intro), [converting count fingerprints to
binary](#chemfp-fpc2fps-intro), and [converting binary
fingerprints to count](#chemfp-fps2fpc-intro).

## Sparse fingerprints quick start[](#sparse-fingerprints-quick-start "Link to this heading")

In this section you’ll learn how to generate Morgan count fingerprints
for ChEMBL 36, convert them to binary fingerprints using the
“superimpose” method, and search the results with [simsearch](simsearch_command.html#simsearch). You will need a copy of [chembl\_36.sdf.gz](https://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/releases/chembl_36/chembl_36.sdf.gz)
from the [ChEMBL 36 release](https://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/releases/chembl_36/).

This is a quick overview. The rest of this chapter goes into the details.

Chemfp 5.0 has initial support for [sparse fingerprints](#what-are-sparse-fingerprints). You can use
[chemfp rdkit2fpc](chemfp_rdkit2fpc_command.html#chemfp-rdkit2fpc) to generate sparse count
fingerprints in [FPC format](#fpc-format-intro) and [chemfp
fpc2fps](chemfp_fpc2fps_command.html#chemfp-fpc2fps) to convert sparse count fingerprints to
binary fingerprints, which can then be used for [similarity
search](simsearch_command.html#simsearch), [clustering](chemfp_butina_command.html#chemfp-butina), and the other
chemfp components and APIs.

ChEMBL 36 came out a couple of days ago, as I write this
documentation. I’ll work with that dataset, which means downloading
it:

```
% curl -LO https://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/releases/chembl_36/chembl_36.sdf.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  893M  100  893M    0     0  2053k      0  0:07:25  0:07:25 --:--:-- 2128k
```

The [chemfp rdkit2fpc](chemfp_rdkit2fpc_command.html#chemfp-rdkit2fpc) command uses RDKit to
generate sparse count fingerprints using one of the four available
RDKit sparse fingerprint generators <chemfp\_rdkit2fpc\_intro>. The
default generates Morgan fingerprints with radius 3. I’ll save the
output to “chembl\_36\_morgan3.fpc”.

```
% chemfp rdkit2fps chembl_36.sdf.gz -o chembl_36_morgan3.fpc
chembl_36.sdf.gz: 100%|██████████| 936M/936M [15:30<00:00, 1.01Mbytes/s]
```

(I omitted the many RDKit warning messages.)

The FPC file starts with a header and then text-encoded sparse fingerprint records:

```
% head chembl_36_morgan3.fpc
head chembl_36_morgan3.fpc | head -6 | fold -w75
#FPC1
#type=RDKit-MorganCount/2 radius=3 useFeatures=0
#software=RDKit/2024.09.5 chemfp/5.0
#source=chembl_36.sdf.gz
#date=2025-09-23T12:05:42+00:00
8819703,10565946:6,21411075,74537039:3,98513984:3,106928295,155357245,20080
3840:2,202916677,203696813:2,205091775,209539530,275844649:3,348315680,3627
36814,416356657,426185235,481036053:3,552744685,584893129:2,588615134,60371
2107,614696445,632355422,705633911:2,725338437,732650486,733416567:4,739682
264:2,742000539,751208592:3,765252582,786270123:2,787341104,831463242,84020
3949,847336149:3,847957139:13,847961216:24,851463431:2,861569459:2,86466231
1:3,864942730:38,867780956,868515887:2,881868678:3,891329428:2,898782895,90
4435074,912632640:2,919730633,945676240,951226070:2,951664601,963360736,993
357377:2,1022303596:2,1064745320,1067601182,1091317056:2,1092185181,1100037
548:2,1112379768,1135998617:2,1141162250:4,1143249862,1156835409,1160986729
:6,1167322652:5,1167510932,1173125914:2,1177897542:2,1178235770,1182622762:
2,1241519671,1248171218,1256884789:4,1259710714:2,1276993226,1288546412:2,1
355146676:2,1362518133:23,1368548858:3,1453891735,1475008087:2,1506563592:2
,1506993418,1510328189:32,1510461303:7,1514288082:3,1533864325:2,1534122513
,1535166686,1582607016:5,1583799011:9,1618787606,1618797937:4,1685248591:2,
1693331843,1732175000,1739265633:2,1750892114:9,1754284222,1797524254:2,184
0891614:2,1842658656,1845470297,1858577693:2,1868611658,1884205411:2,189945
4565:2,1927060881,1931762473,1960485383,1962383056:3,2007823391:2,201508900
2,2015594738:2,2028220934,2031636797,2041434490:2,2056290811,2089752391,209
5932647,2096521477,2100423615,2117068077:2,2132511834:8,2133811111:5,214203
2900:2,2150151661,2191273952:17,2221177404,2225186000:2,2231929377:3,224527
3601:32,2245384272:41,2246699815:35,2246728737:22,2259647190:5,2264318846,2
289501320:2,2299784278:17,2319182106,2333272823:5,2343062145,2361265913:2,2
405469776:2,2423543607:5,2442018706,2448572767:3,2498288868:2,2520548245,25
34441460,2591432844:11,2592785365,2599973650,2604604876,2637439965:2,264906
3844,2654043257:2,2666857930:5,2678918872:3,2684694360,2697110228:2,2752034
647:2,2763854213,2806018737,2832976762,2843304388,2863307117:2,2867688340:2
,2892360967,2929652889,2939120473,2940239131,2941064859:2,2964009977,296896
8094:6,2976033787:6,2981789305,2989341071:7,3004333805,3008901642:3,3099695
679:2,3135357859:2,3143227007,3147457595,3149497025:2,3182041044:3,31821772
90:5,3201831218,3203925050,3217380708:9,3218693969:9,3234104871,3241680715,
3261096889,3262357651,3272226737:3,3284700855:2,3296404462:2,3303793604,331
4130824,3317330686,3328145258:4,3332377904,3338734523:2,3344893792,33661738
70,3392469258,3447215649:2,3466781987,3506165101,3510196525:5,3537119515:16
,3542456614:4,3556458277:2,3561287756,3684238839,3718957586,3791102067:2,38
21303249,3850635461:2,3916616716:5,3969756582,3985977119:2,3999906991:2,402
2716898,4031920000,4037464357,4057379760,4066851934:3,4070780135,4078658161
:2,4081006743,4086993724,4121755354,4124858218:4,4181883701,4222851645:23,4
223976160:18,4264485148,4274980665,4278941385:2       CHEMBL440245
```

Chemfp 5.0 does not support direct sparse count fingerprint similarity
search, only an indirect search after converting the sparse count
fingerprints to binary fingerprints and searching the binary
fingerprints.

The [chemfp fpc2fps](chemfp_fpc2fps_command.html#chemfp-fpc2fps) command implements several
methods to convert the sparse count fingerprints to (dense) binary
fingerprints. The default is “[superimpose](#fpc2fps-superimpose-method), which uses superimposed coding to
distribute the feature id and its counts across the fingerprint.

```
% chemfp fpc2fps chembl_36_morgan3.fpc -o chembl_36_morgan3_superimpose.fpb
chembl_36_morgan3.fpc: 100%|███████| 2.37G/2.37G [00:36<00:00, 65.8Mbytes/s]
```

The result is an FPB file with fingerprint sorted by increasing
popcount (the fingerprints with the fewest on-bits come first).

```
% fpcat chembl_36_morgan3_superimpose.fpb | head -5 | fold -w75 -s
#FPS1
#num_bits=2048
#type=RDKit-MorganCount/2 radius=3 useFeatures=0 | superimpose/1
num_bits=2048
#software=RDKit/2024.09.5 chemfp/5.0b2
000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000004000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000
CHEMBL4300465
```

Search requires going through the same steps to generate binary query
fingerprints before using them to search the targets. The following
creates a SMILES file with two record then uses a pipeline to generate
the two corresponding binary fingerprints, in FPB format, for a
k=10 nearest-neighbor similarity search.

```
% cat > queries.smi
c1ccccc1O phenol
C1=CC=C(C=C1)NC(=O)C2=CC(=CC(=C2)N)C(=O)NC3=CC=CC=C3 PubChem_C617508
% chemfp rdkit2fpc queries.smi | \
   chemfp fpc2fps | \
   simsearch chembl_36_morgan3_superimpose.fpb -k 10 --out csv
query_id,target_id,score
phenol,CHEMBL14060,1.0000000
phenol,CHEMBL16068,0.5172414
phenol,CHEMBL16070,0.5172414
phenol,CHEMBL116296,0.5172414
phenol,CHEMBL119405,0.5172414
phenol,CHEMBL5186653,0.5172414
phenol,CHEMBL9113,0.5172414
phenol,CHEMBL538,0.5172414
phenol,CHEMBL16200,0.5172414
phenol,CHEMBL2107497,0.5000000
PubChem_C617508,CHEMBL4526222,0.8061224
PubChem_C617508,CHEMBL4534018,0.7722772
PubChem_C617508,CHEMBL4571777,0.7647059
PubChem_C617508,CHEMBL4555047,0.7500000
PubChem_C617508,CHEMBL4557884,0.7428571
PubChem_C617508,CHEMBL4465008,0.6730769
PubChem_C617508,CHEMBL188775,0.6476190
PubChem_C617508,CHEMBL4438910,0.6393443
PubChem_C617508,CHEMBL1378530,0.6074766
PubChem_C617508,CHEMBL2158387,0.6036036
```

We can compare the search results with the [folded](#fpc2fps-fold-method) Morgan3 fingerprints (folding ignores the
feature count) by converting the existing count fingerprints rather
than re-processing the structures. These fingerprints are identical to
the default (`--morgan3`) binary fingerprints generated
by [rdkit2fps](rdkit2fps_command.html#rdkit2fps).

```
%  chemfp fpc2fps -m fold chembl_36_morgan3.fpc -o chembl_36_morgan3_fold.fpb
chembl_36_morgan3.fpc: 100%|██████████| 2.37G/2.37G [00:45<00:00, 52.5Mbytes/s]
% chemfp rdkit2fpc queries.smi | \
    chemfp fpc2fps -m fold | \
    simsearch chembl_36_morgan3_fold.fpb -k 10 --out csv
query_id,target_id,score
phenol,CHEMBL14060,1.0000000
phenol,CHEMBL73380,0.4400000
phenol,CHEMBL537,0.4375000
phenol,CHEMBL24147,0.4210526
phenol,CHEMBL3769799,0.4166667
phenol,CHEMBL495708,0.3928571
phenol,CHEMBL280998,0.3888889
phenol,CHEMBL3039845,0.3809524
phenol,CHEMBL79759,0.3793103
phenol,CHEMBL224318,0.3793103
PubChem_C617508,CHEMBL4438910,0.7567568
PubChem_C617508,CHEMBL4526222,0.6363636
PubChem_C617508,CHEMBL475680,0.6000000
PubChem_C617508,CHEMBL39258,0.5957447
PubChem_C617508,CHEMBL4534018,0.5957447
PubChem_C617508,CHEMBL4557884,0.5957447
PubChem_C617508,CHEMBL4571777,0.5957447
PubChem_C617508,CHEMBL4555047,0.5833333
PubChem_C617508,CHEMBL277484,0.5777778
PubChem_C617508,CHEMBL394811,0.5714286
```

RDKit’s binary fingerprint generator also implements [count
simulation](#fpc2fps-rdkit-method), which is a different way to
incorporate counts in the generated fingerprints. This is avaialble
as **rdkit2fps \\-\\-countSimulation=1**, or by converting
the FPC file using the “rdkit-countsim” (or “rdkit” for short) method:

```
% chemfp fpc2fps -m rdkit chembl_36_morgan3.fpc -o chembl_36_morgan3_count_sim.fpb
chembl_36_morgan3.fpc: 100%|██████████| 2.37G/2.37G [02:30<00:00, 15.8Mbytes/s]
% chemfp rdkit2fpc queries.smi | \
    chemfp fpc2fps -m rdkit | \
    simsearch chembl_36_morgan3_count_sim.fpb -k 10 --out csv
query_id,target_id,score
phenol,CHEMBL14060,1.0000000
phenol,CHEMBL5186653,0.4800000
phenol,CHEMBL320474,0.4642857
phenol,CHEMBL16068,0.4615385
phenol,CHEMBL16070,0.4615385
phenol,CHEMBL116296,0.4615385
phenol,CHEMBL119405,0.4615385
phenol,CHEMBL9113,0.4615385
phenol,CHEMBL538,0.4615385
phenol,CHEMBL16200,0.4615385
PubChem_C617508,CHEMBL4438910,0.7763158
PubChem_C617508,CHEMBL4526222,0.7375000
PubChem_C617508,CHEMBL4555047,0.7023810
PubChem_C617508,CHEMBL4534018,0.7023810
PubChem_C617508,CHEMBL4571777,0.7023810
PubChem_C617508,CHEMBL4557884,0.6860465
PubChem_C617508,CHEMBL4465008,0.6385542
PubChem_C617508,CHEMBL188775,0.6219512
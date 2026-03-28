# tgv CWL Generation Report

## tgv_download

### Tool Description
Download command

### Metadata
- **Docker Image**: quay.io/biocontainers/tgv:0.1.0--h521fa98_0
- **Homepage**: https://github.com/zeqianli/tgv
- **Package**: https://anaconda.org/channels/bioconda/packages/tgv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tgv/overview
- **Total Downloads**: 533
- **Last updated**: 2025-09-08
- **GitHub**: https://github.com/zeqianli/tgv
- **Stars**: N/A
### Original Help Text
```text
Download command

Usage: tgv download [OPTIONS] <REFERENCE>

Arguments:
  <REFERENCE>  Name to download

Options:
      --cache-dir <CACHE_DIR>  Cache directory [default: ~/.tgv]
  -h, --help                   Print help
```


## tgv_list

### Tool Description
Browse a genome: tgv -g <genome> (e.g. tgv -g rat)

### Metadata
- **Docker Image**: quay.io/biocontainers/tgv:0.1.0--h521fa98_0
- **Homepage**: https://github.com/zeqianli/tgv
- **Package**: https://anaconda.org/channels/bioconda/packages/tgv/overview
- **Validation**: PASS

### Original Help Text
```text
hg19
hg38
Human (UCSC assembly: hg38)
Mouse (UCSC assembly: mm10)
Rat (UCSC assembly: rn6)
Zoo (UCSC assembly: zooHuman3)
SARS (UCSC assembly: sc1)
C. elegans (UCSC assembly: ce11)
C. briggsae (UCSC assembly: cb3)
Fugu (UCSC assembly: fr3)
D. melanogaster (UCSC assembly: dm6)
D. pseudoobscura (UCSC assembly: dp3)
S. cerevisiae (UCSC assembly: sacCer3)
Chimp (UCSC assembly: panTro6)
Chicken (UCSC assembly: galGal6)
Dog (UCSC assembly: canFam4)
C. intestinalis (UCSC assembly: ci3)
D. yakuba (UCSC assembly: droYak2)
Zebrafish (UCSC assembly: danRer11)
A. gambiae (UCSC assembly: anoGam3)
Tetraodon (UCSC assembly: tetNig2)
X. tropicalis (UCSC assembly: xenTro10)
D. mojavensis (UCSC assembly: droMoj2)
A. mellifera (UCSC assembly: apiMel2)
D. virilis (UCSC assembly: droVir2)
D. ananassae (UCSC assembly: droAna2)
Opossum (UCSC assembly: monDom5)
Cow (UCSC assembly: bosTau9)
Rhesus (UCSC assembly: rheMac10)
D. simulans (UCSC assembly: droSim1)
D. erecta (UCSC assembly: droEre1)
D. grimshawi (UCSC assembly: droGri1)
D. persimilis (UCSC assembly: droPer1)
D. sechellia (UCSC assembly: droSec1)
S. purpuratus (UCSC assembly: strPur2)
Stickleback (UCSC assembly: gasAcu1)
Cat (UCSC assembly: felCat9)
Medaka (UCSC assembly: oryLat2)
Lizard (UCSC assembly: anoCar2)
Platypus (UCSC assembly: ornAna2)
Horse (UCSC assembly: equCab3)
C. remanei (UCSC assembly: caeRem3)
C. brenneri (UCSC assembly: caePb2)
P. pacificus (UCSC assembly: priPac1)
Orangutan (UCSC assembly: ponAbe3)
Marmoset (UCSC assembly: calJac4)
Guinea Pig (UCSC assembly: cavPor3)
Lancelet (UCSC assembly: braFlo1)
Lamprey (UCSC assembly: petMar2)
C. japonica (UCSC assembly: caeJap1)
Zebra finch (UCSC assembly: taeGut2)
Sea Hare (UCSC assembly: aplCal1)
Elephant (UCSC assembly: loxAfr3)
Panda (UCSC assembly: ailMel1)
Rabbit (UCSC assembly: oryCun2)
Pig (UCSC assembly: susScr11)
Sheep (UCSC assembly: oviAri4)
Turkey (UCSC assembly: melGal5)
Microbat (UCSC assembly: myoLuc2)
Gorilla (UCSC assembly: gorGor6)
Gibbon (UCSC assembly: nomLeu3)
Wallaby (UCSC assembly: macEug2)
Naked mole-rat (UCSC assembly: hetGla2)
Painted turtle (UCSC assembly: chrPic1)
Tenrec (UCSC assembly: echTel2)
Tasmanian devil (UCSC assembly: sarHar1)
Medium ground finch (UCSC assembly: geoFor1)
Sloth (UCSC assembly: choHof1)
Kangaroo rat (UCSC assembly: dipOrd1)
Hedgehog (UCSC assembly: eriEur2)
Mouse lemur (UCSC assembly: micMur2)
Manatee (UCSC assembly: triMan1)
Squirrel (UCSC assembly: speTri2)
Squirrel monkey (UCSC assembly: saiBol1)
Baboon (UCSC assembly: papAnu4)
Rock hyrax (UCSC assembly: proCap1)
Megabat (UCSC assembly: pteVam1)
Shrew (UCSC assembly: sorAra2)
Tarsier (UCSC assembly: tarSyr2)
Tree shrew (UCSC assembly: tupBel1)
Alpaca (UCSC assembly: vicPac2)
Atlantic cod (UCSC assembly: gadMor1)
Coelacanth (UCSC assembly: latCha1)
Budgerigar (UCSC assembly: melUnd1)
Bushbaby (UCSC assembly: otoGar3)
Armadillo (UCSC assembly: dasNov3)
Pika (UCSC assembly: ochPri3)
Nile tilapia (UCSC assembly: oreNil2)
Dolphin (UCSC assembly: turTru2)
White rhinoceros (UCSC assembly: cerSim1)
Ferret (UCSC assembly: musFur1)
American alligator (UCSC assembly: allMis1)
Minke whale (UCSC assembly: balAcu1)
Chinese hamster (UCSC assembly: criGriChoV2)
Elephant shark (UCSC assembly: calMil1)
Ebola virus (UCSC assembly: eboVir3)
Southern sea otter (UCSC assembly: enhLutNer1)
SARS-CoV-2 (UCSC assembly: wuhCor1)
Bonobo (UCSC assembly: panPan3)
Brown kiwi (UCSC assembly: aptMan1)
Crab-eating macaque (UCSC assembly: macFas5)
Wuhan market virus (UCSC assembly: wuhCor1)
Malayan flying lemur (UCSC assembly: galVar1)
Green monkey (UCSC assembly: chlSab2)
Golden snub-nosed monkey (UCSC assembly: rhiRox1)
Proboscis monkey (UCSC assembly: nasLar1)
Bison (UCSC assembly: bisBis1)
Tibetan frog (UCSC assembly: nanPar1)
Chinese pangolin (UCSC assembly: manPen1)
Golden eagle (UCSC assembly: aquChr2)
African clawed frog (UCSC assembly: xenLae2)
Garter snake (UCSC assembly: thaSir1)
Hawaiian monk seal (UCSC assembly: neoSch1)
Little brown bat (UCSC assembly: myoLuc2)
Monkeypox virus (UCSC assembly: mpxvRivers)
covid (UCSC assembly: wuhCor1)
celegans (UCSC assembly: ce11)
ecoli (UCSC assembly: GCF_000005845.2)
118 common genomes
Browse a genome: tgv -g <genome> (e.g. tgv -g rat)
```


## Metadata
- **Skill**: generated

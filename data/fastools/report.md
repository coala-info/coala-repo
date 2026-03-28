# fastools CWL Generation Report

## fastools_add

### Tool Description
Add a sequence to the 5' end of each read in a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: fastools add [-h] [-q QUALITY] INPUT OUTPUT SEQ

Add a sequence to the 5' end of each read in a FASTQ file.

positional arguments:
  INPUT       input file
  OUTPUT      output file
  SEQ         a sequence (str)

options:
  -h, --help  show this help message and exit
  -q QUALITY  quality score (int default=40)
```


## fastools_aln

### Tool Description
Calculate the Levenshtein distance between two FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools aln [-h] INPUT INPUT

Calculate the Levenshtein distance between two FASTA files.

positional arguments:
  INPUT       input files

options:
  -h, --help  show this help message and exit
```


## fastools_cat

### Tool Description
Return the sequence content of a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools cat [-h] INPUT

Return the sequence content of a FASTA file.

positional arguments:
  INPUT       input file

options:
  -h, --help  show this help message and exit
```


## fastools_collapse

### Tool Description
Remove all mononucleotide stretches from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools collapse [-h] [-s MAX_STRETCH] INPUT OUTPUT

Remove all mononucleotide stretches from a FASTA file.

positional arguments:
  INPUT                 input file
  OUTPUT                output file

options:
  -h, --help            show this help message and exit
  -s MAX_STRETCH, --stretch MAX_STRETCH
                        Length of the stretch (int default: 3)
```


## fastools_csv2fa2

### Tool Description
Convert a CSV file to two FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools csv2fa2 [-h] [-s] INPUT OUTPUT OUTPUT

Convert a CSV file to two FASTA files.

positional arguments:
  INPUT       input file
  OUTPUT      output files

options:
  -h, --help  show this help message and exit
  -s          skip the first line of the CSV file
```


## fastools_descr

### Tool Description
Return the description of all records in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools descr [-h] INPUT

Return the description of all records in a FASTA file.

positional arguments:
  INPUT       input file

options:
  -h, --help  show this help message and exit
```


## fastools_dna2rna

### Tool Description
Convert the FASTA/FASTQ content from DNA to RNA.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools dna2rna [-h] INPUT OUTPUT

Convert the FASTA/FASTQ content from DNA to RNA.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_edit

### Tool Description
Replace regions in a reference sequence. The header of the edits file must have the following strucure: >name chrom:start_end

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools edit [-h] INPUT OUTPUT EDITS

Replace regions in a reference sequence. The header of the edits file must
have the following strucure: >name chrom:start_end

positional arguments:
  INPUT       input file
  OUTPUT      output file
  EDITS       FASTA file containing edits

options:
  -h, --help  show this help message and exit
```


## fastools_fa2fq

### Tool Description
Convert a FASTA file to a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools fa2fq [-h] [-q QUALITY] INPUT OUTPUT

Convert a FASTA file to a FASTQ file.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
  -q QUALITY  quality score (int default=40)
```


## fastools_fa2gb

### Tool Description
Convert a FASTA file to a GenBank file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools fa2gb [-h] INPUT OUTPUT ACCNO

Convert a FASTA file to a GenBank file.

positional arguments:
  INPUT       input file
  OUTPUT      output file
  ACCNO       accession number

options:
  -h, --help  show this help message and exit
```


## fastools_famotif2bed

### Tool Description
Find a given sequence in a FASTA file and write the results to a Bed file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools famotif2bed [-h] INPUT OUTPUT MOTIF

Find a given sequence in a FASTA file and write the results to a Bed file.

positional arguments:
  INPUT       input file
  OUTPUT      output file
  MOTIF       The sequence to be found

options:
  -h, --help  show this help message and exit
```


## fastools_fq2fa

### Tool Description
Convert a FASTQ file to a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools fq2fa [-h] INPUT OUTPUT

Convert a FASTQ file to a FASTA file.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_gb2fa

### Tool Description
Convert a GenBank file to a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools gb2fa [-h] INPUT OUTPUT

Convert a GenBank file to a FASTA file.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_gen

### Tool Description
Generate a DNA sequence in FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools gen [-h] OUTPUT ACCNO DESCR LENGTH

Generate a DNA sequence in FASTA format.

positional arguments:
  OUTPUT      output file
  ACCNO       accession number
  DESCR       description of the DNA sequence
  LENGTH      length of the DNA sequence

options:
  -h, --help  show this help message and exit
```


## fastools_get

### Tool Description
Retrieve a reference sequence and find the location of a specific gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools get [-h] [-s START] [-p STOP] [-o ORIENTATION]
                    OUTPUT ACCNO EMAIL

Retrieve a reference sequence and find the location of a specific gene.

positional arguments:
  OUTPUT          output file
  ACCNO           accession number
  EMAIL           email address

options:
  -h, --help      show this help message and exit
  -s START        start of the area of interest
  -p STOP         end of the area of interest
  -o ORIENTATION  orientation (1=forward, 2=reverse)
```


## fastools_length

### Tool Description
Report the lengths of all FASTA records in a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools length [-h] INPUT

Report the lengths of all FASTA records in a file.

positional arguments:
  INPUT       input file

options:
  -h, --help  show this help message and exit
```


## fastools_lenfilt

### Tool Description
Split a FASTA/FASTQ file on length.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools lenfilt [-h] [-l LENGTH] INPUT OUTPUT OUTPUT

Split a FASTA/FASTQ file on length.

positional arguments:
  INPUT       input file
  OUTPUT      output files

options:
  -h, --help  show this help message and exit
  -l LENGTH   length threshold (int default: 25)
```


## fastools_list_enzymes

### Tool Description
List of restriction enzymes.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
AanI
AarI
AasI
AatII
Aba13301I
Aba6411II
AbaB8342IV
AbaCIII
AbaPBA3II
AbaSI
AbaUMB2I
Abr4036II
AbsI
Acc16I
Acc36I
Acc65I
Acc65V
AccB1I
AccB7I
AccBSI
AccI
AccII
AccIII
AccIX
AccX
AceIII
AchA6III
AciI
AclI
AclWI
Aco12261II
AcoI
AcoY31II
AcsI
AcuI
AcvI
AcyI
AdeI
Adh6U21I
AfaI
AfeI
AfiI
AflII
AflIII
AgeI
AgsI
AhaIII
AhdI
AhlI
AhyRBAHI
AhyYL17I
AjiI
AjnI
AjuI
AleI
AlfI
AloI
AluBI
AluI
Alw21I
Alw26I
Alw44I
AlwFI
AlwI
AlwNI
Ama87I
AmaCSI
Aod1I
Aor13HI
Aor51HI
AoxI
ApaBI
ApaI
ApaLI
ApeKI
ApoI
ApyPI
AquII
AquIII
AquIV
ArsI
AscI
AseI
Asi256I
AsiGI
AsiSI
Asl11923II
Asp103I
Asp114pII
Asp337I
Asp700I
Asp718I
AspA2I
AspAMDIV
AspBHI
AspDUT2V
AspJHL3II
AspLEI
AspNIH4III
AspS9I
AspSLV7III
Asu14238IV
AsuC2I
AsuHPI
AsuI
AsuII
AsuNHI
AteTI
AvaI
AvaII
AvaIII
AvrII
Awo1030IV
AxyI
BaeGI
BaeI
Bag18758I
BalI
BamHI
BanI
BanII
BanLI
BarI
Bau1417V
BauI
Bbr52II
Bbr57III
Bbr7017II
Bbr7017III
BbrPI
BbsI
BbuB31I
BbuB31II
Bbv12I
BbvCI
BbvI
BbvII
BccI
Bce10661III
Bce3081I
Bce83I
BceAI
BceSIV
BcefI
BcgI
BciT130I
BciVI
BclI
BcnI
Bco11035III
BcoDI
BcuI
BdaI
BetI
BfaI
BfaSII
BfiI
BfmI
BfoI
BfrI
BfuAI
BfuI
Bga514I
BglI
BglII
BinI
BisI
BkrAM31DI
Ble402II
BlnI
BloAII
BlpI
BlsI
BmcAI
Bme1390I
Bme18I
BmeDI
BmeRI
BmeT110I
BmgBI
BmgI
BmgT120I
BmiI
BmrFI
BmrI
BmsI
BmtI
BmuI
BoxI
BpiI
BplI
BpmI
Bps6700III
Bpu10I
Bpu1102I
Bpu14I
BpuEI
BpuMI
Bsa29I
BsaAI
BsaBI
BsaHI
BsaI
BsaJI
BsaWI
BsaXI
BsbI
Bsc4I
BscAI
BscGI
BscXI
Bse118I
Bse1I
Bse21I
Bse3DI
Bse8I
BseAI
BseBI
BseCI
BseDI
BseGI
BseJI
BseLI
BseMI
BseMII
BseNI
BsePI
BseRI
BseSI
BseX3I
BseXI
BseYI
BsgI
Bsh1236I
Bsh1285I
BshFI
BshNI
BshTI
BshVI
BsiEI
BsiHKAI
BsiHKCI
BsiI
BsiSI
BsiWI
BsiYI
BslFI
BslI
BsmAI
BsmBI
BsmFI
BsmI
BsnI
Bso31I
BsoBI
Bsp119I
Bsp120I
Bsp1286I
Bsp13I
Bsp1407I
Bsp143I
Bsp1720I
Bsp19I
Bsp24I
Bsp3004IV
Bsp460III
Bsp68I
BspACI
BspANI
BspCNI
BspD6I
BspDI
BspEI
BspFNI
BspGI
BspHI
BspLI
BspLU11I
BspMAI
BspMI
BspMII
BspNCI
BspOI
BspPI
BspQI
BspT104I
BspT107I
BspTI
BspTNI
BsrBI
BsrDI
BsrFI
BsrGI
BsrI
BssAI
BssECI
BssHII
BssMI
BssNAI
BssNI
BssSI
BssT1I
Bst1107I
Bst2BI
Bst2UI
Bst4CI
Bst6I
BstACI
BstAFI
BstAPI
BstAUI
BstBAI
BstBI
BstC8I
BstDEI
BstDSI
BstEII
BstENI
BstF5I
BstFNI
BstH2I
BstHHI
BstKTI
BstMAI
BstMBI
BstMCI
BstMWI
BstNI
BstNSI
BstPAI
BstPI
BstSCI
BstSFI
BstSLI
BstSNI
BstUI
BstV1I
BstV2I
BstX2I
BstXI
BstYI
BstZ17I
BstZI
Bsu15I
Bsu36I
BsuI
BsuRI
BsuTUI
BtgI
BtgZI
BthCI
BtrI
BtsCI
BtsI
BtsIMutI
BtuMI
Bve1B23I
BveI
Cac8I
CaiI
Cal14237I
CalB3II
Cau10061II
CauII
Cba13II
Cba16038I
Cbo67071IV
Cch467III
CchII
CchIII
CciI
CciNI
Cco11366VI
Cco11437V
Cco14983V
Cco14983VI
CcrNAIII
Cdi11397I
Cdi13746V
Cdi13750III
CdiI
CdpI
Cdu23823II
Cfa8380I
CfoI
Cfr10I
Cfr13I
Cfr42I
Cfr9I
CfrI
CfrMH13II
CfrMH16VI
Cfupf3II
Cgl13032I
Cgl13032II
ChaI
Cin11811I
Cje265V
Cje54107III
CjeFIII
CjeFV
CjeI
CjeNII
CjeNIII
CjeNV
CjeP659IV
CjePI
CjuI
CjuII
Cko11077IV
Cla11845III
ClaI
Cly7489II
Cpe10578V
Cpe13170II
Cpe2837III
CpoI
Cre7908I
Csa9238II
CseI
CsiI
Csp2014I
Csp6I
CspAI
CspCI
CspI
CstMI
CviAII
CviJI
CviKI_1
CviQI
CviRI
Dde51507I
DdeI
DinI
Dpi3069I
Dpi3084I
Dpi3090II
DpnI
DpnII
DraI
DraII
DraIII
DraRI
DrdI
DrdII
DrdIV
DrdV
DrdVI
DrdVIII
DriI
DsaI
DseDI
DspS02II
DvuIII
EaeI
EagI
Eam1104I
Eam1105I
EarI
EciI
Ecl136II
Ecl234I
Ecl35734I
EclXI
Eco105I
Eco130I
Eco147I
Eco24I
Eco31I
Eco32I
Eco4174I
Eco43896II
Eco4465II
Eco47I
Eco47III
Eco52I
Eco53kI
Eco57I
Eco57MI
Eco72I
Eco8164I
Eco81I
Eco88I
Eco9009II
Eco9020I
Eco9035I
Eco91I
Eco9699II
EcoBLMcrX
EcoE1140I
EcoHI
EcoHSI
EcoICRI
EcoMVII
EcoNI
EcoNIH6II
EcoO109I
EcoO65I
EcoRI
EcoRII
EcoRV
EcoT14I
EcoT22I
EcoT38I
EgeI
EheI
Ehi46392I
Eli8509II
ErhG4T10I
ErhI
EsaBC3I
EsaSSI
Esp3007I
Esp3I
EspI
FaeI
FaiI
FalI
FaqI
FatI
FauI
FauNDI
Fba202Z8II
FbaI
FblI
Fco1691IV
FinI
FmuI
Fna13121I
Fnu11326II
Fnu11326IV
Fnu4HI
FnuDII
FokI
FriOI
FseI
Fsp4HI
FspAI
FspBI
FspEI
FspI
FspPK15I
FtnUV
GauT27I
Gba708II
GdiII
GlaI
GluI
Gru56503II
GsaI
GsuI
HaeI
HaeII
HaeIII
HapII
HauII
HbaII
Hca13221V
HdeNY26I
HdeZA17I
HgaI
HgiAI
HgiCI
HgiEII
HgiJII
HhaI
Hin1I
Hin1II
Hin4I
Hin4II
Hin6I
HinP1I
HincII
HindII
HindIII
HinfI
HpaI
HpaII
HphI
Hpy166II
Hpy178III
Hpy188I
Hpy188III
Hpy300XI
Hpy8I
Hpy99I
Hpy99XIII
Hpy99XIV
Hpy99XIV_mut1
Hpy99XXII
HpyAS001VI
HpyAV
HpyAXIV
HpyAXVIII
HpyAXVI_mut1
HpyAXVI_mut2
HpyCH4III
HpyCH4IV
HpyCH4V
HpyF10VI
HpyF3I
HpyLIM6XII
HpyPU007XIX
HpySE526I
HpyUM032XIII
HpyUM032XIII_mut1
HpyUM032XIV
HpyUM037X
Hso63250IV
Hso63373III
Hsp92I
Hsp92II
HspAI
HspMHR1II
Jma19592I
Jma19592II
Jsp2502II
Kas9737III
KasI
KflI
Kor51II
Kpn156V
Kpn2I
Kpn327I
Kpn9178I
Kpn9644II
KpnI
KpnNH25III
KpnNIH30III
KpnNIH50I
Kro7512II
KroI
KroNI
Ksp22I
Ksp632I
KspAI
KspI
Kzo9I
Lba2029III
Lbr124II
Lde4408II
LguI
LlaG50I
LmnI
Lmo370I
Lmo911II
Lpl1004II
Lpn11417II
Lpn12272I
LpnI
LpnPI
Lra68I
LsaDS4I
Lsp1109I
Lsp48III
Lsp6406VI
LweI
MabI
MaeI
MaeII
MaeIII
MalI
MaqI
MauBI
Mba11I
MbiI
MboI
MboII
McaTI
Mch10819I
Mch946II
McrI
MfeI
MflI
MhlI
MjaIV
MkaDII
Mla10359I
MlsI
Mlu211III
MluCI
MluI
MluNI
Mly113I
MlyI
MmeI
MnlI
Mox20I
Mph1103I
MreI
MroI
MroNI
MroXI
MscI
MseI
MslI
Msp20I
MspA1I
MspCI
MspF392I
MspGI
MspI
MspI7II
MspI7IV
MspJI
MspR9I
MspSC27II
MssI
MstI
MteI
MtuHN878II
MunI
Mva1269I
MvaI
MvnI
MwoI
NaeI
Nal45188II
NarI
Nbr128II
NciI
NcoI
NdeI
NdeII
NgoAVII
NgoAVIII
NgoMIV
NhaXI
NheI
NhoI
NlaCI
NlaIII
NlaIV
Nli3877I
NmeA6CIII
NmeAIII
NmeDI
NmuCI
NotI
NpeUS61II
NruI
NsbI
NsiI
NspBII
NspES21II
NspI
NspV
ObaBS10I
OgrI
OliI
OspHL35III
PabI
Pac19842II
PacI
PacIII
Pae10662III
Pae8506I
PaeI
PaePA99III
PaeR7I
PagI
Pal408I
PalAI
PaqCI
PasI
PauI
Pba2294I
Pbu13063II
PcaII
PceI
PciI
PciSI
Pcr308II
PcsI
PctI
Pdi8503III
PdiI
PdmI
Pdu1735I
PenI
PfeI
Pfl10783II
Pfl1108I
Pfl23II
Pfl3756II
Pfl8569I
PflFI
PflMI
PflPt14I
PfoI
PfrJS12IV
PfrJS12V
PfrJS15III
Pin17FIII
PinAI
PinP23II
PinP59III
PkrI
PlaDI
Ple19I
PleI
PliMI
PluTI
PmaCI
Pme10899I
PmeI
PmlI
PpiI
PpiP13II
PpsI
Ppu10I
Ppu21I
PpuMI
Pru8113I
PscI
Pse18267I
PshAI
PshBI
PsiI
Psp0357II
Psp03I
Psp124BI
Psp1406I
Psp5II
Psp6I
PspCI
PspD7DII
PspEI
PspFI
PspGI
PspLI
PspN4I
PspOMI
PspOMII
PspPI
PspPPI
PspPRI
PspR84I
PspXI
PsrI
PssI
Pst14472I
Pst145I
Pst273I
PstI
PstNI
PsuGI
PsuI
PsyI
PteI
PvuI
PvuII
Ran11014IV
Rba2021I
RceI
RdeGBI
RdeGBII
RdeGBIII
Rer8036II
RflFIII
RgaI
Rgo13296IV
Rho5650I
RigI
Rkr11038I
RlaI
RlaII
RleAI
Rmu369III
RpaB5I
RpaBI
RpaI
RpaTI
RruI
RsaI
RsaNI
RseI
Rsp008IV
Rsp008V
Rsp531II
RspPBTS2III
Rsr2I
RsrII
Rtr1953I
SacI
SacII
Saf8902III
Sag901I
SalI
SanDI
SapI
SaqAI
SatI
Sau1803III
Sau3AI
Sau5656II
Sau64037IV
Sau96I
SauI
SauMJ015III
Sba460II
SbfI
Sbo46I
ScaI
SchI
SciI
ScoDS2II
ScrFI
SdaI
SdeAI
SdeOSI
SduI
Sdy5370I
Sdy7136I
Sdy9603I
SecI
SelI
Sen17963III
Sen5794III
Sen6480IV
SenA1673III
SenSARA26III
SenTFIV
Sep11964I
SetI
SexAI
SfaAI
SfaNI
SfcI
SfeI
SfiI
Sfl13829III
SfoI
Sfr274I
Sfr303I
SfuI
SgeI
SgfI
Sgr7807I
SgrAI
SgrAII
SgrBI
SgrDI
SgrTI
SgsI
SimI
SinI
SlaI
Sma10259II
Sma325I
SmaI
SmaUMH5I
SmaUMH8I
SmiI
SmiMI
SmlI
SmoI
Sna507VIII
SnaBI
SnaI
Sno506I
Spe19205IV
SpeI
SphI
SplI
SpnRII
SpoDI
SrfI
Sse232I
Sse8387I
Sse8647I
Sse9I
SseBI
SsiI
Ssp6803IV
Ssp714II
SspD5I
SspDI
SspI
SspJOR1II
SspMI
SstE37I
SstI
Sth132I
Sth20745III
Sth302II
SthSt3II
StsI
StuI
StyD4I
StyI
SurP32aII
SwaI
TaaI
TagI
TaiI
TaqI
TaqII
TaqIII
TasI
TatI
TauI
TfiI
TkoI
TkoII
TpyTP2I
Tru1I
Tru9I
TscAI
TseFI
TseI
TsoI
Tsp45I
Tsp4CI
TspARh3I
TspDTI
TspEI
TspGWI
TspMI
TspRI
TssI
TstI
TsuI
Tth111I
Tth111II
UbaF11I
UbaF12I
UbaF13I
UbaF14I
UbaF9I
UbaPI
UcoMSI
UnbI
Van9116I
Van91I
VchE4II
Vdi96II
Vha464I
VneI
VpaK11AI
VpaK11BI
VspI
Vtu19109I
WviI
XagI
XapI
XbaI
Xca85IV
XceI
XcmI
XhoI
XhoII
XmaI
XmaIII
XmaJI
XmiI
XmnI
XspI
YkrI
Yps3606I
Yru12986I
ZraI
ZrmI
Zsp2I
```


## fastools_maln

### Tool Description
Calculate the Hamming distance between all sequences in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools maln [-h] INPUT

Calculate the Hamming distance between all sequences in a FASTA file.

positional arguments:
  INPUT       input file

options:
  -h, --help  show this help message and exit
```


## fastools_mangle

### Tool Description
Calculate the complement (not reverse-complement) of a FASTA sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools mangle [-h] INPUT OUTPUT

Calculate the complement (not reverse-complement) of a FASTA sequence.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_merge

### Tool Description
Merge two FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools merge [-h] [-f FILL] INPUT INPUT OUTPUT

Merge two FASTA files.

positional arguments:
  INPUT       input files
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
  -f FILL     Add 'N's between the reads (int default: 0)
```


## fastools_raw2fa

### Tool Description
Make a FASTA file from a raw sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools raw2fa [-h] INPUT OUTPUT ACCNO DESCR

Make a FASTA file from a raw sequence.

positional arguments:
  INPUT       input file
  OUTPUT      output file
  ACCNO       accession number
  DESCR       description of the DNA sequence

options:
  -h, --help  show this help message and exit
```


## fastools_restrict

### Tool Description
Fragment a genome with restriction enzymes.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools restrict [-h] [-r ENZYME] INPUT

Fragment a genome with restriction enzymes.

positional arguments:
  INPUT       input file

options:
  -h, --help  show this help message and exit
  -r ENZYME   restriction enzyme (use multiple times for more enzymes)
```


## fastools_reverse

### Tool Description
Make the reverse complement a FASTA/FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools reverse [-h] INPUT OUTPUT

Make the reverse complement a FASTA/FASTQ file.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_rna2dna

### Tool Description
Convert the FASTA/FASTQ content from RNA to DNA.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools rna2dna [-h] INPUT OUTPUT

Convert the FASTA/FASTQ content from RNA to DNA.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_rselect

### Tool Description
Select a substring from every read. Positions are one-based and inclusive.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools rselect [-h] INPUT OUTPUT ACCNO FIRST LAST

Select a substring from every read. Positions are one-based and inclusive.

positional arguments:
  INPUT       input file
  OUTPUT      output file
  ACCNO       accession number
  FIRST       first base of the selection (int)
  LAST        last base of the selection (int)

options:
  -h, --help  show this help message and exit
```


## fastools_s2i

### Tool Description
Convert sanger FASTQ to illumina FASTQ.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools s2i [-h] INPUT OUTPUT

Convert sanger FASTQ to illumina FASTQ.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_sanitise

### Tool Description
Convert a FASTA/FASTQ file to a standard FASTA/FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools sanitise [-h] INPUT OUTPUT

Convert a FASTA/FASTQ file to a standard FASTA/FASTQ file.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_select

### Tool Description
Select a substring from every read. Positions are one-based and inclusive.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools select [-h] INPUT OUTPUT FIRST LAST

Select a substring from every read. Positions are one-based and inclusive.

positional arguments:
  INPUT       input file
  OUTPUT      output file
  FIRST       first base of the selection (int)
  LAST        last base of the selection (int)

options:
  -h, --help  show this help message and exit
```


## fastools_splitseq

### Tool Description
Split a FASTA/FASTQ file based on containing part of the sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools splitseq [-h] INPUT OUTPUT OUTPUT SEQ

Split a FASTA/FASTQ file based on containing part of the sequence

positional arguments:
  INPUT       input file
  OUTPUT      output files
  SEQ         a sequence (str)

options:
  -h, --help  show this help message and exit
```


## fastools_tagcount

### Tool Description
Count tags in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools tagcount [-h] [-m MISMATCHES] INPUT SEQ

Count tags in a FASTA file.

positional arguments:
  INPUT          input file
  SEQ            a sequence (str)

options:
  -h, --help     show this help message and exit
  -m MISMATCHES  amount of mismatches allowed (int default=2)
```


## Metadata
- **Skill**: not generated

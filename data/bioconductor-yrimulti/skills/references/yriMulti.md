yriMulti – HapMap YRI population, multias-
say interfaces

Vincent J. Carey, stvjc at channing.harvard.edu

May 2016

Contents

1

2

3

Introduction .

.

.

.

.

.

Basic data resources .

Expression data .

Methylation data .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

DnaseI hypersensitivity data .

Genotype data .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Some computations focused on methylation-expression asso-
ciation .
.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

3.1

3.2

Gene-centric selection .

.

.

.

.

.

.

.

.

.

.

.

DNA-methylation association with expression .

.

.

4

Using the MultiAssayExperiment infrastructure .

Construction of the MultiAssayExperiment .

Restriction by range .

.

All pairwise regressions .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Integrating dense genotypes in a VcfStack instance .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2.1

2.2

2.3

2.4

4.1

4.2

4.3

4.4

2

2

2

2

3

3

4

4

5

6

6

7

8

11

yriMulti – HapMap YRI population, multiassay interfaces

1

Introduction

The EBV-transformed B-cells from Yoruban donors are assayed for genotype and various
genomic features in a number of prominent studies. This package helps work with relevant
datasets and data structures as use cases for MultiAssayExperiment package development. A
particular concern is accommodation of distributed genotype data, in this case, based on the
1000 genomes VCF ﬁles in an S3 bucket.

2

Basic data resources

2.1

Expression data

We will use the RNA-seq expression data in the geuvPack package.

library(geuvPack)

data(geuFPKM)

geuFPKM

## class: RangedSummarizedExperiment

## dim: 23722 462

## metadata(3): MIAME constrHist colDataSource

## assays(1): exprs

## rownames(23722): ENSG00000152931.6 ENSG00000183696.9 ...

##

ENSG00000257337.1 ENSG00000177494.5

## rowData names(18): source type ... tag ccdsid

## colnames(462): HG00096 HG00097 ... NA20826 NA20828
## colData names(35): Source.Name Comment.ENA_SAMPLE. ...
##

Factor.Value.laboratory. popcode

2.2 Methylation data

We have added 450k data from Banovich, Lan, McVicker, van de Geijn, Degner, Blischak,
Roux, Pritchard, and Gilad (2014) paper to the yriMulti package.

library(yriMulti)

data(banovichSE)

banovichSE

## class: RangedSummarizedExperiment

## dim: 329469 64

## metadata(0):

## assays(1): betas

## rownames(329469): cg00000029 cg00000165 ... ch.9.98989607R

##

ch.9.991104F

## rowData names(10): addressA addressB ... probeEnd probeTarget

## colnames(64): NA18498 NA18499 ... NA18489 NA18909
## colData names(35): title geo_accession ... data_row_count naid

2

yriMulti – HapMap YRI population, multiassay interfaces

2.3

DnaseI hypersensitivity data

library(dsQTL)
if (!exists("DHStop5_hg19")) data(DHStop5_hg19)

DHStop5_hg19
## class: RangedSummarizedExperiment

## dim: 1465442 70

## metadata(2): MIAME annotation

## assays(1): scores
## rownames(1465442): dhs_chr1_10402 dhs_chr1_10502 ...
##

dhs_chr22_51228236 dhs_chr22_51234736

## rowData names(0):

## colnames(70): NA18486 NA18498 ... NA19239 NA19257

## colData names(9): naid one ... male isFounder

2.4

Genotype data

We take advantage of a function (gtpath) that generates paths to S3-resident VCF from the
1000 genomes project.

litvcf = readVcf(gtpath(20),

param=ScanVcfParam(which=GRanges("20",

IRanges(3.7e7,3.701e7))), genome="hg19")

litvcf

## class: CollapsedVCF

## dim: 347 2504

## rowRanges(vcf):

##

GRanges with 5 metadata columns: paramRangeID, REF, ALT, QUAL, FILTER

## info(vcf):

##

DataFrame with 27 columns: CIEND, CIPOS, CS, END, IMPRECISE, MC, MEINFO...

## info(header(vcf)):

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

CIEND

CIPOS

CS

END

IMPRECISE

MC

MEINFO

MEND

MLEN

MSTART

SVLEN

SVTYPE

TSD

AC

AF

Number Type

Description

2

2

1

1

0

.

4

1

1

1

.

1

1

A

A

Integer Confidence interval around END for imprec...

Integer Confidence interval around POS for imprec...

String Source call set.

Integer End coordinate of this variant

Flag

Imprecise structural variation

String Merged calls.

String Mobile element info of the form NAME,STAR...

Integer Mitochondrial end coordinate of inserted ...

Integer Estimated length of mitochondrial insert

Integer Mitochondrial start coordinate of inserte...

Integer SV length. It is only calculated for stru...

String Type of structural variant

String Precise Target Site Duplication for bases...

Integer Total number of alternate alleles in call...

Float

Estimated allele frequency in the range (...

3

yriMulti – HapMap YRI population, multiassay interfaces

##

##

##

##

##

##

##

##

##

##

##

##

NS

AN
EAS_AF
EUR_AF
AFR_AF
AMR_AF
SAS_AF
DP

AA

1

1

A

A

A

A

A

1

1

.

VT
EX_TARGET
0
MULTI_ALLELIC 0

Integer Number of samples with data

Integer Total number of alleles in called genotypes

Float

Float

Float

Float

Float

Allele frequency in the EAS populations c...

Allele frequency in the EUR populations c...

Allele frequency in the AFR populations c...

Allele frequency in the AMR populations c...

Allele frequency in the SAS populations c...

Integer Total read depth; only low coverage data ...

String Ancestral Allele. Format: AA|REF|ALT|Inde...

String indicates what type of variant the line r...

Flag

Flag

indicates whether a variant is within the...

indicates whether a site is multi-allelic

## geno(vcf):

##

SimpleList of length 1: GT

## geno(header(vcf)):

##

##

Number Type

Description

GT 1

String Genotype

length(colnames(litvcf))

## [1] 2504

length(intersect(colnames(litvcf), colnames(banovichSE)))

## [1] 52

length(intersect(colnames(litvcf), colnames(geuFPKM)))

## [1] 445
length(intersect(colnames(litvcf), colnames(DHStop5_hg19)))
## [1] 59

3

Some computations focused on methylation-
expression association

The yriMulti package is currently a scratch-pad for some integrative infrastructure thoughts.

3.1

Gene-centric selection

With mexGR, a GRanges instance is formed with methylation scores for CpG near a gene. The
assay data are placed in the mcols, with one range devoted to the expression measures.

m1 = mexGR(banovichSE, geuFPKM, symbol="ORMDL3")

m1

## mexGR instance with 44 metadata columns:

## NA18498, NA18499, ..., NA18909, type

## and 7 ranges

mcols(m1)[1:4,1:4]

## DataFrame with 4 rows and 4 columns

##

##

NA18498

NA18499

NA18502

NA18517

<numeric>

<numeric>

<numeric>

<numeric>

## cg01482279 -0.592058106 -0.177502568 -0.00553931 -1.566010118

## cg02305874 -0.463354922 0.287661199 0.553863032 -1.096806505

4

yriMulti – HapMap YRI population, multiassay interfaces

## cg04145193 -0.22453404 -1.179221562 1.090713571

0.453933061

## cg12655416 -0.158362114 -0.899115621 1.020870227

0.53997149

table(mcols(m1)$type)

##

## expr meth

##

1

6

3.2

DNA-methylation association with expression

bindelms computes the regressions of the selected gene’s expression values on the methylation
scores. We have options to transform the expression value (parameter ytx is a function) and
can indicate the radius around the gene coding region to search for CpG (parameter gradius).

We’ll examine a region around gene BRCA2 for a CpG whose methylation score is negatively
associated with BRCA2 expression.

b1 = bindelms(geuFPKM, banovichSE, symbol="BRCA2", ytx=log,

gradius=20000)

b1

## class: RangedSummarizedExperiment

## dim: 29 43

## metadata(6): theCall symbol ... pwd txexpr

## assays(1): betas

## rownames(29): cg00031759 cg00214044 ... cg26458617 cg26941801

## rowData names(15): addressA addressB ... t p

## colnames(43): NA18498 NA18499 ... NA18489 NA18909
## colData names(35): title geo_accession ... data_row_count naid
mcols(b1)[1:3,]

## DataFrame with 3 rows and 15 columns

##

##

addressA

addressB channel platform percentGC

<character> <character>

<Rle>

<Rle> <numeric>

## cg00031759

11602350

## cg00214044

33707391

## cg00785980

12675375

Both

Both

Both

HM450

HM450

HM450

0.5

0.62

0.54

##

##

sourceSeq probeType

probeStart

probeEnd

<DNAStringSet>

<Rle> <character> <character>

## cg00031759 CGGGTATTTC...GCATCCCAAC

## cg00214044 CGGGCACCAG...ACCCATATTT

## cg00785980 GCCCACCTGA...TTCATTCCCG

cg

cg

cg

32889486

32889535

32885906

32885955

32984237

32984286

##

##

probeTarget

<numeric>

## cg00031759

32889534

## cg00214044

32885906

## cg00785980

32984237

##

##

lms

<list>

## cg00031759

list(coefficients = c(`(Intercept)` = 1.71061243102637, `df[, i]` = 0.00740906714807691), residuals = c(`1` = 0.219325797562873, `2` = 1.01220892062976, `3` = -0.547746926935716, `4` = 0.418972067138508, `5` = -0.909339882856854, `6` = -1.20111612958034, `7` = -0.0147992425287601, `8` = -0.493860936903254, `9` = 0.227099020778614, `10` = 0.0998794143226993, `11` = -0.235152833480107, `12` = 0.841088132893405, `13` = 0.360982463847293, `14` = -0.311938388498727, `15` = 0.831361840229042, `16` = -0.000954861239172641, \n`17` = -0.325544637911612, `18` = 0.263100901549202, `19` = 0.259503290649143, `20` = 0.2120401294836, `21` = 0.81956401707551, `22` = -0.2076811084661, `23` = 0.0146389908307824, `24` = -0.220584600754259, `25` = -0.499347464331176, `26` = -0.151695618892318, `27` = 1.1033029330379, `28` = 0.206721310080529, `29` = 0.00553267773561049, `30` = -0.648459725270396, `31` = -0.300833203969147, `32` = -0.163461987201485, `33` = 0.316899890778484, `34` = -0.507749977842189, `35` = 0.123431820850171, `36` = 0.293005288370279, \n`37` = 0.192476284227004, `38` = -0.305179151507846, `39` = -0.434792611689618, `40` = 0.0520252557719296, `41` = -0.352944759125987, `42` = -0.0668031141843947, `43` = 0.0268267153271268), effects = c(`(Intercept)` = -11.2155821874919, `df[, i]` = 0.0360572418223725, -0.77172638236345, 0.508964712870003, -0.768960491318184, -1.33223591537122, -0.159478103058431, -0.267414594370561, 0.227276508181915, 0.0338308912728517, -0.125698745827918, 0.771276446135224, 0.426050036949869, -0.362416524075495, \n0.92546552795241, 0.117923356346592, -0.835512243351397, -0.00836910057185314, 0.338060260367096, 0.110477381532309, 0.79990437334897, -0.126986330023749, -0.00125231032060321, -0.285684628761117, -0.657004171831414, -0.220800507287502, 0.985857428951494, 0.291662571042292, -0.178665774521929, -0.660675612100115, -0.177822994057138, -0.425741159237773, 0.278423701658446, -0.602418115722503, 0.0902238629107786, 0.0388383530760439, -0.0193492760079409, -0.384490057964996, -0.453906519012563, 0.064286256023691, \n-0.261079198801465, 0.108455427546819, -0.059989651699486), rank = 2, fitted.values = c(`1` = 1.71432284669586, `2` = 1.7086377641903, `3` = 1.70328919125304, `4` = 1.71552124514003, `5` = 1.71748426474473, `6` = 1.70690691549903, `7` = 1.70637866686722, `8` = 1.72083735114496, `9` = 1.71202213215361, `10` = 1.70944202989105, `11` = 1.71627944437306, `12` = 1.70929542061877, `13` = 1.71455018806073, `14` = 1.71004863735047, `15` = 1.71568140741875, `16` = 1.71664659949532, `17` = 1.69214736543772, \n`18` = 1.70143900480613, `19` = 1.71507572209924, `20` = 1.70805842952928, `21` = 1.71124929642698, `22` = 1.71515900909009, `23` = 1.71139610746297, `24` = 1.70947898235413, `25` = 1.70587306231543, `26` = 1.70932295680951, `27` = 1.70743965248444, `28` = 1.71532444800271, `29` = 1.70483902123048, `30` = 1.71153929810275, `31` = 1.7168075779791, `32` = 1.70179707078857, `33` = 1.71051622174814, `34` = 1.70832703696799, `35` = 1.71072146701501, `36` = 1.70211311580215, `37` = 1.70376269542869, `38` = 1.70892534007081, \n`39` = 1.71127055779725, `40` = 1.71249289430019, `41` = 1.71559421210793, `42` = 1.71884312320098, `43` = 1.70863293447874), assign = 0:1, qr = list(qr = c(-6.557438524302, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, \n0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.223195152280255, 4.8666372030022, 0.210648074726806, \n-0.128591791351877, -0.183033548554685, 0.110315268801026, 0.124965547222441, -0.276026973197232, -0.0315485121222979, 0.0400072179381175, -0.149619446122787, 0.0440732325544922, -0.101660805224711, 0.0231837608804406, -0.133033680709618, -0.159802008728734, 0.519651904531976, 0.261960553258378, -0.116235797984854, 0.0783795473743037, -0.0101149335239893, -0.11854565272255, -0.0141865437906795, 0.0389823901582856, 0.138987821978797, 0.0433095526570659, 0.0955405118177759, -0.123133882555303, 0.167665586352501, \n-0.0181577471481185, -0.164266534456396, 0.252030065945663, 0.0102159249051047, 0.0709300746711329, 0.00452371838868085, 0.243264974729559, 0.197516061524635, 0.0543369279803987, -0.0107045895596251, -0.0446044787681788, -0.130615433877341, -0.220719693905084, 0.0624464110492524), qraux = c(1.1524985703326, 1.06231246537531), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 41, xlevels = list(), call = lm(formula = df[, yind] ~ df[, i]), terms = df[, yind] ~ df[, i], model = list(`df[, yind]` = c(1.93364864425874, \n2.72084668482006, 1.15554226431733, 2.13449331227854, 0.808144381887874, 0.505790785918688, 1.69157942433846, 1.2269764142417, 1.93912115293223, 1.80932144421375, 1.48112661089296, 2.55038355351218, 2.07553265190802, 1.39811024885174, 2.54704324764779, 1.71569173825615, 1.36660272752611, 1.96453990635533, 1.97457901274838, 1.92009855901288, 2.53081331350249, 1.50747790062399, 1.72603509829375, 1.48889438159987, 1.20652559798426, 1.55762733791719, 2.81074258552233, 1.92204575808324, 1.71037169896609, \n1.06307957283236, 1.41597437400996, 1.53833508358709, 2.02741611252663, 1.2005770591258, 1.83415328786518, 1.99511840417243, 1.89623897965569, 1.40374618856297, 1.27647794610763, 1.76451815007212, 1.36264945298195, 1.65204000901659, 1.73545964980587), `df[, i]` = c(0.500793905, -0.266520305, -0.9884159, 0.662541453, 0.927489734, -0.500132534, -0.571430124, 1.380054994, 0.19026702, -0.157968758, 0.76487542, -0.177756576, 0.531478114, -0.076095096, 0.684158517, 0.814430258, -2.492225434, -1.238135117, \n0.602409316, -0.344712964, 0.085957569, 0.613650541, 0.105772619, -0.152981293, -0.639671448, -0.174040023, -0.428229152, 0.635979791, -0.779235723, 0.125099025, 0.836157485, -1.189807038, -0.012985343, -0.308459083, 0.014716561, -1.147150519, -0.924507156, -0.227706258, 0.088827211, 0.253805673, 0.672389787, 1.110894531, -0.26717217)))

## cg00214044 list(coefficients = c(`(Intercept)` = 1.70619587753478, `df[, i]` = 0.0396189079256385), residuals = c(`1` = 0.233507135447547, `2` = 1.02347152679434, `3` = -0.564098505822397, `4` = 0.422769333839255, `5` = -0.894272315649354, `6` = -1.24572629052158, `7` = -0.0349013012894086, `8` = -0.432296544284284, `9` = 0.266780171354007, `10` = 0.0991512250503073, `11` = -0.248467820214878, `12` = 0.834326142044457, `13` = 0.349139688817186, `14` = -0.278418575776831, `15` = 0.840969815240139, `16` = -0.0180767833471003, \n`17` = -0.357788207283546, `18` = 0.237345539047136, `19` = 0.232820119605088, `20` = 0.152802827538824, `21` = 0.817517720377555, `22` = -0.22895614845851, `23` = 0.00772089541721777, `24` = -0.263692832366972, `25` = -0.481281448494881, `26` = -0.114419024823263, `27` = 1.09110869009513, `28` = 0.217851738983384, `29` = -0.0462485142846892, `30` = -0.610769973029822, `31` = -0.255750975815892, `32` = -0.18300445958917, `33` = 0.328590592492499, `34` = -0.467356934623524, `35` = 0.104391832435022, \n`36` = 0.362045822794185, `37` = 0.152060989472434, `38` = -0.293003331519369, `39` = -0.460002334674722, `40` = 0.0514144613890223, `41` = -0.328949863938489, `42` = -0.0786147231146088, `43` = 0.0603106406885502), effects = c(`(Intercept)` = -11.2155821874919, `df[, i]` = 0.188515947174658, -0.542266892821387, 0.405340172560469, -0.957857933796139, -1.06581442053091, 0.0208508642112904, -0.709839616788833, 0.0540437431001239, 0.0740166959252759, -0.17727423694694, 0.838387243794398, 0.404456624329904, \n-0.470386747527286, 0.795518593927477, 0.0738168550649748, -0.312399685126068, 0.296636780222421, 0.364339427772778, 0.410963846573798, 0.807882475089334, -0.12384368648008, 0.0229738260608016, -0.0784739605668306, -0.617318917618929, -0.328616520151513, 1.11290621017735, 0.163080173717261, 0.158970716315896, -0.816025163418653, -0.471540431127202, -0.152748329780893, 0.247195688124368, -0.701948397208367, 0.176413718943219, -0.0454295672659537, 0.29557702894753, -0.384693487877986, -0.354660601496422, \n0.0408275279347787, -0.446180791291894, -0.00216291900141927, -0.138500280926345), rank = 2, fitted.values = c(`1` = 1.70014150881119, `2` = 1.69737515802571, `3` = 1.71964077013972, `4` = 1.71172397843928, `5` = 1.70241669753723, `6` = 1.75151707644027, `7` = 1.72648072562787, `8` = 1.65927295852599, `9` = 1.67234098157822, `10` = 1.71017021916344, `11` = 1.72959443110784, `12` = 1.71605741146772, `13` = 1.72639296309084, `14` = 1.67652882462857, `15` = 1.70607343240765, `16` = 1.73376852160325, \n`17` = 1.72439093480965, `18` = 1.72719436730819, `19` = 1.7417588931433, `20` = 1.76729573147406, `21` = 1.71329559312493, `22` = 1.7364340490825, `23` = 1.71831420287653, `24` = 1.75258721396685, `25` = 1.68780704647914, `26` = 1.67204636274046, `27` = 1.7196338954272, `28` = 1.70419401909985, `29` = 1.75662021325078, `30` = 1.67384954586218, `31` = 1.67172534982585, `32` = 1.72133954317626, `33` = 1.69882552003413, `34` = 1.66793399374932, `35` = 1.72976145543016, `36` = 1.63307258137824, `37` = 1.74417799018326, \n`38` = 1.69674952008233, `39` = 1.73648028078235, `40` = 1.7131036886831, `41` = 1.69159931692044, `42` = 1.73065473213119, `43` = 1.67514900911732), assign = 0:1, qr = list(qr = c(-6.557438524302, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, \n0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, -0.689257013123291, \n4.75823178994452, -0.0564019363179822, -0.0144065941780126, 0.0349647244905004, -0.225492704384449, -0.0926851027591053, 0.263824614902165, 0.194504097205433, -0.00616453668033502, -0.109202036878642, -0.0373936840947221, -0.0922195583935111, 0.172289302578702, 0.0155672415441986, -0.131343879825984, -0.0815996171567709, -0.0964706800061124, -0.173729532922205, -0.309192016141737, -0.022743367322152, -0.145483412948809, -0.0493650395298183, -0.231169346295228, 0.112462948259103, 0.196066929645777, \n-0.0563654687796906, 0.0255367604945466, -0.252562758069561, 0.186501780655729, 0.197769771869042, -0.0654132325080108, 0.054014452414969, 0.217881365255945, -0.110088032598504, 0.402806900169884, -0.18656185335036, 0.0650267831111604, -0.145728653208535, -0.0217253927438147, 0.0923465045410229, -0.114826500162788, 0.179608659545212), qraux = c(1.1524985703326, 1.06170802969663), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 41, xlevels = list(), call = lm(formula = df[, yind] ~ df[, i]), terms = df[, \n

yind] ~ df[, i], model = list(`df[, yind]` = c(1.93364864425874, 2.72084668482006, 1.15554226431733, 2.13449331227854, 0.808144381887874, 0.505790785918688, 1.69157942433846, 1.2269764142417, 1.93912115293223, 1.80932144421375, 1.48112661089296, 2.55038355351218, 2.07553265190802, 1.39811024885174, 2.54704324764779, 1.71569173825615, 1.36660272752611, 1.96453990635533, 1.97457901274838, 1.92009855901288, 2.53081331350249, 1.50747790062399, 1.72603509829375, 1.48889438159987, 1.20652559798426, \n1.55762733791719, 2.81074258552233, 1.92204575808324, 1.71037169896609, 1.06307957283236, 1.41597437400996, 1.53833508358709, 2.02741611252663, 1.2005770591258, 1.83415328786518, 1.99511840417243, 1.89623897965569, 1.40374618856297, 1.27647794610763, 1.76451815007212, 1.36264945298195, 1.65204000901659, 1.73545964980587), `df[, i]` = c(-0.152815134, -0.222639138, 0.339355457, 0.139531885, -0.095388293, 1.143928525, 0.511999173, -1.184356699, -0.854513608, 0.100314265, 0.590590574, 0.248909787, 0.509784005, \n-0.748810466, -0.003090573, 0.695946595, 0.459251863, 0.530011827, 0.897627357, 1.542189251, 0.179200184, 0.763225771, 0.305872271, 1.170939303, -0.464142805, -0.861949927, 0.339181936, -0.050527855, 1.272734115, -0.816436731, -0.870052445, 0.382233293, -0.186031314, -0.965748068, 0.594806347, -1.845666627, 0.958686512, -0.238430536, 0.764392681, 0.174356425, -0.368424103, 0.617353074, -0.783637663)))

## cg00785980

list(coefficients = c(`(Intercept)` = 1.71120579164398, `df[, i]` = -0.0241223781711239), residuals = c(`1` = 0.216715043465388, `2` = 0.982080901541917, `3` = -0.555507290977021, `4` = 0.417940162155769, `5` = -0.877902495793164, `6` = -1.18013070696951, `7` = -0.0295963278692744, `8` = -0.474233213422787, `9` = 0.226484479226399, `10` = 0.118533772465624, `11` = -0.233872792174618, `12` = 0.85628935133028, `13` = 0.371832406354947, `14` = -0.30390766267996, `15` = 0.833370199963059, `16` = -0.006870802621892, \n`17` = -0.324599597385422, `18` = 0.252833984793422, `19` = 0.237318642178586, `20` = 0.212584818997146, `21` = 0.865650063002942, `22` = -0.215286768222027, `23` = 0.0130254217257263, `24` = -0.243921192403766, `25` = -0.552552519780912, `26` = -0.166995365333189, `27` = 1.05677707747949, `28` = 0.235383678731768, `29` = 0.0130004171930725, `30` = -0.694325728299252, `31` = -0.325275382334114, `32` = -0.154573287981271, `33` = 0.312704831051752, `34` = -0.498858418763644, `35` = 0.116793063781318, \n`36` = 0.317758807408997, `37` = 0.22435835463431, `38` = -0.289240923079242, `39` = -0.43218357014335, `40` = 0.0514230851098443, `41` = -0.349170679501277, `42` = -0.0691672096032317, `43` = 0.0453133727471676), effects = c(`(Intercept)` = -11.2155821874919, `df[, i]` = -0.138970508756578, -0.583149603225869, 0.358784585043733, -0.762380925801238, -1.06389119092415, -0.115220656479571, -0.445532670628416, 0.189754418982007, 0.206909830522985, -0.284131703742182, 0.925732407852061, 0.386271815537024, \n-0.279835306441141, 0.790705922409305, -0.1004358027458, -0.238597819298173, 0.221433357355749, 0.0595947214890593, 0.205188380010405, 1.10075007130501, -0.310009141370273, -0.0258404312791314, -0.396194465685719, -0.855203595815349, -0.272356735743222, 0.783400508261842, 0.347382639631091, 0.0636791059966035, -0.987398353287728, -0.525842294643727, -0.078340234126413, 0.264095687017348, -0.459999197230931, 0.0530162279660289, 0.483023244205672, 0.420995065929352, -0.213458730321512, -0.446152109299619, \n0.0120683031107316, -0.381225272051931, -0.154971713064545, 0.137362019605078), rank = 2, fitted.values = c(`1` = 1.71693360079335, `2` = 1.73876578327814, `3` = 1.71104955529435, `4` = 1.71655315012277, `5` = 1.68604687768104, `6` = 1.68592149288819, `7` = 1.72117575220773, `8` = 1.70120962766449, `9` = 1.71263667370583, `10` = 1.69078767174813, `11` = 1.71499940306758, `12` = 1.6940942021819, `13` = 1.70370024555308, `14` = 1.7020179115317, `15` = 1.71367304768473, `16` = 1.72256254087804, `17` = 1.69120232491153, \n`18` = 1.71170592156191, `19` = 1.7372603705698, `20` = 1.70751374001574, `21` = 1.66516325049955, `22` = 1.72276466884602, `23` = 1.71300967656803, `24` = 1.73281557400364, `25` = 1.75907811776517, `26` = 1.72462270325038, `27` = 1.75396550804285, `28` = 1.68666207935147, `29` = 1.69737128177302, `30` = 1.75740530113161, `31` = 1.74124975634407, `32` = 1.69290837156836, `33` = 1.71471128147487, `34` = 1.69943547788944, `35` = 1.71736022408386, `36` = 1.67735959676343, `37` = 1.67188062502138, `38` = 1.69298711164221, \n`39` = 1.70866151625098, `40` = 1.71309506496228, `41` = 1.71182013248322, `42` = 1.72120721861982, `43` = 1.6901462770587), assign = 0:1, qr = list(qr = c(-6.557438524302, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, \n0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, 0.152498570332605, -0.229852695441081, 5.76106169013366, -0.0012986886253805, \n0.0383039211489139, -0.181212238896, -0.182114479191205, 0.0715671086145482, -0.0721045575676616, 0.0101218525072859, -0.147098568956208, 0.0271235126644309, -0.123305532121565, -0.0541826408180416, -0.0662883317047473, 0.0175793626522611, 0.0815461227428739, -0.144114819618922, 0.00342437293228332, 0.187308343974333, -0.0267416067685812, -0.331486044240361, 0.0830005893760555, 0.0128058958020282, 0.155324604359886, 0.344303863315668, 0.0963705800380047, 0.307514692950946, -0.176785388365363, -0.0997244168155684, \n0.332266657375179, 0.216015051677747, -0.131838498030295, 0.0250502555735625, -0.0848709336205265, 0.0441114408040668, -0.243723925694418, -0.283149353370185, -0.131271902465871, -0.0184824714634537, 0.0134203311596746, 0.00424620860332092, 0.071793533719878, -0.151713898461451), qraux = c(1.1524985703326, 1.19814094955238), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 41, xlevels = list(), call = lm(formula = df[, yind] ~ df[, i]), terms = df[, yind] ~ df[, i], model = list(`df[, yind]` = c(1.93364864425874, \n2.72084668482006, 1.15554226431733, 2.13449331227854, 0.808144381887874, 0.505790785918688, 1.69157942433846, 1.2269764142417, 1.93912115293223, 1.80932144421375, 1.48112661089296, 2.55038355351218, 2.07553265190802, 1.39811024885174, 2.54704324764779, 1.71569173825615, 1.36660272752611, 1.96453990635533, 1.97457901274838, 1.92009855901288, 2.53081331350249, 1.50747790062399, 1.72603509829375, 1.48889438159987, 1.20652559798426, 1.55762733791719, 2.81074258552233, 1.92204575808324, 1.71037169896609, \n1.06307957283236, 1.41597437400996, 1.53833508358709, 2.02741611252663, 1.2005770591258, 1.83415328786518, 1.99511840417243, 1.89623897965569, 1.40374618856297, 1.27647794610763, 1.76451815007212, 1.36264945298195, 1.65204000901659, 1.73545964980587), `df[, i]` = c(-0.237447946, -1.142507237, 0.006476822, -0.221676256, 1.042969884, 1.048167746, -0.413307531, 0.414393801, -0.05931762, 0.846438927, -0.157265233, 0.709365774, 0.311144533, 0.380886165, -0.102280796, -0.470797247, 0.829249363, -0.020733027, \n-1.080099928, 0.153055043, 1.908706547, -0.479176519, -0.074780559, -0.895839631, -1.9845608, -0.55620186, -1.77261612, 1.017466525, 0.573513514, -1.915213714, -1.245481042, 0.758524717, -0.145321071, 0.487941681, -0.255133735, 1.403103568, 1.630235889, 0.755260525, 0.105473655, -0.078320359, -0.025467673, -0.41461198, 0.873028125)))

##

slope

se

t

5

yriMulti – HapMap YRI population, multiassay interfaces

##

<numeric>

<numeric>

<numeric>

## cg00031759 0.00740906714807691 0.100650797876406 0.0736116086945963

## cg00214044 0.0396189079256385 0.102764594709113

0.385530717440033

## cg00785980 -0.0241223781711239 0.0849465400590847 -0.283971285403096

##

##

p

<numeric>

## cg00031759 0.941677399846048

## cg00214044 0.701837353572534

## cg00785980 0.777861586114457

summary(mcols(b1)$t)

##

Min. 1st Qu. Median

Mean 3rd Qu.

Max.

## -1.4738 -0.3809 0.3426 0.2091

0.5894

1.6641

mintind = which.min(mcols(b1)$t)

mincpg = names(b1)[mintind]

mincpg

## [1] "cg20073910"

plotEvM(b1)

4

Using the MultiAssayExperiment infrastructure

4.1

Construction of the MultiAssayExperiment

We will use a uniﬁed object design to reproduce the BRCA2 display just obtained.

We need a list of relevant objects and a phenodata component.

library(MultiAssayExperiment)
myobs = list(geuvRNAseq=geuFPKM, yri450k=banovichSE, yriDHS=DHStop5_hg19)
cold = colData(geuFPKM)

suppressWarnings({

library(MultiAssayExperiment)

mm = MultiAssayExperiment(myobs, as.data.frame(cold))

6

−1.5−1.0−0.50.00.51.01.50.51.01.52.02.5cg20073910log FPKM BRCA2yriMulti – HapMap YRI population, multiassay interfaces

})

mm

## A MultiAssayExperiment object of 3 listed

##

##

##

##

##

experiments with user-defined names and respective classes.

Containing an ExperimentList class object of length 3:

[1] geuvRNAseq: RangedSummarizedExperiment with 23722 rows and 462 columns

[2] yri450k: RangedSummarizedExperiment with 329469 rows and 43 columns

[3] yriDHS: RangedSummarizedExperiment with 1465442 rows and 50 columns

## Features:

##

##

##

experiments() - obtain the ExperimentList instance

colData() - the primary/phenotype DataFrame

sampleMap() - the sample availability DataFrame

`$`, `[`, `[[` - extract colData columns, subset, or experiment

##
## *Format() - convert into a long or wide DataFrame
##

assays() - convert ExperimentList to a SimpleList of matrices

4.2

Restriction by range

We compute the BRCA2 ‘gene range’.

library(erma)

brr = range(genemodel("BRCA2"))

## 'select()' returned 1:many mapping between keys and columns

## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =

## dec, : EOF within quoted string

## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =

## dec, : EOF within quoted string

brr

## GRanges object with 1 range and 0 metadata columns:

##

##

##

##

##

seqnames

<Rle>

ranges strand

<IRanges>

<Rle>

[1]

chr13 32889617-32973809

+

-------

seqinfo: 1 sequence from hg19 genome

Subset the multiassay structure to features in the vicinity of this range.

.subsetByRanges = function(ma, r) {

subsetByRow(ma,r)

}

newmm = .subsetByRanges(mm, brr+20000)

newmm

## A MultiAssayExperiment object of 3 listed

##

##

##

##

##

experiments with user-defined names and respective classes.

Containing an ExperimentList class object of length 3:

[1] geuvRNAseq: RangedSummarizedExperiment with 3 rows and 462 columns

[2] yri450k: RangedSummarizedExperiment with 29 rows and 43 columns

[3] yriDHS: RangedSummarizedExperiment with 32 rows and 50 columns

## Features:

7

yriMulti – HapMap YRI population, multiassay interfaces

##

##

##

experiments() - obtain the ExperimentList instance

colData() - the primary/phenotype DataFrame

sampleMap() - the sample availability DataFrame

`$`, `[`, `[[` - extract colData columns, subset, or experiment

##
## *Format() - convert into a long or wide DataFrame
##

assays() - convert ExperimentList to a SimpleList of matrices

We now have all the relevant features and samples. In fact we have more genes than we really
wanted. But we will proceed with this selection.

4.3

All pairwise regressions

We will introduce a formula idiom to specify a collection of models of interest.

library(doParallel)

## Loading required package: foreach

## Loading required package: iterators

registerDoSEQ()
allLM_pw = function(fmla, mae, xtx=force, ytx=force) {
#

# formula specifies dependent and independent assays

# form all regressions of ytx(dep) on xtx(indep) for all

# pairs of dependent and independent variables defined by

# assays for samples held in common

#

lf = as.list(fmla)

nms = lapply(lf, as.character)

yel = experiments(mae)[[nms[[2]]]]

xel = experiments(mae)[[nms[[3]]]]

sy = colnames(yel)

sx = colnames(xel)

sb = intersect(sy,sx)

yel = yel[,sb]

xel = xel[,sb]

vdf = as.matrix(expand.grid( rownames(yel),

rownames(xel), stringsAsFactors=FALSE ))

allf = apply(vdf, 1, function(x) as.formula(paste(x, collapse="~")))

alllm = foreach (i = 1:length(allf)) %dopar% {

df = data.frame(ytx(assay(yel)[vdf[i,1],]), xtx(assay(xel)[vdf[i,2],]))

names(df) = vdf[i,]

lm(allf[[i]], data=df)

}

names(alllm) = apply(vdf,1,function(x) paste(x, collapse="~"))

allts = lapply(alllm, function(x) summary(x)$coef[2, "t value"])

list(mods=alllm, tslopes=allts)

}

pwplot = function(fmla1, fmla2, mae, ytx=force, xtx=force, ...) {

#

# use fmla1 with assays as components to identify

#

two assays to regard as sources of y and x

8

yriMulti – HapMap YRI population, multiassay interfaces

# fmla2 indicates which features to plot

#

lf = as.list(fmla1)

nms = lapply(lf, as.character)

yel = experiments(mae)[[nms[[2]]]]

xel = experiments(mae)[[nms[[3]]]]

sy = colnames(yel)

sx = colnames(xel)

sb = intersect(sy,sx)

yel = yel[,sb]

xel = xel[,sb]

lf2 = lapply(as.list(fmla2), as.character)

ndf = data.frame( ytx(assay(yel)[ lf2[[2]], ]), xtx(assay(xel)[ lf2[[3]], ]) )

names(ndf) = c(lf2[[2]], lf2[[3]])

plot(fmla2, ndf, ...)

}

pp = allLM_pw(geuvRNAseq~yri450k, newmm, ytx=log)
## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

9

yriMulti – HapMap YRI population, multiassay interfaces

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

## Warning in ytx(assay(yel)[vdf[i, 1], ]): NaNs produced

names(pp)

## [1] "mods"

"tslopes"

summary(pp[[1]][[1]])

##

## Call:

## lm(formula = allf[[i]], data = df)

##

## Residuals:

##

Min

1Q

Median

3Q

Max

## -1.20112 -0.30856 0.00553 0.24330

1.10330

##

## Coefficients:

##

Estimate Std. Error t value Pr(>|t|)

## (Intercept) 1.710612

0.074777

22.876

<2e-16 ***

## cg00031759 0.007409

0.100651

0.074

0.942

## ---
## Signif. codes: 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##

## Residual standard error: 0.4898 on 41 degrees of freedom

## Multiple R-squared: 0.0001321, Adjusted R-squared:

-0.02425

## F-statistic: 0.005419 on 1 and 41 DF,

p-value: 0.9417

which.min(unlist(pp[[2]])) # not BRCA2 but FRY

## ENSG00000073910.13~cg05918473

##

23

The formula idiom can be used to isolate assays and features.

10

yriMulti – HapMap YRI population, multiassay interfaces

pwplot(geuvRNAseq~yri450k, ENSG00000139618.9~cg20073910, newmm, ytx=log)

4.4

Integrating dense genotypes in a VcfStack instance

We set up a reference to a collection of VCF. We’ll use 1000 genomes VCF for chr21, and
chr22. At present (16 Oct 2016) chrY must be kept out of the stack as it does not have the
full set of samples for other chromosomes.

library(gQTLstats)

library(VariantAnnotation)

library(GenomicFiles)

pa = paths1kg(paste0("chr", c(21:22))) #,"Y")))

sn = vcfSamples(scanVcfHeader(TabixFile(pa[1])))

library(Homo.sapiens) # necessary?

stopifnot(requireNamespace("GenomeInfoDb")) # indexVcf with S3 bucket? ->

ob = RangedVcfStack(VcfStack2(pa, seqinfo(Homo.sapiens)))

cd = DataFrame(id1kg=sn)

rownames(cd) = sn

colData(ob) = cd

Now we set up a region of interest and bind it to the stack. This yields an instance of Ranged
VcfStack, for which we have samples, features, and assay methods deﬁned in gQTLstats.

myr = GRanges("chr22", IRanges(20e6,20.01e6))

rowRanges(ob) = myr

colData(ob) = DataFrame(colData(ob), zz=runif(nrow(colData(ob))))

hasInternetConnectivity = function()

!is.null(nsl("www.r-project.org"))

#if (hasInternetConnectivity()) lka = assay(ob)
myobs = list(geuvRNAseq=geuFPKM, yri450k=banovichSE, yriDHS=DHStop5_hg19,

yriGeno=ob)

suppressWarnings({

mm = MultiAssayExperiment(myobs)

})

11

−1.5−1.0−0.50.00.51.01.50.51.01.52.02.5cg20073910ENSG00000139618.9yriMulti – HapMap YRI population, multiassay interfaces

mm

## A MultiAssayExperiment object of 4 listed

##

##

##

##

##

##

experiments with user-defined names and respective classes.

Containing an ExperimentList class object of length 4:

[1] geuvRNAseq: RangedSummarizedExperiment with 23722 rows and 462 columns

[2] yri450k: RangedSummarizedExperiment with 329469 rows and 64 columns

[3] yriDHS: RangedSummarizedExperiment with 1465442 rows and 70 columns

[4] yriGeno: RangedVcfStack with 2 rows and 2504 columns

## Features:

##

##

##

experiments() - obtain the ExperimentList instance

colData() - the primary/phenotype DataFrame

sampleMap() - the sample availability DataFrame

`$`, `[`, `[[` - extract colData columns, subset, or experiment

##
## *Format() - convert into a long or wide DataFrame
##

assays() - convert ExperimentList to a SimpleList of matrices

References

## No encoding supplied: defaulting to UTF-8.

12


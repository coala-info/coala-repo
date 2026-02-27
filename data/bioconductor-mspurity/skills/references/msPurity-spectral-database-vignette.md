# msPurity spectral database schema

Thomas N. Lawson

#### 2025-10-30

# 1 Spectral database schema

```
## Warning: `includeHTML()` was provided a `path` that appears to be a complete HTML document.
## ✖ Path: spectral-database-schema.html
## ℹ Use `tags$iframe()` to include an HTML document. You can either ensure `path` is accessible in your app or document (see e.g. `shiny::addResourcePath()`) and pass the relative path to the `src` argument. Or you can read the contents of `path` and pass the contents to `srcdoc`.
```

xml version="1.0" encoding="UTF-8" standalone="yes" ?

spectral-database

#### spectral-database-schema

[by DbSchema](https://www.dbschema.com)

1

spectral-database
Move the mouse over tables & columns to read the comments.

Base

XCMS

Fk Fk\_c\_peak\_X\_s\_peak\_meta
c\_peak\_X\_s\_peak\_meta ref c\_peaks ( cid )

cid

Fk Fk\_c\_peak\_X\_s\_peak\_meta
c\_peak\_X\_s\_peak\_meta ref s\_peak\_meta ( pid )

pid

Fk Fk\_s\_peak\_meta
s\_peak\_meta ref fileinfo ( fileid )

fileid

Fk fk\_s\_peak\_meta\_source
s\_peak\_meta ref source ( souceid -> id )

souceid

Fk fk\_s\_peak\_meta\_metab\_compound
s\_peak\_meta ref metab\_compound ( inchikey\_id )

inchikey\_id

Fk Fk\_s\_peaks
s\_peaks ref s\_peak\_meta ( pid )

pid

Fk Fk\_c\_peak\_X\_c\_peak\_group
c\_peak\_X\_c\_peak\_group ref c\_peak\_groups ( grpid )

grpid

Fk Fk\_c\_peak\_X\_c\_peak\_group
c\_peak\_X\_c\_peak\_group ref c\_peaks ( cid )

cid

c\_peaksTable Default.c\_peaks
Pk pk\_c\_peaks ( cid )
cidcid
\* integer
Referred by c\_peak\_X\_c\_peak\_group ( cid )
Referred by c\_peak\_X\_s\_peak\_meta ( cid )
mzmz
real
# mzminmzmin
real
# mzmaxmzmax
real
# rtrt
real
# rtminrtmin
real
# rtmaxrtmax
real
# \_into\_into
real
# intfintf
real
# maxomaxo
real
# maxfmaxf
real
# snsn
real
# fileidfileid
integer
References fileinfo ( fileid )

sourceTable Default.source
Pk pk\_source ( id )
idid
\* integer
Referred by s\_peak\_meta ( souceid -> id )
namename
text
t parsing\_softwareparsing\_software
text
t

metab\_compoundTable Default.metab\_compound
Pk pk\_metab\_compound ( inchikey\_id )
inchikey\_idinchikey\_id
\* integer
Referred by s\_peak\_meta ( inchikey\_id )
namename
text
t pubchem\_idpubchem\_id
real
# chemspider\_idchemspider\_id
real
# other\_namesother\_names
text
t exact\_massexact\_mass
real
# molecular\_formulamolecular\_formula
text
t molecular\_weightmolecular\_weight
real
# compound\_classcompound\_class
text
t smilessmiles
text
t created\_atcreated\_at
text
t updated\_atupdated\_at
text
t

c\_peak\_X\_s\_peak\_metaTable Default.c\_peak\_X\_s\_peak\_meta
Pk pk\_c\_peak\_X\_s\_peak\_meta ( cXp\_id )
cXp\_idcXp\_id
\* integer
# pidpid
integer
References s\_peak\_meta ( pid )
cidcid
integer
References c\_peaks ( cid )

s\_peak\_metaTable Default.s\_peak\_meta
Pk pk\_s\_peak\_meta ( pid )
pidpid
\* integer
Referred by c\_peak\_X\_s\_peak\_meta ( pid )
Referred by s\_peaks ( pid )
seqNumseqNum
real
# acquisitionNumacquisitionNum
real
# precursorIntensityprecursorIntensity
real
# precursorScanNumprecursorScanNum
real
# retentionTimeretentionTime
real
# precursorNearestprecursorNearest
real
# aMzaMz
real
# aPurityaPurity
real
# apkNmapkNm
real
# iMziMz
real
# iPurityiPurity
real
# ipkNmipkNm
real
# inPkNminPkNm
real
# inPurityinPurity
real
# purity\_pass\_flagpurity\_pass\_flag
text
t namename
text
t collision\_energycollision\_energy
text
t ms\_levelms\_level
text
t accessionaccession
text
t resolutionresolution
text
t polaritypolarity
text
t fragmentation\_typefragmentation\_type
text
t precursor\_typeprecursor\_type
text
t instrument\_typeinstrument\_type
text
t instrumentinstrument
text
t copyrightcopyright
text
t columncolumn
text
t mass\_accuracymass\_accuracy
text
t mass\_errormass\_error
text
t originorigin
text
t splashsplash
text
t retention\_indexretention\_index
text
t retention\_timeretention\_time
real
# inchikey\_idinchikey\_id
text
References metab\_compound ( inchikey\_id )
souceidsouceid
real
References source ( souceid -> id )
precursor\_mzprecursor\_mz
real
# spectrum\_typespectrum\_type
text
t grpidgrpid
text
t fileidfileid
integer
References fileinfo ( fileid )
--more--

c\_peak\_groupsTable Default.c\_peak\_groups
Pk pk\_c\_peak\_groups ( grpid )
grpidgrpid
\* integer
Referred by c\_peak\_X\_c\_peak\_group ( grpid )
Referred by s\_peaks ( grpid )
mzmz
real
# mzminmzmin
real
# mzmaxmzmax
real
# rtrt
real
# rtminrtmin
real
# rtmaxrtmax
real
# npeaksnpeaks
real
# grp\_namegrp\_name
text
t--more--

fileinfoTable Default.fileinfo
Pk pk\_fileinfo ( fileid )
fileidfileid
\* integer
Referred by c\_peaks ( fileid )
Referred by s\_peak\_meta ( fileid )
filenamefilename
text
t filepthfilepth
text
t nm\_savenm\_save
text
t classclass
text
t

s\_peaksTable Default.s\_peaks
Pk pk\_s\_peaks ( sid )
sidsid
\* integer
# fileidfileid
real
# mzmz
real
# ii
real
# snrsnr
real
# rara
real
# typetype
text
t ra\_pass\_flagra\_pass\_flag
text
t snr\_pass\_flagsnr\_pass\_flag
text
t pass\_flagpass\_flag
text
t scanscan
text
t purity\_pass\_flagpurity\_pass\_flag
text
t intensity\_pass\_flagintensity\_pass\_flag
text
t clcl
real
# rsdrsd
real
# countcount
real
# totaltotal
real
# inPurityinPurity
real
# fracfrac
real
# minnum\_pass\_flagminnum\_pass\_flag
text
t minfrac\_pass\_flagminfrac\_pass\_flag
text
t grpidgrpid
integer
References c\_peak\_groups ( grpid )
pidpid
integer
References s\_peak\_meta ( pid )

c\_peak\_X\_c\_peak\_groupTable Default.c\_peak\_X\_c\_peak\_group
Pk pk\_c\_peak\_X\_c\_peak\_group ( cXg\_id )
cXg\_idcXg\_id
\* integer
# idiidi
real
# bestpeakbestpeak
real
# grpidgrpid
integer
References c\_peak\_groups ( grpid )
cidcid
integer
References c\_peaks ( cid )
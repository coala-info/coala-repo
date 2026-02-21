hom.At.inp.db
April 16, 2019

hom.At.inp.db

Bioconductor annotation data package

Description

Welcome to the hom.At.inp.db annotation Package. The purpose of this package is to provide
detailed information about the hom.At.inp platform. Bioconductor attempts to update this package
biannually with the most recently available inparanoid data, but inparanoid data sources have not
historically updated that frequently. Please check inparanoid to learn more about when they have
last updated their databases.

You can learn what objects this package supports with the following command:

ls("package:hom.At.inp.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:hom.At.inp.db")

hom.At.inpMAPCOUNTS

Number of mapped keys for the maps in package hom.At.inp.db

Description

hom.At.inpMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map
in package hom.At.inp.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function deﬁned in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

1

hom.At.inpHOMSA

2

Examples

hom.At.inpMAPCOUNTS
mapnames <- names(hom.At.inpMAPCOUNTS)
hom.At.inpMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package hom.At.inp.db
checkMAPCOUNTS("hom.At.inp.db")

hom.At.inpORGANISM

The Organism for hom.At.inp

Description

hom.At.inpORGANISM is an R object that contains a single item: a character string that names the
organism for which hom.At.inp was built.

Details

Although the package name is suggestive of the organism for which it was built, hom.At.inpORGANISM
provides a simple way to programmatically extract the organism name.

Examples

hom.At.inpORGANISM

hom.At.inpHOMSA

Map between IDs for genes in one organism to their predicted par-
alogs in another

Description

A map of this type is an R object that provides mappings between identiﬁers for genes in the package
organism and their predicted paralogs in the map that the organism is named after. So for example,
if the inparanoid package is the human package, then the hom.At.inpRATNO map would provide
mappings between human and rat.

Details

Mappings between gene identiﬁers and their paralogs as predicted by the Inparanoid algorithm. The
map ﬁlters out paralogs that have an Inparanoid score less than 100

Mappings are normally given from the ID of the organism in the package to the IDs of the organism
listed in the map name.

Reversal can be made of ANY map by using the function revmap (see examples below).

Names for these maps are done in the "INPARANOID style" which means that they are normally
the 1st three letters of the genus followed by the 1st two letters of the species. For example: "Mus
musculus" becomes "MUSMU", "Homo sapiens" becomes "HOMSA", "Monodelphis domestica"
becomes "MONDO" etc. This means that for most of these organisms it will be possible to easily
guess the abbreviations used. An exception may occur in the future if a new model organism has a
very similar genus and species name to an existing one.

hom.At.inpHOMSA

References

http://inparanoid.sbc.su.se/download/current/sqltables

Examples

3

x <- hom.At.inpAPIME
# Get honeybee IDs that are paralogous to the pkg IDs
mapped_IDs <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_IDs])
if(length(xx) > 0) {

# Get the paralogs for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

#Now for the reverse map (honeybee IDs back to pkg paralog)
x <- revmap(hom.At.inpAPIME)
mapped_IDs <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_IDs])
if(length(xx) > 0) {

# Get the paralogs for the first five IDs
xx[1:5]
# Get the first one
xx[[1]]

}

## Not run:

#For the most common organisms, we try to ensure that you can
#map back to an Entrez Gene ID by providing you with necessary
#maps in the related organism based annotation packages.
The
#following example shows how to get from an Entrez Gene ID for
#Human to Entrez Gene IDs for Mouse even though inparanoid does
#not map to Entrez Gene IDs for either of these species.

#You will have to include the appropriate packages for
#humans:
library("org.Hs.eg.db")
#and for mouse:
library("org.Mm.eg.db")
#And of course you will need the inparanoid package:
library("hom.Hs.inp.db")

#Start with some Human Entrez Gene IDs
humanEGIds <- c("4488","4487")

#Inparanoid uses ensembl protein IDs so start with
#those. Notice that there will be many protein IDs returned for
#a typical gene since there are many possible translations.
humanProtIds <- mget(humanEGIds,org.Hs.egENSEMBLPROT)

#Map the IDs that we can from inparanoid. Notice that by design,
#inparanoid only represents each gene product with a single
#translation product. Therefore your list could slim down a lot

4

hom.At.inp_dbconn

#during this step. Also, if the thing you are trying to match
#up at this step has less than 100% seed status, you will not
#find it in this step.
rawMouseProtIds <- mget(unlist(humanProtIds),hom.Hs.inpMUSMU,ifnotfound=NA)
#This also means that we need to clean up the NAs from our result
mouseProtIds <- rawMouseProtIds[!is.na(rawMouseProtIds)]

#Then use the mouse organism based packages to convert these IDs
#back to an Entrez Gene ID again (this time for mouse).
mouseEGIds <- mget(unlist(mouseProtIds),

org.Mm.egENSEMBLPROT2EG,ifnotfound=NA)

#Now go ahead and have a look at the output
mouseEGIds

## End(Not run)

hom.At.inp_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

hom.At.inp_dbconn()
hom.At.inp_dbfile()
hom.At.inp_dbschema(file="", show.indices=FALSE)
hom.At.inp_dbInfo()

Arguments

file

A connection, or a character string naming the ﬁle to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

hom.At.inp_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by hom.At.inp_dbconn or you will
break all the AnnDbObj objects deﬁned in this package!

hom.At.inp_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite ﬁle).

hom.At.inp_dbschema prints the schema deﬁnition of the package annotation DB.

hom.At.inp_dbInfo prints other information about the package annotation DB.

hom.At.inp_dbconn

Value

5

hom.At.inp_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.

hom.At.inp_dbfile: a character string with the path to the package annotation DB.

hom.At.inp_dbschema: none (invisible NULL).

hom.At.inp_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "metadata" table:
dbGetQuery(hom.At.inp_dbconn(), "SELECT COUNT(*) FROM metadata")

hom.At.inp_dbschema()

hom.At.inp_dbInfo()

Index

∗Topic datasets

hom.At.inp.db, 1
hom.At.inp_dbconn, 4
hom.At.inpHOMSA, 2
hom.At.inpMAPCOUNTS, 1
hom.At.inpORGANISM, 2

∗Topic utilities

hom.At.inp_dbconn, 4

AnnDbObj, 4

cat, 4
checkMAPCOUNTS, 1
count.mappedkeys, 1

dbconn, 5
dbConnect, 5
dbDisconnect, 4
dbfile, 5
dbGetQuery, 5
dbInfo, 5
dbschema, 5

hom.At.inp (hom.At.inp.db), 1
hom.At.inp.db, 1
hom.At.inp_dbconn, 4
hom.At.inp_dbfile (hom.At.inp_dbconn), 4
hom.At.inp_dbInfo (hom.At.inp_dbconn), 4
hom.At.inp_dbschema

(hom.At.inp_dbconn), 4

hom.At.inpACYPI (hom.At.inpHOMSA), 2
hom.At.inpAEDAE (hom.At.inpHOMSA), 2
hom.At.inpANOGA (hom.At.inpHOMSA), 2
hom.At.inpAPIME (hom.At.inpHOMSA), 2
hom.At.inpARATH (hom.At.inpHOMSA), 2
hom.At.inpASPFU (hom.At.inpHOMSA), 2
hom.At.inpBATDE (hom.At.inpHOMSA), 2
hom.At.inpBOMMO (hom.At.inpHOMSA), 2
hom.At.inpBOSTA (hom.At.inpHOMSA), 2
hom.At.inpBRAFL (hom.At.inpHOMSA), 2
hom.At.inpBRUMA (hom.At.inpHOMSA), 2
hom.At.inpCAEBR (hom.At.inpHOMSA), 2
hom.At.inpCAEBRE (hom.At.inpHOMSA), 2
hom.At.inpCAEEL (hom.At.inpHOMSA), 2

6

hom.At.inpCAEJA (hom.At.inpHOMSA), 2
hom.At.inpCAERE (hom.At.inpHOMSA), 2
hom.At.inpCANAL (hom.At.inpHOMSA), 2
hom.At.inpCANFA (hom.At.inpHOMSA), 2
hom.At.inpCANGL (hom.At.inpHOMSA), 2
hom.At.inpCAPSP (hom.At.inpHOMSA), 2
hom.At.inpCAVPO (hom.At.inpHOMSA), 2
hom.At.inpCHLRE (hom.At.inpHOMSA), 2
hom.At.inpCIOIN (hom.At.inpHOMSA), 2
hom.At.inpCIOSA (hom.At.inpHOMSA), 2
hom.At.inpCOCIM (hom.At.inpHOMSA), 2
hom.At.inpCOPCI (hom.At.inpHOMSA), 2
hom.At.inpCRYHO (hom.At.inpHOMSA), 2
hom.At.inpCRYNE (hom.At.inpHOMSA), 2
hom.At.inpCRYPA (hom.At.inpHOMSA), 2
hom.At.inpCULPI (hom.At.inpHOMSA), 2
hom.At.inpCYAME (hom.At.inpHOMSA), 2
hom.At.inpDANRE (hom.At.inpHOMSA), 2
hom.At.inpDAPPU (hom.At.inpHOMSA), 2
hom.At.inpDEBHA (hom.At.inpHOMSA), 2
hom.At.inpDICDI (hom.At.inpHOMSA), 2
hom.At.inpDROAN (hom.At.inpHOMSA), 2
hom.At.inpDROGR (hom.At.inpHOMSA), 2
hom.At.inpDROME (hom.At.inpHOMSA), 2
hom.At.inpDROMO (hom.At.inpHOMSA), 2
hom.At.inpDROPS (hom.At.inpHOMSA), 2
hom.At.inpDROVI (hom.At.inpHOMSA), 2
hom.At.inpDROWI (hom.At.inpHOMSA), 2
hom.At.inpENTHI (hom.At.inpHOMSA), 2
hom.At.inpEQUCA (hom.At.inpHOMSA), 2
hom.At.inpESCCO (hom.At.inpHOMSA), 2
hom.At.inpFUSGR (hom.At.inpHOMSA), 2
hom.At.inpGALGA (hom.At.inpHOMSA), 2
hom.At.inpGASAC (hom.At.inpHOMSA), 2
hom.At.inpGIALA (hom.At.inpHOMSA), 2
hom.At.inpHELRO (hom.At.inpHOMSA), 2
hom.At.inpHOMSA, 2
hom.At.inpIXOSC (hom.At.inpHOMSA), 2
hom.At.inpKLULA (hom.At.inpHOMSA), 2
hom.At.inpLEIMA (hom.At.inpHOMSA), 2
hom.At.inpLOTGI (hom.At.inpHOMSA), 2
hom.At.inpMACMU (hom.At.inpHOMSA), 2
hom.At.inpMAGGR (hom.At.inpHOMSA), 2

INDEX

7

hom.At.inpMAPCOUNTS, 1
hom.At.inpMONBR (hom.At.inpHOMSA), 2
hom.At.inpMONDO (hom.At.inpHOMSA), 2
hom.At.inpMUSMU (hom.At.inpHOMSA), 2
hom.At.inpNASVI (hom.At.inpHOMSA), 2
hom.At.inpNEMVE (hom.At.inpHOMSA), 2
hom.At.inpNEUCR (hom.At.inpHOMSA), 2
hom.At.inpORGANISM, 2
hom.At.inpORNAN (hom.At.inpHOMSA), 2
hom.At.inpORYLA (hom.At.inpHOMSA), 2
hom.At.inpORYSA (hom.At.inpHOMSA), 2
hom.At.inpOSTTA (hom.At.inpHOMSA), 2
hom.At.inpPANTR (hom.At.inpHOMSA), 2
hom.At.inpPEDPA (hom.At.inpHOMSA), 2
hom.At.inpPHYPA (hom.At.inpHOMSA), 2
hom.At.inpPHYRA (hom.At.inpHOMSA), 2
hom.At.inpPHYSO (hom.At.inpHOMSA), 2
hom.At.inpPLAFA (hom.At.inpHOMSA), 2
hom.At.inpPLAVI (hom.At.inpHOMSA), 2
hom.At.inpPONPY (hom.At.inpHOMSA), 2
hom.At.inpPOPTR (hom.At.inpHOMSA), 2
hom.At.inpPRIPA (hom.At.inpHOMSA), 2
hom.At.inpPUCGR (hom.At.inpHOMSA), 2
hom.At.inpRATNO (hom.At.inpHOMSA), 2
hom.At.inpRHIOR (hom.At.inpHOMSA), 2
hom.At.inpSACCE (hom.At.inpHOMSA), 2
hom.At.inpSCHMA (hom.At.inpHOMSA), 2
hom.At.inpSCHPO (hom.At.inpHOMSA), 2
hom.At.inpSCLSC (hom.At.inpHOMSA), 2
hom.At.inpSORBI (hom.At.inpHOMSA), 2
hom.At.inpSTANO (hom.At.inpHOMSA), 2
hom.At.inpSTRPU (hom.At.inpHOMSA), 2
hom.At.inpTAKRU (hom.At.inpHOMSA), 2
hom.At.inpTETNI (hom.At.inpHOMSA), 2
hom.At.inpTETTH (hom.At.inpHOMSA), 2
hom.At.inpTHAPS (hom.At.inpHOMSA), 2
hom.At.inpTHEAN (hom.At.inpHOMSA), 2
hom.At.inpTHEPA (hom.At.inpHOMSA), 2
hom.At.inpTRIAD (hom.At.inpHOMSA), 2
hom.At.inpTRICA (hom.At.inpHOMSA), 2
hom.At.inpTRIVA (hom.At.inpHOMSA), 2
hom.At.inpTRYCR (hom.At.inpHOMSA), 2
hom.At.inpUSTMA (hom.At.inpHOMSA), 2
hom.At.inpXENTR (hom.At.inpHOMSA), 2
hom.At.inpYARLI (hom.At.inpHOMSA), 2

mappedkeys, 1


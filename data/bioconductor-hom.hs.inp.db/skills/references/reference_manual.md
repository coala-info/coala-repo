hom.Hs.inp.db
August 27, 2020

hom.Hs.inp.db

Bioconductor annotation data package

Description

Welcome to the hom.Hs.inp.db annotation Package. The purpose of this package is to provide
detailed information about the hom.Hs.inp platform. Bioconductor attempts to update this package
biannually with the most recently available inparanoid data, but inparanoid data sources have not
historically updated that frequently. Please check inparanoid to learn more about when they have
last updated their databases.

You can learn what objects this package supports with the following command:

ls("package:hom.Hs.inp.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:hom.Hs.inp.db")

hom.Hs.inpMAPCOUNTS

Number of mapped keys for the maps in package hom.Hs.inp.db

Description

hom.Hs.inpMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map
in package hom.Hs.inp.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function deﬁned in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

1

hom.Hs.inpHOMSA

2

Examples

hom.Hs.inpMAPCOUNTS
mapnames <- names(hom.Hs.inpMAPCOUNTS)
hom.Hs.inpMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package hom.Hs.inp.db
checkMAPCOUNTS("hom.Hs.inp.db")

hom.Hs.inpORGANISM

The Organism for hom.Hs.inp

Description

hom.Hs.inpORGANISM is an R object that contains a single item: a character string that names the
organism for which hom.Hs.inp was built.

Details

Although the package name is suggestive of the organism for which it was built, hom.Hs.inpORGANISM
provides a simple way to programmatically extract the organism name.

Examples

hom.Hs.inpORGANISM

hom.Hs.inpHOMSA

Map between IDs for genes in one organism to their predicted par-
alogs in another

Description

A map of this type is an R object that provides mappings between identiﬁers for genes in the package
organism and their predicted paralogs in the map that the organism is named after. So for example,
if the inparanoid package is the human package, then the hom.Hs.inpRATNO map would provide
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

hom.Hs.inpHOMSA

References

http://inparanoid.sbc.su.se/download/current/sqltables

Examples

3

x <- hom.Hs.inpAPIME
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
x <- revmap(hom.Hs.inpAPIME)
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

hom.Hs.inp_dbconn

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

hom.Hs.inp_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

hom.Hs.inp_dbconn()
hom.Hs.inp_dbfile()
hom.Hs.inp_dbschema(file="", show.indices=FALSE)
hom.Hs.inp_dbInfo()

Arguments

file

A connection, or a character string naming the ﬁle to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

hom.Hs.inp_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by hom.Hs.inp_dbconn or you will
break all the AnnDbObj objects deﬁned in this package!

hom.Hs.inp_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite ﬁle).

hom.Hs.inp_dbschema prints the schema deﬁnition of the package annotation DB.

hom.Hs.inp_dbInfo prints other information about the package annotation DB.

hom.Hs.inp_dbconn

Value

5

hom.Hs.inp_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.

hom.Hs.inp_dbfile: a character string with the path to the package annotation DB.

hom.Hs.inp_dbschema: none (invisible NULL).

hom.Hs.inp_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "metadata" table:
dbGetQuery(hom.Hs.inp_dbconn(), "SELECT COUNT(*) FROM metadata")

hom.Hs.inp_dbschema()

hom.Hs.inp_dbInfo()

Index

∗ datasets

hom.Hs.inp.db, 1
hom.Hs.inp_dbconn, 4
hom.Hs.inpHOMSA, 2
hom.Hs.inpMAPCOUNTS, 1
hom.Hs.inpORGANISM, 2

∗ utilities

hom.Hs.inp_dbconn, 4

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

hom.Hs.inp (hom.Hs.inp.db), 1
hom.Hs.inp.db, 1
hom.Hs.inp_dbconn, 4
hom.Hs.inp_dbfile (hom.Hs.inp_dbconn), 4
hom.Hs.inp_dbInfo (hom.Hs.inp_dbconn), 4
hom.Hs.inp_dbschema

(hom.Hs.inp_dbconn), 4

hom.Hs.inpACYPI (hom.Hs.inpHOMSA), 2
hom.Hs.inpAEDAE (hom.Hs.inpHOMSA), 2
hom.Hs.inpANOGA (hom.Hs.inpHOMSA), 2
hom.Hs.inpAPIME (hom.Hs.inpHOMSA), 2
hom.Hs.inpARATH (hom.Hs.inpHOMSA), 2
hom.Hs.inpASPFU (hom.Hs.inpHOMSA), 2
hom.Hs.inpBATDE (hom.Hs.inpHOMSA), 2
hom.Hs.inpBOMMO (hom.Hs.inpHOMSA), 2
hom.Hs.inpBOSTA (hom.Hs.inpHOMSA), 2
hom.Hs.inpBRAFL (hom.Hs.inpHOMSA), 2
hom.Hs.inpBRUMA (hom.Hs.inpHOMSA), 2
hom.Hs.inpCAEBR (hom.Hs.inpHOMSA), 2
hom.Hs.inpCAEBRE (hom.Hs.inpHOMSA), 2
hom.Hs.inpCAEEL (hom.Hs.inpHOMSA), 2

6

hom.Hs.inpCAEJA (hom.Hs.inpHOMSA), 2
hom.Hs.inpCAERE (hom.Hs.inpHOMSA), 2
hom.Hs.inpCANAL (hom.Hs.inpHOMSA), 2
hom.Hs.inpCANFA (hom.Hs.inpHOMSA), 2
hom.Hs.inpCANGL (hom.Hs.inpHOMSA), 2
hom.Hs.inpCAPSP (hom.Hs.inpHOMSA), 2
hom.Hs.inpCAVPO (hom.Hs.inpHOMSA), 2
hom.Hs.inpCHLRE (hom.Hs.inpHOMSA), 2
hom.Hs.inpCIOIN (hom.Hs.inpHOMSA), 2
hom.Hs.inpCIOSA (hom.Hs.inpHOMSA), 2
hom.Hs.inpCOCIM (hom.Hs.inpHOMSA), 2
hom.Hs.inpCOPCI (hom.Hs.inpHOMSA), 2
hom.Hs.inpCRYHO (hom.Hs.inpHOMSA), 2
hom.Hs.inpCRYNE (hom.Hs.inpHOMSA), 2
hom.Hs.inpCRYPA (hom.Hs.inpHOMSA), 2
hom.Hs.inpCULPI (hom.Hs.inpHOMSA), 2
hom.Hs.inpCYAME (hom.Hs.inpHOMSA), 2
hom.Hs.inpDANRE (hom.Hs.inpHOMSA), 2
hom.Hs.inpDAPPU (hom.Hs.inpHOMSA), 2
hom.Hs.inpDEBHA (hom.Hs.inpHOMSA), 2
hom.Hs.inpDICDI (hom.Hs.inpHOMSA), 2
hom.Hs.inpDROAN (hom.Hs.inpHOMSA), 2
hom.Hs.inpDROGR (hom.Hs.inpHOMSA), 2
hom.Hs.inpDROME (hom.Hs.inpHOMSA), 2
hom.Hs.inpDROMO (hom.Hs.inpHOMSA), 2
hom.Hs.inpDROPS (hom.Hs.inpHOMSA), 2
hom.Hs.inpDROVI (hom.Hs.inpHOMSA), 2
hom.Hs.inpDROWI (hom.Hs.inpHOMSA), 2
hom.Hs.inpENTHI (hom.Hs.inpHOMSA), 2
hom.Hs.inpEQUCA (hom.Hs.inpHOMSA), 2
hom.Hs.inpESCCO (hom.Hs.inpHOMSA), 2
hom.Hs.inpFUSGR (hom.Hs.inpHOMSA), 2
hom.Hs.inpGALGA (hom.Hs.inpHOMSA), 2
hom.Hs.inpGASAC (hom.Hs.inpHOMSA), 2
hom.Hs.inpGIALA (hom.Hs.inpHOMSA), 2
hom.Hs.inpHELRO (hom.Hs.inpHOMSA), 2
hom.Hs.inpHOMSA, 2
hom.Hs.inpIXOSC (hom.Hs.inpHOMSA), 2
hom.Hs.inpKLULA (hom.Hs.inpHOMSA), 2
hom.Hs.inpLEIMA (hom.Hs.inpHOMSA), 2
hom.Hs.inpLOTGI (hom.Hs.inpHOMSA), 2
hom.Hs.inpMACMU (hom.Hs.inpHOMSA), 2
hom.Hs.inpMAGGR (hom.Hs.inpHOMSA), 2

INDEX

7

hom.Hs.inpMAPCOUNTS, 1
hom.Hs.inpMONBR (hom.Hs.inpHOMSA), 2
hom.Hs.inpMONDO (hom.Hs.inpHOMSA), 2
hom.Hs.inpMUSMU (hom.Hs.inpHOMSA), 2
hom.Hs.inpNASVI (hom.Hs.inpHOMSA), 2
hom.Hs.inpNEMVE (hom.Hs.inpHOMSA), 2
hom.Hs.inpNEUCR (hom.Hs.inpHOMSA), 2
hom.Hs.inpORGANISM, 2
hom.Hs.inpORNAN (hom.Hs.inpHOMSA), 2
hom.Hs.inpORYLA (hom.Hs.inpHOMSA), 2
hom.Hs.inpORYSA (hom.Hs.inpHOMSA), 2
hom.Hs.inpOSTTA (hom.Hs.inpHOMSA), 2
hom.Hs.inpPANTR (hom.Hs.inpHOMSA), 2
hom.Hs.inpPEDPA (hom.Hs.inpHOMSA), 2
hom.Hs.inpPHYPA (hom.Hs.inpHOMSA), 2
hom.Hs.inpPHYRA (hom.Hs.inpHOMSA), 2
hom.Hs.inpPHYSO (hom.Hs.inpHOMSA), 2
hom.Hs.inpPLAFA (hom.Hs.inpHOMSA), 2
hom.Hs.inpPLAVI (hom.Hs.inpHOMSA), 2
hom.Hs.inpPONPY (hom.Hs.inpHOMSA), 2
hom.Hs.inpPOPTR (hom.Hs.inpHOMSA), 2
hom.Hs.inpPRIPA (hom.Hs.inpHOMSA), 2
hom.Hs.inpPUCGR (hom.Hs.inpHOMSA), 2
hom.Hs.inpRATNO (hom.Hs.inpHOMSA), 2
hom.Hs.inpRHIOR (hom.Hs.inpHOMSA), 2
hom.Hs.inpSACCE (hom.Hs.inpHOMSA), 2
hom.Hs.inpSCHMA (hom.Hs.inpHOMSA), 2
hom.Hs.inpSCHPO (hom.Hs.inpHOMSA), 2
hom.Hs.inpSCLSC (hom.Hs.inpHOMSA), 2
hom.Hs.inpSORBI (hom.Hs.inpHOMSA), 2
hom.Hs.inpSTANO (hom.Hs.inpHOMSA), 2
hom.Hs.inpSTRPU (hom.Hs.inpHOMSA), 2
hom.Hs.inpTAKRU (hom.Hs.inpHOMSA), 2
hom.Hs.inpTETNI (hom.Hs.inpHOMSA), 2
hom.Hs.inpTETTH (hom.Hs.inpHOMSA), 2
hom.Hs.inpTHAPS (hom.Hs.inpHOMSA), 2
hom.Hs.inpTHEAN (hom.Hs.inpHOMSA), 2
hom.Hs.inpTHEPA (hom.Hs.inpHOMSA), 2
hom.Hs.inpTRIAD (hom.Hs.inpHOMSA), 2
hom.Hs.inpTRICA (hom.Hs.inpHOMSA), 2
hom.Hs.inpTRIVA (hom.Hs.inpHOMSA), 2
hom.Hs.inpTRYCR (hom.Hs.inpHOMSA), 2
hom.Hs.inpUSTMA (hom.Hs.inpHOMSA), 2
hom.Hs.inpXENTR (hom.Hs.inpHOMSA), 2
hom.Hs.inpYARLI (hom.Hs.inpHOMSA), 2

mappedkeys, 1


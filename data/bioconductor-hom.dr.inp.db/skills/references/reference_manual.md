hom.Dr.inp.db
April 16, 2019

hom.Dr.inp.db

Bioconductor annotation data package

Description

Welcome to the hom.Dr.inp.db annotation Package. The purpose of this package is to provide
detailed information about the hom.Dr.inp platform. Bioconductor attempts to update this package
biannually with the most recently available inparanoid data, but inparanoid data sources have not
historically updated that frequently. Please check inparanoid to learn more about when they have
last updated their databases.

You can learn what objects this package supports with the following command:

ls("package:hom.Dr.inp.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:hom.Dr.inp.db")

hom.Dr.inpMAPCOUNTS

Number of mapped keys for the maps in package hom.Dr.inp.db

Description

hom.Dr.inpMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map
in package hom.Dr.inp.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function deﬁned in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

1

hom.Dr.inpHOMSA

2

Examples

hom.Dr.inpMAPCOUNTS
mapnames <- names(hom.Dr.inpMAPCOUNTS)
hom.Dr.inpMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package hom.Dr.inp.db
checkMAPCOUNTS("hom.Dr.inp.db")

hom.Dr.inpORGANISM

The Organism for hom.Dr.inp

Description

hom.Dr.inpORGANISM is an R object that contains a single item: a character string that names the
organism for which hom.Dr.inp was built.

Details

Although the package name is suggestive of the organism for which it was built, hom.Dr.inpORGANISM
provides a simple way to programmatically extract the organism name.

Examples

hom.Dr.inpORGANISM

hom.Dr.inpHOMSA

Map between IDs for genes in one organism to their predicted par-
alogs in another

Description

A map of this type is an R object that provides mappings between identiﬁers for genes in the package
organism and their predicted paralogs in the map that the organism is named after. So for example,
if the inparanoid package is the human package, then the hom.Dr.inpRATNO map would provide
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

hom.Dr.inpHOMSA

References

http://inparanoid.sbc.su.se/download/current/sqltables

Examples

3

x <- hom.Dr.inpAPIME
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
x <- revmap(hom.Dr.inpAPIME)
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

hom.Dr.inp_dbconn

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

hom.Dr.inp_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

hom.Dr.inp_dbconn()
hom.Dr.inp_dbfile()
hom.Dr.inp_dbschema(file="", show.indices=FALSE)
hom.Dr.inp_dbInfo()

Arguments

file

A connection, or a character string naming the ﬁle to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

hom.Dr.inp_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by hom.Dr.inp_dbconn or you will
break all the AnnDbObj objects deﬁned in this package!

hom.Dr.inp_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite ﬁle).

hom.Dr.inp_dbschema prints the schema deﬁnition of the package annotation DB.

hom.Dr.inp_dbInfo prints other information about the package annotation DB.

hom.Dr.inp_dbconn

Value

5

hom.Dr.inp_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.

hom.Dr.inp_dbfile: a character string with the path to the package annotation DB.

hom.Dr.inp_dbschema: none (invisible NULL).

hom.Dr.inp_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "metadata" table:
dbGetQuery(hom.Dr.inp_dbconn(), "SELECT COUNT(*) FROM metadata")

hom.Dr.inp_dbschema()

hom.Dr.inp_dbInfo()

Index

∗Topic datasets

hom.Dr.inp.db, 1
hom.Dr.inp_dbconn, 4
hom.Dr.inpHOMSA, 2
hom.Dr.inpMAPCOUNTS, 1
hom.Dr.inpORGANISM, 2

∗Topic utilities

hom.Dr.inp_dbconn, 4

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

hom.Dr.inp (hom.Dr.inp.db), 1
hom.Dr.inp.db, 1
hom.Dr.inp_dbconn, 4
hom.Dr.inp_dbfile (hom.Dr.inp_dbconn), 4
hom.Dr.inp_dbInfo (hom.Dr.inp_dbconn), 4
hom.Dr.inp_dbschema

(hom.Dr.inp_dbconn), 4

hom.Dr.inpACYPI (hom.Dr.inpHOMSA), 2
hom.Dr.inpAEDAE (hom.Dr.inpHOMSA), 2
hom.Dr.inpANOGA (hom.Dr.inpHOMSA), 2
hom.Dr.inpAPIME (hom.Dr.inpHOMSA), 2
hom.Dr.inpARATH (hom.Dr.inpHOMSA), 2
hom.Dr.inpASPFU (hom.Dr.inpHOMSA), 2
hom.Dr.inpBATDE (hom.Dr.inpHOMSA), 2
hom.Dr.inpBOMMO (hom.Dr.inpHOMSA), 2
hom.Dr.inpBOSTA (hom.Dr.inpHOMSA), 2
hom.Dr.inpBRAFL (hom.Dr.inpHOMSA), 2
hom.Dr.inpBRUMA (hom.Dr.inpHOMSA), 2
hom.Dr.inpCAEBR (hom.Dr.inpHOMSA), 2
hom.Dr.inpCAEBRE (hom.Dr.inpHOMSA), 2
hom.Dr.inpCAEEL (hom.Dr.inpHOMSA), 2

6

hom.Dr.inpCAEJA (hom.Dr.inpHOMSA), 2
hom.Dr.inpCAERE (hom.Dr.inpHOMSA), 2
hom.Dr.inpCANAL (hom.Dr.inpHOMSA), 2
hom.Dr.inpCANFA (hom.Dr.inpHOMSA), 2
hom.Dr.inpCANGL (hom.Dr.inpHOMSA), 2
hom.Dr.inpCAPSP (hom.Dr.inpHOMSA), 2
hom.Dr.inpCAVPO (hom.Dr.inpHOMSA), 2
hom.Dr.inpCHLRE (hom.Dr.inpHOMSA), 2
hom.Dr.inpCIOIN (hom.Dr.inpHOMSA), 2
hom.Dr.inpCIOSA (hom.Dr.inpHOMSA), 2
hom.Dr.inpCOCIM (hom.Dr.inpHOMSA), 2
hom.Dr.inpCOPCI (hom.Dr.inpHOMSA), 2
hom.Dr.inpCRYHO (hom.Dr.inpHOMSA), 2
hom.Dr.inpCRYNE (hom.Dr.inpHOMSA), 2
hom.Dr.inpCRYPA (hom.Dr.inpHOMSA), 2
hom.Dr.inpCULPI (hom.Dr.inpHOMSA), 2
hom.Dr.inpCYAME (hom.Dr.inpHOMSA), 2
hom.Dr.inpDANRE (hom.Dr.inpHOMSA), 2
hom.Dr.inpDAPPU (hom.Dr.inpHOMSA), 2
hom.Dr.inpDEBHA (hom.Dr.inpHOMSA), 2
hom.Dr.inpDICDI (hom.Dr.inpHOMSA), 2
hom.Dr.inpDROAN (hom.Dr.inpHOMSA), 2
hom.Dr.inpDROGR (hom.Dr.inpHOMSA), 2
hom.Dr.inpDROME (hom.Dr.inpHOMSA), 2
hom.Dr.inpDROMO (hom.Dr.inpHOMSA), 2
hom.Dr.inpDROPS (hom.Dr.inpHOMSA), 2
hom.Dr.inpDROVI (hom.Dr.inpHOMSA), 2
hom.Dr.inpDROWI (hom.Dr.inpHOMSA), 2
hom.Dr.inpENTHI (hom.Dr.inpHOMSA), 2
hom.Dr.inpEQUCA (hom.Dr.inpHOMSA), 2
hom.Dr.inpESCCO (hom.Dr.inpHOMSA), 2
hom.Dr.inpFUSGR (hom.Dr.inpHOMSA), 2
hom.Dr.inpGALGA (hom.Dr.inpHOMSA), 2
hom.Dr.inpGASAC (hom.Dr.inpHOMSA), 2
hom.Dr.inpGIALA (hom.Dr.inpHOMSA), 2
hom.Dr.inpHELRO (hom.Dr.inpHOMSA), 2
hom.Dr.inpHOMSA, 2
hom.Dr.inpIXOSC (hom.Dr.inpHOMSA), 2
hom.Dr.inpKLULA (hom.Dr.inpHOMSA), 2
hom.Dr.inpLEIMA (hom.Dr.inpHOMSA), 2
hom.Dr.inpLOTGI (hom.Dr.inpHOMSA), 2
hom.Dr.inpMACMU (hom.Dr.inpHOMSA), 2
hom.Dr.inpMAGGR (hom.Dr.inpHOMSA), 2

INDEX

7

hom.Dr.inpMAPCOUNTS, 1
hom.Dr.inpMONBR (hom.Dr.inpHOMSA), 2
hom.Dr.inpMONDO (hom.Dr.inpHOMSA), 2
hom.Dr.inpMUSMU (hom.Dr.inpHOMSA), 2
hom.Dr.inpNASVI (hom.Dr.inpHOMSA), 2
hom.Dr.inpNEMVE (hom.Dr.inpHOMSA), 2
hom.Dr.inpNEUCR (hom.Dr.inpHOMSA), 2
hom.Dr.inpORGANISM, 2
hom.Dr.inpORNAN (hom.Dr.inpHOMSA), 2
hom.Dr.inpORYLA (hom.Dr.inpHOMSA), 2
hom.Dr.inpORYSA (hom.Dr.inpHOMSA), 2
hom.Dr.inpOSTTA (hom.Dr.inpHOMSA), 2
hom.Dr.inpPANTR (hom.Dr.inpHOMSA), 2
hom.Dr.inpPEDPA (hom.Dr.inpHOMSA), 2
hom.Dr.inpPHYPA (hom.Dr.inpHOMSA), 2
hom.Dr.inpPHYRA (hom.Dr.inpHOMSA), 2
hom.Dr.inpPHYSO (hom.Dr.inpHOMSA), 2
hom.Dr.inpPLAFA (hom.Dr.inpHOMSA), 2
hom.Dr.inpPLAVI (hom.Dr.inpHOMSA), 2
hom.Dr.inpPONPY (hom.Dr.inpHOMSA), 2
hom.Dr.inpPOPTR (hom.Dr.inpHOMSA), 2
hom.Dr.inpPRIPA (hom.Dr.inpHOMSA), 2
hom.Dr.inpPUCGR (hom.Dr.inpHOMSA), 2
hom.Dr.inpRATNO (hom.Dr.inpHOMSA), 2
hom.Dr.inpRHIOR (hom.Dr.inpHOMSA), 2
hom.Dr.inpSACCE (hom.Dr.inpHOMSA), 2
hom.Dr.inpSCHMA (hom.Dr.inpHOMSA), 2
hom.Dr.inpSCHPO (hom.Dr.inpHOMSA), 2
hom.Dr.inpSCLSC (hom.Dr.inpHOMSA), 2
hom.Dr.inpSORBI (hom.Dr.inpHOMSA), 2
hom.Dr.inpSTANO (hom.Dr.inpHOMSA), 2
hom.Dr.inpSTRPU (hom.Dr.inpHOMSA), 2
hom.Dr.inpTAKRU (hom.Dr.inpHOMSA), 2
hom.Dr.inpTETNI (hom.Dr.inpHOMSA), 2
hom.Dr.inpTETTH (hom.Dr.inpHOMSA), 2
hom.Dr.inpTHAPS (hom.Dr.inpHOMSA), 2
hom.Dr.inpTHEAN (hom.Dr.inpHOMSA), 2
hom.Dr.inpTHEPA (hom.Dr.inpHOMSA), 2
hom.Dr.inpTRIAD (hom.Dr.inpHOMSA), 2
hom.Dr.inpTRICA (hom.Dr.inpHOMSA), 2
hom.Dr.inpTRIVA (hom.Dr.inpHOMSA), 2
hom.Dr.inpTRYCR (hom.Dr.inpHOMSA), 2
hom.Dr.inpUSTMA (hom.Dr.inpHOMSA), 2
hom.Dr.inpXENTR (hom.Dr.inpHOMSA), 2
hom.Dr.inpYARLI (hom.Dr.inpHOMSA), 2

mappedkeys, 1


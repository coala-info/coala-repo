hom.Mm.inp.db
April 16, 2019

hom.Mm.inp.db

Bioconductor annotation data package

Description

Welcome to the hom.Mm.inp.db annotation Package. The purpose of this package is to provide
detailed information about the hom.Mm.inp platform. Bioconductor attempts to update this package
biannually with the most recently available inparanoid data, but inparanoid data sources have not
historically updated that frequently. Please check inparanoid to learn more about when they have
last updated their databases.

You can learn what objects this package supports with the following command:

ls("package:hom.Mm.inp.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:hom.Mm.inp.db")

hom.Mm.inpMAPCOUNTS

Number of mapped keys for the maps in package hom.Mm.inp.db

Description

hom.Mm.inpMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map
in package hom.Mm.inp.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function deﬁned in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

1

hom.Mm.inpHOMSA

2

Examples

hom.Mm.inpMAPCOUNTS
mapnames <- names(hom.Mm.inpMAPCOUNTS)
hom.Mm.inpMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package hom.Mm.inp.db
checkMAPCOUNTS("hom.Mm.inp.db")

hom.Mm.inpORGANISM

The Organism for hom.Mm.inp

Description

hom.Mm.inpORGANISM is an R object that contains a single item: a character string that names
the organism for which hom.Mm.inp was built.

Details

Although the package name is suggestive of the organism for which it was built, hom.Mm.inpORGANISM
provides a simple way to programmatically extract the organism name.

Examples

hom.Mm.inpORGANISM

hom.Mm.inpHOMSA

Map between IDs for genes in one organism to their predicted par-
alogs in another

Description

A map of this type is an R object that provides mappings between identiﬁers for genes in the package
organism and their predicted paralogs in the map that the organism is named after. So for example,
if the inparanoid package is the human package, then the hom.Mm.inpRATNO map would provide
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

hom.Mm.inpHOMSA

References

http://inparanoid.sbc.su.se/download/current/sqltables

Examples

3

x <- hom.Mm.inpAPIME
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
x <- revmap(hom.Mm.inpAPIME)
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

hom.Mm.inp_dbconn

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

hom.Mm.inp_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

hom.Mm.inp_dbconn()
hom.Mm.inp_dbfile()
hom.Mm.inp_dbschema(file="", show.indices=FALSE)
hom.Mm.inp_dbInfo()

Arguments

file

A connection, or a character string naming the ﬁle to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

hom.Mm.inp_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by hom.Mm.inp_dbconn or you will
break all the AnnDbObj objects deﬁned in this package!

hom.Mm.inp_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite ﬁle).

hom.Mm.inp_dbschema prints the schema deﬁnition of the package annotation DB.

hom.Mm.inp_dbInfo prints other information about the package annotation DB.

hom.Mm.inp_dbconn

Value

5

hom.Mm.inp_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.

hom.Mm.inp_dbfile: a character string with the path to the package annotation DB.

hom.Mm.inp_dbschema: none (invisible NULL).

hom.Mm.inp_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "metadata" table:
dbGetQuery(hom.Mm.inp_dbconn(), "SELECT COUNT(*) FROM metadata")

hom.Mm.inp_dbschema()

hom.Mm.inp_dbInfo()

Index

∗Topic datasets

hom.Mm.inp.db, 1
hom.Mm.inp_dbconn, 4
hom.Mm.inpHOMSA, 2
hom.Mm.inpMAPCOUNTS, 1
hom.Mm.inpORGANISM, 2

∗Topic utilities

hom.Mm.inp_dbconn, 4

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

hom.Mm.inp (hom.Mm.inp.db), 1
hom.Mm.inp.db, 1
hom.Mm.inp_dbconn, 4
hom.Mm.inp_dbfile (hom.Mm.inp_dbconn), 4
hom.Mm.inp_dbInfo (hom.Mm.inp_dbconn), 4
hom.Mm.inp_dbschema

(hom.Mm.inp_dbconn), 4

hom.Mm.inpACYPI (hom.Mm.inpHOMSA), 2
hom.Mm.inpAEDAE (hom.Mm.inpHOMSA), 2
hom.Mm.inpANOGA (hom.Mm.inpHOMSA), 2
hom.Mm.inpAPIME (hom.Mm.inpHOMSA), 2
hom.Mm.inpARATH (hom.Mm.inpHOMSA), 2
hom.Mm.inpASPFU (hom.Mm.inpHOMSA), 2
hom.Mm.inpBATDE (hom.Mm.inpHOMSA), 2
hom.Mm.inpBOMMO (hom.Mm.inpHOMSA), 2
hom.Mm.inpBOSTA (hom.Mm.inpHOMSA), 2
hom.Mm.inpBRAFL (hom.Mm.inpHOMSA), 2
hom.Mm.inpBRUMA (hom.Mm.inpHOMSA), 2
hom.Mm.inpCAEBR (hom.Mm.inpHOMSA), 2
hom.Mm.inpCAEBRE (hom.Mm.inpHOMSA), 2
hom.Mm.inpCAEEL (hom.Mm.inpHOMSA), 2

6

hom.Mm.inpCAEJA (hom.Mm.inpHOMSA), 2
hom.Mm.inpCAERE (hom.Mm.inpHOMSA), 2
hom.Mm.inpCANAL (hom.Mm.inpHOMSA), 2
hom.Mm.inpCANFA (hom.Mm.inpHOMSA), 2
hom.Mm.inpCANGL (hom.Mm.inpHOMSA), 2
hom.Mm.inpCAPSP (hom.Mm.inpHOMSA), 2
hom.Mm.inpCAVPO (hom.Mm.inpHOMSA), 2
hom.Mm.inpCHLRE (hom.Mm.inpHOMSA), 2
hom.Mm.inpCIOIN (hom.Mm.inpHOMSA), 2
hom.Mm.inpCIOSA (hom.Mm.inpHOMSA), 2
hom.Mm.inpCOCIM (hom.Mm.inpHOMSA), 2
hom.Mm.inpCOPCI (hom.Mm.inpHOMSA), 2
hom.Mm.inpCRYHO (hom.Mm.inpHOMSA), 2
hom.Mm.inpCRYNE (hom.Mm.inpHOMSA), 2
hom.Mm.inpCRYPA (hom.Mm.inpHOMSA), 2
hom.Mm.inpCULPI (hom.Mm.inpHOMSA), 2
hom.Mm.inpCYAME (hom.Mm.inpHOMSA), 2
hom.Mm.inpDANRE (hom.Mm.inpHOMSA), 2
hom.Mm.inpDAPPU (hom.Mm.inpHOMSA), 2
hom.Mm.inpDEBHA (hom.Mm.inpHOMSA), 2
hom.Mm.inpDICDI (hom.Mm.inpHOMSA), 2
hom.Mm.inpDROAN (hom.Mm.inpHOMSA), 2
hom.Mm.inpDROGR (hom.Mm.inpHOMSA), 2
hom.Mm.inpDROME (hom.Mm.inpHOMSA), 2
hom.Mm.inpDROMO (hom.Mm.inpHOMSA), 2
hom.Mm.inpDROPS (hom.Mm.inpHOMSA), 2
hom.Mm.inpDROVI (hom.Mm.inpHOMSA), 2
hom.Mm.inpDROWI (hom.Mm.inpHOMSA), 2
hom.Mm.inpENTHI (hom.Mm.inpHOMSA), 2
hom.Mm.inpEQUCA (hom.Mm.inpHOMSA), 2
hom.Mm.inpESCCO (hom.Mm.inpHOMSA), 2
hom.Mm.inpFUSGR (hom.Mm.inpHOMSA), 2
hom.Mm.inpGALGA (hom.Mm.inpHOMSA), 2
hom.Mm.inpGASAC (hom.Mm.inpHOMSA), 2
hom.Mm.inpGIALA (hom.Mm.inpHOMSA), 2
hom.Mm.inpHELRO (hom.Mm.inpHOMSA), 2
hom.Mm.inpHOMSA, 2
hom.Mm.inpIXOSC (hom.Mm.inpHOMSA), 2
hom.Mm.inpKLULA (hom.Mm.inpHOMSA), 2
hom.Mm.inpLEIMA (hom.Mm.inpHOMSA), 2
hom.Mm.inpLOTGI (hom.Mm.inpHOMSA), 2
hom.Mm.inpMACMU (hom.Mm.inpHOMSA), 2
hom.Mm.inpMAGGR (hom.Mm.inpHOMSA), 2

INDEX

7

hom.Mm.inpMAPCOUNTS, 1
hom.Mm.inpMONBR (hom.Mm.inpHOMSA), 2
hom.Mm.inpMONDO (hom.Mm.inpHOMSA), 2
hom.Mm.inpMUSMU (hom.Mm.inpHOMSA), 2
hom.Mm.inpNASVI (hom.Mm.inpHOMSA), 2
hom.Mm.inpNEMVE (hom.Mm.inpHOMSA), 2
hom.Mm.inpNEUCR (hom.Mm.inpHOMSA), 2
hom.Mm.inpORGANISM, 2
hom.Mm.inpORNAN (hom.Mm.inpHOMSA), 2
hom.Mm.inpORYLA (hom.Mm.inpHOMSA), 2
hom.Mm.inpORYSA (hom.Mm.inpHOMSA), 2
hom.Mm.inpOSTTA (hom.Mm.inpHOMSA), 2
hom.Mm.inpPANTR (hom.Mm.inpHOMSA), 2
hom.Mm.inpPEDPA (hom.Mm.inpHOMSA), 2
hom.Mm.inpPHYPA (hom.Mm.inpHOMSA), 2
hom.Mm.inpPHYRA (hom.Mm.inpHOMSA), 2
hom.Mm.inpPHYSO (hom.Mm.inpHOMSA), 2
hom.Mm.inpPLAFA (hom.Mm.inpHOMSA), 2
hom.Mm.inpPLAVI (hom.Mm.inpHOMSA), 2
hom.Mm.inpPONPY (hom.Mm.inpHOMSA), 2
hom.Mm.inpPOPTR (hom.Mm.inpHOMSA), 2
hom.Mm.inpPRIPA (hom.Mm.inpHOMSA), 2
hom.Mm.inpPUCGR (hom.Mm.inpHOMSA), 2
hom.Mm.inpRATNO (hom.Mm.inpHOMSA), 2
hom.Mm.inpRHIOR (hom.Mm.inpHOMSA), 2
hom.Mm.inpSACCE (hom.Mm.inpHOMSA), 2
hom.Mm.inpSCHMA (hom.Mm.inpHOMSA), 2
hom.Mm.inpSCHPO (hom.Mm.inpHOMSA), 2
hom.Mm.inpSCLSC (hom.Mm.inpHOMSA), 2
hom.Mm.inpSORBI (hom.Mm.inpHOMSA), 2
hom.Mm.inpSTANO (hom.Mm.inpHOMSA), 2
hom.Mm.inpSTRPU (hom.Mm.inpHOMSA), 2
hom.Mm.inpTAKRU (hom.Mm.inpHOMSA), 2
hom.Mm.inpTETNI (hom.Mm.inpHOMSA), 2
hom.Mm.inpTETTH (hom.Mm.inpHOMSA), 2
hom.Mm.inpTHAPS (hom.Mm.inpHOMSA), 2
hom.Mm.inpTHEAN (hom.Mm.inpHOMSA), 2
hom.Mm.inpTHEPA (hom.Mm.inpHOMSA), 2
hom.Mm.inpTRIAD (hom.Mm.inpHOMSA), 2
hom.Mm.inpTRICA (hom.Mm.inpHOMSA), 2
hom.Mm.inpTRIVA (hom.Mm.inpHOMSA), 2
hom.Mm.inpTRYCR (hom.Mm.inpHOMSA), 2
hom.Mm.inpUSTMA (hom.Mm.inpHOMSA), 2
hom.Mm.inpXENTR (hom.Mm.inpHOMSA), 2
hom.Mm.inpYARLI (hom.Mm.inpHOMSA), 2

mappedkeys, 1


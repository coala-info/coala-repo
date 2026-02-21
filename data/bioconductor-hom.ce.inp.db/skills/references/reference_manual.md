hom.Ce.inp.db
April 16, 2019

hom.Ce.inp.db

Bioconductor annotation data package

Description

Welcome to the hom.Ce.inp.db annotation Package. The purpose of this package is to provide
detailed information about the hom.Ce.inp platform. Bioconductor attempts to update this package
biannually with the most recently available inparanoid data, but inparanoid data sources have not
historically updated that frequently. Please check inparanoid to learn more about when they have
last updated their databases.

You can learn what objects this package supports with the following command:

ls("package:hom.Ce.inp.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:hom.Ce.inp.db")

hom.Ce.inpMAPCOUNTS

Number of mapped keys for the maps in package hom.Ce.inp.db

Description

hom.Ce.inpMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map
in package hom.Ce.inp.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function deﬁned in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

1

hom.Ce.inpHOMSA

2

Examples

hom.Ce.inpMAPCOUNTS
mapnames <- names(hom.Ce.inpMAPCOUNTS)
hom.Ce.inpMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package hom.Ce.inp.db
checkMAPCOUNTS("hom.Ce.inp.db")

hom.Ce.inpORGANISM

The Organism for hom.Ce.inp

Description

hom.Ce.inpORGANISM is an R object that contains a single item: a character string that names the
organism for which hom.Ce.inp was built.

Details

Although the package name is suggestive of the organism for which it was built, hom.Ce.inpORGANISM
provides a simple way to programmatically extract the organism name.

Examples

hom.Ce.inpORGANISM

hom.Ce.inpHOMSA

Map between IDs for genes in one organism to their predicted par-
alogs in another

Description

A map of this type is an R object that provides mappings between identiﬁers for genes in the package
organism and their predicted paralogs in the map that the organism is named after. So for example,
if the inparanoid package is the human package, then the hom.Ce.inpRATNO map would provide
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

hom.Ce.inpHOMSA

References

http://inparanoid.sbc.su.se/download/current/sqltables

Examples

3

x <- hom.Ce.inpAPIME
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
x <- revmap(hom.Ce.inpAPIME)
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

hom.Ce.inp_dbconn

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

hom.Ce.inp_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

hom.Ce.inp_dbconn()
hom.Ce.inp_dbfile()
hom.Ce.inp_dbschema(file="", show.indices=FALSE)
hom.Ce.inp_dbInfo()

Arguments

file

A connection, or a character string naming the ﬁle to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

hom.Ce.inp_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by hom.Ce.inp_dbconn or you will
break all the AnnDbObj objects deﬁned in this package!

hom.Ce.inp_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite ﬁle).

hom.Ce.inp_dbschema prints the schema deﬁnition of the package annotation DB.

hom.Ce.inp_dbInfo prints other information about the package annotation DB.

hom.Ce.inp_dbconn

Value

5

hom.Ce.inp_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.

hom.Ce.inp_dbfile: a character string with the path to the package annotation DB.

hom.Ce.inp_dbschema: none (invisible NULL).

hom.Ce.inp_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "metadata" table:
dbGetQuery(hom.Ce.inp_dbconn(), "SELECT COUNT(*) FROM metadata")

hom.Ce.inp_dbschema()

hom.Ce.inp_dbInfo()

Index

∗Topic datasets

hom.Ce.inp.db, 1
hom.Ce.inp_dbconn, 4
hom.Ce.inpHOMSA, 2
hom.Ce.inpMAPCOUNTS, 1
hom.Ce.inpORGANISM, 2

∗Topic utilities

hom.Ce.inp_dbconn, 4

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

hom.Ce.inp (hom.Ce.inp.db), 1
hom.Ce.inp.db, 1
hom.Ce.inp_dbconn, 4
hom.Ce.inp_dbfile (hom.Ce.inp_dbconn), 4
hom.Ce.inp_dbInfo (hom.Ce.inp_dbconn), 4
hom.Ce.inp_dbschema

(hom.Ce.inp_dbconn), 4

hom.Ce.inpACYPI (hom.Ce.inpHOMSA), 2
hom.Ce.inpAEDAE (hom.Ce.inpHOMSA), 2
hom.Ce.inpANOGA (hom.Ce.inpHOMSA), 2
hom.Ce.inpAPIME (hom.Ce.inpHOMSA), 2
hom.Ce.inpARATH (hom.Ce.inpHOMSA), 2
hom.Ce.inpASPFU (hom.Ce.inpHOMSA), 2
hom.Ce.inpBATDE (hom.Ce.inpHOMSA), 2
hom.Ce.inpBOMMO (hom.Ce.inpHOMSA), 2
hom.Ce.inpBOSTA (hom.Ce.inpHOMSA), 2
hom.Ce.inpBRAFL (hom.Ce.inpHOMSA), 2
hom.Ce.inpBRUMA (hom.Ce.inpHOMSA), 2
hom.Ce.inpCAEBR (hom.Ce.inpHOMSA), 2
hom.Ce.inpCAEBRE (hom.Ce.inpHOMSA), 2
hom.Ce.inpCAEEL (hom.Ce.inpHOMSA), 2

6

hom.Ce.inpCAEJA (hom.Ce.inpHOMSA), 2
hom.Ce.inpCAERE (hom.Ce.inpHOMSA), 2
hom.Ce.inpCANAL (hom.Ce.inpHOMSA), 2
hom.Ce.inpCANFA (hom.Ce.inpHOMSA), 2
hom.Ce.inpCANGL (hom.Ce.inpHOMSA), 2
hom.Ce.inpCAPSP (hom.Ce.inpHOMSA), 2
hom.Ce.inpCAVPO (hom.Ce.inpHOMSA), 2
hom.Ce.inpCHLRE (hom.Ce.inpHOMSA), 2
hom.Ce.inpCIOIN (hom.Ce.inpHOMSA), 2
hom.Ce.inpCIOSA (hom.Ce.inpHOMSA), 2
hom.Ce.inpCOCIM (hom.Ce.inpHOMSA), 2
hom.Ce.inpCOPCI (hom.Ce.inpHOMSA), 2
hom.Ce.inpCRYHO (hom.Ce.inpHOMSA), 2
hom.Ce.inpCRYNE (hom.Ce.inpHOMSA), 2
hom.Ce.inpCRYPA (hom.Ce.inpHOMSA), 2
hom.Ce.inpCULPI (hom.Ce.inpHOMSA), 2
hom.Ce.inpCYAME (hom.Ce.inpHOMSA), 2
hom.Ce.inpDANRE (hom.Ce.inpHOMSA), 2
hom.Ce.inpDAPPU (hom.Ce.inpHOMSA), 2
hom.Ce.inpDEBHA (hom.Ce.inpHOMSA), 2
hom.Ce.inpDICDI (hom.Ce.inpHOMSA), 2
hom.Ce.inpDROAN (hom.Ce.inpHOMSA), 2
hom.Ce.inpDROGR (hom.Ce.inpHOMSA), 2
hom.Ce.inpDROME (hom.Ce.inpHOMSA), 2
hom.Ce.inpDROMO (hom.Ce.inpHOMSA), 2
hom.Ce.inpDROPS (hom.Ce.inpHOMSA), 2
hom.Ce.inpDROVI (hom.Ce.inpHOMSA), 2
hom.Ce.inpDROWI (hom.Ce.inpHOMSA), 2
hom.Ce.inpENTHI (hom.Ce.inpHOMSA), 2
hom.Ce.inpEQUCA (hom.Ce.inpHOMSA), 2
hom.Ce.inpESCCO (hom.Ce.inpHOMSA), 2
hom.Ce.inpFUSGR (hom.Ce.inpHOMSA), 2
hom.Ce.inpGALGA (hom.Ce.inpHOMSA), 2
hom.Ce.inpGASAC (hom.Ce.inpHOMSA), 2
hom.Ce.inpGIALA (hom.Ce.inpHOMSA), 2
hom.Ce.inpHELRO (hom.Ce.inpHOMSA), 2
hom.Ce.inpHOMSA, 2
hom.Ce.inpIXOSC (hom.Ce.inpHOMSA), 2
hom.Ce.inpKLULA (hom.Ce.inpHOMSA), 2
hom.Ce.inpLEIMA (hom.Ce.inpHOMSA), 2
hom.Ce.inpLOTGI (hom.Ce.inpHOMSA), 2
hom.Ce.inpMACMU (hom.Ce.inpHOMSA), 2
hom.Ce.inpMAGGR (hom.Ce.inpHOMSA), 2

INDEX

7

hom.Ce.inpMAPCOUNTS, 1
hom.Ce.inpMONBR (hom.Ce.inpHOMSA), 2
hom.Ce.inpMONDO (hom.Ce.inpHOMSA), 2
hom.Ce.inpMUSMU (hom.Ce.inpHOMSA), 2
hom.Ce.inpNASVI (hom.Ce.inpHOMSA), 2
hom.Ce.inpNEMVE (hom.Ce.inpHOMSA), 2
hom.Ce.inpNEUCR (hom.Ce.inpHOMSA), 2
hom.Ce.inpORGANISM, 2
hom.Ce.inpORNAN (hom.Ce.inpHOMSA), 2
hom.Ce.inpORYLA (hom.Ce.inpHOMSA), 2
hom.Ce.inpORYSA (hom.Ce.inpHOMSA), 2
hom.Ce.inpOSTTA (hom.Ce.inpHOMSA), 2
hom.Ce.inpPANTR (hom.Ce.inpHOMSA), 2
hom.Ce.inpPEDPA (hom.Ce.inpHOMSA), 2
hom.Ce.inpPHYPA (hom.Ce.inpHOMSA), 2
hom.Ce.inpPHYRA (hom.Ce.inpHOMSA), 2
hom.Ce.inpPHYSO (hom.Ce.inpHOMSA), 2
hom.Ce.inpPLAFA (hom.Ce.inpHOMSA), 2
hom.Ce.inpPLAVI (hom.Ce.inpHOMSA), 2
hom.Ce.inpPONPY (hom.Ce.inpHOMSA), 2
hom.Ce.inpPOPTR (hom.Ce.inpHOMSA), 2
hom.Ce.inpPRIPA (hom.Ce.inpHOMSA), 2
hom.Ce.inpPUCGR (hom.Ce.inpHOMSA), 2
hom.Ce.inpRATNO (hom.Ce.inpHOMSA), 2
hom.Ce.inpRHIOR (hom.Ce.inpHOMSA), 2
hom.Ce.inpSACCE (hom.Ce.inpHOMSA), 2
hom.Ce.inpSCHMA (hom.Ce.inpHOMSA), 2
hom.Ce.inpSCHPO (hom.Ce.inpHOMSA), 2
hom.Ce.inpSCLSC (hom.Ce.inpHOMSA), 2
hom.Ce.inpSORBI (hom.Ce.inpHOMSA), 2
hom.Ce.inpSTANO (hom.Ce.inpHOMSA), 2
hom.Ce.inpSTRPU (hom.Ce.inpHOMSA), 2
hom.Ce.inpTAKRU (hom.Ce.inpHOMSA), 2
hom.Ce.inpTETNI (hom.Ce.inpHOMSA), 2
hom.Ce.inpTETTH (hom.Ce.inpHOMSA), 2
hom.Ce.inpTHAPS (hom.Ce.inpHOMSA), 2
hom.Ce.inpTHEAN (hom.Ce.inpHOMSA), 2
hom.Ce.inpTHEPA (hom.Ce.inpHOMSA), 2
hom.Ce.inpTRIAD (hom.Ce.inpHOMSA), 2
hom.Ce.inpTRICA (hom.Ce.inpHOMSA), 2
hom.Ce.inpTRIVA (hom.Ce.inpHOMSA), 2
hom.Ce.inpTRYCR (hom.Ce.inpHOMSA), 2
hom.Ce.inpUSTMA (hom.Ce.inpHOMSA), 2
hom.Ce.inpXENTR (hom.Ce.inpHOMSA), 2
hom.Ce.inpYARLI (hom.Ce.inpHOMSA), 2

mappedkeys, 1


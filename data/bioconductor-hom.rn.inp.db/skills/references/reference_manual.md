hom.Rn.inp.db
April 16, 2019

hom.Rn.inp.db

Bioconductor annotation data package

Description

Welcome to the hom.Rn.inp.db annotation Package. The purpose of this package is to provide
detailed information about the hom.Rn.inp platform. Bioconductor attempts to update this package
biannually with the most recently available inparanoid data, but inparanoid data sources have not
historically updated that frequently. Please check inparanoid to learn more about when they have
last updated their databases.

You can learn what objects this package supports with the following command:

ls("package:hom.Rn.inp.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:hom.Rn.inp.db")

hom.Rn.inpMAPCOUNTS

Number of mapped keys for the maps in package hom.Rn.inp.db

Description

hom.Rn.inpMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map
in package hom.Rn.inp.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function deﬁned in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

1

hom.Rn.inpHOMSA

2

Examples

hom.Rn.inpMAPCOUNTS
mapnames <- names(hom.Rn.inpMAPCOUNTS)
hom.Rn.inpMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package hom.Rn.inp.db
checkMAPCOUNTS("hom.Rn.inp.db")

hom.Rn.inpORGANISM

The Organism for hom.Rn.inp

Description

hom.Rn.inpORGANISM is an R object that contains a single item: a character string that names
the organism for which hom.Rn.inp was built.

Details

Although the package name is suggestive of the organism for which it was built, hom.Rn.inpORGANISM
provides a simple way to programmatically extract the organism name.

Examples

hom.Rn.inpORGANISM

hom.Rn.inpHOMSA

Map between IDs for genes in one organism to their predicted par-
alogs in another

Description

A map of this type is an R object that provides mappings between identiﬁers for genes in the package
organism and their predicted paralogs in the map that the organism is named after. So for example,
if the inparanoid package is the human package, then the hom.Rn.inpRATNO map would provide
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

hom.Rn.inpHOMSA

References

http://inparanoid.sbc.su.se/download/current/sqltables

Examples

3

x <- hom.Rn.inpAPIME
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
x <- revmap(hom.Rn.inpAPIME)
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

hom.Rn.inp_dbconn

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

hom.Rn.inp_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

hom.Rn.inp_dbconn()
hom.Rn.inp_dbfile()
hom.Rn.inp_dbschema(file="", show.indices=FALSE)
hom.Rn.inp_dbInfo()

Arguments

file

A connection, or a character string naming the ﬁle to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

hom.Rn.inp_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by hom.Rn.inp_dbconn or you will
break all the AnnDbObj objects deﬁned in this package!

hom.Rn.inp_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite ﬁle).

hom.Rn.inp_dbschema prints the schema deﬁnition of the package annotation DB.

hom.Rn.inp_dbInfo prints other information about the package annotation DB.

hom.Rn.inp_dbconn

Value

5

hom.Rn.inp_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.

hom.Rn.inp_dbfile: a character string with the path to the package annotation DB.

hom.Rn.inp_dbschema: none (invisible NULL).

hom.Rn.inp_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "metadata" table:
dbGetQuery(hom.Rn.inp_dbconn(), "SELECT COUNT(*) FROM metadata")

hom.Rn.inp_dbschema()

hom.Rn.inp_dbInfo()

Index

∗Topic datasets

hom.Rn.inp.db, 1
hom.Rn.inp_dbconn, 4
hom.Rn.inpHOMSA, 2
hom.Rn.inpMAPCOUNTS, 1
hom.Rn.inpORGANISM, 2

∗Topic utilities

hom.Rn.inp_dbconn, 4

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

hom.Rn.inp (hom.Rn.inp.db), 1
hom.Rn.inp.db, 1
hom.Rn.inp_dbconn, 4
hom.Rn.inp_dbfile (hom.Rn.inp_dbconn), 4
hom.Rn.inp_dbInfo (hom.Rn.inp_dbconn), 4
hom.Rn.inp_dbschema

(hom.Rn.inp_dbconn), 4

hom.Rn.inpACYPI (hom.Rn.inpHOMSA), 2
hom.Rn.inpAEDAE (hom.Rn.inpHOMSA), 2
hom.Rn.inpANOGA (hom.Rn.inpHOMSA), 2
hom.Rn.inpAPIME (hom.Rn.inpHOMSA), 2
hom.Rn.inpARATH (hom.Rn.inpHOMSA), 2
hom.Rn.inpASPFU (hom.Rn.inpHOMSA), 2
hom.Rn.inpBATDE (hom.Rn.inpHOMSA), 2
hom.Rn.inpBOMMO (hom.Rn.inpHOMSA), 2
hom.Rn.inpBOSTA (hom.Rn.inpHOMSA), 2
hom.Rn.inpBRAFL (hom.Rn.inpHOMSA), 2
hom.Rn.inpBRUMA (hom.Rn.inpHOMSA), 2
hom.Rn.inpCAEBR (hom.Rn.inpHOMSA), 2
hom.Rn.inpCAEBRE (hom.Rn.inpHOMSA), 2
hom.Rn.inpCAEEL (hom.Rn.inpHOMSA), 2

6

hom.Rn.inpCAEJA (hom.Rn.inpHOMSA), 2
hom.Rn.inpCAERE (hom.Rn.inpHOMSA), 2
hom.Rn.inpCANAL (hom.Rn.inpHOMSA), 2
hom.Rn.inpCANFA (hom.Rn.inpHOMSA), 2
hom.Rn.inpCANGL (hom.Rn.inpHOMSA), 2
hom.Rn.inpCAPSP (hom.Rn.inpHOMSA), 2
hom.Rn.inpCAVPO (hom.Rn.inpHOMSA), 2
hom.Rn.inpCHLRE (hom.Rn.inpHOMSA), 2
hom.Rn.inpCIOIN (hom.Rn.inpHOMSA), 2
hom.Rn.inpCIOSA (hom.Rn.inpHOMSA), 2
hom.Rn.inpCOCIM (hom.Rn.inpHOMSA), 2
hom.Rn.inpCOPCI (hom.Rn.inpHOMSA), 2
hom.Rn.inpCRYHO (hom.Rn.inpHOMSA), 2
hom.Rn.inpCRYNE (hom.Rn.inpHOMSA), 2
hom.Rn.inpCRYPA (hom.Rn.inpHOMSA), 2
hom.Rn.inpCULPI (hom.Rn.inpHOMSA), 2
hom.Rn.inpCYAME (hom.Rn.inpHOMSA), 2
hom.Rn.inpDANRE (hom.Rn.inpHOMSA), 2
hom.Rn.inpDAPPU (hom.Rn.inpHOMSA), 2
hom.Rn.inpDEBHA (hom.Rn.inpHOMSA), 2
hom.Rn.inpDICDI (hom.Rn.inpHOMSA), 2
hom.Rn.inpDROAN (hom.Rn.inpHOMSA), 2
hom.Rn.inpDROGR (hom.Rn.inpHOMSA), 2
hom.Rn.inpDROME (hom.Rn.inpHOMSA), 2
hom.Rn.inpDROMO (hom.Rn.inpHOMSA), 2
hom.Rn.inpDROPS (hom.Rn.inpHOMSA), 2
hom.Rn.inpDROVI (hom.Rn.inpHOMSA), 2
hom.Rn.inpDROWI (hom.Rn.inpHOMSA), 2
hom.Rn.inpENTHI (hom.Rn.inpHOMSA), 2
hom.Rn.inpEQUCA (hom.Rn.inpHOMSA), 2
hom.Rn.inpESCCO (hom.Rn.inpHOMSA), 2
hom.Rn.inpFUSGR (hom.Rn.inpHOMSA), 2
hom.Rn.inpGALGA (hom.Rn.inpHOMSA), 2
hom.Rn.inpGASAC (hom.Rn.inpHOMSA), 2
hom.Rn.inpGIALA (hom.Rn.inpHOMSA), 2
hom.Rn.inpHELRO (hom.Rn.inpHOMSA), 2
hom.Rn.inpHOMSA, 2
hom.Rn.inpIXOSC (hom.Rn.inpHOMSA), 2
hom.Rn.inpKLULA (hom.Rn.inpHOMSA), 2
hom.Rn.inpLEIMA (hom.Rn.inpHOMSA), 2
hom.Rn.inpLOTGI (hom.Rn.inpHOMSA), 2
hom.Rn.inpMACMU (hom.Rn.inpHOMSA), 2
hom.Rn.inpMAGGR (hom.Rn.inpHOMSA), 2

INDEX

7

hom.Rn.inpMAPCOUNTS, 1
hom.Rn.inpMONBR (hom.Rn.inpHOMSA), 2
hom.Rn.inpMONDO (hom.Rn.inpHOMSA), 2
hom.Rn.inpMUSMU (hom.Rn.inpHOMSA), 2
hom.Rn.inpNASVI (hom.Rn.inpHOMSA), 2
hom.Rn.inpNEMVE (hom.Rn.inpHOMSA), 2
hom.Rn.inpNEUCR (hom.Rn.inpHOMSA), 2
hom.Rn.inpORGANISM, 2
hom.Rn.inpORNAN (hom.Rn.inpHOMSA), 2
hom.Rn.inpORYLA (hom.Rn.inpHOMSA), 2
hom.Rn.inpORYSA (hom.Rn.inpHOMSA), 2
hom.Rn.inpOSTTA (hom.Rn.inpHOMSA), 2
hom.Rn.inpPANTR (hom.Rn.inpHOMSA), 2
hom.Rn.inpPEDPA (hom.Rn.inpHOMSA), 2
hom.Rn.inpPHYPA (hom.Rn.inpHOMSA), 2
hom.Rn.inpPHYRA (hom.Rn.inpHOMSA), 2
hom.Rn.inpPHYSO (hom.Rn.inpHOMSA), 2
hom.Rn.inpPLAFA (hom.Rn.inpHOMSA), 2
hom.Rn.inpPLAVI (hom.Rn.inpHOMSA), 2
hom.Rn.inpPONPY (hom.Rn.inpHOMSA), 2
hom.Rn.inpPOPTR (hom.Rn.inpHOMSA), 2
hom.Rn.inpPRIPA (hom.Rn.inpHOMSA), 2
hom.Rn.inpPUCGR (hom.Rn.inpHOMSA), 2
hom.Rn.inpRATNO (hom.Rn.inpHOMSA), 2
hom.Rn.inpRHIOR (hom.Rn.inpHOMSA), 2
hom.Rn.inpSACCE (hom.Rn.inpHOMSA), 2
hom.Rn.inpSCHMA (hom.Rn.inpHOMSA), 2
hom.Rn.inpSCHPO (hom.Rn.inpHOMSA), 2
hom.Rn.inpSCLSC (hom.Rn.inpHOMSA), 2
hom.Rn.inpSORBI (hom.Rn.inpHOMSA), 2
hom.Rn.inpSTANO (hom.Rn.inpHOMSA), 2
hom.Rn.inpSTRPU (hom.Rn.inpHOMSA), 2
hom.Rn.inpTAKRU (hom.Rn.inpHOMSA), 2
hom.Rn.inpTETNI (hom.Rn.inpHOMSA), 2
hom.Rn.inpTETTH (hom.Rn.inpHOMSA), 2
hom.Rn.inpTHAPS (hom.Rn.inpHOMSA), 2
hom.Rn.inpTHEAN (hom.Rn.inpHOMSA), 2
hom.Rn.inpTHEPA (hom.Rn.inpHOMSA), 2
hom.Rn.inpTRIAD (hom.Rn.inpHOMSA), 2
hom.Rn.inpTRICA (hom.Rn.inpHOMSA), 2
hom.Rn.inpTRIVA (hom.Rn.inpHOMSA), 2
hom.Rn.inpTRYCR (hom.Rn.inpHOMSA), 2
hom.Rn.inpUSTMA (hom.Rn.inpHOMSA), 2
hom.Rn.inpXENTR (hom.Rn.inpHOMSA), 2
hom.Rn.inpYARLI (hom.Rn.inpHOMSA), 2

mappedkeys, 1


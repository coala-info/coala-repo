hom.Sc.inp.db
April 16, 2019

hom.Sc.inp.db

Bioconductor annotation data package

Description

Welcome to the hom.Sc.inp.db annotation Package. The purpose of this package is to provide
detailed information about the hom.Sc.inp platform. Bioconductor attempts to update this package
biannually with the most recently available inparanoid data, but inparanoid data sources have not
historically updated that frequently. Please check inparanoid to learn more about when they have
last updated their databases.

You can learn what objects this package supports with the following command:

ls("package:hom.Sc.inp.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:hom.Sc.inp.db")

hom.Sc.inpMAPCOUNTS

Number of mapped keys for the maps in package hom.Sc.inp.db

Description

hom.Sc.inpMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map
in package hom.Sc.inp.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function deﬁned in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

1

hom.Sc.inpHOMSA

2

Examples

hom.Sc.inpMAPCOUNTS
mapnames <- names(hom.Sc.inpMAPCOUNTS)
hom.Sc.inpMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package hom.Sc.inp.db
checkMAPCOUNTS("hom.Sc.inp.db")

hom.Sc.inpORGANISM

The Organism for hom.Sc.inp

Description

hom.Sc.inpORGANISM is an R object that contains a single item: a character string that names the
organism for which hom.Sc.inp was built.

Details

Although the package name is suggestive of the organism for which it was built, hom.Sc.inpORGANISM
provides a simple way to programmatically extract the organism name.

Examples

hom.Sc.inpORGANISM

hom.Sc.inpHOMSA

Map between IDs for genes in one organism to their predicted par-
alogs in another

Description

A map of this type is an R object that provides mappings between identiﬁers for genes in the package
organism and their predicted paralogs in the map that the organism is named after. So for example,
if the inparanoid package is the human package, then the hom.Sc.inpRATNO map would provide
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

hom.Sc.inpHOMSA

References

http://inparanoid.sbc.su.se/download/current/sqltables

Examples

3

x <- hom.Sc.inpAPIME
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
x <- revmap(hom.Sc.inpAPIME)
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

hom.Sc.inp_dbconn

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

hom.Sc.inp_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

hom.Sc.inp_dbconn()
hom.Sc.inp_dbfile()
hom.Sc.inp_dbschema(file="", show.indices=FALSE)
hom.Sc.inp_dbInfo()

Arguments

file

A connection, or a character string naming the ﬁle to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

hom.Sc.inp_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by hom.Sc.inp_dbconn or you will
break all the AnnDbObj objects deﬁned in this package!

hom.Sc.inp_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite ﬁle).

hom.Sc.inp_dbschema prints the schema deﬁnition of the package annotation DB.

hom.Sc.inp_dbInfo prints other information about the package annotation DB.

hom.Sc.inp_dbconn

Value

5

hom.Sc.inp_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.

hom.Sc.inp_dbfile: a character string with the path to the package annotation DB.

hom.Sc.inp_dbschema: none (invisible NULL).

hom.Sc.inp_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "metadata" table:
dbGetQuery(hom.Sc.inp_dbconn(), "SELECT COUNT(*) FROM metadata")

hom.Sc.inp_dbschema()

hom.Sc.inp_dbInfo()

Index

∗Topic datasets

hom.Sc.inp.db, 1
hom.Sc.inp_dbconn, 4
hom.Sc.inpHOMSA, 2
hom.Sc.inpMAPCOUNTS, 1
hom.Sc.inpORGANISM, 2

∗Topic utilities

hom.Sc.inp_dbconn, 4

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

hom.Sc.inp (hom.Sc.inp.db), 1
hom.Sc.inp.db, 1
hom.Sc.inp_dbconn, 4
hom.Sc.inp_dbfile (hom.Sc.inp_dbconn), 4
hom.Sc.inp_dbInfo (hom.Sc.inp_dbconn), 4
hom.Sc.inp_dbschema

(hom.Sc.inp_dbconn), 4

hom.Sc.inpACYPI (hom.Sc.inpHOMSA), 2
hom.Sc.inpAEDAE (hom.Sc.inpHOMSA), 2
hom.Sc.inpANOGA (hom.Sc.inpHOMSA), 2
hom.Sc.inpAPIME (hom.Sc.inpHOMSA), 2
hom.Sc.inpARATH (hom.Sc.inpHOMSA), 2
hom.Sc.inpASPFU (hom.Sc.inpHOMSA), 2
hom.Sc.inpBATDE (hom.Sc.inpHOMSA), 2
hom.Sc.inpBOMMO (hom.Sc.inpHOMSA), 2
hom.Sc.inpBOSTA (hom.Sc.inpHOMSA), 2
hom.Sc.inpBRAFL (hom.Sc.inpHOMSA), 2
hom.Sc.inpBRUMA (hom.Sc.inpHOMSA), 2
hom.Sc.inpCAEBR (hom.Sc.inpHOMSA), 2
hom.Sc.inpCAEBRE (hom.Sc.inpHOMSA), 2
hom.Sc.inpCAEEL (hom.Sc.inpHOMSA), 2

6

hom.Sc.inpCAEJA (hom.Sc.inpHOMSA), 2
hom.Sc.inpCAERE (hom.Sc.inpHOMSA), 2
hom.Sc.inpCANAL (hom.Sc.inpHOMSA), 2
hom.Sc.inpCANFA (hom.Sc.inpHOMSA), 2
hom.Sc.inpCANGL (hom.Sc.inpHOMSA), 2
hom.Sc.inpCAPSP (hom.Sc.inpHOMSA), 2
hom.Sc.inpCAVPO (hom.Sc.inpHOMSA), 2
hom.Sc.inpCHLRE (hom.Sc.inpHOMSA), 2
hom.Sc.inpCIOIN (hom.Sc.inpHOMSA), 2
hom.Sc.inpCIOSA (hom.Sc.inpHOMSA), 2
hom.Sc.inpCOCIM (hom.Sc.inpHOMSA), 2
hom.Sc.inpCOPCI (hom.Sc.inpHOMSA), 2
hom.Sc.inpCRYHO (hom.Sc.inpHOMSA), 2
hom.Sc.inpCRYNE (hom.Sc.inpHOMSA), 2
hom.Sc.inpCRYPA (hom.Sc.inpHOMSA), 2
hom.Sc.inpCULPI (hom.Sc.inpHOMSA), 2
hom.Sc.inpCYAME (hom.Sc.inpHOMSA), 2
hom.Sc.inpDANRE (hom.Sc.inpHOMSA), 2
hom.Sc.inpDAPPU (hom.Sc.inpHOMSA), 2
hom.Sc.inpDEBHA (hom.Sc.inpHOMSA), 2
hom.Sc.inpDICDI (hom.Sc.inpHOMSA), 2
hom.Sc.inpDROAN (hom.Sc.inpHOMSA), 2
hom.Sc.inpDROGR (hom.Sc.inpHOMSA), 2
hom.Sc.inpDROME (hom.Sc.inpHOMSA), 2
hom.Sc.inpDROMO (hom.Sc.inpHOMSA), 2
hom.Sc.inpDROPS (hom.Sc.inpHOMSA), 2
hom.Sc.inpDROVI (hom.Sc.inpHOMSA), 2
hom.Sc.inpDROWI (hom.Sc.inpHOMSA), 2
hom.Sc.inpENTHI (hom.Sc.inpHOMSA), 2
hom.Sc.inpEQUCA (hom.Sc.inpHOMSA), 2
hom.Sc.inpESCCO (hom.Sc.inpHOMSA), 2
hom.Sc.inpFUSGR (hom.Sc.inpHOMSA), 2
hom.Sc.inpGALGA (hom.Sc.inpHOMSA), 2
hom.Sc.inpGASAC (hom.Sc.inpHOMSA), 2
hom.Sc.inpGIALA (hom.Sc.inpHOMSA), 2
hom.Sc.inpHELRO (hom.Sc.inpHOMSA), 2
hom.Sc.inpHOMSA, 2
hom.Sc.inpIXOSC (hom.Sc.inpHOMSA), 2
hom.Sc.inpKLULA (hom.Sc.inpHOMSA), 2
hom.Sc.inpLEIMA (hom.Sc.inpHOMSA), 2
hom.Sc.inpLOTGI (hom.Sc.inpHOMSA), 2
hom.Sc.inpMACMU (hom.Sc.inpHOMSA), 2
hom.Sc.inpMAGGR (hom.Sc.inpHOMSA), 2

INDEX

7

hom.Sc.inpMAPCOUNTS, 1
hom.Sc.inpMONBR (hom.Sc.inpHOMSA), 2
hom.Sc.inpMONDO (hom.Sc.inpHOMSA), 2
hom.Sc.inpMUSMU (hom.Sc.inpHOMSA), 2
hom.Sc.inpNASVI (hom.Sc.inpHOMSA), 2
hom.Sc.inpNEMVE (hom.Sc.inpHOMSA), 2
hom.Sc.inpNEUCR (hom.Sc.inpHOMSA), 2
hom.Sc.inpORGANISM, 2
hom.Sc.inpORNAN (hom.Sc.inpHOMSA), 2
hom.Sc.inpORYLA (hom.Sc.inpHOMSA), 2
hom.Sc.inpORYSA (hom.Sc.inpHOMSA), 2
hom.Sc.inpOSTTA (hom.Sc.inpHOMSA), 2
hom.Sc.inpPANTR (hom.Sc.inpHOMSA), 2
hom.Sc.inpPEDPA (hom.Sc.inpHOMSA), 2
hom.Sc.inpPHYPA (hom.Sc.inpHOMSA), 2
hom.Sc.inpPHYRA (hom.Sc.inpHOMSA), 2
hom.Sc.inpPHYSO (hom.Sc.inpHOMSA), 2
hom.Sc.inpPLAFA (hom.Sc.inpHOMSA), 2
hom.Sc.inpPLAVI (hom.Sc.inpHOMSA), 2
hom.Sc.inpPONPY (hom.Sc.inpHOMSA), 2
hom.Sc.inpPOPTR (hom.Sc.inpHOMSA), 2
hom.Sc.inpPRIPA (hom.Sc.inpHOMSA), 2
hom.Sc.inpPUCGR (hom.Sc.inpHOMSA), 2
hom.Sc.inpRATNO (hom.Sc.inpHOMSA), 2
hom.Sc.inpRHIOR (hom.Sc.inpHOMSA), 2
hom.Sc.inpSACCE (hom.Sc.inpHOMSA), 2
hom.Sc.inpSCHMA (hom.Sc.inpHOMSA), 2
hom.Sc.inpSCHPO (hom.Sc.inpHOMSA), 2
hom.Sc.inpSCLSC (hom.Sc.inpHOMSA), 2
hom.Sc.inpSORBI (hom.Sc.inpHOMSA), 2
hom.Sc.inpSTANO (hom.Sc.inpHOMSA), 2
hom.Sc.inpSTRPU (hom.Sc.inpHOMSA), 2
hom.Sc.inpTAKRU (hom.Sc.inpHOMSA), 2
hom.Sc.inpTETNI (hom.Sc.inpHOMSA), 2
hom.Sc.inpTETTH (hom.Sc.inpHOMSA), 2
hom.Sc.inpTHAPS (hom.Sc.inpHOMSA), 2
hom.Sc.inpTHEAN (hom.Sc.inpHOMSA), 2
hom.Sc.inpTHEPA (hom.Sc.inpHOMSA), 2
hom.Sc.inpTRIAD (hom.Sc.inpHOMSA), 2
hom.Sc.inpTRICA (hom.Sc.inpHOMSA), 2
hom.Sc.inpTRIVA (hom.Sc.inpHOMSA), 2
hom.Sc.inpTRYCR (hom.Sc.inpHOMSA), 2
hom.Sc.inpUSTMA (hom.Sc.inpHOMSA), 2
hom.Sc.inpXENTR (hom.Sc.inpHOMSA), 2
hom.Sc.inpYARLI (hom.Sc.inpHOMSA), 2

mappedkeys, 1


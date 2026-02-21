cMAP
February 11, 2026

cMAP

Bioconductor annotation data package

Description

The annotation package was built using a downloadable R package - AnnBuilder (download and
build your own) from www.bioconductor.org using the following public data sources:

cMAP: http://cmap.nci.nih.gov/PW/Download. Build: Unavailable. Downloaded:Tue Sep 12
16:52:56 2006

Tue Sep 12 16:52:56 2006

cMAP

KEGG

The function cMAP() provides information about the binary data files

cMAPCARTAINTERACTION

An annotation data file that maps cMAP molecule identifiers to data
concerning the interactions between molecules

Description

cMAPCARTAINTERACTION maps cMAP (NCICB Pathway Interaction Database) molecule iden-
tifiers to data about the interactions of the molecule represented by the identifiers and other molecules

Details

This is an environment object containing key and value pairs. Keys are molecule identifiers and
values are lists of vectors and sublists. Each molecule identifier is mapped to a list that has a source,
process, reversible, condition, and component element.

The source element is a character string indicating whether the interactions between molecules are
from a BioCarta or KEGG pathway.

The process is a character string describing the process the key molecule is involved. Potential val-
ues include "reaction", "modification", "transcription", "translocation", "macroprocess" or a more
specific subtype of macroprocess including any term from the GO Biological Process vocabulary.

The reversible element is a boolean indicating whether the interaction is reversible.

1

2

cMAPCARTAMOLECULE

The condition element is a character string indicating the biological process the interactions take
place. Potential values include any term from the GO Biological Process vocabulary.

The component element contains sublists of vectors. Each key molecule identifier has a sequence
of component represented by elements of the sublist. Each sublist has an identifier (molecule iden-
tifier of the interacting molecule), edge (indicating the way two molecule interact. Potential values
include "input", "agent", "inhibitor", and "output"), role (the function of the key molecule. Poten-
tial values include any term from the GO Molecular Function vocabulary), location (a GO Cellular
Component vocabulary indicating the location of the interaction), and activity (an abstract term that
can be "inactive", "active", "active1", "active2") elements.

Mappings were based on data provided by:

cMAP: http://cmap.nci.nih.gov/PW/Download. Build: Unavailable. Downloaded:Tue Sep 12
16:52:56 2006

Package built: Tue Sep 12 16:52:56 2006

References

cMAP http://cmap.nci.nih.gov/PW

Examples

require(cMAP) || stop(paste(cMAP, "unavailable"))
xx <- as.list(cMAPCARTAINTERACTION)
if(length(xx) > 0){

# Get the value of the first key
xx[[1]]
# Get the values for multiget for a few keys
if(length(xx) >= 3){
xx[1:3]
}

}

cMAPCARTAMOLECULE

An annotation data file that maps cMAP molecule identifiers to data
concerning the molecule

Description

cMAPCARTAMOLECULE maps cMAP (NCICB Pathway Interaction Database) molecule identi-
fiers to data about the molecules

Details

This is an environment object containing key and value pairs. Keys are molecule identifiers and
values are lists of vectors and sublists. Each molecule identifier is mapped to a list that has a type,
extid, component, and member element.

The type element is a character string describing what type of molecule the key molecule identifier
corresponds to. Potential values for type include "protein", "complex", "compound", and "rna".

The extid element is a named vector of character strings. values of the vector are external identifiers
corresponding to the key molecule identifier. Names of the vector are abbreviations of the external
public data sources from which the external identifiers are obtained. Potential values for vector

cMAPCARTAPATHWAY

3

names include "LL" (Entrez Gene identifier), "CA" (CAChemical Abstract number), "GO" (Gene
Ontology), "KG" (KEGG), etc.

The component element is a sublist with an identifier (molecule id of the component molecule),
location (a GO Cellular Component vocabulary indicating the location of the molecule), and activity
(an abstract term that can be "inactive", "active", "active1", "active2") elements. The component
element only applies to complex molecules. Each complex molecule has a sequence of component
molecules represented by elements of the sublist.

The member element is a named vector of molecule identifiers for molecules that belong to the same
protein family as the key molecule identifier. Names of the vector are the key molecule identifier.

Mappings were based on data provided by:

cMAP: http://cmap.nci.nih.gov/PW/Download. Build: Unavailable. Downloaded:Tue Sep 12
16:52:56 2006

Package built: Tue Sep 12 16:52:56 2006

References

cMAP http://cmap.nci.nih.gov/PW

Examples

require(cMAP) || stop(paste(cMAP, "unavailable"))
xx <- as.list(cMAPCARTAMOLECULE)
if(length(xx) > 0){

# Get the value of the first key
xx[[1]]
# Get the values for multiget for a few keys
if(length(xx) >= 3){
xx[1:3]
}

}

cMAPCARTAPATHWAY

An annotation data file that maps cMAP short pathway names to de-
scriptive data about the pathway

Description

cMAPCARTAPATHWAY maps cMAP (NCICB Pathway Interaction Database) abbreviated path-
way names to descriptive data about the pathway

Details

This is an environment object containing key and value pairs. Keys are short pathway names and
values are lists of vectors. Each pathway name is mapped to a list that has an identifier. name,
organism, source, and component element.

The identifier element is an integer for NCICB Pathway Interaction Database identifier.

The name element is the full length of textual descriptive name for the pathway.

The organism is a character string for an abbreviation of organism name (e. g. Hs = human)

The source element is a character string indicating whether the interaction is a BioCarta or KEGG
pathway.

4

cMAPKEGGINTERACTION

The type element is a character string describing what type of molecule the key molecule identifier
corresponds to. Potential values for type include "protein", "complex", "compound", and "rna".

The component element is a vector of integers for the identifiers of molecules that are involved in
the pathway.

Mappings were based on data provided by:

cMAP: http://cmap.nci.nih.gov/PW/Download. Build: Unavailable. Downloaded:Tue Sep 12
16:52:56 2006

Package built: Tue Sep 12 16:52:56 2006

References

cMAP http://cmap.nci.nih.gov/PW

Examples

require(cMAP) || stop(paste(cMAP, "unavailable"))
xx <- as.list(cMAPCARTAPATHWAY)
if(length(xx) > 0){

# Get the value of the first key
xx[[1]]
# Get the values for multiget for a few keys
if(length(xx) >= 3){
xx[1:3]
}

}

cMAPKEGGINTERACTION

An annotation data file that maps cMAP molecule identifiers to data
concerning the interactions between molecules

Description

cMAPKEGGINTERACTION maps cMAP (NCICB Pathway Interaction Database) molecule iden-
tifiers to data about the interactions of the molecule represented by the identifiers and other molecules

Details

This is an environment object containing key and value pairs. Keys are molecule identifiers and
values are lists of vectors and sublists. Each molecule identifier is mapped to a list that has a source,
process, reversible, condition, and component element.

The source element is a character string indicating whether the interactions between molecules are
from a BioCarta or KEGG pathway.

The process is a character string describing the process the key molecule is involved. Potential val-
ues include "reaction", "modification", "transcription", "translocation", "macroprocess" or a more
specific subtype of macroprocess including any term from the GO Biological Process vocabulary.

The reversible element is a boolean indicating whether the interaction is reversible.

The condition element is a character string indicating the biological process the interactions take
place. Potential values include any term from the GO Biological Process vocabulary.

cMAPKEGGMOLECULE

5

The component element contains sublists of vectors. Each key molecule identifier has a sequence
of component represented by elements of the sublist. Each sublist has an identifier (molecule iden-
tifier of the interacting molecule), edge (indicating the way two molecule interact. Potential values
include "input", "agent", "inhibitor", and "output"), role (the function of the key molecule. Poten-
tial values include any term from the GO Molecular Function vocabulary), location (a GO Cellular
Component vocabulary indicating the location of the interaction), and activity (an abstract term that
can be "inactive", "active", "active1", "active2") elements.

Mappings were based on data provided by:

cMAP: http://cmap.nci.nih.gov/PW/Download. Build: Unavailable. Downloaded:Tue Sep 12
16:52:56 2006

Package built: Tue Sep 12 16:52:56 2006

References

cMAP http://cmap.nci.nih.gov/PW

Examples

require(cMAP) || stop(paste(cMAP, "unavailable"))
xx <- as.list(cMAPKEGGINTERACTION)
if(length(xx) > 0){

# Get the value of the first key
xx[[1]]
# Get the values for multiget for a few keys
if(length(xx) >= 3){
xx[1:3]
}

}

cMAPKEGGMOLECULE

An annotation data file that maps cMAP molecule identifiers to data
concerning the molecule

Description

cMAPKEGGMOLECULE maps cMAP (NCICB Pathway Interaction Database) molecule identi-
fiers to data about the molecules

Details

This is an environment object containing key and value pairs. Keys are molecule identifiers and
values are lists of vectors and sublists. Each molecule identifier is mapped to a list that has a type,
extid, component, and member element.

The type element is a character string describing what type of molecule the key molecule identifier
corresponds to. Potential values for type include "protein", "complex", "compound", and "rna".

The extid element is a named vector of character strings. values of the vector are external identifiers
corresponding to the key molecule identifier. Names of the vector are abbreviations of the external
public data sources from which the external identifiers are obtained. Potential values for vector
names include "LL" (Entrez Gene identifier), "CA" (CAChemical Abstract number), "GO" (Gene
Ontology), "KG" (KEGG), etc.

6

cMAPKEGGPATHWAY

The component element is a sublist with an identifier (molecule id of the component molecule),
location (a GO Cellular Component vocabulary indicating the location of the molecule), and activity
(an abstract term that can be "inactive", "active", "active1", "active2") elements. The component
element only applies to complex molecules. Each complex molecule has a sequence of component
molecules represented by elements of the sublist.

The member element is a named vector of molecule identifiers for molecules that belong to the same
protein family as the key molecule identifier. Names of the vector are the key molecule identifier.

Mappings were based on data provided by:

cMAP: http://cmap.nci.nih.gov/PW/Download. Build: Unavailable. Downloaded:Tue Sep 12
16:52:56 2006

Package built: Tue Sep 12 16:52:56 2006

References

cMAP http://cmap.nci.nih.gov/PW

Examples

require(cMAP) || stop(paste(cMAP, "unavailable"))
xx <- as.list(cMAPKEGGMOLECULE)
if(length(xx) > 0){

# Get the value of the first key
xx[[1]]
# Get the values for multiget for a few keys
if(length(xx) >= 3){
xx[1:3]
}

}

cMAPKEGGPATHWAY

An annotation data file that maps cMAP short pathway names to de-
scriptive data about the pathway

Description

cMAPKEGGPATHWAY maps cMAP (NCICB Pathway Interaction Database) abbreviated pathway
names to descriptive data about the pathway

Details

This is an environment object containing key and value pairs. Keys are short pathway names and
values are lists of vectors. Each pathway name is mapped to a list that has an identifier. name,
organism, source, and component element.

The identifier element is an integer for NCICB Pathway Interaction Database identifier.

The name element is the full length of textual descriptive name for the pathway.

The organism is a character string for an abbreviation of organism name (e. g. Hs = human)

The source element is a character string indicating whether the interaction is a BioCarta or KEGG
pathway.

The type element is a character string describing what type of molecule the key molecule identifier
corresponds to. Potential values for type include "protein", "complex", "compound", and "rna".

cMAPQC

7

The component element is a vector of integers for the identifiers of molecules that are involved in
the pathway.

Mappings were based on data provided by:

cMAP: http://cmap.nci.nih.gov/PW/Download. Build: Unavailable. Downloaded:Tue Sep 12
16:52:56 2006

Package built: Tue Sep 12 16:52:56 2006

References

cMAP http://cmap.nci.nih.gov/PW

Examples

require(cMAP) || stop(paste(cMAP, "unavailable"))
xx <- as.list(cMAPKEGGPATHWAY)
if(length(xx) > 0){

# Get the value of the first key
xx[[1]]
# Get the values for multiget for a few keys
if(length(xx) >= 3){
xx[1:3]
}

}

cMAPQC

Quality control information for cMAP

Description

cMAPQC is an R environment that provides quality control information for cMAP

Details

This file contains quality control information that can be displayed by typing cMAP() after loading
the package using library(cMAP). The follow items are included:

Date built: Date when the package was built.

Number of probes: total number of probes included

Probe number missmatch: if the total number of probes of any of the data file is different from a
base file used to check the data files the name of the data file will be listed

Probe missmatch: if any of probes in a data file missmatched that of the base file, the name of the
data file will be listed

Mappings found for probe based files: number of mappings obtained for the total number of probes

Mappings found for non-probe based files: total number of mappings obtained

Index

∗ datasets

cMAP, 1
cMAPCARTAINTERACTION, 1
cMAPCARTAMOLECULE, 2
cMAPCARTAPATHWAY, 3
cMAPKEGGINTERACTION, 4
cMAPKEGGMOLECULE, 5
cMAPKEGGPATHWAY, 6
cMAPQC, 7

cMAP, 1
cMAPCARTAINTERACTION, 1
cMAPCARTAMOLECULE, 2
cMAPCARTAPATHWAY, 3
cMAPKEGGINTERACTION, 4
cMAPKEGGMOLECULE, 5
cMAPKEGGPATHWAY, 6
cMAPMAPCOUNTS (cMAPQC), 7
cMAPQC, 7

8


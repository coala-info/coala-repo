# met4j CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| met4j_extractannotations | PASS |  |
| met4j_extractpathways | PASS |  |
| met4j_fbctnotes | PASS |  |
| met4j_formulamapper | PASS |  |
| met4j_getbiggmodelproteome | Failed | tool bug: the tool calls the old http BiGG API address, which now redirects to https, so it stops with 'Problem of connection'. |
| met4j_getentities | PASS |  |
| met4j_getgenesfromreactions | PASS |  |
| met4j_getmetaboliteattributes | PASS |  |
| met4j_getreactantsfromreactions | PASS |  |
| met4j_grouprxnbyenzymeclass | PASS |  |
| met4j_kegg2sbml | Failed | tool bug: the tool cannot parse the current KEGG API organism info line ('info badly formatted') and writes no SBML. |
| met4j_notestofbc | PASS |  |
| met4j_sbml2carbonskeletonnet | PASS |  |
| met4j_sbml2compoundgraph | PASS |  |
| met4j_sbml2graph | PASS |  |
| met4j_sbml2pathwaynet | PASS |  |
| met4j_sbml2tab | PASS |  |
| met4j_sbmlwizard | PASS |  |
| met4j_setcharges | PASS |  |
| met4j_setchemicalformulas | PASS |  |
| met4j_setecnumbers | PASS |  |
| met4j_setgprs | PASS |  |
| met4j_setids | PASS |  |
| met4j_setnames | PASS |  |
| met4j_setpathways | PASS |  |
| met4j_setreferences | PASS |  |
| met4j_tab2sbml | PASS |  |

## met4j_extractannotations

### Tool Description
Extract databases' references from SBML annotations or notes. The references are exported as a tabulated file with one column with the SBML compound, reaction or gene identifiers, and one column with the corresponding database identifier.The name of the targeted database need to be provided under the same form than the one used in the notes field or the identifiers.org uri.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Total Downloads**: 100.0K
- **Last updated**: 2026-01-31
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
ExtractAnnotations
Extract databases' references from SBML annotations or notes. The references are exported as a tabulated file with one column with the SBML compound, reaction or gene identifiers, and one column with the corresponding database identifier.The name of the targeted database need to be provided under the same form than the one used in the notes field or the identifiers.org uri.
 -db VAL                                : name of the referenced database to
                                          export annotations from, as listed in
                                          notes or identifiers.org base uri
 -export [METABOLITE | REACTION | GENE] : the type of entity to extract
                                          annotation, either metabolite,
                                          reaction, or gene
 -h                                     : prints the help (default: true)
 -i VAL                                 : input SBML file
 -o VAL                                 : output file path
 -skip                                  : Skip entities without the selected
                                          annotations, by default output them
                                          with NA value (default: false)
 -uniq                                  : keep only one identifier if multiple
                                          are referenced for the same entity
                                          (default: false)
```


## met4j_extractpathways

### Tool Description
Extract pathway(s) from a SBML file and create a sub-network SBML file

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file
 -h     : prints the help (default: true)
 -i VAL : input SBML file
 -o VAL : output SBML file
 -p VAL : pathway identifiers, separated by "+" sign if more than one
```


## met4j_getentities

### Tool Description
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.The output file is a tabulated file with two columns, one with entity identifiers, and one with the entity type. If no entity type is selected, all of them are returned by default. Only identifiers are written, attributes can be extracted from dedicated apps or from the Sbml2Tab app.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.The output file is a tabulated file with two columns, one with entity identifiers, and one with the entity type. If no entity type is selected, all of them are returned by default. Only identifiers are written, attributes can be extracted from dedicated apps or from the Sbml2Tab app.
 -c (--compartments) : Extract Compartments (default: false)
 -g (--genes)        : Extract Genes (default: false)
 -h                  : prints the help (default: true)
 -i VAL              : Input SBML file
 -m (--metabolites)  : Extract Metabolites (default: false)
 -nt (--noTypeCol)   : Do not write type column (default: false)
 -o VAL              : Output file
 -p (--pathways)     : Extract Pathways (default: false)
 -r (--reactions)    : Extract Reactions (default: false)
```


## met4j_getgenesfromreactions

### Tool Description
Get associated gene list from a list of reactions and a SBML file. Parse SBML GPR annotations and output a tab-separated file with one row per gene, associated reaction identifiers from input file in first column, gene identifiers in second column.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
GetGenesFromReactions
Get associated gene list from a list of reactions and a SBML file. Parse SBML GPR annotations and output a tab-separated file with one row per gene, associated reaction identifiers from input file in first column, gene identifiers in second column.
 -col N   : Column number in reaction file (first as 1) (default: 1)
 -h       : prints the help (default: true)
 -header  : Skip reaction file header (default: false)
 -i VAL   : Input SBML file
 -o VAL   : Output file
 -r VAL   : Input Reaction file
 -sep VAL : Separator in reaction file (default: 	)
```


## met4j_getmetaboliteattributes

### Tool Description
Create a tabulated file with metabolite attributes from a SBML file

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file
 -h     : prints the help (default: true)
 -i VAL : Input SBML file
 -o VAL : Output file
```


## met4j_getreactantsfromreactions

### Tool Description
Get reactant lists from a list of reactions and a Sbml file. Output a tab-separated file with one row per reactant, reaction identifiers in first column, reactant identifiers in second column. It can provides substrates, products, or both (by default). In the case of reversible reactions, all reactants are considered as both substrates and products

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
GetReactantsFromReactions
Get reactant lists from a list of reactions and a Sbml file. Output a tab-separated file with one row per reactant, reaction identifiers in first column, reactant identifiers in second column. It can provides substrates, products, or both (by default). In the case of reversible reactions, all reactants are considered as both substrates and products
 -col N            : Column number in reaction file (first as 1) (default: 1)
 -h                : prints the help (default: true)
 -header           : Skip reaction file header (default: false)
 -i VAL            : Input SBML file
 -o VAL            : Output file
 -p (--products)   : Extract products only (default: false)
 -r VAL            : Input Reaction file
 -s (--substrates) : Extract substrates only (default: false)
 -sep VAL          : Separator in reaction file (default: 	)
```


## met4j_grouprxnbyenzymeclass

### Tool Description
Alternative functional grouping of reactions in model :Replace pathways in model by groups of reactions sharing EC numbers. EC numbers are retrieved from annotation fields, and propagated to their parent class (e.g. EC 1.2.3.4 will be added to groups 1.2.3, 1.2 and 1).

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model :Replace pathways in model by groups of reactions sharing EC numbers. EC numbers are retrieved from annotation fields, and propagated to their parent class (e.g. EC 1.2.3.4 will be added to groups 1.2.3, 1.2 and 1).
Reactions without EC number are kept in the model but won't have any group assigned.
Original pathway assignments are erased.
EC groups with size out of the range [min-max] are ignored.
 -h     : prints the help (default: true)
 -i VAL : input SBML file
 -max N : maximum size of the EC class to convert as pathway (default: 200)
 -min N : minimum size of the EC class to convert as pathway (default: 2)
 -o VAL : output SBML file
```


## met4j_setcharges

### Tool Description
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges
The charge must be a number. The ids must correspond between the tabulated file and the SBML file.
If prefix or suffix is different in the SBML file, use the -p or the -s options.
The charge will be written in the SBML file in two locations:+
- in the reaction notes (e.g. charge: -1)
- as fbc attribute (e.g. fbc:charge="1")
 -c VAL   : [#] Comment String in the tabulated file. The lines beginning by
            this string won't be read (default: #)
 -cc N    : [2] number of the column where are the charges (default: 2)
 -ci N    : [1] number of the column where are the metabolite ids (default: 1)
 -h       : prints the help (default: true)
 -i VAL   : Original SBML file
 -n N     : [0] Number of lines to skip at the beginning of the tabulated file
            (default: 0)
 -o VAL   : [out.sbml] SBML output file (default: out.sbml)
 -p       : [deactivated] To match the objects in the sbml file, adds the
            prefix M_ to metabolite ids (default: false)
 -s       : [deactivated] To match the objects in the sbml file, adds the
            suffix _comparmentID to metabolites (default: false)
 -tab VAL : Input Tabulated file
```


## met4j_setchemicalformulas

### Tool Description
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas
The ids must correspond between the tabulated file and the SBML file.
If prefix or suffix is different in the SBML file, use the -p or the -s options.
The formula will be written in the SBML file in two locations:+
- in the metabolite HTML notes (e.g. formula: C16H29O2)
- as a fbc attribute (e.g. fbc:chemicalFormula="C16H29O2")
 -c VAL   : [#] Comment String in the tabulated file. The lines beginning by
            this string won't be read (default: #)
 -cf N    : [2] number of the column where are the formulas (default: 2)
 -ci N    : [1] number of the column where are the metabolite ids (default: 1)
 -h       : prints the help (default: true)
 -i VAL   : Original SBML file
 -n N     : [0] Number of lines to skip at the beginning of the tabulated file
            (default: 0)
 -o VAL   : [out.sbml] SBML output file (default: out.sbml)
 -p       : [deactivated] To match the objects in the sbml file, adds the
            prefix M_ to metabolite ids (default: false)
 -s       : [deactivated] To match the objects in the sbml file, adds the
            suffix _comparmentID to metabolites (default: false)
 -tab VAL : Input Tabulated file
```


## met4j_setecnumbers

### Tool Description
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers
The ids must correspond between the tabulated file and the SBML file.
If prefix R_ is present in the ids in the SBML file and not in the tabulated file, use the -p option.
The EC will be written in the SBML file in two locations:
- in the reaction HTML notes (e.g. EC_NUMBER: 2.4.2.14)
- as a reaction MIRIAM annotation (see https://pubmed.ncbi.nlm.nih.gov/16333295/) with ec-code identifiers link (https://registry.identifiers.org/registry/ec-code)
 -c VAL   : [#] Comment String in the tabulated file. The lines beginning by
            this string won't be read (default: #)
 -cec N   : [2] number of the column where are the ecs (default: 2)
 -ci N    : [1] number of the column where are the reaction ids (default: 1)
 -h       : prints the help (default: true)
 -i VAL   : Original SBML file
 -n N     : [0] Number of lines to skip at the beginning of the tabulated file
            (default: 0)
 -o VAL   : [out.sbml] SBML output file (default: out.sbml)
 -p       : [deactivated] To match the objects in the sbml file, adds the
            prefix R_ to reactions (default: false)
 -tab VAL : Input Tabulated file
```


## met4j_setgprs

### Tool Description
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way
The ids must correspond between the tabulated file and the SBML file.
If prefix R_ is present in the ids in the SBML file and not in the tabulated file, use the -p option.
GPR must be written in a cobra way in the tabulated file as described in Schellenberger et al 2011 Nature Protocols 6(9):1290-307
(The GPR will be written in the SBML file in two locations:
- in the reaction html notes (GENE_ASSOCIATION: ( XC_0401 ) OR ( XC_3282 ))
- as fbc gene product association (see FBC package specifications: https://doi.org/10.1515/jib-2017-0082)
 -c VAL   : [#] Comment String in the tabulated file. The lines beginning by
            this string won't be read (default: #)
 -cgpr N  : [2] number of the column where are the gprs (default: 2)
 -ci N    : [1] number of the column where are the reaction ids (default: 1)
 -h       : prints the help (default: true)
 -i VAL   : Original SBML file
 -n N     : [0] Number of lines to skip at the beginning of the tabulated file
            (default: 0)
 -o VAL   : [out.sbml] SBML output file (default: out.sbml)
 -p       : [deactivated] To match the objects in the sbml file, adds the
            prefix R_ to reactions (default: false)
 -tab VAL : Input Tabulated file
```


## met4j_setids

### Tool Description
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids
The ids must correspond between the tabulated file and the SBML file.
If prefix or suffix is different in the SBML file, use the -p or the -s options.

 -c VAL                                 : [#] Comment String in the tabulated
                                          file. The lines beginning by this
                                          string won't be read (default: #)
 -ci N                                  : [1] number of the column where are
                                          the object ids (default: 1)
 -cnew N                                : [2] number of the column where are
                                          the new ids (default: 2)
 -h                                     : prints the help (default: true)
 -i VAL                                 : Original SBML file
 -n N                                   : [0] Number of lines to skip at the
                                          beginning of the tabulated file
                                          (default: 0)
 -o VAL                                 : [out.sbml] SBML output file (default:
                                          out.sbml)
 -p                                     : [deactivated] To match the objects in
                                          the sbml file, adds the prefix R_ to
                                          reactions and M_ to metabolites
                                          (default: false)
 -s                                     : [deactivated] To match the objects in
                                          the sbml file, adds the suffix
                                          _comparmentID to metabolites
                                          (default: false)
 -t [REACTION | METABOLITE | GENE |     : [REACTION] Object type in the column
 PROTEIN | PATHWAY | COMPARTMENT]         id : REACTION;METABOLITE;GENE;PATHWAY
                                          (default: REACTION)
 -tab VAL                               : Input Tabulated file
```


## met4j_setnames

### Tool Description
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names
The ids must correspond between the tabulated file and the SBML file.
If prefix or suffix is different in the SBML file, use the -p or the -s options.

 -c VAL                                 : [#] Comment String in the tabulated
                                          file. The lines beginning by this
                                          string won't be read (default: #)
 -ci N                                  : [1] number of the column where are
                                          the object ids (default: 1)
 -cname N                               : [2] number of the column where are
                                          the names (default: 2)
 -h                                     : prints the help (default: true)
 -i VAL                                 : Original SBML file
 -n N                                   : [0] Number of lines to skip at the
                                          beginning of the tabulated file
                                          (default: 0)
 -o VAL                                 : [out.sbml] SBML output file (default:
                                          out.sbml)
 -p                                     : [deactivated] To match the objects in
                                          the sbml file, adds the prefix R_ to
                                          reactions and M_ to metabolites
                                          (default: false)
 -s                                     : [deactivated] To match the objects in
                                          the sbml file, adds the suffix
                                          _comparmentID to metabolites
                                          (default: false)
 -t [REACTION | METABOLITE | GENE |     : [REACTION] Object type in the column
 PROTEIN | PATHWAY | COMPARTMENT]         id : REACTION;METABOLITE;GENE;PATHWAY
                                          (default: REACTION)
 -tab VAL                               : Input Tabulated file
```


## met4j_setpathways

### Tool Description
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways
The ids must correspond between the tabulated file and the SBML file.
If prefix R_ is present in the ids in the SBML file and not in the tabulated file, use the -p option.
Pathways will be written in the SBML file in two ways:- as reaction note (e.g. SUBSYSTEM: purine_biosynthesis)- as SBML group (see Group package specifications: https://pmc.ncbi.nlm.nih.gov/articles/PMC5451322/)
 -c VAL   : [#] Comment String in the tabulated file. The lines beginning by
            this string won't be read (default: #)
 -ci N    : [1] number of the column where are the reaction ids (default: 1)
 -cp N    : [2] number of the column where are the pathways (default: 2)
 -h       : prints the help (default: true)
 -i VAL   : Original SBML file
 -n N     : [0] Number of lines to skip at the beginning of the tabulated file
            (default: 0)
 -o VAL   : [out.sbml] SBML output file (default: out.sbml)
 -p       : [deactivated] To match the objects in the sbml file, adds the
            prefix R_ to reactions (default: false)
 -sep VAL : [|] Separator of pathways in the tabulated file (default: |)
 -tab VAL : Input Tabulated file
```


## met4j_setreferences

### Tool Description
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references
Reference name given as parameter (-ref) must correspond to an existing id in the registry of identifiers.org (https://registry.identifiers.org/registry)
The corresponding key:value pair will be written as metabolite or reaction MIRIAM annotation (see https://pubmed.ncbi.nlm.nih.gov/16333295/)
 -c VAL                                 : [#] Comment String in the tabulated
                                          file. The lines beginning by this
                                          string won't be read (default: #)
 -ci N                                  : [1] number of the column where are
                                          the object ids (default: 1)
 -cr N                                  : [2] number of the column where are
                                          the references (default: 2)
 -h                                     : prints the help (default: true)
 -i VAL                                 : Original SBML file
 -n N                                   : [0] Number of lines to skip at the
                                          beginning of the tabulated file
                                          (default: 0)
 -o VAL                                 : [out.sbml] SBML output file (default:
                                          out.sbml)
 -p                                     : [deactivated] To match the objects in
                                          the sbml file, adds the prefix R_ to
                                          reactions and M_ to metabolites
                                          (default: false)
 -ref VAL                               : Name of the reference. Must exist in
                                          identifiers.org (https://registry.iden
                                          tifiers.org/registry)
 -s                                     : [deactivated] To match the objects in
                                          the sbml file, adds the suffix
                                          _comparmentID to metabolites
                                          (default: false)
 -t [REACTION | METABOLITE | GENE |     : [REACTION] Object type in the column
 PROTEIN | PATHWAY | COMPARTMENT]         id : REACTION;METABOLITE;GENE;PATHWAY
                                          (default: REACTION)
 -tab VAL                               : Input Tabulated file
```


## met4j_getbiggmodelproteome

### Tool Description
Get proteome in fasta format of a model present in the BIGG database

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database
 -h     : prints the help (default: true)
 -m VAL : [ex: iMM904] id of the BIGG model
 -o VAL : [proteome.fas] path of the output file (default: proteome.fas)
```


## met4j_fbctnotes

### Tool Description
Convert FBC package annotations to sbml html notes

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
FbcToNotes
Convert FBC package annotations to sbml html notes
 -h     : prints the help (default: true)
 -i VAL : input SBML file
 -o VAL : output SBML file
```


## met4j_kegg2sbml

### Tool Description
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.
Errors returned by this program could be due to Kegg API dysfunctions or limitations. Try later if this problem occurs.
 -h       : prints the help (default: true)
 -o VAL   : [out.sbml] Out sbml file (default: out.sbml)
 -org VAL : [] Kegg org id. Must be 3 letters ( (default: )
```


## met4j_notestofbc

### Tool Description
Convert sbml html notes to fbc package annotations

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
NotesToFbc
Convert sbml html notes to fbc package annotations
 -h     : prints the help (default: true)
 -i VAL : input SBML file
 -o VAL : output SBML file
```


## met4j_sbml2carbonskeletonnet

### Tool Description
Metabolic networks used for quantitative analysis often contain links that are irrelevant for graph-based structural analysis. For example, inclusion of side compounds or modelling artifacts such as 'biomass' nodes. Focusing on links between compounds that share parts of their carbon skeleton allows to avoid many transitions involving side compounds, and removes entities without defined chemical structure. This app produces a Carbon Skeleton Network relevant for graph-based analysis of metabolism, in GML or matrix format, from a SBML and an GSAM atom mapping file. GSAM (see https://forgemia.inra.fr/metexplore/gsam) performs atom mapping at genome-scale level using the Reaction Decoder Tool (https://github.com/asad/ReactionDecoder) and allows to compute the number of conserved atoms of a given type between reactants.This app also enables Markov-chain based analysis of metabolic networks by computing reaction-normalized transition probabilities on the Carbon Skeleton Network.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
Sbml2CarbonSkeletonNet
Metabolic networks used for quantitative analysis often contain links that are irrelevant for graph-based structural analysis. For example, inclusion of side compounds or modelling artifacts such as 'biomass' nodes. Focusing on links between compounds that share parts of their carbon skeleton allows to avoid many transitions involving side compounds, and removes entities without defined chemical structure. This app produces a Carbon Skeleton Network relevant for graph-based analysis of metabolism, in GML or matrix format, from a SBML and an GSAM atom mapping file. GSAM (see https://forgemia.inra.fr/metexplore/gsam) performs atom mapping at genome-scale level using the Reaction Decoder Tool (https://github.com/asad/ReactionDecoder) and allows to compute the number of conserved atoms of a given type between reactants.This app also enables Markov-chain based analysis of metabolic networks by computing reaction-normalized transition probabilities on the Carbon Skeleton Network.
 -f (--format) [gml | tab | nodeList |  : Format of the exported graphTabulated
 json | matrix | jsonviz]                 edge list by default (source id 	
                                          edge type 	 target id). Other options
                                          include GML, JsonGraph, and tabulated
                                          node list (label 	 node id 	 node
                                          type). (default: tab)
 -fi (--fromIndexes)                    : Use GSAM output with carbon indexes
                                          (default: false)
 -g VAL                                 : input GSAM file
 -h                                     : prints the help (default: true)
 -i VAL                                 : input SBML file
 -ks (--keepSingleCarbon)               : keep edges involving single-carbon
                                          compounds, such as CO2 (requires
                                          formulas in SBML) (default: false)
 -main (--onlyMainTransition)           : Compute RPAIRS-like tags and keep
                                          only main transitions for each
                                          reaction (default: false)
 -mc (--nocomp)                         : merge compartments (requires unique
                                          compound names that are consistent
                                          across compartments) (default: false)
 -me (--simple)                         : merge parallel edges to produce a
                                          simple graph (default: false)
 -o VAL                                 : output file: path to the tabulated
                                          file where the resulting network will
                                          be exported
 -ri (--removeIsolatedNodes)            : remove isolated nodes (default: false)
 -tp (--transitionproba)                : set transition probability as weight
                                          (default: false)
 -un (--undirected)                     : create as undirected (default: false)
```


## met4j_sbml2compoundgraph

### Tool Description
Metabolic networks used for quantitative analysis often contain links that are irrelevant for graph-based structural analysis. For example, inclusion of side compounds or modelling artifacts such as 'biomass' nodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
Sbml2CompoundGraph
Metabolic networks used for quantitative analysis often contain links that are irrelevant for graph-based structural analysis. For example, inclusion of side compounds or modelling artifacts such as 'biomass' nodes.
While Carbon Skeleton Graph offer a relevant alternative topology for graph-based analysis, it requires compounds' structure information, usually not provided in model, and difficult to retrieve for model with sparse cross-reference annotations.
In contrary to the Sbml2Graph app that performs a raw conversion of the SBML content, the present app propose a fine-tuned creation of compound graph from predefined list of side compounds and degree weighting to get relevant structure without structural data.This app also enables Markov-chain based analysis of metabolic networks by computing reaction-normalized transition probabilities on the network.
 -cw (--customWeights) VAL              : an optional file containing weights
                                          for compound pairs
 -dw (--degreeWeights)                  : penalize traversal of hubs by using
                                          degree square weighting (default:
                                          false)
 -f (--format) [gml | tab | nodeList |  : Format of the exported graphTabulated
 json | matrix | jsonviz]                 edge list by default (source id 	
                                          edge type 	 target id). Other options
                                          include GML, JsonGraph, and tabulated
                                          node list (label 	 node id 	 node
                                          type). (default: tab)
 -h                                     : prints the help (default: true)
 -i VAL                                 : input SBML file
 -mc (--mergecomp) [no | by_name |      : merge compartments. Use names if
 by_id]                                   consistent and unambiguous across
                                          compartments, or identifiers if
                                          compartment suffix is present (id in
                                          form "xxx_y" with xxx as base
                                          identifier and y as compartment
                                          label). (default: no)
 -me (--simple)                         : merge parallel edges to produce a
                                          simple graph (default: false)
 -o VAL                                 : output file: path to the tabulated
                                          file where the resulting network will
                                          be exported
 -ri (--removeIsolatedNodes)            : remove isolated nodes (default: false)
 -sc VAL                                : input Side compound file
 -tp (--transitionproba)                : set weight as random walk transition
                                          probability, normalized by reaction
                                          (default: false)
 -un (--undirected)                     : create as undirected (default: false)
```


## met4j_sbml2graph

### Tool Description
Create a graph representation of a SBML file content, and export it in graph file format.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.
The graph can be either a compound graph, a reaction graph or a bipartite graph, and can be exported in gml or tabulated file format.
 -b (--bipartite)                       : create bipartite graph (default:
                                          false)
 -c (--compound)                        : create compound graph (default: true)
 -f (--format) [gml | tab | nodeList |  : Format of the exported graphTabulated
 json | matrix | jsonviz]                 edge list by default (source id 	
                                          edge type 	 target id). Other options
                                          include GML, JsonGraph, and tabulated
                                          node list (label 	 node id 	 node
                                          type). (default: tab)
 -h                                     : prints the help (default: true)
 -i VAL                                 : input SBML file
 -o VAL                                 : output file: path to the tabulated
                                          file where the resulting network will
                                          be exported
 -r (--reaction)                        : create reaction graph (default: false)
```


## met4j_sbml2pathwaynet

### Tool Description
Creation of a Pathway Network representation of a SBML file content

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content
Genome-scale metabolic networks are often partitioned into metabolic pathways. Pathways are frequently considered independently despite frequent coupling in their activity due to shared metabolites. In order to decipher the interconnections linking overlapping pathways, this app proposes the creation of "Pathway Network", where two pathways are linked if they share compounds.
 -cw (--customWeights) VAL              : an optional file containing weights
                                          for pathway pairs
 -f (--format) [gml | tab | nodeList |  : Format of the exported graphTabulated
 json | matrix | jsonviz]                 edge list by default (source id 	
                                          edge type 	 target id). Other options
                                          include GML, JsonGraph, and tabulated
                                          node list (label 	 node id 	 node
                                          type). (default: tab)
 -h                                     : prints the help (default: true)
 -i VAL                                 : input SBML file
 -ncw (--connectorWeights)              : set number of connecting compounds as
                                          weight (default: false)
 -o VAL                                 : output Graph file
 -oss (--onlySourcesAndSinks)           : consider only metabolites that are
                                          source or sink in the pathway (i.e
                                          non-intermediary compounds) (default:
                                          false)
 -ri (--removeIsolatedNodes)            : remove isolated nodes (default: false)
 -sc VAL                                : input Side compound file (recommended)
```


## met4j_sbml2tab

### Tool Description
Create a tabulated file listing reaction attributes from a SBML file

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file
 -h       : prints the help (default: true)
 -i VAL   : Sbml file
 -irr VAL : [-->] String for irreversible reaction (default: -->)
 -o VAL   : [out.tsv] Tabulated file (default: out.tsv)
 -rev VAL : [<==>] String for reversible reaction (default: <==>)
```


## met4j_sbmlwizard

### Tool Description
General SBML model processing including compound removal (such as side compounds or isolated compounds), reaction removal (ex. blocked or exchange reaction), and compartment merging

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
SbmlWizard
General SBML model processing including compound removal (such as side compounds or isolated compounds), reaction removal (ex. blocked or exchange reaction), and compartment merging
 -h                                     : prints the help (default: true)
 -i VAL                                 : input SBML file
 -kc (--retainC) VAL                    : file containing identifiers of
                                          compounds to keep from the metabolic
                                          network
 -kr (--retainR) VAL                    : file containing identifiers of
                                          reactions to keep from the metabolic
                                          network
 -mc (--mergecomp) [no | by_name |      : merge compartments using the provided
 by_id]                                   strategy. No merge by default.
                                          "by_name" can be used if names are
                                          consistent and unambiguous across
                                          compartments, "by_id" can be used if
                                          compartment suffix is present in
                                          compounds identifiers (id in form
                                          "xxx_y" with xxx as base identifier
                                          and y as compartment label).
                                          (default: no)
 -o VAL                                 : output SBML file
 -r0 (--noFlux)                         : remove reactions with lower and upper
                                          flux bounds both set to 0.0 (default:
                                          false)
 -rEX (--removeExchange) VAL            : remove exchange reactions and species
                                          from given exchange compartment
                                          identifier
 -rc (--removeC) VAL                    : file containing identifiers of
                                          compounds to remove from the
                                          metabolic network
 -rdr (--noDuplicated)                  : remove duplicated reactions (same
                                          reactants, same GPR) (default: false)
 -ric (--noIsolated)                    : remove isolated compounds (not
                                          involved in any reaction) (default:
                                          false)
 -rr (--removeR) VAL                    : file containing identifiers of
                                          reactions to remove from the
                                          metabolic network
```


## met4j_tab2sbml

### Tool Description
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas
 -M_c                        : [false] Use Palsson et al. convention:
                               compartment suffix in metabolite ids with _
                               separator (default: false)
 -b (--boundary) VAL         : set a compartment as the system boundary. All
                               metabolites in this compartment will have the
                               attribute `boundaryCondition` set to true in the
                               sbml.
 -cf N                       : [2] number of the column where are the reaction
                               formulas (default: 2)
 -ci N                       : [1] number of the column where are the reaction
                               ids (default: 1)
 -dcpt VAL                   : [c] Default compartment (default: c)
 -h                          : prints the help (default: true)
 -i VAL                      : Tabulated file
 -id VAL                     : [NA] Model id written in the SBML file (default:
                               NA)
 -ign (--ignore-failed-read) : skip lines with parsing errors instead of
                               stopping the process (default: false)
 -irr VAL                    : [-->] String for irreversible reaction (default:
                               -->)
 -n N                        : [0] Number of lines to skip at the beginning of
                               the tabulated file (default: 0)
 -o VAL                      : [out.sbml] Out sbml file (default: out.sbml)
 -rev VAL                    : [<==>] String for reversible reaction (default:
                               <==>)
```


## met4j_formulamapper

### Tool Description
Retrieve metabolites in a SBML file from their chemical formula.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula. 
The SBML file is expected to contain fbc:chemicalFormula attributes for species entries.
The input formula file should contain one formula per line. The output is a tab delimited file with two columns: query formula, sbml metabolite id (one line per match)
 -f VAL            : input formula file (one per line)
 -h                : prints the help (default: true)
 -i VAL            : input SBML file
 -na               : Output formulas without match in model, with NA value
                     (default: false)
 -o (--output) VAL : output mapping file
```


## Metadata
- **Skill**: generated

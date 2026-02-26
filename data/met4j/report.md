# met4j CWL Generation Report

## met4j_extractannotations

### Tool Description
Extract databases' references from SBML annotations or notes.

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
First argument is not a valid package name : extractannotations
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
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
First argument is not a valid package name : extractpathways
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_getentities

### Tool Description
Met4j-Toolbox: Applications classified by package.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : getentities
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_getgenesfromreactions

### Tool Description
Get gene lists from a list of reactions and a SBML file.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : getgenesfromreactions
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_getmetaboliteattributes

### Tool Description
The applications are classified by package. The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app Launch the application with the -h parameter to get the list of the parameters and a complete description.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : getmetaboliteattributes
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_getreactantsfromreactions

### Tool Description
Get reactant lists from a list of reactions and a SBML file.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : getreactantsfromreactions
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_grouprxnbyenzymeclass

### Tool Description
The applications are classified by package. The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app Launch the application with the -h parameter to get the list of the parameters and a complete description.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : grouprxnbyenzymeclass
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_setcharges

### Tool Description
Met4j-Toolbox: Applications classified by package.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : setcharges
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
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
First argument is not a valid package name : setchemicalformulas
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_setecnumbers

### Tool Description
Met4j-Toolbox: Applications classified by package.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : setecnumbers
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_setgprs

### Tool Description
Met4j-Toolbox: Applications classified by package.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : setgprs
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_setids

### Tool Description
Met4j-Toolbox: Applications classified by package.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : setids
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_setnames

### Tool Description
Met4j-Toolbox: Applications classified by package.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : setnames
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_setpathways

### Tool Description
Met4j-Toolbox: Applications classified by package.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : setpathways
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_setreferences

### Tool Description
Met4j-Toolbox: Applications classified by package. The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app. Launch the application with the -h parameter to get the list of the parameters and a complete description.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : setreferences
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
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
First argument is not a valid package name : getbiggmodelproteome
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_fbctnotes

### Tool Description
Met4j-Toolbox: Applications classified by package.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : fbctnotes
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
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
First argument is not a valid package name : kegg2sbml
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_notestofbc

### Tool Description
Met4j-Toolbox: Applications classified by package.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : notestofbc
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_sbml2carbonskeletonnet

### Tool Description
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : sbml2carbonskeletonnet
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_sbml2compoundgraph

### Tool Description
Advanced creation of a compound graph representation of a SBML file content

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : sbml2compoundgraph
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
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
First argument is not a valid package name : sbml2graph
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_sbml2pathwaynet

### Tool Description
The applications are classified by package. The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app Launch the application with the -h parameter to get the list of the parameters and a complete description.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : sbml2pathwaynet
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
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
First argument is not a valid package name : sbml2tab
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_sbmlwizard

### Tool Description
Met4j-Toolbox: Applications classified by package.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : sbmlwizard
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_tab2sbml

### Tool Description
The applications are classified by package. The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app Launch the application with the -h parameter to get the list of the parameters and a complete description.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : tab2sbml
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## met4j_formulamapper

### Tool Description
Met4j-Toolbox: Applications classified by package.

### Metadata
- **Docker Image**: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
- **Homepage**: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/met4j/overview
- **Validation**: PASS

### Original Help Text
```text
First argument is not a valid package name : formulamapper
Valid packages are : attributes, bigg, convert, mapping, networkAnalysis, reconstruction

Usage: met4j [package.function] [options]
  example : met4j convert.Sbml2Graph -i mySbml.xml -o ./output.txt

-------------------------------------------
# Met4j-Toolbox
The applications are classified by package.
The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app
Launch the application with the -h parameter to get the list of the parameters and a complete description.

## Package fr.inrae.toulouse.metexplore.met4j_toolbox

### GenerateGalaxyFiles
Create the galaxy file tree containing met4j-toolbox app wrappers

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.attributes

### ExtractAnnotations
Extract databases' references from SBML annotations or notes.

### ExtractPathways
Extract pathway(s) from a SBML file and create a sub-network SBML file

### GetEntities
Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.

### GetGenesFromReactions
Get gene lists from a list of reactions and a SBML file.

### GetMetaboliteAttributes
Create a tabulated file with metabolite attributes from a SBML file

### GetReactantsFromReactions
Get reactant lists from a list of reactions and a SBML file.

### GroupRxnByEnzymeClass
Alternative functional grouping of reactions in model : Replace pathways by groups of reactions sharing EC numbers

### SetCharges
Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges

### SetChemicalFormulas
Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas

### SetEcNumbers
Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers

### SetGprs
Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way

### SetIds
Set new ids to network objects in a SBML file from a tabulated file containing the old ids and the new ids

### SetNames
Set names to network objects in a SBML file from a tabulated file containing the object ids and the names

### SetPathways
Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways

### SetReferences
Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.bigg

### GetBiggModelProteome
Get proteome in fasta format of a model present in the BIGG database

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.convert

### FbcToNotes
Convert FBC package annotations to sbml html notes

### Kegg2Sbml
Build a SBML file from KEGG organism-specific pathways. Uses Kegg API.

### NotesToFbc
Convert sbml html notes to fbc package annotations

### Sbml2CarbonSkeletonNet
Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)

### Sbml2CompoundGraph
Advanced creation of a compound graph representation of a SBML file content

### Sbml2Graph
Create a graph representation of a SBML file content, and export it in graph file format.

### Sbml2PathwayNet
Creation of a Pathway Network representation of a SBML file content

### Sbml2Tab
Create a tabulated file listing reaction attributes from a SBML file

### SbmlWizard
General SBML model processing

### Tab2Sbml
Create a Sbml File from a tabulated file that contains the reaction ids and the formulas

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.mapping

### FormulaMapper
Retrieve metabolites in a SBML file from their chemical formula

### IdMapper
Map external metabolite identifiers (kegg, metanetx, pubchem CID...) to metabolite ids from a SBML file

### MassMapper
Retrieve metabolites in a SBML file from their mass.

### NameMatcher
From a list of compound names, find the best matching metabolites in a SBML model using fuzzy name matching on harmonized aliases.

### ORApathwayEnrichment
Perform Over Representation Analysis for Pathway Enrichment, using one-tailed exact Fisher Test.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.networkAnalysis

### BipartiteDistanceMatrix
Create a compound to reactions distance matrix.

### ChemSimilarityWeighting
Provides tabulated compound graph edge list, with one column with reactant pair's chemical similarity.

### ChokePoint
Compute the Choke points of a metabolic network.

### DegreeWeighting
Provides tabulated compound graph edge list, with one column with target's degree.

### DistanceMatrix
Create a compound to compound distance matrix.

### ExtractSubBipNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds and/or reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### ExtractSubNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of compounds of interests ids, one per row.

### ExtractSubReactionNetwork
Create a subnetwork from a metabolic network in SBML format, and two files containing lists of reactions of interests ids, one per row, plus one file of the same format containing side compounds ids.

### LoadPoint
Compute the Load points of a metabolic network. Load points constitute an indicator of lethality and can help identifying drug targets.

### MetaboRank
Compute the MetaboRank, a custom personalized PageRank for metabolic network.

### NetworkSummary
Create a report summarizing several graph measures characterising the structure of a metabolic network.

### PrecursorNetwork
Perform a network expansion from a set of compound targets to create a precursor network.

### ReactionDistanceMatrix
Create a reaction to reaction distance matrix.

### ScopeNetwork
Perform a network expansion from a set of compound seeds to create a scope network

### SeedsAndTargets
Identify exogenously acquired compounds, exogenously available producible compounds and/or dead ends metabolites from metabolic network topology

### SideCompoundsScan
Scan a network to identify side compounds.

### TopologicalPathwayAnalysis
Run a Topological Pathway Analysis (TPA) to identify key pathways based on topological properties of its constituting compounds.

------------------------------------------
## Package fr.inrae.toulouse.metexplore.met4j_toolbox.reconstruction

### CreateMetaNetwork
Create a Meta-Network from two sub-networks in SBML format.

### SbmlCheckBalance
Check balance of all the reactions in a SBML.

------------------------------------------
```


## Metadata
- **Skill**: generated

---
name: met4j
description: Met4j is a Java library for metabolic network analysis that enables processing, topological analysis, and conversion of SBML models. Use when user asks to convert SBML models to graphs, perform choke-point analysis, calculate metabolic scope, or extract sub-networks based on specific biological criteria.
homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md
---


# met4j

## Overview
Met4j is a comprehensive Java library designed for metabolic network analysis. It offers a modular toolbox for processing SBML models, enabling users to perform complex topological analyses, convert between metabolic formats, and compute structural properties of metabolic networks. This skill assists in selecting the correct Met4j module for specific biological questions and provides the necessary command-line patterns to execute these tasks efficiently.

## Core Workflows and CLI Patterns

### Model Manipulation and Conversion
Met4j provides utilities to clean and standardize SBML models before analysis.
- **SBML to Graph**: Convert metabolic models into various graph representations (bipartite, compound, or reaction graphs).
- **Attribute Management**: Add or remove annotations, SBO terms, and chemical identifiers.
- **Filtering**: Extract sub-networks based on pathways, compartments, or specific lists of reactions/compounds.

### Topological Analysis
Use these modules to understand the structural characteristics of the network:
- **Choke-point Analysis**: Identify reactions whose removal disconnects the network, suggesting potential essentiality.
- **Scope Calculation**: Determine the set of metabolites reachable from a given seed set of precursors.
- **Precursor Sets**: Identify the minimal sets of nutrients required to produce a specific target metabolite.
- **Distance Metrics**: Calculate shortest paths and diameters within the metabolic graph.

### Best Practices
- **Input Validation**: Always validate SBML files using the `CheckSBML` module before running complex topological analyses to ensure compatibility with the parser.
- **Side Compounds**: When creating graphs, use the `SideCompound` removal tools to exclude ubiquitous metabolites (like H2O, ATP, CO2) that create biologically irrelevant shortcuts in the network.
- **Memory Management**: For large-scale models (e.g., community models), ensure the Java Heap Space is sufficiently allocated using `-Xmx` flags when calling the JAR.

## Common Command Patterns
Met4j is typically invoked via a launcher or by calling specific class files within the toolbox JAR:
- `java -cp met4j-toolbox.jar fr.inrae.toulouse.metexplore.met4j_toolbox.[ModuleGroup].[ModuleName] -input <file.sbml> [options]`



## Subcommands

| Command | Description |
|---------|-------------|
| bigg.GetBiggModelProteome | Get proteome in fasta format of a model present in the BIGG database |
| convert.Sbml2CarbonSkeletonNet | Create a carbon skeleton graph representation of a SBML file content, using GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam) |
| convert.Sbml2CompoundGraph | Advanced creation of a compound graph representation of a SBML file content |
| convert.Sbml2Graph | Create a graph representation of a SBML file content, and export it in graph file format. |
| met4j | Extract databases' references from SBML annotations or notes. |
| met4j | Extract pathway(s) from a SBML file and create a sub-network SBML file |
| met4j | Met4j-Toolbox: Applications classified by package. |
| met4j | Met4j-Toolbox: Applications classified by package. |
| met4j | Met4j-Toolbox: Applications classified by package. |
| met4j | Get gene lists from a list of reactions and a SBML file. |
| met4j | The applications are classified by package. The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app Launch the application with the -h parameter to get the list of the parameters and a complete description. |
| met4j | Get reactant lists from a list of reactions and a SBML file. |
| met4j | The applications are classified by package. The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app Launch the application with the -h parameter to get the list of the parameters and a complete description. |
| met4j | Build a SBML file from KEGG organism-specific pathways. Uses Kegg API. |
| met4j | Met4j-Toolbox: Applications classified by package. |
| met4j | The applications are classified by package. The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app Launch the application with the -h parameter to get the list of the parameters and a complete description. |
| met4j | Create a tabulated file listing reaction attributes from a SBML file |
| met4j | Met4j-Toolbox: Applications classified by package. |
| met4j | Met4j-Toolbox: Applications classified by package. |
| met4j | Set Formula to network metabolites from a tabulated file containing the metabolite ids and the formulas |
| met4j | Met4j-Toolbox: Applications classified by package. |
| met4j | Met4j-Toolbox: Applications classified by package. |
| met4j | Met4j-Toolbox: Applications classified by package. |
| met4j | Met4j-Toolbox: Applications classified by package. |
| met4j | Met4j-Toolbox: Applications classified by package. |
| met4j | Met4j-Toolbox: Applications classified by package. The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app. Launch the application with the -h parameter to get the list of the parameters and a complete description. |
| met4j | The applications are classified by package. The complete class name must be provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile) to launch the app Launch the application with the -h parameter to get the list of the parameters and a complete description. |

## Reference documentation
- [Met4j Toolbox README](./references/forge_inrae_fr_metexplore_met4j_-_blob_master_met4j-toolbox_README.md)
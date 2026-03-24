# Genetic Design (BASIC Assembly) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.micalis.fr/equipe/galaxy-synbiocad/
- **Package**: https://workflowhub.eu/workflows/2009
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/2009/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 209
- **Last updated**: 2025-12-16
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Genetic_Design_(BASIC_Assembly).ga` (Main Workflow)
- **Project**: galaxy-SynBioCAD
- **Views**: 1264

## Description

# Genetic Design (BASIC Assembly)

* This workflow encodes the top-ranking predicted pathways from the previous workflow into plasmids intended to be expressed in the specified organism. BASIC is used as assembly method. 
* It provides ECHO® liquid handler instructions file.
* pub DOI: 10.1016/j.isci.2025.113599

## input:

* _Sampling file: csv file_ : The **CSV** file should contain cell-free components combination. This data will be passed to the icFree_extractor & icFree_learner tools.
* _Fluo/Lumi values_ : The **CSV** file should contain fuorescence/luminescence values. This data will be passed to the icFree_extractor tool.
* _referance file_ : The **CSV** reference yields file for calibratio. This data will be passed to the icFree_extractor tool.

## Tools:

>_Selenzy_

It is an open-source tool for selecting enzyme sequences from reaction-based queries. It uses reaction templates (e.g., RetroRules) to search for similar reactions in the MetaNetX5 database and retrieves the corresponding annotated enzyme sequences. The tool provides combined scoring based on reaction similarity, sequence conservation, phylogenetic distance, and sequence properties. It accepts SBML pathway files as input and returns SBML pathways annotated with UniProt IDs.

>_BASIC-design_

It generates BASIC-compatible genetic constructs from SBML files annotated with enzyme IDs, such as those produced by Selenzyme. Using the BASIC DNA assembly method—based on orthogonal linkers and type IIs restriction enzymes—it assembles constructs with predefined or user-supplied linkers, promoters, and backbones. The tool outputs three CSV files (construct designs and plate coordinates for linkers and DNA parts) and a set of SBOL files, one per construct. It supports multiple promoter and RBS combinations for each enzyme-coding sequence, and can optionally permute gene order in operon designs.
        
>_DNA-Bot_
        
It is a software tool that converts construct design CSV files—such as those produced by rpBASICDesign—into automated assembly protocols for OpenTrons liquid-handling robots. Users may specify labware and protocol parameters (e.g., washing or incubation times). DNA-Bot outputs Python scripts implementing the four BASIC assembly steps: Clip reactions (ligation of DNA parts with linkers), Purification (magnetic-bead cleanup), Assembly (combining purified parts into final constructs), and Transformation (introducing plasmids into the host strain and plating). The tool also produces metadata for tracking experimental parameters.

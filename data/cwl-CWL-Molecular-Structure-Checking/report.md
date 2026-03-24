# CWL Molecular Structure Checking CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://mmb.irbbarcelona.org/biobb/
- **Package**: https://workflowhub.eu/workflows/776
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/776/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 1.4K
- **Last updated**: 2024-03-05
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `workflow.cwl` (Main Workflow)
- **Project**: BioBB Building Blocks
- **Views**: 2980
- **Creators**: Adam Hospital, Genís Bayarri
- **Discussion / source**: http://mmb.irbbarcelona.org/biobb/workflows
- **Discussion / source**: https://mmb.irbbarcelona.org/biobb/workflows/tutorials/structure_checking
- **Discussion / source**: https://biobb-wf-structure-checking.readthedocs.io/en/latest/tutorial.html

## Description

# Molecular Structure Checking using BioExcel Building Blocks (biobb)

***

This tutorial aims to illustrate the process of **checking** a **molecular structure** before using it as an input for a **Molecular Dynamics** simulation. The workflow uses the **BioExcel Building Blocks library (biobb)**. The particular structure used is the crystal structure of **human Adenylate Kinase 1A (AK1A)**, in complex with the **AP5A inhibitor** (PDB code [1Z83](https://www.rcsb.org/structure/1z83)).  

**Structure checking** is a key step before setting up a protein system for **simulations**. A number of **common issues** found in structures at **Protein Data Bank** may compromise the success of the **simulation**, or may suggest that longer **equilibration** procedures are necessary.

The **workflow** shows how to:

- Run **basic manipulations on structures** (selection of models, chains, alternative locations
- Detect and fix **amide assignments** and **wrong chiralities**
- Detect and fix **protein backbone** issues (missing fragments, and atoms, capping)
- Detect and fix **missing side-chain atoms**
- **Add hydrogen atoms** according to several criteria
- Detect and classify **atomic clashes**
- Detect possible **disulfide bonds (SS)**

An implementation of this workflow in a **web-based Graphical User Interface (GUI)** can be found in the [https://mmb.irbbarcelona.org/biobb-wfs/](https://mmb.irbbarcelona.org/biobb-wfs/) server (see [https://mmb.irbbarcelona.org/biobb-wfs/help/create/structure#check](https://mmb.irbbarcelona.org/biobb-wfs/help/create/structure#check)).

***

## Copyright & Licensing
This software has been developed in the [MMB group](http://mmb.irbbarcelona.org) at the [BSC](http://www.bsc.es/) & [IRB](https://www.irbbarcelona.org/) for the [European BioExcel](http://bioexcel.eu/), funded by the European Commission (EU H2020 [823830](http://cordis.europa.eu/projects/823830), EU H2020 [675728](http://cordis.europa.eu/projects/675728)).

* (c) 2015-2023 [Barcelona Supercomputing Center](https://www.bsc.es/)
* (c) 2015-2023 [Institute for Research in Biomedicine](https://www.irbbarcelona.org/)

Licensed under the
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0), see the file LICENSE for details.

![](https://bioexcel.eu/wp-content/uploads/2019/04/Bioexcell_logo_1080px_transp.png "Bioexcel")

# Galaxy GMX Automatic Ligand Parameterization tutorial CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://mmb.irbbarcelona.org/biobb/
- **Package**: https://workflowhub.eu/workflows/294
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/294/ro_crate?version=3
- **Conda**: N/A
- **Total Downloads**: 2.1K
- **Last updated**: 2023-05-03
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 3
- **License**: Apache-2.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `biobb_wf_ligand_parameterization.ga` (Main Workflow)
- **Project**: BioBB Building Blocks
- **Views**: 8985
- **Creators**: Adam Hospital, Genís Bayarri
- **Discussion / source**: https://mmb.irbbarcelona.org/biobb/workflows
- **Discussion / source**: https://biobb.usegalaxy.es/u/gbayarri/w/gmx-ligand-parameterization
- **Discussion / source**: https://biobb-wf-ligand-parameterization.readthedocs.io/en/latest/tutorial.html

## Description

# Automatic Ligand parameterization tutorial using BioExcel Building Blocks (biobb)

***
## This workflow must be run in **biobb.usegalaxy.es**. Please, [click here to access](https://biobb.usegalaxy.es/u/gbayarri/w/gmx-ligand-parameterization).
***

This tutorial aims to illustrate the process of **ligand parameterization** for a **small molecule**, step by step, using the **BioExcel Building Blocks library (biobb)**. The particular example used is the **Sulfasalazine** protein (3-letter code SAS), used to treat rheumatoid arthritis, ulcerative colitis, and Crohn's disease.

**OpenBabel and ACPype** packages are used to **add hydrogens, energetically minimize the structure**, and **generate parameters** for the **GROMACS** package. With *Generalized Amber Force Field (GAFF) forcefield and AM1-BCC* charges.

***

## Copyright & Licensing
This software has been developed in the [MMB group](http://mmb.irbbarcelona.org) at the [BSC](http://www.bsc.es/) & [IRB](https://www.irbbarcelona.org/) for the [European BioExcel](http://bioexcel.eu/), funded by the European Commission (EU H2020 [823830](http://cordis.europa.eu/projects/823830), EU H2020 [675728](http://cordis.europa.eu/projects/675728)).

* (c) 2015-2023 [Barcelona Supercomputing Center](https://www.bsc.es/)
* (c) 2015-2023 [Institute for Research in Biomedicine](https://www.irbbarcelona.org/)

Licensed under the
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0), see the file LICENSE for details.

![](https://bioexcel.eu/wp-content/uploads/2019/04/Bioexcell_logo_1080px_transp.png "Bioexcel")

# Galaxy Protein conformational ensembles generation CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://mmb.irbbarcelona.org/biobb/
- **Package**: https://workflowhub.eu/workflows/490
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/490/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 1.3K
- **Last updated**: 2023-06-01
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: other-open
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `biobb_wf_flexdyn.ga` (Main Workflow)
- **Project**: BioBB Building Blocks
- **Views**: 7430
- **Creators**: Adam Hospital, Genís Bayarri
- **Discussion / source**: https://mmb.irbbarcelona.org/biobb/workflows
- **Discussion / source**: https://biobb.usegalaxy.es/u/gbayarri/w/protein-conformational-ensembles-generation
- **Discussion / source**: https://biobb-wf-flexdyn.readthedocs.io/en/latest/tutorial.html

## Description

# Protein Conformational ensembles generation

## Workflow included in the [ELIXIR 3D-Bioinfo](https://elixir-europe.org/communities/3d-bioinfo) Implementation Study:

### Building on PDBe-KB to chart and characterize the conformation landscape of native proteins

This tutorial aims to illustrate the process of generating **protein conformational ensembles** from** 3D structures **and analysing its **molecular flexibility**, step by step, using the **BioExcel Building Blocks library (biobb)**.

## Conformational landscape of native proteins
**Proteins** are **dynamic** systems that adopt multiple **conformational states**, a property essential for many **biological processes** (e.g. binding other proteins, nucleic acids, small molecule ligands, or switching between functionaly active and inactive states). Characterizing the different **conformational states** of proteins and the transitions between them is therefore critical for gaining insight into their **biological function** and can help explain the effects of genetic variants in **health** and **disease** and the action of drugs.

**Structural biology** has become increasingly efficient in sampling the different **conformational states** of proteins. The **PDB** has currently archived more than **170,000 individual structures**, but over two thirds of these structures represent **multiple conformations** of the same or related protein, observed in different crystal forms, when interacting with other proteins or other macromolecules, or upon binding small molecule ligands. Charting this conformational diversity across the PDB can therefore be employed to build a useful approximation of the **conformational landscape** of native proteins.

A number of resources and **tools** describing and characterizing various often complementary aspects of protein **conformational diversity** in known structures have been developed, notably by groups in Europe. These tools include algorithms with varying degree of sophistication, for aligning the 3D structures of individual protein chains or domains, of protein assemblies, and evaluating their degree of **structural similarity**. Using such tools one can **align structures pairwise**, compute the corresponding **similarity matrix**, and identify ensembles of **structures/conformations** with a defined **similarity level** that tend to recur in different PDB entries, an operation typically performed using **clustering** methods. Such workflows are at the basis of resources such as **CATH, Contemplate, or PDBflex** that offer access to **conformational ensembles** comprised of similar **conformations** clustered according to various criteria. Other types of tools focus on differences between **protein conformations**, identifying regions of proteins that undergo large **collective displacements** in different PDB entries, those that act as **hinges or linkers**, or regions that are inherently **flexible**.

To build a meaningful approximation of the **conformational landscape** of native proteins, the **conformational ensembles** (and the differences between them), identified on the basis of **structural similarity/dissimilarity** measures alone, need to be **biophysically characterized**. This may be approached at **two different levels**. 
- At the **biological level**, it is important to link observed **conformational ensembles**, to their **functional roles** by evaluating the correspondence with **protein family classifications** based on sequence information and **functional annotations** in public databases e.g. Uniprot, PDKe-Knowledge Base (KB). These links should provide valuable mechanistic insights into how the **conformational and dynamic properties** of proteins are exploited by evolution to regulate their **biological function**. <br><br>

- At the **physical level** one needs to introduce **energetic consideration** to evaluate the likelihood that the identified **conformational ensembles** represent **conformational states** that the protein (or domain under study) samples in isolation. Such evaluation is notoriously **challenging** and can only be roughly approximated by using **computational methods** to evaluate the extent to which the observed **conformational ensembles** can be reproduced by algorithms that simulate the **dynamic behavior** of protein systems. These algorithms include the computationally expensive **classical molecular dynamics (MD) simulations** to sample local thermal fluctuations but also faster more approximate methods such as **Elastic Network Models** and **Normal Node Analysis** (NMA) to model low energy **collective motions**. Alternatively, **enhanced sampling molecular dynamics** can be used to model complex types of **conformational changes** but at a very high computational cost. 

The **ELIXIR 3D-Bioinfo Implementation Study** *Building on PDBe-KB to chart and characterize the conformation landscape of native proteins* focuses on:

1. Mapping the **conformational diversity** of proteins and their homologs across the PDB. 
2. Characterize the different **flexibility properties** of protein regions, and link this information to sequence and functional annotation.
3. Benchmark **computational methods** that can predict a biophysical description of protein motions.

This notebook is part of the third objective, where a list of **computational resources** that are able to predict **protein flexibility** and **conformational ensembles** have been collected, evaluated, and integrated in reproducible and interoperable workflows using the **BioExcel Building Blocks library**. Note that the list is not meant to be exhaustive, it is built following the expertise of the implementation study partners.

***

## Copyright & Licensing
This software has been developed in the [MMB group](http://mmb.irbbarcelona.org) at the [BSC](http://www.bsc.es/) & [IRB](https://www.irbbarcelona.org/) for the [European BioExcel](http://bioexcel.eu/), funded by the European Commission (EU H2020 [823830](http://cordis.europa.eu/projects/823830), EU H2020 [675728](http://cordis.europa.eu/projects/675728)).

* (c) 2015-2023 [Barcelona Supercomputing Center](https://www.bsc.es/)
* (c) 2015-2023 [Institute for Research in Biomedicine](https://www.irbbarcelona.org/)

Licensed under the
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0), see the file LICENSE for details.

![](https://bioexcel.eu/wp-content/uploads/2019/04/Bioexcell_logo_1080px_transp.png "Bioexcel")

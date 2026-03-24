## CWL workflows used in UNLOCK

*This repository is under active development*

Our workflows are written in such a way that they depend on available docker images. Therefor execution of our workflows do not need a lot dependencies even though there are many different tools used but rely (heavily) on docker and publically available images. We either use already available community images or we create and host them ourself when needed.

**Requirements:**

- Docker
- A cwl-runner (we use [cwltool](https://github.com/common-workflow-language/cwltool/))

**Installation and usage**

Short introduction on how setup and use these workflows:<br>
[https://docs.m-unlock.nl/docs/workflows/setup.html](https://docs.m-unlock.nl/docs/workflows/setup.html)
<br>

These workflows are also published on the WorkflowHub: [https://workflowhub.eu/projects/16#workflows](https://workflowhub.eu/projects/16#workflows). On here you can see in more detail the in- and outputs and the steps involved.

Some are summarized here.

#### Workflow Metagenomics Assembly

[Workflowhub link](https://workflowhub.eu/workflows/367)

Workflow for assembly from Illumina reads and/or longreads. Customizable to a certain extend on which steps to run. (can also be used for isolates)<br>
Main steps involved:

- [Workflow Illumina Quality](#Workflow-Illumina-Quality)
- [Workflow Longread Quality](#Workflow-Longread-Quality)
- Assembly: SPAdes / Flye
- Short read polishing (pypolca) (optional)
- ONT read polishing (Medaka) (optional)
- QUAST (Assembly quality report)
- [Workflow Metagenomics Binning] (Workflow-Metagenomics-Binning) (optional)

#### Workflow Metagenomics Binning

[Workflowhub link](https://workflowhub.eu/workflows/64)

- Metabat2 / MaxBin2 / SemiBin binning (minimum MetaBat2)
- EukRep (eukaryotic classification)
- Binette bin refinement
- CheckM2 bin quality
- BUSCO bin quality (optional)
- GTDB-Tk bin taxonomic classification (optional)

#### Workflow Illumina Quality

[Workflowhub link](https://workflowhub.eu/workflows/336)

- Quality plots. With Sequali (before and after filtering)
- Quality filtering
- Human contamination filtering with . (optional)
- Custom reference filtering, output mapped or unmapped reads. (optional)
- PhiX removal (BBduk)
- rRNA removal (BBduk) (optional)

#### Workflow Longread Quality

[Workflowhub link](https://workflowhub.eu/workflows/337)

- NanoPlot Quality plot and reports (before and after filtering)
- Fastplong Longreads quality filtering
- Hostile, Human contamination filtering with . (optional)
- Hostile, Custom reference filtering, output mapped or unmapped reads. (optional)

#### Workflow Longread 16S

- [Workflow Longread Quality](#Workflow-Longread-Quality) (optional)
- Emu: species-level taxonomic abundance for full-length 16S reads

#### Workflow HUMAnN3 (HMP Unified Metabolic Analysis Network)

- [Workflow Illumina Quality](#Workflow-Illumina-Quality) (optional)
- MetaPhlan4 read classification
- HUMAnN3
- HUMAnN utility for regrouping table features
- HUMAnN utility for renormalizing
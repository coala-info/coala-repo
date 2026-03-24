# (Hybrid) Metagenomics workflow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://m-unlock.com
- **Package**: https://workflowhub.eu/workflows/367
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/367/ro_crate?version=3
- **Source repository (git):** https://gitlab.com/m-unlock/cwl
- **Conda**: N/A
- **Total Downloads**: 1.3K
- **Last updated**: 2026-01-23
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 3
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `workflows/workflow_metagenomics_assembly.cwl` (Main Workflow)
- **Project**: UNLOCK
- **Views**: 7671
- **Creators**: Bart Nijsse, Jasper Koehorst, Changlin Ke
- **Discussion / source**: https://gitlab.com/m-unlock/cwl/-/issues

## Description

**Workflow (hybrid) metagenomic assembly and binning**<br>
  - Workflow Illumina Quality: 
    - Sequali (control)
    - hostile contamination filter
    - fastp (quality trimming)
  - Workflow Longread Quality:	
    - NanoPlot (control)
    - fastplong (quality trimming)
    - hostile contamination filter
  - Kraken2 taxonomic classification of FASTQ reads
  - SPAdes/Flye (Assembly)
  - Medaka/PyPolCA (Assembly polishing)
  - QUAST (Assembly quality report)

  (optional)
  - Workflow binnning
    - Metabat2/MaxBin2/SemiBin
    - Binette
    - BUSCO
    - GTDB-Tk

  (optional)
  - Workflow Genome-scale metabolic models https://workflowhub.eu/workflows/372
    - CarveMe (GEM generation)
    - MEMOTE (GEM test suite)
    - SMETANA (Species METabolic interaction ANAlysis)

Other UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br><br>

**All tool CWL files and other workflows can be found here:**<br>
  https://gitlab.com/m-unlock/cwl/ <br>

**How to setup and use an UNLOCK workflow:**<br>
https://docs.m-unlock.nl/docs/workflows/setup.html<br>

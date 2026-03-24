# Nanopore Assembly Workflow - Deprecated - CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://m-unlock.com
- **Package**: https://workflowhub.eu/workflows/254
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/254/ro_crate?version=3
- **Source repository (git):** https://git.wur.nl/unlock/cwl
- **Conda**: N/A
- **Total Downloads**: 2.1K
- **Last updated**: 2023-02-02
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 3
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `cwl/workflows/workflow_nanopore_assembly.cwl` (Main Workflow)
- **Project**: UNLOCK
- **Views**: 8203
- **Creators**: Bart Nijsse, Jasper Koehorst, Germán Royval
- **Discussion / source**: https://gitlab.com/m-unlock/cwl/-/issues

## Description

#### - Deprecated -
#### See our updated hybrid assembly workflow: https://workflowhub.eu/workflows/367
#### And other workflows: https://workflowhub.eu/projects/16#workflows
# 
**Workflow for sequencing with ONT Nanopore data, from basecalled reads to (meta)assembly and binning**
- Workflow Nanopore Quality
- Kraken2 taxonomic classification of FASTQ reads
- Flye (de-novo assembly)
- Medaka (assembly polishing)
- metaQUAST (assembly quality reports)

**When Illumina reads are provided:** 
  - Workflow Illumina Quality: https://workflowhub.eu/workflows/336?version=1	
  - Assembly polishing with Pilon<br>
  - Workflow binnning https://workflowhub.eu/workflows/64?version=11
      - Metabat2
      - CheckM
      - BUSCO
      - GTDB-Tk

**All tool CWL files and other workflows can be found here:**<br>
  Tools: https://git.wur.nl/unlock/cwl/-/tree/master/cwl<br>
  Workflows: https://git.wur.nl/unlock/cwl/-/tree/master/cwl/workflows<br>

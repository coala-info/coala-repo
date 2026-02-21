---
name: evigene
description: EvidentialGene (evigene) is a specialized genome informatics suite used to produce "Evidence Directed" gene sets.
homepage: http://arthropods.eugenes.org/EvidentialGene/
---

# evigene

## Overview
EvidentialGene (evigene) is a specialized genome informatics suite used to produce "Evidence Directed" gene sets. It is most commonly employed to process transcript assemblies from multiple sources (like Trinity, SOAPdenovo-Trans, or Velvet) to filter out redundancies, fragments, and artifacts, leaving behind the most biologically plausible gene models. It is a standard tool for researchers working on non-model organisms to create high-confidence protein and mRNA sets.

## Usage Guidelines

### Environment Setup
Evigene scripts are typically organized within a nested directory structure. When installed via Bioconda, you may need to locate the installation directory to call scripts directly.
- Define the home directory: `export EVIGENEHOME=/path/to/conda/envs/your_env/opt/evigene`
- Scripts are categorized by function (e.g., `prot/`, `rnaseq/`).

### Core Workflow: tr2aacds.pl
The `tr2aacds.pl` (Transcript to Amino Acid and Coding DNA Sequence) script is the primary pipeline for mRNA assembly reduction.

**Basic Command Pattern:**
```bash
$EVIGENEHOME/scripts/prot/tr2aacds.pl -mrna transcripts.fasta -NCPU 8 -MAXMEM 16000
```

**Key Parameters:**
- `-mrna`: The input FASTA file containing your pooled transcript assemblies.
- `-NCPU`: Number of processors to use for BLAST and other compute-intensive steps.
- `-MAXMEM`: Maximum memory in megabytes.
- `-nodeset`: Used if running on a cluster environment.

### Output Interpretation
Evigene produces several files categorized by quality:
- `*.okay.aa / *.okay.cds`: The high-quality, non-redundant set of proteins and coding sequences.
- `*.okalt.aa / *.okalt.cds`: Alternative transcripts or isoforms that are also high quality.
- `*.drop`: Sequences identified as redundant, fragments, or low quality.

### Expert Tips
- **Input Pooling**: For best results, combine assemblies from multiple different assemblers (e.g., Trinity + Velvet + rnaSPAdes) into a single input file. Evigene excels at picking the "best" version of a gene from diverse sources.
- **Naming Conventions**: Ensure your input FASTA headers are simple and unique. Avoid complex special characters that might break Perl string parsing.
- **CD-HIT Dependency**: Evigene relies heavily on CD-HIT for initial clustering. Ensure `cd-hit` is in your PATH.
- **Protein Evidence**: If you have high-quality protein evidence from related species, use the `prot2genome` workflows within the suite to improve gene model selection.

## Reference documentation
- [Evigene Overview](./references/anaconda_org_channels_bioconda_packages_evigene_overview.md)
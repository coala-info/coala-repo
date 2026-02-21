---
name: lightstringgraph
description: LightStringGraph (LSG) is a specialized toolset designed for large-scale genome assembly tasks where memory efficiency is critical.
homepage: http://lsg.algolab.eu
---

# lightstringgraph

## Overview
LightStringGraph (LSG) is a specialized toolset designed for large-scale genome assembly tasks where memory efficiency is critical. It utilizes external memory structures to build string graphs from high-throughput sequencing data. The workflow typically involves preparing reverse-complemented reads, generating a Burrows-Wheeler Transform (BWT) via BEETL, and then executing the LSG pipeline to produce a reduced string graph suitable for downstream assembly.

## Workflow and CLI Usage

### 1. Data Preparation
LSG requires a FASTA file containing both forward reads and their reverse complements.
- Given `input.fa` with $n$ reads, create `combined.fa` with $2n$ reads.
- Reads $n+1$ to $2n$ must be the reverse complement of reads $1$ to $n$.

### 2. BWT Generation
Before running LSG, you must generate the BWT using the BEETL library.
```bash
beetl-bwt -i combined.fa -o <BWTPrefix> --output-format=ASCII --generate-lcp --generate-end-pos-file
```

### 3. Constructing the Overlap Graph (lsg)
The `lsg` tool identifies overlaps between reads.
```bash
lsg -B <BWTPrefix> -T <Tau> -C <CycNum>
```
- `-B`: The prefix used during BWT generation.
- `-T`: Minimum overlap length (Tau).
- `-C`: Number of cycles. Usually set to `(read_length - Tau)`.

### 4. Transitive Reduction (redbuild)
The `redbuild` tool performs transitive reduction to simplify the graph into a string graph.
```bash
redbuild -b <BWTPrefix> -r combined.fa -m <CycNum+1>
```
- `-m`: Should be set to the value of `<CycNum>` used in the previous step plus one.

### 5. Format Conversion (graph2asqg)
To export the graph for use in other assemblers, convert it to the Assembly String Graph (ASQG) format.
```bash
graph2asqg -b <BWTPrefix> -r combined.fa -l <readLength> > output.asqg
```

## Expert Tips and Troubleshooting
- **File Descriptor Limits**: `lsg` opens many temporary files. If the tool crashes with a logic error, increase the system limit using `ulimit -n 2048` (or higher).
- **Cleanup**: If a run fails, manually delete all `*.tmplsg.*` files in the working directory before restarting to prevent data corruption.
- **Memory Management**: LSG is designed for external memory; ensure the disk partition used for temporary files has sufficient space for the BWT and intermediate graph structures.

## Reference documentation
- [LightStringGraph Overview](./references/lsg_algolab_eu_index.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_lightstringgraph_overview.md)
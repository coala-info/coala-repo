---
name: vadr
description: VADR (Viral Annotation DefineR) is a specialized suite of tools designed for the high-throughput classification and annotation of viral sequences.
homepage: https://github.com/ncbi/vadr
---

# vadr

## Overview
VADR (Viral Annotation DefineR) is a specialized suite of tools designed for the high-throughput classification and annotation of viral sequences. It works by comparing query sequences against a library of curated reference models (covariance models and hidden Markov models). VADR is the primary tool used by GenBank staff to evaluate incoming submissions for several major human pathogens. It not only provides feature annotation (like CDS coordinates) but also generates "alerts" for sequences that diverge from expected biological patterns, helping researchers identify potential sequencing errors or significant evolutionary changes.

## Core Workflows

### 1. Pre-processing: Trimming Ambiguous Nucleotides
Before running annotation, it is critical to trim terminal ambiguous nucleotides (Ns) to ensure consistency with GenBank's internal pipeline.
```bash
$VADRSCRIPTSDIR/miniscripts/fasta-trim-terminal-ambigs.pl --minlen 50 --maxlen 30000 input.fa > trimmed.fa
```
*Note: Adjust `--minlen` and `--maxlen` based on the specific virus (e.g., 210,000 for Mpox).*

### 2. General Annotation with v-annotate.pl
The primary tool for detailed annotation. It requires an input FASTA and an output directory.
```bash
v-annotate.pl --split --cpu 8 -s -r --nomisc --mdir /path/to/models trimmed.fa output_dir
```
*   `--split`: Splits the input file into chunks for parallel processing.
*   `--cpu <n>`: Sets the number of parallel threads.
*   `-s`: Fixes the alignment to the model (suggested for most viral runs).
*   `-r`: Replaces stretches of Ns with expected nucleotides where possible.

### 3. Virus-Specific CLI Patterns
Different viruses require specific flags to account for their unique genomic structures and GenBank requirements.

#### SARS-CoV-2
```bash
v-annotate.pl --split --cpu 8 --glsearch -s -r --nomisc --mkey sarscov2 \
  --lowsim5seq 6 --lowsim3seq 6 \
  --alt_fail lowscore,insertnn,deletinn \
  --mdir /path/to/sarscov2-models trimmed.fa output_dir
```

#### Influenza (Flu)
```bash
v-annotate.pl --split --cpu 8 -r --atgonly --xnocomp --nomisc \
  --alt_fail extrant5,extrant3 --mkey flu \
  --mdir /path/to/flu-models trimmed.fa output_dir
```
*   `--atgonly`: Only considers ATG as a valid start codon.

#### Mpox Virus (MPXV)
```bash
v-annotate.pl --split --cpu 4 --glsearch --minimap2 -s -r --nomisc --mkey mpxv \
  --r_lowsimok --r_lowsimxd 100 --r_lowsimxl 2000 \
  --alt_pass discontn,dupregin --s_overhang 150 \
  --mdir /path/to/mpxv-models trimmed.fa output_dir
```
*   `--minimap2`: Uses minimap2 for initial alignment, which is faster for long genomes like Mpox.

#### Respiratory Syncytial Virus (RSV)
```bash
v-annotate.pl --split --cpu 4 -r --mkey rsv --xnocomp \
  --mdir /path/to/rsv-models trimmed.fa output_dir
```
*   **Memory Warning**: RSV annotation is memory-intensive. Running with `--cpu 4` may require up to 128GB of RAM.

## Expert Tips and Best Practices
*   **Model Selection**: Use `--mkey` to specify the library (e.g., `flavi`, `calici`, `sarscov2`). If your models are not in the default `$VADRMODELDIR`, you must provide the path via `--mdir`.
*   **Handling Alerts**: VADR generates `.alt` files. A sequence "passes" if it has zero fatal alerts.
*   **Misc_features**: By default, if a CDS has a non-fatal error (like a frameshift in a non-essential SARS-CoV-2 ORF), VADR may annotate it as a `misc_feature` instead of a `CDS`. Use `--nomisc` if you want to prevent this behavior and keep the original feature type even if it fails.
*   **Performance**: Always use `--split` when using `--cpu` to ensure the workload is actually distributed across cores.
*   **Validation**: Use `v-test.pl` after installation to ensure the environment variables and dependencies (Infernal, BLAST, HMMER) are correctly configured.

## Reference documentation
- [VADR GitHub README](./references/github_com_NLM-DIR_vadr.md)
- [SARS-CoV-2 Annotation Guide](./references/github_com_NLM-DIR_vadr_wiki_Coronavirus-annotation.md)
- [Mpox Virus Annotation Guide](./references/github_com_NLM-DIR_vadr_wiki_Mpox-virus-annotation.md)
- [Influenza Annotation Guide](./references/github_com_NLM-DIR_vadr_wiki_influenza-annotation.md)
- [RSV Annotation Guide](./references/github_com_NLM-DIR_vadr_wiki_RSV-annotation.md)
- [Available VADR Model Files](./references/github_com_NLM-DIR_vadr_wiki_Available-VADR-model-files.md)
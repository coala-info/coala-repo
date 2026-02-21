---
name: clermontyping
description: The clermontyping skill enables the automated classification of Escherichia strains by simulating the Clermont quadriplex PCR method in silico.
homepage: https://github.com/happykhan/ClermonTyping
---

# clermontyping

## Overview
The clermontyping skill enables the automated classification of Escherichia strains by simulating the Clermont quadriplex PCR method in silico. This tool is essential for epidemiological research and strain characterization, providing a high-concordance alternative to traditional laboratory PCR assays. It processes genomic assemblies or contigs to detect specific marker genes (arpA, chuA, yjaA, and TspE4.C2) and uses these profiles to assign phylogroups or species identities.

## Installation
The tool is most easily managed via Conda:
```bash
conda install bioconda::clermontyping
```

## Core CLI Usage

### Standard Analysis
To analyze a single FASTA file containing contigs or a complete genome:
```bash
clermonTyping.sh --fasta path/to/genome.fasta --name my_analysis
```

### Batch Processing
ClermonTyping uses a unique `@` separator for multiple input files. Note that absolute paths are recommended for batch strings:
```bash
clermonTyping.sh --fasta /data/strain1.fasta@/data/strain2.fasta@/data/strain3.fasta
```

### Filtering by Contig Size
To improve accuracy and reduce noise from small fragments, use the threshold option to ignore contigs below a specific base pair length:
```bash
clermonTyping.sh --fasta genome.fasta --threshold 500
```

## Advanced Manual Workflow
If you need to run the pipeline components independently (e.g., to customize BLAST parameters), follow this sequence:

1. **Create BLAST Database**:
   ```bash
   makeblastdb -in genome.fasta -input_type fasta -out genome_db -dbtype nucl
   ```

2. **Run BLASTn**:
   The Python parser requires XML output format (`-outfmt 5`). Use the `primers.fasta` file located in the tool's data directory.
   ```bash
   blastn -query ./data/primers.fasta -db genome_db -perc_identity 90 -task blastn -outfmt 5 -out results.xml
   ```

3. **Parse Results**:
   Use the internal Python script to determine the phylotype from the XML:
   ```bash
   clermont.py -x results.xml --mismatch 2 --length 5
   ```

## Output Interpretation
The tool generates a results folder (default: `analysis_date`) containing:
- **analysis.html**: A visual report showing the presence/absence (+/-) of the quadriplex genes and the final phylogroup assignment.
- **analysis_phylogroups.txt**: A TSV file suitable for downstream automated processing.
- **strain_mash_screen.tab**: Informative Mash-based prediction (used for comparison, not primary assignment).

## Expert Tips
- **Ambiguity Handling**: If the "supp" column in the output is populated, it indicates the tool performed additional allele checks to resolve ambiguities between closely related groups like C and E.
- **Input Formatting**: Ensure FASTA headers do not contain special characters that might interfere with shell processing, especially when using the `@` batching syntax.
- **BLAST Sensitivity**: If a strain fails to type but is known to be E. coli, consider manually running the BLAST step with a lower `--perc_identity` or adjusting the `--mismatch` parameter in the Python script.

## Reference documentation
- [ClermonTyping Overview](./references/anaconda_org_channels_bioconda_packages_clermontyping_overview.md)
- [ClermonTyping GitHub Documentation](./references/github_com_happykhan_ClermonTyping.md)
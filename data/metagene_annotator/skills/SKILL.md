---
name: metagene_annotator
description: The metagene_annotator skill enables the identification of open reading frames (ORFs) and gene structures in diverse prokaryotic sequences.
homepage: http://metagene.cb.k.u-tokyo.ac.jp/
---

# metagene_annotator

## Overview
The metagene_annotator skill enables the identification of open reading frames (ORFs) and gene structures in diverse prokaryotic sequences. It is particularly effective for metagenomic datasets where the source organism is unknown, as it uses a set of pre-trained models to predict genes based on codon usage and ribosomal binding site patterns.

## Usage Patterns

### Basic Gene Prediction
To run a standard gene prediction on a FASTA file:
```bash
mga [input_file.fasta] > [output_file.mga]
```

### Specifying Sequence Type
While the tool often auto-detects, you can force specific models for better accuracy:
- **Metagenomic/Short Reads**: Default mode, handles fragmented sequences.
- **Single Genome**: Optimized for complete or near-complete bacterial genomes.
- **Phage**: Optimized for viral/phage genetic architectures.

### Output Interpretation
The standard output provides a tab-delimited format containing:
1. **Gene ID**: Sequential identifier.
2. **Location**: Start and end coordinates.
3. **Strand**: Direction of the gene (+/-).
4. **Frame**: Reading frame (0, 1, or 2).
5. **Score**: Confidence metric for the prediction.
6. **Model**: The specific model used for that prediction (e.g., b for bacteria, p for phage).

## Best Practices
- **Input Formatting**: Ensure FASTA headers are concise; long headers can sometimes cause truncation in downstream parsing of MGA outputs.
- **Sequence Length**: For very short reads (<100bp), gene prediction sensitivity decreases significantly. It is most effective on contigs or reads longer than 200bp.
- **Post-Processing**: The output is a custom format. To use this with standard bioinformatics tools, you may need to convert the `.mga` output to GFF3 or BED format using awk or custom scripts.

## Reference documentation
- [MetaGeneAnnotator Overview](./references/anaconda_org_channels_bioconda_packages_metagene_annotator_overview.md)
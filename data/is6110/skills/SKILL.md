---
name: is6110
description: The `is6110` tool is a lightweight bioinformatics utility designed to detect the presence and location of insertion sequences—specifically IS6110—within *Mycobacterium tuberculosis* genomes.
homepage: https://github.com/jodyphelan/is6110
---

# is6110

## Overview
The `is6110` tool is a lightweight bioinformatics utility designed to detect the presence and location of insertion sequences—specifically IS6110—within *Mycobacterium tuberculosis* genomes. It operates directly on BAM alignment files, eliminating the need for read realignment. By identifying these mobile genetic elements, the tool helps researchers understand evolutionary adaptations and drug resistance mechanisms (such as disruptions in the *mmpR5* gene). The tool outputs results in standard VCF format, which can be optionally annotated with gene disruption information if a GFF file is provided.

## Installation
Install the tool via Bioconda:
```bash
conda install bioconda::is6110
```

## Command Line Usage

### Basic Execution
To scan the entire genome for IS6110 insertions:
```bash
is6110 -b input.bam -o output.vcf -r reference.fasta -g genes.gff
```

### Targeted Analysis
If you are only interested in specific genomic regions (e.g., known drug resistance loci), you can limit the search to save time:

**Single Region:**
```bash
is6110 -b input.bam -o output.vcf -r reference.fasta -g genes.gff -r Chromosome:778385-779715
```

**Multiple Regions (BED file):**
```bash
is6110 -b input.bam -o output.vcf -r reference.fasta -g genes.gff -T regions.bed
```

## Best Practices and Expert Tips

### Annotation and Output
*   **Gene Disruption:** Always provide a GFF file (`-g`) to receive SnpEff-style annotations in the VCF. This is critical for determining if an insertion has caused a `transcript_ablation` or other high-impact mutations in genes like *thyA* or *mmpR5*.
*   **VCF Format:** The tool uses the `INS:ME:<IS_NAME>` alternate allele format. Ensure downstream tools are compatible with the VCF specification for mobile element insertions.

### Customization
*   **Other Insertion Sequences:** While named `is6110`, the tool can identify other insertion sequences. You can provide a custom FASTA file containing the sequence of the mobile element you wish to track.
*   **BAM Requirements:** The tool is designed to work with standard BAM files. Recent updates allow processing of BAM files even if they lack specific Read Group (`@RG`) information.

### Limitations
*   **No Deletions:** This tool currently only detects insertions. If your workflow requires characterization of IS deletions, consider using `ISMapper` instead.
*   **Development Status:** The tool is under active development; always verify high-impact calls manually using a genome browser like IGV to confirm clipped read support at the insertion site.

## Reference documentation
- [is6110 GitHub Repository](./references/github_com_jodyphelan_is6110.md)
- [is6110 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_is6110_overview.md)
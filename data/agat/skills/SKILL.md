---
name: agat
description: The provided text does not contain help information for the tool. It is an error log from a container runtime (Apptainer/Singularity) indicating a failure to build the image due to lack of disk space.
homepage: https://github.com/NBISweden/AGAT
---

# agat

## Overview

AGAT (Another Gff Analysis Toolkit) is a robust suite of tools designed to address the high variability and frequent errors found in genomic annotation files. While GFF3 and GTF have specifications, many tools produce "flavors" that are incompatible with downstream software. AGAT acts as a powerful intermediary that can check, fix, and pad missing information (like missing parent features or UTRs) to create standardized, sorted, and valid GFF3 files. It is particularly useful for bioinformaticians working with non-model organisms or diverse annotation sources where file consistency is a major hurdle.

## Common CLI Patterns

Most AGAT tools follow a consistent naming convention and parameter structure. Tools prefixed with `agat_convert_sp_` or `agat_sp_` utilize the "Super-Parser," which is the most robust way to handle non-standard files.

### Standardization and Fixing
To take a messy or incomplete GFF/GTF file and turn it into a standardized, sorted GFF3:
`agat_convert_sp_gxf2gxf.pl -gff input.gff -o output.gff3`

This command automatically:
- Adds missing parent features (e.g., creating a gene feature if only mRNA exists).
- Fixes non-unique IDs.
- Corrects feature locations and removes duplicates.

### Format Conversion
AGAT provides specific scripts for converting to common bioinformatics formats:
- **To GTF:** `agat_convert_sp_gff2gtf.pl --gff input.gff3 -o output.gtf`
- **To BED:** `agat_convert_sp_gff2bed.pl --gff input.gff3 -o output.bed`
- **To TSV:** `agat_sp_gff2tsv.pl --gff input.gff3 -o output.tsv`

### Sequence Extraction
Extract FASTA sequences (nucleotide or protein) based on GFF coordinates:
`agat_sp_extract_sequences.pl -gff input.gff3 -f genome.fasta -o output.fasta`
*Note: Use `--type` to specify if you want cds, exon, mRNA, etc.*

### Filtering and Refinement
- **Keep Longest Isoform:** Useful for simplifying annotations for comparative genomics.
  `agat_sp_keep_longest_isoform.pl -gff input.gff3 -o longest_isoforms.gff3`
- **Filter by ORF size:**
  `agat_sp_filter_by_ORF_size.pl -gff input.gff3 --size 300 -o filtered.gff3`

## Expert Tips

1. **Check Statistics First:** Before processing a new annotation, run `agat_sp_statistics.pl -gff input.gff` to get a high-level view of feature counts, lengths, and potential issues.
2. **The "Super-Parser" Advantage:** Always prefer scripts with the `_sp_` prefix. These are designed to be "robust to even the most despicable GTF/GFF files" and will handle coordinate sorting and attribute cleaning automatically.
3. **Missing Features:** If your annotation is missing introns or UTRs but has CDS and Exon info, AGAT can generate them using `agat_sp_add_introns.pl` or `agat_sp_manage_UTRs.pl`.
4. **ID Management:** If you have conflicting IDs or need to rename features according to a specific pattern, use `agat_sp_manage_IDs.pl`.
5. **Functional Annotation:** AGAT can merge functional information (like protein names or GO terms) into your GFF3 using `agat_sp_manage_functional_annotation.pl`.

## Reference documentation
- [AGAT Main Repository and Usage](./references/github_com_NBISweden_AGAT.md)
- [Bioconda AGAT Overview](./references/anaconda_org_channels_bioconda_packages_agat_overview.md)
---
name: ucsc-gff3togenepred
description: `gff3ToGenePred` is a specialized utility from the UCSC Genome Browser "kent" toolset designed to bridge the gap between the complex, attribute-rich GFF3 format and the simplified genePred format.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-gff3togenepred

## Overview
`gff3ToGenePred` is a specialized utility from the UCSC Genome Browser "kent" toolset designed to bridge the gap between the complex, attribute-rich GFF3 format and the simplified genePred format. While GFF3 uses a parent-child relationship (Gene > mRNA > Exon/CDS) to describe features, genePred flattens these into single-line records per transcript. This tool is essential for bioinformaticians preparing custom annotation tracks or converting Ensembl/NCBI annotations for use in UCSC-compatible pipelines.

## Command Line Usage

The basic syntax requires an input GFF3 file and a destination path for the genePred file:

```bash
gff3ToGenePred input.gff3 output.gp
```

### Common Options and Flags

*   **Attribute Mapping**: By default, the tool looks for specific tags to identify transcripts and genes. You can override these:
    *   `-rnaNameAttr=attr`: Use the specified attribute (e.g., `transcript_id` or `Name`) as the transcript name in the output.
    *   `-geneNameAttr=attr`: Use the specified attribute (e.g., `gene_id`) as the gene name.
*   **Error Handling**:
    *   `-warnAndSkipBad`: Instead of terminating on a malformed record or inconsistent hierarchy, the tool will issue a warning and continue processing.
*   **Refinement**:
    *   `-allowOneExon`: Permits the conversion of single-exon genes which might otherwise be filtered depending on the source.
    *   `-honorStopCodons`: Ensures that stop codons are handled according to the GFF3 specification during coordinate calculation.

## Expert Tips and Best Practices

*   **Input Sorting**: While `gff3ToGenePred` is robust, it performs best when the GFF3 file is "clean." If you encounter errors regarding missing parent features, ensure your GFF3 is sorted so that parents (genes) appear before children (mRNAs/exons).
*   **Validation**: Always follow conversion with `genePredCheck` (another UCSC utility) to ensure the resulting file is valid and that coordinates are consistent with the reference genome.
*   **Attribute Selection**: GFF3 files from different sources (NCBI vs. Ensembl vs. FlyBase) use different attribute keys for IDs. Always inspect the first few lines of your GFF3 to determine if you need to set `-rnaNameAttr`.
*   **Handling "Parent" Issues**: If the tool fails to find a parent for an exon, it is often due to the GFF3 using `ID` and `Parent` tags that don't match exactly in case or string value.

## Reference documentation
- [ucsc-gff3togenepred Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-gff3togenepred_overview.md)
- [UCSC Genome Browser Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Kent Source Utilities Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
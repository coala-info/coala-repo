---
name: ucsc-gtftogenepred
description: The ucsc-gtftogenepred tool converts GTF (Gene Transfer Format) files into the genePred format. Use when user asks to convert GTF files to genePred format, create extended genePred files, handle non-standard GTF files, or debug GTF conversion errors.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-gtftogenepred

## Overview
`gtfToGenePred` is a specialized utility from the UCSC Genome Browser "kent" toolset. It parses GTF files—standard formats for describing gene models—and transforms them into the genePred format, a table-based representation used for efficient genomic data handling. This conversion is often a prerequisite for downstream bioinformatics workflows, such as building custom annotation databases or converting gene models into BED format using `genePredToBed`.

## Common CLI Patterns

### Basic Conversion
The most straightforward usage converts a standard GTF file to a genePred file:
```bash
gtfToGenePred input.gtf output.gp
```

### Extended genePred Format
For most modern applications, especially when creating tracks for the UCSC Genome Browser, use the `-genePredExt` flag. This includes additional columns like gene name and frame information:
```bash
gtfToGenePred -genePredExt input.gtf output.gp
```

### Handling Non-Standard GTF Files
If the input GTF uses a different attribute name for the gene ID or transcript ID (common in some custom pipelines), you can specify them:
```bash
gtfToGenePred -geneIdAttr=gene_name -transcriptIdAttr=transcript_id input.gtf output.gp
```

### Error Reporting and Debugging
When working with large or potentially malformed GTF files, use these flags to identify issues:
- `-allErrors`: Report all parsing errors instead of stopping at the first one.
- `-infoOut=file.txt`: Write detailed information about the conversion process to a separate file.

## Expert Tips and Best Practices

- **Validation**: Always follow a conversion with `genePredCheck` to ensure the resulting file is valid and consistent with the reference genome.
- **Source Compatibility**: This tool is highly optimized for GENCODE and Ensembl GTF files. If using GTF files from other sources (like StringTie), ensure the `exon` and `CDS` features are correctly defined, as `gtfToGenePred` relies on these to build the gene model.
- **Binary Permissions**: If you have downloaded the binary directly from the UCSC server, ensure it is executable:
  ```bash
  chmod +x gtfToGenePred
  ```
- **Sorting**: While `gtfToGenePred` does not strictly require a sorted GTF, many downstream tools that use the resulting `.gp` file do. It is best practice to sort your GTF by chromosome and start position before conversion.
- **Missing Exons**: Use the `-ignoreGroupsWithoutExons` flag if your GTF contains entries that describe genes or transcripts without explicit exon features, which would otherwise trigger an error.

## Reference documentation
- [ucsc-gtftogenepred overview](./references/anaconda_org_channels_bioconda_packages_ucsc-gtftogenepred_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
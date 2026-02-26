---
name: ucsc-netsyntenic
description: ucsc-netsyntenic identifies and annotates syntenic regions within genome alignment nets. Use when user asks to identify syntenic regions in genome alignments, add synteny information to alignment nets, or annotate genome alignment nets.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-netsyntenic

## Overview
The `netSyntenic` utility is a specialized tool within the UCSC Kent toolset designed for the post-processing of genome alignment nets. After generating a net file (typically via `chainNet`), `netSyntenic` is used to scan the alignment blocks and identify those that maintain conserved order and orientation (synteny) between the target and query genomes. It annotates the net file so that subsequent filtering steps can prioritize alignments that are part of these larger, more reliable syntenic structures.

## Command Line Usage

The tool follows the standard UCSC Kent utility pattern of taking an input file and an output file as positional arguments.

### Basic Syntax
```bash
netSyntenic input.net output.net
```

### Integration in the Alignment Pipeline
`netSyntenic` is typically the second-to-last step in the chain-to-net pipeline. A standard workflow looks like this:

1.  **chainNet**: Create the initial net from chains.
2.  **netSyntenic**: Add synteny information to the net.
3.  **netFilter**: Filter the syntenic net based on score, size, or synteny status.

Example of a piped workflow:
```bash
chainNet target_query.chain target.chrom.sizes query.chrom.sizes stdout /dev/null \
| netSyntenic stdin target_query.syntenic.net
```

## Best Practices and Expert Tips

*   **Input Requirements**: Ensure your input `.net` file is properly formatted. The tool expects a standard UCSC net file, which is a hierarchical representation of alignments.
*   **Synteny Annotation**: The tool adds a `synteny` attribute to the net lines. This does not remove any data by itself; it merely labels the blocks. You must use `netFilter` with the `-syn` flag afterwards if you wish to extract only the syntenic regions.
*   **Handling Large Genomes**: For very large alignments, ensure you have sufficient disk space for the output, as the added synteny metadata slightly increases the file size.
*   **Permission Errors**: If running the binary directly after download from the UCSC repository, remember to set execution permissions: `chmod +x netSyntenic`.
*   **Database Connectivity**: Unlike some other UCSC tools, `netSyntenic` operates purely on flat files and does not require an `.hg.conf` file or a connection to the UCSC MySQL database.

## Reference documentation
- [Bioconda ucsc-netsyntenic Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-netsyntenic_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
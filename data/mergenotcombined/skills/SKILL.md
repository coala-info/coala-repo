---
name: mergenotcombined
description: mergenotcombined is a specialized C-based utility designed for processing paired-end sequencing data.
homepage: https://github.com/andvides/mergeNotCombined.git
---

# mergenotcombined

## Overview

mergenotcombined is a specialized C-based utility designed for processing paired-end sequencing data. Unlike traditional merging tools that attempt to align and collapse overlapping regions, this tool performs a "join" operation. It takes a forward read (R1), appends a user-defined joining string (typically a sequence of 'N's), and then appends the reverse complement of the reverse read (R2). This approach is essential for pipelines that require a single-sequence representation of a pair while maintaining the orientation and identity of both ends.

## Usage Instructions

The tool follows a simple positional argument structure.

### Basic Command Syntax
```bash
mergeNotCombined <forward_fastq> <reverse_fastq> <join_string>
```

### Example
To join two FASTQ files using a 10-base 'N' spacer:
```bash
mergeNotCombined sample_R1.fastq sample_R2.fastq 'NNNNNNNNNN'
```

### Functional Logic
1. **Forward Read (R1):** Taken as-is from the first file.
2. **Join String:** The literal string provided as the third argument is inserted between the reads.
3. **Reverse Read (R2):** The tool automatically generates the reverse complement of the sequence in the second file before appending it.

## Best Practices and Tips

- **Join String Selection:** Use a string of 'N' characters that is long enough to be easily identified or filtered by downstream tools, or use a specific sequence tag if required by your specific assay.
- **Quoting:** Always wrap the `join_string` in single or double quotes in the terminal to prevent shell interpretation issues, especially if using a long string of characters.
- **Input Validation:** Ensure that your R1 and R2 files are synchronized (contain the same number of reads in the same order). The tool processes reads sequentially and assumes the files are properly paired.
- **Installation:** The tool is available via Bioconda. If it is not in the environment, it can be installed using:
  ```bash
  conda install bioconda::mergenotcombined
  ```

## Reference documentation
- [Anaconda Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mergenotcombined_overview.md)
- [GitHub Repository Documentation](./references/github_com_andvides_mergeNotCombined.md)
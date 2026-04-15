---
name: hackgap
description: hackgap is a fast, JIT-compiled k-mer counter that supports gapped k-mers. Use when user asks to count k-mers, especially with gaps, in biological sequences.
homepage: https://gitlab.com/rahmannlab/hackgap
metadata:
  docker_image: "quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0"
---

# hackgap

hackgap/
├── SKILL.md
└── references/
    ├── anaconda_org_channels_bioconda_packages_hackgap_overview.md
    ├── gitlab_com_rahmannlab_hackgap.atom.md
    ├── gitlab_com_rahmannlab_hackgap.md
    ├── gitlab_com_rahmannlab_hackgap_-_blob_master_CHANGELOG.md
    ├── gitlab_com_rahmannlab_hackgap_-_blob_master_LICENSE.md
    ├── gitlab_com_rahmannlab_hackgap_-_blob_master_README.md
    ├── gitlab_com_rahmannlab_hackgap_-_branches.md
    ├── gitlab_com_rahmannlab_hackgap_-_commits_master.md
    └── gitlab_com_rahmannlab_hackgap_-_tags.md
---
name: hackgap
description: A fast, JIT-compiled k-mer counter that supports gapped k-mers. Use when needing to efficiently count k-mers, especially with gaps, in biological sequences.
---
## Overview
hackgap is a command-line tool designed for rapid k-mer counting, with a specific focus on its ability to handle gapped k-mers. It leverages Just-In-Time (JIT) compilation for performance, making it suitable for large-scale genomic or sequence analysis tasks where efficient k-mer enumeration is critical.

## Usage Instructions

hackgap is primarily used via its command-line interface. The core functionality revolves around counting k-mers from input sequences.

### Basic K-mer Counting

To count standard k-mers (without gaps) from a FASTA or FASTQ file:

```bash
hackgap count --k <kmer_length> <input_file.fasta>
```

Replace `<kmer_length>` with the desired k-mer size (e.g., 21, 31).

### Gapped K-mer Counting

hackgap's key feature is its support for gapped k-mers. This allows for counting k-mers where certain positions are ignored or "gapped." The `--gaps` option specifies the positions of these gaps.

**Example:** To count 5-mers with gaps at positions 1 and 3 (0-indexed):

```bash
hackgap count --k 5 --gaps 1,3 <input_file.fasta>
```

This would count sequences like `A-C-G` where the second and fourth characters are ignored.

### Input and Output

*   **Input:** hackgap accepts input from standard input or specified files. Supported formats typically include FASTA and FASTQ.
*   **Output:** By default, counts are printed to standard output. The output format is usually a list of k-mers and their corresponding counts.

### Expert Tips

*   **Performance:** For very large datasets, consider piping data directly to `hackgap` from `stdin` to avoid intermediate file I/O.
    ```bash
    cat large_genome.fasta | hackgap count --k 31 > kmer_counts.txt
    ```
*   **Gapped K-mer Design:** Carefully consider the placement of gaps (`--gaps`) based on the biological question. Gaps can help capture longer-range dependencies or account for variations.
*   **Parameter Tuning:** Experiment with different `--k` values to find the optimal k-mer length for your specific analysis. Shorter k-mers are more abundant but less specific; longer k-mers are less abundant but more specific.
*   **JIT Compilation:** The JIT compilation means the first run might be slightly slower as the code is optimized. Subsequent runs with similar parameters should be faster.



## Subcommands

| Command | Description |
|---------|-------------|
| hackgap | hackgap: error: argument COMMAND: invalid choice: 'COMMAND' (choose from count, countwith, pycount, info) |
| hackgap | hackgap: error: argument COMMAND: invalid choice: 'The' (choose from count, countwith, pycount, info) |
| hackgap | hackgap: error: argument COMMAND: invalid choice: 'counts' (choose from count, countwith, pycount, info) |
| hackgap | hackgap: error: argument COMMAND: invalid choice: 'or' (choose from count, countwith, pycount, info) |
| hackgap count | Count k-mers in specified files. |
| hackgap countwith | Count k-mers in files using an existing index. |
| hackgap pycount | Index and count k-mers in FASTQ files. |
| hackgap_info | Prints information about a hash table. |

## Reference documentation
- [hackgap Overview](./references/anaconda_org_channels_bioconda_packages_hackgap_overview.md)
- [hackgap GitLab Repository](./references/gitlab_com_rahmannlab_hackgap.md)
- [hackgap README](./references/gitlab_com_rahmannlab_hackgap_-_blob_master_README.md)
---
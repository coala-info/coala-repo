# qcatch CWL Generation Report

## qcatch

### Tool Description
QCatch: Command-line Interface

### Metadata
- **Docker Image**: quay.io/biocontainers/qcatch:0.2.10--pyhdfd78af_0
- **Homepage**: https://github.com/COMBINE-lab/QCatch
- **Package**: https://anaconda.org/channels/bioconda/packages/qcatch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/qcatch/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2026-02-22
- **GitHub**: https://github.com/COMBINE-lab/QCatch
- **Stars**: N/A
### Original Help Text
```text
usage: qcatch [-h] --input INPUT [--output OUTPUT] [--chemistry CHEMISTRY]
              [--save_filtered_h5ad] [--gene_id2name_file GENE_ID2NAME_FILE]
              [--valid_cell_list VALID_CELL_LIST]
              [--n_partitions N_PARTITIONS] [--remove_doublets]
              [--skip_umap_tsne] [--visualize_doublets]
              [--export_summary_table] [--verbose] [--version]

QCatch: Command-line Interface

options:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to either the .h5ad file itself or to the
                        directory containing the quantification output files.
  --output OUTPUT, -o OUTPUT
                        Path to the desired output directory (optional) . If
                        provided, QCatch will save all result files and the QC
                        report to this directory without modifying the
                        original input. If not provided, QCatch will overwrite
                        the original `.h5ad` file in place by appending new
                        columns on anndata.obs(if input is a `.h5ad`), or save
                        results in the input directory (if input is a folder
                        of quantification results).
  --chemistry CHEMISTRY, -c CHEMISTRY
                        Specifies the chemistry used in the experiment, which
                        determines the range for the empty_drops step.
                        Supported options: '10X_3p_v2', '10X_3p_v3',
                        '10X_3p_v4', '10X_5p_v3', '10X_3p_LT', '10X_HT'. If
                        you used a standard 10X chemistry (e.g., '10X_3p_v2',
                        '10X_3p_v3') and performed quantification with
                        `simpleaf`(v0.19.5 or later), QCatch can usually infer
                        the correct chemistry automatically from the metadata.
                        If inference fails, QCatch will stop and prompt you to
                        provide the chemistry explicitly via this flag.
  --save_filtered_h5ad, -s
                        If enabled, QCatch will save a separate `.h5ad` file
                        containing only the retained cells.
  --gene_id2name_file GENE_ID2NAME_FILE, -g GENE_ID2NAME_FILE
                        File provides a mapping from gene IDs to gene names.
                        The file must be a TSV containing two
                        columns—‘gene_id’ (e.g., ENSG00000284733) and
                        ‘gene_name’ (e.g., OR4F29)—without a header row. If
                        not provided, the program will attempt to retrieve the
                        mapping from a remote registry. If that lookup fails,
                        mitochondria plots will not be displayed.
  --valid_cell_list VALID_CELL_LIST, -l VALID_CELL_LIST
                        File provides a user-specified list of valid cell
                        barcode. The file must be a TSV containing one column
                        with cell barcodes without a header row. If provided,
                        qcatch will skip the internal cell calling steps and
                        and use the supplied list instead.
  --n_partitions N_PARTITIONS, -n N_PARTITIONS
                        Number of partitions (max number of barcodes to
                        consider for ambient estimation). Use `--n_partitions`
                        only when working with a custom or unsupported
                        chemistry. When provided, this value will override the
                        chemistry-based configuration during the cell-calling
                        step.
  --remove_doublets, -d
                        If enabled, QCatch will perform doublet detection(use
                        `Scrublet` tool) and remove detected doublets from the
                        cells retained after cell calling.
  --skip_umap_tsne, -u  If provided, skips generation of UMAP and t-SNE plots.
  --visualize_doublets, -vd
                        If set, generates additional UMAP and t-SNE plots that
                        include doublets (alongside the standard doublet-free
                        plots).
  --export_summary_table, -e
                        If enabled, QCatch will export the summary metrics as
                        a separate CSV file.
  --verbose, -b         Enable verbose logging with debug-level messages
  --version, -v         Display the installed version of qcatch.
```


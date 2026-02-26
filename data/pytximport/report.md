# pytximport CWL Generation Report

## pytximport

### Tool Description
Call the tximport function via the command line.

### Metadata
- **Docker Image**: quay.io/biocontainers/pytximport:0.12.0--pyhdfd78af_0
- **Homepage**: https://pytximport.readthedocs.io/en/latest/start.html
- **Package**: https://anaconda.org/channels/bioconda/packages/pytximport/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pytximport/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/complextissue/pytximport
- **Stars**: N/A
### Original Help Text
```text
Usage: pytximport run [OPTIONS]

  Call the tximport function via the command line.

Options:
  -i, --file_paths, --file-paths PATH
                                  The path to an quantification file. To
                                  provide multiple input files, use `-i
                                  input1.sf -i input2.sf ...`.  [required]
  -t, --data_type, --data-type [kallisto|salmon|sailfish|oarfish|piscem|stringtie|rsem|tsv]
                                  The type of quantification files.
                                  [required]
  -m, --transcript_gene_map, --transcript-gene-map PATH
                                  The path to the transcript to gene map.
                                  Either a tab-separated (.tsv) or comma-
                                  separated (.csv) file. Expected column names
                                  are `transcript_id` and `gene_id`.
  -c, --counts_from_abundance, --counts-from-abundance [scaled_tpm|length_scaled_tpm|dtu_scaled_tpm]
                                  The method to calculate the counts from the
                                  abundance. Leave empty to use counts. For
                                  differential gene expression analysis, we
                                  recommend using `length_scaled_tpm`. For
                                  differential transcript expression analysis,
                                  we recommend using `scaled_tpm`. For
                                  differential isoform usage analysis, we
                                  recommend using `dtu_scaled_tpm`.
  -o, --output_path, --save-path PATH
                                  The output path to save the resulting counts
                                  to.  [required]
  -of, --output_format, --output-format [csv|h5ad]
                                  The format of the output file.
  -ow, --output_path_overwrite, --save-path-overwrite
                                  Provide this flag to overwrite an existing
                                  file at the output path.
  --ignore_after_bar, --ignore-after-bar BOOLEAN
                                  Whether to split the transcript id after the
                                  bar character (`|`).
  --ignore_transcript_version, --ignore-transcript-version BOOLEAN
                                  Whether to ignore the transcript version.
  -gl, --gene_level, --gene-level
                                  Provide this flag when importing gene-level
                                  counts from RSEM files.
  -tx, --return_transcript_data, --return-transcript-data
                                  Provide this flag to return transcript-level
                                  instead of gene-summarized data.
                                  Incompatible with gene-level input and
                                  `counts_from_abundance=length_scaled_tpm`.
  -ir, --inferential_replicates, --inferential-replicates
                                  Provide this flag to make use of inferential
                                  replicates. Will use the median of the
                                  inferential replicates.
  -id, --id_column, --id-column TEXT
                                  The column name for the transcript id.
  -counts, --counts_column, --counts-column TEXT
                                  The column name for the counts.
  -length, --length_column, --length-column TEXT
                                  The column name for the length.
  -tpm, --abundance_column, --abundance-column TEXT
                                  The column name for the abundance.
  --existence_optional, --existence-optional
                                  Whether the existence of the files is
                                  optional.
  --help                          Show this message and exit.
```


cwlVersion: v1.2
class: CommandLineTool
baseCommand: [modle_tools, evaluate]
label: modle_tools_evaluate
doc: "Helper tool to compare contact matrices in cooler format.\n\nTool homepage: https://github.com/paulsengroup/MoDLE"
inputs:
  - id: input_cooler
    type: File
    doc: Path or URI to a Cooler file to use as input.
    inputBinding:
      position: 101
      prefix: --input-cooler
  - id: reference_cooler
    type: File
    doc: Path or URI to a Cooler file to use as reference.
    inputBinding:
      position: 101
      prefix: --reference-cooler
  - id: output_prefix
    type: string
    doc: Output prefix. Can be an absolute or relative path including the file
      name but without the extension.
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: diagonal_width
    type: int
    doc: Width of the subdiagonal window to consider for comparison.
    inputBinding:
      position: 101
      prefix: --diagonal-width
  - id: regions_of_interest
    type:
      - 'null'
      - File
    doc: Path to a BED file with the list of regions of interest to be processed.
    inputBinding:
      position: 101
      prefix: --regions-of-interest
  - id: chrom_sizes
    type:
      - 'null'
      - File
    doc: Path to a .chrom.sizes file. This option is required when the Coolers
      passed with options --input-cooler and --reference-cooler do not have the
      same number of chromosomes.
    inputBinding:
      position: 101
      prefix: --chrom-sizes
  - id: weight_file
    type:
      - 'null'
      - File
    doc: Path to a TSV file containing the weights to apply to pixels before
      computing the correlation. The TSV should have a header with at least the
      columns chrom and diag.
    inputBinding:
      position: 101
      prefix: --weight-file
  - id: weight_column_name
    type:
      - 'null'
      - string
    doc: Label for the weight column (needs --weight-file).
    inputBinding:
      position: 101
      prefix: --weight-column-name
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalize matrices to range 0-1 before comparing them.
    inputBinding:
      position: 101
      prefix: --normalize
  - id: no_normalize
    type:
      - 'null'
      - boolean
    doc: Do not normalize matrices to range 0-1 before comparing them.
    inputBinding:
      position: 101
      prefix: --no-normalize
  - id: metric
    type:
      - 'null'
      - string
    doc: 'Comparison metric. Supported metrics: custom, eucl_dist, pearson, rmse, spearman.'
    inputBinding:
      position: 101
      prefix: --metric
  - id: reciprocal_weights
    type:
      - 'null'
      - boolean
    doc: Use the weights reciprocal instead of the actual weights (needs --weight-file).
    inputBinding:
      position: 101
      prefix: --reciprocal-weights
  - id: exclude_zero_pixels
    type:
      - 'null'
      - boolean
    doc: When comparing rows or columns of pixels, ignore pairs of pixels where
      one or both pixels are zero.
    inputBinding:
      position: 101
      prefix: --exclude-zero-pixels
  - id: include_zero_pixels
    type:
      - 'null'
      - boolean
    doc: When comparing rows or columns of pixels, keep pairs of pixels where one
      or both pixels are zero.
    inputBinding:
      position: 101
      prefix: --include-zero-pixels
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files (if any).
    inputBinding:
      position: 101
      prefix: --force
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of worker threads.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written under the output prefix.
    outputBinding:
      glob: $(inputs.output_prefix)*
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/modle:1.1.0--h63853f4_0
stdout: modle_tools_evaluate.out

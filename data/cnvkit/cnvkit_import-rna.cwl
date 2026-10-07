cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - import-rna
label: cnvkit_import-rna
doc: "Convert a cohort of per-gene log2 ratios to CNVkit .cnr format.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: gene_counts
    type:
      type: array
      items: File
    doc: "Tabular files with Ensembl gene ID and number of reads mapped to each gene, from RSEM or another transcript quantifier."
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: "Input format name: 'rsem' for RSEM gene-level read counts (*_rsem.genes.results), or 'counts' for generic 2-column gene IDs and their read counts (e.g. TCGA level 2 RNA expression). (choices: rsem, counts)"
    inputBinding:
      position: 101
      prefix: --format
  - id: gene_resource
    type: File
    doc: "Location of gene info table from Ensembl BioMart."
    inputBinding:
      position: 101
      prefix: --gene-resource
  - id: correlations
    type:
      - 'null'
      - File
    doc: "Correlation of each gene's copy number with expression. Output of cnv_expression_correlate.py."
    inputBinding:
      position: 101
      prefix: --correlations
  - id: max_log2
    type:
      - 'null'
      - float
    doc: "Maximum log2 ratio in output. Observed values above this limit will be replaced with this value. [Default: 3.0]"
    inputBinding:
      position: 101
      prefix: --max-log2
  - id: normal
    type:
      - 'null'
      - type: array
        items: File
    doc: "Normal samples (same format as `gene_counts`) to be used as a control to when normalizing and re-centering gene read depth ratios. All filenames following this option will be used."
    inputBinding:
      position: 101
      prefix: --normal
  - id: output_dir
    type: string
    default: cnvkit_output
    doc: "Directory to write a CNVkit .cnr file for each input sample. [Default: .]"
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: output
    type:
      - 'null'
      - string
    doc: "Output file name (summary table)."
    inputBinding:
      position: 101
      prefix: --output
  - id: no_gc
    type:
      - 'null'
      - boolean
    doc: "Skip GC correction."
    inputBinding:
      position: 101
      prefix: --no-gc
  - id: no_txlen
    type:
      - 'null'
      - boolean
    doc: "Skip transcript length correction."
    inputBinding:
      position: 101
      prefix: --no-txlen
outputs:
  - id: output_dir_out
    type:
      - 'null'
      - Directory
    doc: "Directory to write a CNVkit .cnr file for each input sample. [Default: .]"
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output file name (summary table)."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({class: "Directory", basename: inputs.output_dir, listing: [], writable: true})'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1

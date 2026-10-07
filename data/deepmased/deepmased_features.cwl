cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - DeepMAsED
  - features
label: deepmased_features
doc: "Create feature tables for Predict\n\nTool homepage: https://github.com/leylabmpi/DeepMAsED"
inputs:
  - id: bam_fasta_table
    type: File
    doc: 'Tab-delim table matching BAM and ref-fasta files (header: bam<tab>fasta)'
    inputBinding:
      position: 2
  - id: outdir
    type:
      - 'null'
      - string
    doc: 'Output directory (default: .)'
    default: deepmased_features
    inputBinding:
      position: 1
      prefix: --outdir
  - id: name
    type:
      - 'null'
      - string
    doc: 'Output feature-file table name (default: feature_file_table.tsv)'
    inputBinding:
      position: 1
      prefix: --name
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: 'gzip feature tables (default: False)'
    inputBinding:
      position: 1
      prefix: --gzip
  - id: procs
    type:
      - 'null'
      - int
    doc: 'Number of parallel processes (default: 1)'
    inputBinding:
      position: 1
      prefix: --procs
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Debug mode for testing (default: False)'
    inputBinding:
      position: 1
      prefix: --debug
  - id: data_files
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: Files and folders named in the input table (feature tables, or BAM files with their
      .bai index and FASTA files; the image has no samtools to index BAM files), staged writable
      in the working directory so the relative paths in the table resolve and the tool can
      write pickles or indexes beside them
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: Per-BAM feature tables (<bam>_feats.tsv) and the feature file table
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.data_files ? inputs.data_files : [])'
        writable: true
      - entry: '$({class: ''Directory'', basename: inputs.outdir, listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmased:0.3.1--pyh5ca1d4c_0
stdout: deepmased_features.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangwas collect
label: pangwas_collect
doc: "Collect extracted sequences from multiple samples into one file.\n\nTakes as
  input multiple TSV files from extract, which can be supplied \nas either space separate
  paths, or a text file containing paths. \nDuplicate sequence IDs will be identified
  and given the suffix '.#'.\nOutputs concatenated FASTA and TSV files.\n\nTool homepage:
  https://github.com/phac-nml/pangwas"
inputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: tsv
    type:
      type: array
      items: File
    doc: TSV files from the extract subcommand.
    inputBinding:
      position: 101
      prefix: --tsv
  - id: tsv_paths
    type: File
    doc: TXT file containing paths to TSV files.
    inputBinding:
      position: 101
      prefix: --tsv-paths
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
stdout: pangwas_collect.out

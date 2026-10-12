cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - collect
label: pangwas_collect
doc: "Collect extracted sequences from multiple samples into one file.\n\nTakes as input multiple TSV files from extract, which can be supplied \nas either space separate paths, or a text file containing paths. \nDuplicate sequence IDs will be identified and given the suffix '.#'.\nOutputs concatenated FASTA and TSV files.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: tsv
    type:
      - 'null'
      - type: array
        items: File
    doc: "TSV files from the extract subcommand."
    inputBinding:
      position: 101
      prefix: --tsv
  - id: tsv_paths
    type:
      - 'null'
      - File
    doc: "TXT file containing paths to TSV files."
    inputBinding:
      position: 101
      prefix: --tsv-paths
  - id: listed_tsv
    type:
      - 'null'
      - type: array
        items: File
    doc: "The TSV files named in tsv_paths; staged in the working directory so the listed paths resolve."
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory. (default: .)"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files."
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: regions
    type: File
    doc: "TSV table of all sequence regions"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'regions.tsv')"
  - id: sequences
    type: File
    doc: "FASTA of all collected sequences"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'sequences.fasta')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.listed_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0

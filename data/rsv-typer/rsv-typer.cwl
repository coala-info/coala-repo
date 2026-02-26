cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsv-typer
label: rsv-typer
doc: "A tool for typing RSV sequences.\n\nTool homepage: https://github.com/DiltheyLab/RSVTyper"
inputs:
  - id: amplicon_length
    type:
      - 'null'
      - string
    doc: "Minimum and maximum length of your amplicons comma\n                   \
      \     separated (e.g. 350,900). Add 200 nt to your maximum\n               \
      \         length."
    inputBinding:
      position: 101
      prefix: --ampliconLength
  - id: input
    type: Directory
    doc: "Path to basecalled, demultiplexed fastq-files. It\n                    \
      \    should end with the barcode directory (e.g.\n                        barcode15/)"
    inputBinding:
      position: 101
      prefix: --input
  - id: medaka_model
    type: string
    doc: "Medaka model that should be used for the artic\n                       \
      \ pipeline (depends on basecaller used)"
    inputBinding:
      position: 101
      prefix: --medakaModel
  - id: nextclade_output
    type:
      - 'null'
      - string
    doc: "Output file format of the nextclade results (tsv, csv,\n               \
      \         json, ndjson, all). Default: tsv"
    default: tsv
    inputBinding:
      position: 101
      prefix: --nextcladeOutput
  - id: ref_dir
    type:
      - 'null'
      - Directory
    doc: "Path to directory containing the references if the\n                   \
      \     location was changed"
    inputBinding:
      position: 101
      prefix: --refDir
  - id: sample
    type: string
    doc: Name of the sample
    inputBinding:
      position: 101
      prefix: --sample
  - id: scheme_dir
    type:
      - 'null'
      - Directory
    doc: "Path to primal scheme if the location of it was\n                      \
      \  changed"
    inputBinding:
      position: 101
      prefix: --schemeDir
  - id: scheme_version
    type:
      - 'null'
      - string
    doc: Name of your primer scheme version
    inputBinding:
      position: 101
      prefix: --schemeVersion
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsv-typer:0.5.0--pyh7e72e81_0

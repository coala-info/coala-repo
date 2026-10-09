cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - HLAProfiler.pl
  - create_taxonomy
label: hlaprofiler_create_taxonomy
doc: "Create a kraken-compatible taxonomy for HLA alleles from a reference fasta.\n\nTool homepage: https://github.com/ExpressionAnalysis/HLAProfiler"
inputs:
  - id: reference
    type: File
    doc: 'HLA reference fasta'
    inputBinding:
      position: 1
      prefix: -reference
  - id: cwd
    type: File
    doc: 'File containing the names of common and well-documented alleles (can be empty)'
    inputBinding:
      position: 1
      prefix: -cwd
  - id: output_dir
    type: string
    doc: 'Parent directory of the taxonomy (created in the working directory)'
    inputBinding:
      position: 1
      prefix: -output_dir
  - id: log
    type:
      - 'null'
      - string
    default: HLAProfiler.log
    doc: 'Name of the log file (the module needs a log file name)'
    inputBinding:
      position: 1
      prefix: -log
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory of the module
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_dir)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hlaprofiler:1.0.5--0

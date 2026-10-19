cwlVersion: v1.2
class: CommandLineTool
baseCommand: phandango_mapper
label: pyseer_phandango_mapper
doc: "Create Phandango Manhattan plot from kmer results.\n\nTool homepage: https://github.com/mgalardini/pyseer"
inputs:
  - id: kmers
    type: File
    doc: Kmers file, filtered output from SEER.
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: Reference fasta file.
    inputBinding:
      position: 2
  - id: output_path
    type: string
    doc: Output file.
    inputBinding:
      position: 3
  - id: bwa
    type:
      - 'null'
      - string
    doc: Location of bwa executable.
    inputBinding:
      position: 4
      prefix: --bwa
  - id: tmp_prefix
    type:
      - 'null'
      - string
    doc: Directory to store temporary files.
    inputBinding:
      position: 4
      prefix: --tmp-prefix
  - id: use_filter_p
    type:
      - 'null'
      - boolean
    doc: Plot the unadjusted p-value.
    inputBinding:
      position: 4
      prefix: --use-filter-p
outputs:
  - id: phandango_plot
    type: File
    doc: Phandango plot file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0

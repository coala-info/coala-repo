cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftUp
label: ucsc-liftup
doc: "The ucsc-liftup tool (liftUp) is used to lift coordinates from one set to another,
  typically used in genome assembly processing to map coordinates from contigs to
  scaffolds or chromosomes.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: lift_file
    type: File
    doc: The file containing the lift specifications.
    inputBinding:
      position: 1
  - id: source_lift
    type: File
    doc: The source lift file.
    inputBinding:
      position: 2
  - id: old_file
    type: File
    doc: The original file to be lifted.
    inputBinding:
      position: 3
  - id: no_sub
    type:
      - 'null'
      - boolean
    doc: Do not substitute names.
    inputBinding:
      position: 104
      prefix: -nosub
  - id: type
    type:
      - 'null'
      - string
    doc: Specify the type of the input file (e.g., .psl, .bed).
    inputBinding:
      position: 104
      prefix: -type
outputs:
  - id: dest_lift
    type: File
    doc: The output lift file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-liftup:482--h0b57e2e_0

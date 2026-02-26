cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedAnnotateGenes
label: ngs-bits_BedAnnotateGenes
doc: "Annotates BED file regions with gene names.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: clear
    type:
      - 'null'
      - boolean
    doc: Clear all annotations present in the input file.
    default: false
    inputBinding:
      position: 101
      prefix: -clear
  - id: extend
    type:
      - 'null'
      - int
    doc: The number of bases to extend the gene regions before annotation.
    default: 0
    inputBinding:
      position: 101
      prefix: -extend
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input BED file. If unset, reads from STDIN.
    default: ''
    inputBinding:
      position: 101
      prefix: -in
  - id: settings_file
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: test
    type:
      - 'null'
      - boolean
    doc: Uses the test database instead of on the production database.
    default: false
    inputBinding:
      position: 101
      prefix: -test
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED file. If unset, writes to STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0

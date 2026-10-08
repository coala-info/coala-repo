cwlVersion: v1.2
class: CommandLineTool
baseCommand: plastome_arch_info.py
label: getorganelle_plastome_arch_info.py
doc: "Count the LSC, SSC and IR/DR lengths of plastome sequences from fasta files.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: sequences
    type:
      type: array
      items: File
    doc: "Input fasta format sequences."
    inputBinding:
      position: 2
  - id: output_file
    type: string
    doc: "Output table file name."
    inputBinding:
      position: 1
      prefix: -o
  - id: min_ir_length
    type:
      - 'null'
      - int
    doc: "The minimum repeat length treated as the IR region of plastome. Default: 5000"
    inputBinding:
      position: 101
      prefix: -r
  - id: valid_bases
    type:
      - 'null'
      - string
    doc: "Valid bases. Default: ATGCRMYKHBDVatgcrmykhbdv"
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: arch_table
    type: File
    doc: "Tab-separated table of LSC, SSC and IR lengths per sequence."
    outputBinding:
      glob: "$(inputs.output_file)"
  - id: stdout
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_plastome_arch_info.py.out

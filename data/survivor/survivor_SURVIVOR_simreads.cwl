cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - simreads
label: survivor_simreads
doc: "Simulate long reads (PacBio or ONT) from an error profile\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: reference
    type: File
    doc: "Reference fasta file."
    inputBinding:
      position: 1
  - id: error_profile
    type: File
    doc: "Error profile file (see scanreads)."
    inputBinding:
      position: 2
  - id: coverage
    type: float
    doc: "Coverage."
    inputBinding:
      position: 3
  - id: output_prefix
    type: string
    doc: "Output prefix."
    inputBinding:
      position: 4
outputs:
  - id: reads
    type: File
    doc: "Simulated reads (fasta) written under the prefix."
    outputBinding:
      glob: '$(inputs.output_prefix)*'
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
stdout: survivor_simreads.out

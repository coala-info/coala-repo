cwlVersion: v1.2
class: CommandLineTool
baseCommand: binchicken
label: binchicken_evaluate
doc: "Evaluate binchicken results\n\nTool homepage: https://github.com/aroneys/binchicken"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files to evaluate
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write results to
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0

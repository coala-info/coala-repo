cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicberg rescue
label: hicberg_rescue
doc: "Reallocate ambiguous reads to the most plausible position according to\n  model.\n\
  \nTool homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: genome
    type: string
    doc: genome
    inputBinding:
      position: 1
  - id: cpus
    type:
      - 'null'
      - int
    doc: Threads to use for analysis.
    inputBinding:
      position: 102
      prefix: --cpus
  - id: enzyme
    type:
      - 'null'
      - string
    doc: Enzymes to use for genome digestion.
    inputBinding:
      position: 102
      prefix: --enzyme
  - id: mode
    type:
      - 'null'
      - string
    doc: Statistical model to use for ambiguous reads assignment.
    inputBinding:
      position: 102
      prefix: --mode
outputs:
  - id: output_folder
    type:
      - 'null'
      - File
    doc: Output folder to save results.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0

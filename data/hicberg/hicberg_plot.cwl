cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicberg plot
label: hicberg_plot
doc: "Plot results from analysis.\n\nTool homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: genome
    type: string
    doc: Genome
    inputBinding:
      position: 1
  - id: bins
    type:
      - 'null'
      - int
    doc: Genomic resolution.
    default: 2000
    inputBinding:
      position: 102
      prefix: --bins
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

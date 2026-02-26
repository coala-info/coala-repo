cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicberg_get-tables
label: hicberg_get-tables
doc: "Create tables for the genome length detail and the bins.\n\nTool homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: genome
    type: string
    doc: Genome to process
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
      - Directory
    doc: Output folder to save results. If not set, the current directory is 
      used.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0

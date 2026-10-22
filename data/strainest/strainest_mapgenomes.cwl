cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strainest
  - mapgenomes
label: strainest_mapgenomes
doc: "Map genomes to a reference.\n\nTool homepage: https://github.com/compmetagen/strainest"
inputs:
  - id: genomes
    type:
      type: array
      items: File
    doc: Genomes to map
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: Reference genome
    inputBinding:
      position: 2
  - id: mapped
    type: string
    doc: Output file for mapped genomes (FASTA)
    inputBinding:
      position: 3
outputs:
  - id: mapped_file
    type: File
    doc: Output file for mapped genomes
    outputBinding:
      glob: $(inputs.mapped)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainest:1.2.4--py35_0

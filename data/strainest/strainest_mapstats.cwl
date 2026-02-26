cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strainest
  - mapstats
label: strainest_mapstats
doc: "Compute basic statistics on the mapped genomes file.\n\nTool homepage: https://github.com/compmetagen/strainest"
inputs:
  - id: mapped
    type: File
    doc: Mapped genomes file
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: Output file/directory for statistics
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainest:1.2.4--py35_0
stdout: strainest_mapstats.out

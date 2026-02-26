cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - simutrain
label: maq_simutrain
doc: "Simulate reads from a reference genome.\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: simupars_file
    type: File
    doc: Simulation parameters file
    inputBinding:
      position: 1
  - id: known_reads_file
    type: File
    doc: Known reads file (e.g., FASTQ format)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_simutrain.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - genome
label: capcruncher_genome
doc: "Genome wide methods digestion.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: command
    type: string
    doc: Command to execute (e.g., digest)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
stdout: capcruncher_genome.out

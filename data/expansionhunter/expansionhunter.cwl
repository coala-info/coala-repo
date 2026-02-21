cwlVersion: v1.2
class: CommandLineTool
baseCommand: expansionhunter
label: expansionhunter
doc: "A tool for estimating sizes of tandem repeat expansions by analyzing sequencing
  reads.\n\nTool homepage: https://github.com/Illumina/ExpansionHunter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expansionhunter:5.0.0--hc26b3af_5
stdout: expansionhunter.out

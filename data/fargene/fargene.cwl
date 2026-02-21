cwlVersion: v1.2
class: CommandLineTool
baseCommand: fargene
label: fargene
doc: "Fragmented Antibiotic Resistance Gene Identifier\n\nTool homepage: https://github.com/fannyhb/fargene"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fargene:0.1--py27h864c0ab_3
stdout: fargene.out

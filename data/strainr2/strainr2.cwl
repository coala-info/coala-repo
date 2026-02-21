cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainr2
label: strainr2
doc: "Strain-level profiling of metagenomic samples\n\nTool homepage: https://github.com/BisanzLab/StrainR2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainr2:2.3.0--r44h577a1d6_0
stdout: strainr2.out

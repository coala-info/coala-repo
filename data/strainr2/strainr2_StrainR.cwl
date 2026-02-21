cwlVersion: v1.2
class: CommandLineTool
baseCommand: StrainR
label: strainr2_StrainR
doc: "StrainR: A tool for strain-level profiling of metagenomic samples.\n\nTool homepage:
  https://github.com/BisanzLab/StrainR2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainr2:2.3.0--r44h577a1d6_0
stdout: strainr2_StrainR.out

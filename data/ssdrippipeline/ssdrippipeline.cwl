cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssdrippipeline
label: ssdrippipeline
doc: "A pipeline for ssDRIP-seq (single-stranded DNA-RNA immunoprecipitation sequencing)
  data analysis.\n\nTool homepage: https://github.com/PEHGP/ssDripPipeline"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssdrippipeline:0.0.5--kuan
stdout: ssdrippipeline.out

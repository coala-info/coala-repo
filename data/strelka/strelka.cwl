cwlVersion: v1.2
class: CommandLineTool
baseCommand: strelka
label: strelka
doc: "Strelka is a somatic and germline small variant caller. Note: The provided text
  contains container runtime error logs rather than the tool's help documentation.\n
  \nTool homepage: https://github.com/Illumina/strelka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strelka:2.9.10--hdfd78af_2
stdout: strelka.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: phava
label: phava
doc: "Phage Annotation and Verification Assistant (Note: The provided text contained
  container build logs rather than help text; no arguments could be extracted).\n\n
  Tool homepage: https://github.com/patrickwest/PhaVa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
stdout: phava.out

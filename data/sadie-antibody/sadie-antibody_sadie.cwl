cwlVersion: v1.2
class: CommandLineTool
baseCommand: sadie
label: sadie-antibody_sadie
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a container runtime error log.\n\nTool homepage: https://sadie.jordanrwillis.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
stdout: sadie-antibody_sadie.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: sadie-antibody
label: sadie-antibody
doc: "SADIE (Somatic Antibody Divergence Inference and Estimation) antibody analysis
  tool. Note: The provided text appears to be a container runtime error log rather
  than the tool's help output, so no arguments could be extracted.\n\nTool homepage:
  https://sadie.jordanrwillis.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
stdout: sadie-antibody.out

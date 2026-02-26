cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nomadic
  - start
label: nomadic_start
doc: "Get started with nomadic.\n\nThis command will help you set up a new workspace
  for a specific organism.\n\nCurrently supported organisms:\n- Plasmodium falciparum
  (pfalciparum)\n- Anopheles gambiae (agambiae)\n\nTool homepage: https://jasonahendry.github.io/nomadic/"
inputs:
  - id: organism
    type:
      - 'null'
      - string
    doc: Specify the organism (pfalciparum or agambiae)
    inputBinding:
      position: 1
  - id: workspace
    type: Directory
    doc: Path to workspace.
    inputBinding:
      position: 102
      prefix: --workspace
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
stdout: nomadic_start.out

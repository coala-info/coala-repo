cwlVersion: v1.2
class: CommandLineTool
baseCommand: gather_setup_igblast_env.sh
label: gather_setup_igblast_env.sh
doc: "Setup the IgBLAST environment for the gather toolset.\n\nTool homepage: https://github.com/Neuroimmunology-UiO/gather"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gather:1.0.1--pyh7e72e81_1
stdout: gather_setup_igblast_env.sh.out

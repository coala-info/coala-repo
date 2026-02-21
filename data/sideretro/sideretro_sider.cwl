cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sideretro
  - sider
label: sideretro_sider
doc: "Sideretro tool (Note: The provided text is a container build log and does not
  contain help documentation or argument details).\n\nTool homepage: https://github.com/galantelab/sideRETRO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sideretro:1.1.6--hb728cf0_0
stdout: sideretro_sider.out

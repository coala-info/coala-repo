cwlVersion: v1.2
class: CommandLineTool
baseCommand: miru-hero
label: miru-hero
doc: "A tool for MIRU-VNTR typing (Note: The provided text is an error log and does
  not contain usage information or a description).\n\nTool homepage: https://gitlab.com/LPCDRP/miru-hero"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miru-hero:0.10.0--pyh5e36f6f_0
stdout: miru-hero.out

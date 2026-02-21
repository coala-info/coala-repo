cwlVersion: v1.2
class: CommandLineTool
baseCommand: matam_matam_assembly.py
label: matam_matam_assembly.py
doc: "MATAM (Mapping and Assembly for Terrestrial and Aquatic Metagenomes) assembly
  tool. Note: The provided help text contains only system error messages regarding
  container execution and does not list specific command-line arguments.\n\nTool homepage:
  https://github.com/bonsai-team/matam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matam:1.6.2--haf24da9_0
stdout: matam_matam_assembly.py.out

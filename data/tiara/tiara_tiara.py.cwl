cwlVersion: v1.2
class: CommandLineTool
baseCommand: tiara
label: tiara_tiara.py
doc: "A tool for identification of eukaryotic, archaeal, bacterial, mitochondrial,
  and plastid sequences (Note: The provided text is a container execution log and
  does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/savetz/tiara"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiara:1.0.3
stdout: tiara_tiara.py.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: pacbio_falcon_fc_quiver.py
label: pacbio_falcon_fc_quiver.py
doc: "A tool within the PacBio FALCON assembly pipeline, likely related to the Quiver
  consensus polishing step. Note: The provided help text contains only system error
  messages and no argument definitions.\n\nTool homepage: https://github.com/PacificBiosciences/FALCON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacbio_falcon:052016--py27_0
stdout: pacbio_falcon_fc_quiver.py.out

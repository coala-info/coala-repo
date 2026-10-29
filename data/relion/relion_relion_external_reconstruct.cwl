cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_external_reconstruct
label: relion_relion_external_reconstruct
doc: "Call an external reconstruction program for a RELION refinement (internal helper of relion_refine).\n\
  \nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input_star
    type: File
    doc: Input STAR file that describes the external reconstruction (must have a .star extension)
    inputBinding:
      position: 1
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_external_reconstruct.out

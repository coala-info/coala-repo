cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_star_datablock_ctfdat
label: relion_relion_star_datablock_ctfdat
doc: "Print a STAR datablock for all images in an xmipp-format CTFDAT file.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: ctfdat_file
    type: File
    doc: XMIPP CTFDAT file
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
  - id: datablock
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_star_datablock_ctfdat.out

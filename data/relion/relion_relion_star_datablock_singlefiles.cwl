cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_star_datablock_singlefiles
label: relion_relion_star_datablock_singlefiles
doc: "Print a STAR datablock with one row for each image that matches a wildcard.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: wildcard
    type: string
    doc: Wildcard (in quotes) for the single image files, for example 'tmp/*'
    inputBinding:
      position: 1
  - id: values
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional data values written after each image name (value1 value2 ...)
    inputBinding:
      position: 2
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
stdout: relion_relion_star_datablock_singlefiles.out

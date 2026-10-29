cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_convert_star
label: relion_relion_convert_star
doc: "Convert a RELION-3.0 STAR file to the RELION-3.1 format with optics groups.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input STAR file to be converted
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type: string
    doc: Output STAR file to be written
    inputBinding:
      position: 101
      prefix: --o
  - id: Cs
    type:
      - 'null'
      - float
    doc: 'Spherical aberration (mm) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --Cs
  - id: Q0
    type:
      - 'null'
      - float
    doc: 'Amplitude contrast (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --Q0
  - id: box_size
    type:
      - 'null'
      - int
    doc: 'Image box size. If image stack is missing you can try using this. Assumes 2D image stack. (RELION
      default: -1)'
    inputBinding:
      position: 101
      prefix: --box_size
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: converted_star
    type: File
    doc: Converted STAR file
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_convert_star.out

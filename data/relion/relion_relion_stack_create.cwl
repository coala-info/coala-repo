cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_stack_create
label: relion_relion_stack_create
doc: "Write the particle images of a STAR file into one new image stack (or one stack per micrograph).\n\
  \nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input STAR file with the images (as rlnImageName) to be saved in a stack
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output rootname (RELION default: output)'
    inputBinding:
      position: 101
      prefix: --o
    default: output
  - id: split_per_micrograph
    type:
      - 'null'
      - boolean
    doc: Write out separate stacks for each micrograph (needs rlnMicrographName in STAR file)
    inputBinding:
      position: 101
      prefix: --split_per_micrograph
  - id: apply_transformation
    type:
      - 'null'
      - boolean
    doc: Apply the inplane-transformations (needs _rlnOriginX/Y and _rlnAnglePsi in STAR file) by real
      space interpolation
    inputBinding:
      position: 101
      prefix: --apply_transformation
  - id: apply_rounded_offsets_only
    type:
      - 'null'
      - boolean
    doc: Apply the rounded translations only (so-recentering without interpolation; needs _rlnOriginX/Y
      in STAR file)
    inputBinding:
      position: 101
      prefix: --apply_rounded_offsets_only
  - id: ignore_optics
    type:
      - 'null'
      - boolean
    doc: Ignore optics groups. This allows you to read and write RELION 3.0 STAR files but does NOT allow
      you to convert 3.1 STAR files back to the 3.0 format.
    inputBinding:
      position: 101
      prefix: --ignore_optics
  - id: one_by_one
    type:
      - 'null'
      - boolean
    doc: Write particles one by one. This saves memory but can be slower.
    inputBinding:
      position: 101
      prefix: --one_by_one
  - id: float16
    type:
      - 'null'
      - boolean
    doc: Write images in 16bit float format (default is 32bit).
    inputBinding:
      position: 101
      prefix: --float16
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: stacks
    type: &id001
      type: array
      items: File
    doc: Image stacks
    outputBinding:
      glob: $(inputs.output)*.mrcs
  - id: star_files
    type: *id001
    doc: STAR files that point to the new stacks
    outputBinding:
      glob: $(inputs.output)*.star
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0

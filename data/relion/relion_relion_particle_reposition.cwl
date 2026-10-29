cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_particle_reposition
label: relion_relion_particle_reposition
doc: "Put 2D class averages or 3D projections back at the particle positions on the micrographs.\n\nTool\
  \ homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input STAR file with rlnMicrographName's
    inputBinding:
      position: 101
      prefix: --i
  - id: opt
    type: File
    doc: Optimiser STAR file with the 2D classes or 3D maps to be repositioned
    inputBinding:
      position: 101
      prefix: --opt
  - id: output
    type:
      - 'null'
      - string
    doc: Output rootname, to be added to input micrograph names
    inputBinding:
      position: 101
      prefix: --o
  - id: odir
    type:
      - 'null'
      - string
    doc: Output directory (default is same as input micrographs directory
    inputBinding:
      position: 101
      prefix: --odir
  - id: data
    type:
      - 'null'
      - File
    doc: Data STAR file with selected particles (default is to use all particles)
    inputBinding:
      position: 101
      prefix: --data
  - id: background
    type:
      - 'null'
      - float
    doc: 'The fraction of micrograph background noise in the output micrograph (RELION default: 0.1)'
    inputBinding:
      position: 101
      prefix: --background
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Invert the contrast in the references?
    inputBinding:
      position: 101
      prefix: --invert
  - id: ctf
    type:
      - 'null'
      - boolean
    doc: Apply CTF for each particle to the references?
    inputBinding:
      position: 101
      prefix: --ctf
  - id: norm_radius
    type:
      - 'null'
      - int
    doc: 'Radius of the circle used for background normalisation (in pixels) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --norm_radius
  - id: subtract
    type:
      - 'null'
      - boolean
    doc: Subtract repositioned micrographs from the input ones?
    inputBinding:
      position: 101
      prefix: --subtract
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Repositioned micrographs
    outputBinding:
      glob: $(inputs.odir)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_particle_reposition.out

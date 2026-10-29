cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_particle_symmetry_expand
label: relion_relion_particle_symmetry_expand
doc: "Expand a particle STAR file according to a point-group or helical symmetry.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input particle STAR file
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output expanded particle STAR file (RELION default: expanded.star)'
    inputBinding:
      position: 101
      prefix: --o
    default: expanded.star
  - id: sym
    type:
      - 'null'
      - string
    doc: 'Symmetry point group (RELION default: C1)'
    inputBinding:
      position: 101
      prefix: --sym
  - id: helix
    type:
      - 'null'
      - boolean
    doc: Do helical symmetry expansion
    inputBinding:
      position: 101
      prefix: --helix
  - id: twist
    type:
      - 'null'
      - float
    doc: 'Helical twist (deg) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --twist
  - id: rise
    type:
      - 'null'
      - float
    doc: 'Helical rise (A) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --rise
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size (A) (RELION default: 1.)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: asu
    type:
      - 'null'
      - int
    doc: 'Number of asymmetrical units to expand (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --asu
  - id: frac_sampling
    type:
      - 'null'
      - int
    doc: 'Number of samplings in between a single asymmetrical unit (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --frac_sampling
  - id: frac_range
    type:
      - 'null'
      - float
    doc: 'Range of the rise [-0.5, 0.5> to be sampled (RELION default: 0.5)'
    inputBinding:
      position: 101
      prefix: --frac_range
  - id: ignore_optics
    type:
      - 'null'
      - boolean
    doc: Provide this option for relion-3.0 functionality, without optics groups
    inputBinding:
      position: 101
      prefix: --ignore_optics
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: expanded_star
    type: File
    doc: Expanded particle STAR file
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_particle_symmetry_expand.out

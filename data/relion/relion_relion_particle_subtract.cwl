cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_particle_subtract
label: relion_relion_particle_subtract
doc: "Subtract the projection of a reference from particle images (signal subtraction).\n\nTool homepage:\
  \ https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Name of optimiser.star file from refinement/classification to use for subtraction
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output directory name (RELION default: Subtract/)'
    inputBinding:
      position: 101
      prefix: --o
    default: Subtract/
  - id: mask
    type:
      - 'null'
      - File
    doc: Name of the 3D mask with all density that should be kept, i.e. not subtracted
    inputBinding:
      position: 101
      prefix: --mask
  - id: data
    type:
      - 'null'
      - File
    doc: Name of particle STAR file, in case not all particles from optimiser are to be used
    inputBinding:
      position: 101
      prefix: --data
  - id: ignore_class
    type:
      - 'null'
      - boolean
    doc: Ignore the rlnClassNumber column in the particle STAR file.
    inputBinding:
      position: 101
      prefix: --ignore_class
  - id: revert
    type:
      - 'null'
      - File
    doc: Name of particle STAR file to revert. When this is provided, all other options are ignored.
    inputBinding:
      position: 101
      prefix: --revert
  - id: ssnr
    type:
      - 'null'
      - boolean
    doc: Don't subtract, only calculate average spectral SNR in the images
    inputBinding:
      position: 101
      prefix: --ssnr
  - id: float16
    type:
      - 'null'
      - boolean
    doc: Write in half-precision 16 bit floating point numbers (MRC mode 12), instead of 32 bit (MRC mode
      0).
    inputBinding:
      position: 101
      prefix: --float16
  - id: recenter_on_mask
    type:
      - 'null'
      - boolean
    doc: Use this flag to center the subtracted particles on projections of the centre-of-mass of the
      input mask
    inputBinding:
      position: 101
      prefix: --recenter_on_mask
  - id: center_x
    type:
      - 'null'
      - float
    doc: 'X-coordinate of 3D coordinate, which will be projected to center the subtracted particles. (RELION
      default: 9999)'
    inputBinding:
      position: 101
      prefix: --center_x
  - id: center_y
    type:
      - 'null'
      - float
    doc: 'Y-coordinate of 3D coordinate, which will be projected to center the subtracted particles. (RELION
      default: 9999)'
    inputBinding:
      position: 101
      prefix: --center_y
  - id: center_z
    type:
      - 'null'
      - float
    doc: 'Z-coordinate of 3D coordinate, which will be projected to center the subtracted particles. (RELION
      default: 9999)'
    inputBinding:
      position: 101
      prefix: --center_z
  - id: new_box
    type:
      - 'null'
      - int
    doc: 'Output size of the subtracted particles (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --new_box
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with subtracted particles
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_particle_subtract.out

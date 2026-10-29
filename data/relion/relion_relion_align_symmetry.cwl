cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_align_symmetry
label: relion_relion_align_symmetry
doc: "Align a 3D map to the symmetry axes of a given point group.\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: input
    type: File
    doc: 'Input map to be aligned (OR: input model.star, from which input map will be selected)'
    inputBinding:
      position: 101
      prefix: --i
  - id: sym
    type: string
    doc: Target point group symmetry
    inputBinding:
      position: 101
      prefix: --sym
  - id: select_largest_class
    type:
      - 'null'
      - boolean
    doc: Select largest class from model.star; by default map with best symmetry will be selected
    inputBinding:
      position: 101
      prefix: --select_largest_class
  - id: select_highest_resol
    type:
      - 'null'
      - boolean
    doc: Select class with highest resolution from model.star; by default map with best symmetry will
      be selected
    inputBinding:
      position: 101
      prefix: --select_highest_resol
  - id: output
    type:
      - 'null'
      - string
    doc: 'Name for output aligned map) (RELION default: aligned.mrc)'
    inputBinding:
      position: 101
      prefix: --o
    default: aligned.mrc
  - id: box_size
    type:
      - 'null'
      - int
    doc: 'Working box size in pixels. Very small box (such that Nyquist is aroud 20 A) is usually sufficient.
      (RELION default: 64)'
    inputBinding:
      position: 101
      prefix: --box_size
  - id: keep_centre
    type:
      - 'null'
      - boolean
    doc: Do not re-centre the input
    inputBinding:
      position: 101
      prefix: --keep_centre
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size (in Angstroms) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: only_rot
    type:
      - 'null'
      - boolean
    doc: Keep TILT and PSI fixed and search only ROT (rotation along the Z axis)
    inputBinding:
      position: 101
      prefix: --only_rot
  - id: nr_uniform
    type:
      - 'null'
      - int
    doc: 'Randomly search this many orientations (RELION default: 400)'
    inputBinding:
      position: 101
      prefix: --nr_uniform
  - id: maxres
    type:
      - 'null'
      - float
    doc: 'Maximum resolution (in Angstrom) to consider in Fourier space (default Nyquist) (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --maxres
  - id: local_search_range
    type:
      - 'null'
      - int
    doc: 'Local search range (1 + 2 * this number) (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --local_search_range
  - id: local_search_step
    type:
      - 'null'
      - float
    doc: 'Local search step (in degrees) (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --local_search_step
  - id: pad
    type:
      - 'null'
      - float
    doc: 'Padding factor (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --pad
  - id: apply_sym
    type:
      - 'null'
      - boolean
    doc: Also apply the symmetry to the map
    inputBinding:
      position: 101
      prefix: --apply_sym
  - id: NN
    type:
      - 'null'
      - boolean
    doc: Use nearest-neighbour instead of linear interpolation
    inputBinding:
      position: 101
      prefix: --NN
outputs:
  - id: aligned_map
    type: File
    doc: Aligned map
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_align_symmetry.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_find_lattice
label: relion_relion_tomo_find_lattice
doc: "Find a regular lattice (for example a virus capsid or a membrane protein array) in a tomogram.\n\
  \nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: tomogram
    type: File
    doc: Tomogram
    inputBinding:
      position: 101
      prefix: --t
  - id: lattice_spacing
    type: float
    doc: Lattice spacing [Å]
    inputBinding:
      position: 101
      prefix: --d
  - id: angpix
    type: float
    doc: Pixel size [Å]
    inputBinding:
      position: 101
      prefix: --angpix
  - id: output
    type: string
    doc: Output filename
    inputBinding:
      position: 101
      prefix: --o
  - id: filter_width
    type:
      - 'null'
      - float
    doc: 'Filter width [~Px] (RELION default: 10.0)'
    inputBinding:
      position: 101
      prefix: --f
  - id: min_value
    type:
      - 'null'
      - float
    doc: 'Minimal abs. value of bandpass filtered image (RELION default: 0.333)'
    inputBinding:
      position: 101
      prefix: --mv
  - id: min_density
    type:
      - 'null'
      - float
    doc: 'Minimal lattice density (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --md
  - id: taper_distance
    type:
      - 'null'
      - float
    doc: 'Tapering distance [Px] (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --td
  - id: overtones
    type:
      - 'null'
      - int
    doc: 'Number of overtones (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --ot
  - id: replace_by_noise
    type:
      - 'null'
      - boolean
    doc: Replace tomogram contents by white noise
    inputBinding:
      position: 101
      prefix: --noise
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Maxima, minima, density and band-pass maps
    outputBinding:
      glob: $(inputs.output)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_find_lattice.out

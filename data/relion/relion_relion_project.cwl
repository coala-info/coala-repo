cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_project
label: relion_relion_project
doc: "Project a 3D map in one or many directions to 2D images, optionally with CTF and noise.\n\nTool\
  \ homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input map to be projected
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type:
      - 'null'
      - string
    doc: 'Rootname for output projections (RELION default: proj)'
    inputBinding:
      position: 101
      prefix: --o
    default: proj
  - id: float16
    type:
      - 'null'
      - boolean
    doc: Write in half-precision 16 bit floating point numbers (MRC mode 12), instead of 32 bit (MRC mode
      0).
    inputBinding:
      position: 101
      prefix: --float16
  - id: ctf
    type:
      - 'null'
      - boolean
    doc: Apply CTF to reference projections
    inputBinding:
      position: 101
      prefix: --ctf
  - id: ctf_phase_flip
    type:
      - 'null'
      - boolean
    doc: Flip phases of the CTF in the output projections
    inputBinding:
      position: 101
      prefix: --ctf_phase_flip
  - id: ctf_intact_first_peak
    type:
      - 'null'
      - boolean
    doc: Ignore CTFs until their first peak?
    inputBinding:
      position: 101
      prefix: --ctf_intact_first_peak
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size (in Angstroms) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: mask
    type:
      - 'null'
      - File
    doc: Mask that will be applied to the input map prior to making projections
    inputBinding:
      position: 101
      prefix: --mask
  - id: ang
    type:
      - 'null'
      - File
    doc: Particle STAR file with orientations and CTF for multiple projections (if None, assume single
      projection)
    inputBinding:
      position: 101
      prefix: --ang
  - id: nr_uniform
    type:
      - 'null'
      - int
    doc: 'OR get this many random samples from a uniform angular distribution (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --nr_uniform
  - id: sigma_offset
    type:
      - 'null'
      - float
    doc: 'Apply Gaussian errors (A) with this stddev to the XY-offsets (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --sigma_offset
  - id: rot
    type:
      - 'null'
      - float
    doc: 'First Euler angle (for a single projection) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --rot
  - id: tilt
    type:
      - 'null'
      - float
    doc: 'Second Euler angle (for a single projection) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --tilt
  - id: psi
    type:
      - 'null'
      - float
    doc: 'Third Euler angle (for a single projection) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --psi
  - id: xoff
    type:
      - 'null'
      - float
    doc: 'Origin X-offsets (in pixels) (for a single projection) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --xoff
  - id: yoff
    type:
      - 'null'
      - float
    doc: 'Origin Y-offsets (in pixels) (for a single projection) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --yoff
  - id: zoff
    type:
      - 'null'
      - float
    doc: 'Origin Z-offsets (in pixels) (for a single 3D rotation) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --zoff
  - id: add_noise
    type:
      - 'null'
      - boolean
    doc: Add noise to the output projections (only with --ang)
    inputBinding:
      position: 101
      prefix: --add_noise
  - id: white_noise
    type:
      - 'null'
      - float
    doc: 'Standard deviation of added white Gaussian noise (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --white_noise
  - id: model_noise
    type:
      - 'null'
      - File
    doc: Model STAR file with power spectra for coloured Gaussian noise
    inputBinding:
      position: 101
      prefix: --model_noise
  - id: subtract_exp
    type:
      - 'null'
      - boolean
    doc: Subtract projections from experimental images (in --ang)
    inputBinding:
      position: 101
      prefix: --subtract_exp
  - id: ignore_particle_name
    type:
      - 'null'
      - boolean
    doc: Ignore the rlnParticleName column (in --ang)
    inputBinding:
      position: 101
      prefix: --ignore_particle_name
  - id: rot3d
    type:
      - 'null'
      - boolean
    doc: Perform 3D rotations instead of projection into 2D images
    inputBinding:
      position: 101
      prefix: --3d_rot
  - id: simulate
    type:
      - 'null'
      - boolean
    doc: Simulate data with known ground-truth by subtracting signal and adding projection in random orientation.
    inputBinding:
      position: 101
      prefix: --simulate
  - id: adjust_simulation_SNR
    type:
      - 'null'
      - float
    doc: 'Relative SNR compared to input images for realistic simulation of data (RELION default: 1.)'
    inputBinding:
      position: 101
      prefix: --adjust_simulation_SNR
  - id: ang_simulate
    type:
      - 'null'
      - File
    doc: STAR file with orientations for projections of realistic simulations (random from --ang STAR
      file by default)
    inputBinding:
      position: 101
      prefix: --ang_simulate
  - id: maxres
    type:
      - 'null'
      - float
    doc: 'Maximum resolution (in Angstrom) to consider in Fourier space (default Nyquist) (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --maxres
  - id: pad
    type:
      - 'null'
      - float
    doc: 'Padding factor (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --pad
  - id: ctf2
    type:
      - 'null'
      - boolean
    doc: Apply CTF*CTF to reference projections
    inputBinding:
      position: 101
      prefix: --ctf2
  - id: NN
    type:
      - 'null'
      - boolean
    doc: Use nearest-neighbour instead of linear interpolation
    inputBinding:
      position: 101
      prefix: --NN
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: projections
    type:
      type: array
      items: File
    doc: Projection images (and STAR file with --ang)
    outputBinding:
      glob: $(inputs.output)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_project.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: sqpics
label: bart_sqpics
doc: "Parallel-imaging compressed-sensing reconstruction.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: kspace
    type: string
    doc: kspace
    inputBinding:
      position: 1
  - id: sensitivities
    type: string
    doc: sensitivities
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 3
  - id: admm_max_cg_iterations
    type:
      - 'null'
      - int
    doc: ADMM max. CG iterations
    inputBinding:
      position: 104
      prefix: -C
  - id: admm_rho
    type:
      - 'null'
      - float
    doc: ADMM rho
    inputBinding:
      position: 104
      prefix: -u
  - id: debug_level
    type:
      - 'null'
      - int
    doc: Debug level
    inputBinding:
      position: 104
      prefix: -d
  - id: disable_random_wavelet_cycle_spinning
    type:
      - 'null'
      - boolean
    doc: disable random wavelet cycle spinning
    inputBinding:
      position: 104
      prefix: -n
  - id: generalized_regularization
    type:
      - 'null'
      - string
    doc: generalized regularization options (-Rh for help)
    inputBinding:
      position: 104
      prefix: -R
  - id: iteration_stepsize
    type:
      - 'null'
      - float
    doc: iteration stepsize
    inputBinding:
      position: 104
      prefix: -s
  - id: kspace_trajectory
    type:
      - 'null'
      - File
    doc: k-space trajectory
    inputBinding:
      position: 104
      prefix: -t
  - id: l1_wavelet
    type:
      - 'null'
      - boolean
    doc: toggle l1-wavelet or l2 regularization.
    inputBinding:
      position: 104
      prefix: -l1
  - id: l2_regularization
    type:
      - 'null'
      - boolean
    doc: toggle l1-wavelet or l2 regularization.
    inputBinding:
      position: 104
      prefix: -l2
  - id: lowrank_block_size
    type:
      - 'null'
      - int
    doc: Lowrank block size
    inputBinding:
      position: 104
      prefix: -b
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: max. number of iterations
    inputBinding:
      position: 104
      prefix: -i
  - id: pattern_or_weights
    type:
      - 'null'
      - File
    doc: pattern or weights
    inputBinding:
      position: 104
      prefix: -p
  - id: regularization_parameter
    type:
      - 'null'
      - float
    doc: regularization parameter
    inputBinding:
      position: 104
      prefix: -r
  - id: rescale_image_after_reconstruction
    type:
      - 'null'
      - boolean
    doc: Re-scale the image after reconstruction
    inputBinding:
      position: 104
      prefix: -S
  - id: restrict_fov
    type:
      - 'null'
      - float
    doc: restrict FOV
    inputBinding:
      position: 104
      prefix: -f
  - id: scale_stepsize_based_on_max_eigenvalue
    type:
      - 'null'
      - boolean
    doc: Scale stepsize based on max. eigenvalue
    inputBinding:
      position: 104
      prefix: -e
  - id: scaling_value
    type:
      - 'null'
      - float
    doc: scaling
    inputBinding:
      position: 104
      prefix: -w
  - id: select_admm
    type:
      - 'null'
      - boolean
    doc: Select ADMM
    inputBinding:
      position: 104
      prefix: -m
  - id: truth_file
    type:
      - 'null'
      - File
    doc: (truth file)
    inputBinding:
      position: 104
      prefix: -T
  - id: use_gpu
    type:
      - 'null'
      - boolean
    doc: use GPU
    inputBinding:
      position: 104
      prefix: -g
  - id: warm_start_image
    type:
      - 'null'
      - File
    doc: Warm start with <img>
    inputBinding:
      position: 104
      prefix: -W
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_sqpics.out

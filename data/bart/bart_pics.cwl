cwlVersion: v1.2
class: CommandLineTool
baseCommand: pics
label: bart_pics
doc: "Parallel-imaging compressed-sensing reconstruction.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: kspace
    type: File
    doc: k-space data
    inputBinding:
      position: 1
  - id: sensitivities
    type: File
    doc: coil sensitivities
    inputBinding:
      position: 2
  - id: admm_cg_iterations
    type:
      - 'null'
      - int
    doc: ADMM max. CG iterations
    inputBinding:
      position: 103
      prefix: -C
  - id: admm_rho
    type:
      - 'null'
      - float
    doc: ADMM rho
    inputBinding:
      position: 103
      prefix: -u
  - id: basis_pursuit_eps
    type:
      - 'null'
      - float
    doc: Basis Pursuit formulation, || y- Ax ||_2 <= eps
    inputBinding:
      position: 103
      prefix: -P
  - id: batch_mode_flags
    type:
      - 'null'
      - string
    doc: batch-mode
    inputBinding:
      position: 103
      prefix: -L
  - id: cclambda
    type:
      - 'null'
      - float
    doc: (cclambda)
    inputBinding:
      position: 103
      prefix: -q
  - id: debug_level
    type:
      - 'null'
      - int
    doc: Debug level
    inputBinding:
      position: 103
      prefix: -d
  - id: disable_random_wavelet_cycle_spinning
    type:
      - 'null'
      - boolean
    doc: disable random wavelet cycle spinning
    inputBinding:
      position: 103
      prefix: -n
  - id: fully_overlapping_llr_blocks
    type:
      - 'null'
      - boolean
    doc: do fully overlapping LLR blocks
    inputBinding:
      position: 103
      prefix: -N
  - id: generalized_regularization
    type:
      - 'null'
      - string
    doc: generalized regularization options (-Rh for help)
    inputBinding:
      position: 103
      prefix: -R
  - id: gpu_device
    type:
      - 'null'
      - int
    doc: use GPU device gpun
    inputBinding:
      position: 103
      prefix: -G
  - id: inverse_scaling_of_data
    type:
      - 'null'
      - float
    doc: inverse scaling of the data
    inputBinding:
      position: 103
      prefix: -w
  - id: iteration_stepsize
    type:
      - 'null'
      - float
    doc: iteration stepsize
    inputBinding:
      position: 103
      prefix: -s
  - id: kspace_trajectory
    type:
      - 'null'
      - File
    doc: k-space trajectory
    inputBinding:
      position: 103
      prefix: -t
  - id: l1_wavelet
    type:
      - 'null'
      - boolean
    doc: toggle l1-wavelet regularization
    inputBinding:
      position: 103
      prefix: -l1
  - id: l2_regularization
    type:
      - 'null'
      - boolean
    doc: toggle l2 regularization
    inputBinding:
      position: 103
      prefix: -l2
  - id: lowrank_block_size
    type:
      - 'null'
      - int
    doc: Lowrank block size
    inputBinding:
      position: 103
      prefix: -b
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: max. number of iterations
    inputBinding:
      position: 103
      prefix: -i
  - id: pattern_or_weights
    type:
      - 'null'
      - File
    doc: pattern or weights
    inputBinding:
      position: 103
      prefix: -p
  - id: randshift_nufft
    type:
      - 'null'
      - boolean
    doc: randshift for NUFFT
    inputBinding:
      position: 103
      prefix: -K
  - id: real_value_constraint
    type:
      - 'null'
      - boolean
    doc: real-value constraint
    inputBinding:
      position: 103
      prefix: -c
  - id: regularization_parameter
    type:
      - 'null'
      - float
    doc: regularization parameter
    inputBinding:
      position: 103
      prefix: -r
  - id: rescale_image_after_reconstruction
    type:
      - 'null'
      - boolean
    doc: re-scale the image after reconstruction
    inputBinding:
      position: 103
      prefix: -S
  - id: restrict_fov
    type:
      - 'null'
      - float
    doc: restrict FOV
    inputBinding:
      position: 103
      prefix: -f
  - id: reweighting_gamma
    type:
      - 'null'
      - float
    doc: (reweighting)
    inputBinding:
      position: 103
      prefix: -o
  - id: reweighting_iterations
    type:
      - 'null'
      - int
    doc: (reweighting)
    inputBinding:
      position: 103
      prefix: -O
  - id: scale_stepsize_based_on_max_eigenvalue
    type:
      - 'null'
      - boolean
    doc: Scale stepsize based on max. eigenvalue
    inputBinding:
      position: 103
      prefix: -e
  - id: select_admm
    type:
      - 'null'
      - boolean
    doc: select ADMM
    inputBinding:
      position: 103
      prefix: -m
  - id: select_ist
    type:
      - 'null'
      - boolean
    doc: select IST
    inputBinding:
      position: 103
      prefix: -I
  - id: select_primal_dual
    type:
      - 'null'
      - boolean
    doc: select Primal Dual
    inputBinding:
      position: 103
      prefix: -a
  - id: simultaneous_multi_slice_reconstruction
    type:
      - 'null'
      - boolean
    doc: Simultaneous Multi-Slice reconstruction
    inputBinding:
      position: 103
      prefix: -M
  - id: temporal_basis
    type:
      - 'null'
      - File
    doc: temporal (or other) basis
    inputBinding:
      position: 103
      prefix: -B
  - id: truth_file
    type:
      - 'null'
      - File
    doc: (truth file)
    inputBinding:
      position: 103
      prefix: -T
  - id: use_gpu
    type:
      - 'null'
      - boolean
    doc: use GPU
    inputBinding:
      position: 103
      prefix: -g
  - id: warm_start_image
    type:
      - 'null'
      - File
    doc: Warm start with <img>
    inputBinding:
      position: 103
      prefix: -W
outputs:
  - id: output
    type: File
    doc: output image
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

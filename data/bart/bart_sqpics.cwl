cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, sqpics]
requirements:
  - class: InlineJavascriptRequirement
label: bart_sqpics
doc: "Parallel-imaging compressed-sensing reconstruction.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: kspace
    type: File
    doc: kspace
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: sensitivities
    type: File
    doc: sensitivities
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 12
  - id: admm_max_cg_iterations
    type:
      - 'null'
      - int
    doc: ADMM max. CG iterations
    inputBinding:
      position: 1
      prefix: -C
  - id: admm_rho
    type:
      - 'null'
      - float
    doc: ADMM rho
    inputBinding:
      position: 1
      prefix: -u
  - id: debug_level
    type:
      - 'null'
      - int
    doc: Debug level
    inputBinding:
      position: 1
      prefix: -d
  - id: disable_random_wavelet_cycle_spinning
    type:
      - 'null'
      - boolean
    doc: disable random wavelet cycle spinning
    inputBinding:
      position: 1
      prefix: -n
  - id: generalized_regularization
    type:
      - 'null'
      - string
    doc: generalized regularization options (-Rh for help)
    inputBinding:
      position: 1
      prefix: -R
  - id: iteration_stepsize
    type:
      - 'null'
      - float
    doc: iteration stepsize
    inputBinding:
      position: 1
      prefix: -s
  - id: kspace_trajectory
    type:
      - 'null'
      - File
    doc: k-space trajectory
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 1
      prefix: -t
      valueFrom: "$(self === null ? null : self.path.replace(/\\.cfl$/, ''))"
  - id: l1_wavelet
    type:
      - 'null'
      - boolean
    doc: toggle l1-wavelet or l2 regularization.
    inputBinding:
      position: 1
      prefix: -l1
  - id: l2_regularization
    type:
      - 'null'
      - boolean
    doc: toggle l1-wavelet or l2 regularization.
    inputBinding:
      position: 1
      prefix: -l2
  - id: lowrank_block_size
    type:
      - 'null'
      - int
    doc: Lowrank block size
    inputBinding:
      position: 1
      prefix: -b
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: max. number of iterations
    inputBinding:
      position: 1
      prefix: -i
  - id: pattern_or_weights
    type:
      - 'null'
      - File
    doc: pattern or weights
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 1
      prefix: -p
      valueFrom: "$(self === null ? null : self.path.replace(/\\.cfl$/, ''))"
  - id: regularization_parameter
    type:
      - 'null'
      - float
    doc: regularization parameter
    inputBinding:
      position: 1
      prefix: -r
  - id: rescale_image_after_reconstruction
    type:
      - 'null'
      - boolean
    doc: Re-scale the image after reconstruction
    inputBinding:
      position: 1
      prefix: -S
  - id: restrict_fov
    type:
      - 'null'
      - float
    doc: restrict FOV
    inputBinding:
      position: 1
      prefix: -f
  - id: scale_stepsize_based_on_max_eigenvalue
    type:
      - 'null'
      - boolean
    doc: Scale stepsize based on max. eigenvalue
    inputBinding:
      position: 1
      prefix: -e
  - id: scaling_value
    type:
      - 'null'
      - float
    doc: scaling
    inputBinding:
      position: 1
      prefix: -w
  - id: select_admm
    type:
      - 'null'
      - boolean
    doc: Select ADMM
    inputBinding:
      position: 1
      prefix: -m
  - id: truth_file
    type:
      - 'null'
      - File
    doc: (truth file)
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 1
      prefix: -T
      valueFrom: "$(self === null ? null : self.path.replace(/\\.cfl$/, ''))"
  - id: use_gpu
    type:
      - 'null'
      - boolean
    doc: use GPU
    inputBinding:
      position: 1
      prefix: -g
  - id: warm_start_image
    type:
      - 'null'
      - File
    doc: Warm start with <img>
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 1
      prefix: -W
      valueFrom: "$(self === null ? null : self.path.replace(/\\.cfl$/, ''))"
outputs:
  - id: output_file
    type: File
    doc: Array written as output.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

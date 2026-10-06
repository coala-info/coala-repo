cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, traj]
requirements:
  - class: InlineJavascriptRequirement
label: bart_traj
doc: "Computes k-space trajectories.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 10
  - id: d
    type:
      - 'null'
      - boolean
    doc: 3D
    inputBinding:
      position: 1
      prefix: '-3'
  - id: acceleration
    type:
      - 'null'
      - int
    doc: acceleration
    inputBinding:
      position: 1
      prefix: -a
  - id: aligned_partition_angle
    type:
      - 'null'
      - boolean
    doc: aligned partition angle
    inputBinding:
      position: 1
      prefix: -l
  - id: asymmetric_trajectory
    type:
      - 'null'
      - boolean
    doc: Asymmetric trajectory [DC sampled]
    inputBinding:
      position: 1
      prefix: -c
  - id: correct_transverse_gradient_error_radial
    type:
      - 'null'
      - boolean
    doc: correct transverse gradient error for radial tajectories
    inputBinding:
      position: 1
      prefix: -O
  - id: double_base_angle
    type:
      - 'null'
      - boolean
    doc: double base angle
    inputBinding:
      position: 1
      prefix: -D
  - id: golden_angle_partition
    type:
      - 'null'
      - boolean
    doc: golden angle in partition direction
    inputBinding:
      position: 1
      prefix: -g
  - id: golden_ratio_sampling
    type:
      - 'null'
      - boolean
    doc: golden-ratio sampling
    inputBinding:
      position: 1
      prefix: -G
  - id: gradient_delays_xy
    type:
      - 'null'
      - string
    doc: 'gradient delays: x, y, xy'
    inputBinding:
      position: 1
      prefix: -q
  - id: gradient_delays_xz_yz
    type:
      - 'null'
      - string
    doc: '(gradient delays: z, xz, yz)'
    inputBinding:
      position: 1
      prefix: -Q
  - id: halfcircle_golden_ratio_sampling
    type:
      - 'null'
      - boolean
    doc: halfCircle golden-ratio sampling
    inputBinding:
      position: 1
      prefix: -H
  - id: phase_encoding_lines
    type:
      - 'null'
      - int
    doc: phase encoding lines
    inputBinding:
      position: 1
      prefix: -y
  - id: radial
    type:
      - 'null'
      - boolean
    doc: radial
    inputBinding:
      position: 1
      prefix: -r
  - id: readout_samples
    type:
      - 'null'
      - int
    doc: readout samples
    inputBinding:
      position: 1
      prefix: -x
  - id: sms_multiband_factor
    type:
      - 'null'
      - int
    doc: SMS multiband factor
    inputBinding:
      position: 1
      prefix: -m
  - id: turns
    type:
      - 'null'
      - int
    doc: turns
    inputBinding:
      position: 1
      prefix: -t
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

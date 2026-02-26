cwlVersion: v1.2
class: CommandLineTool
baseCommand: traj
label: bart_traj
doc: "Computes k-space trajectories.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 1
  - id: d
    type:
      - 'null'
      - boolean
    doc: 3D
    inputBinding:
      position: 102
      prefix: '-3'
  - id: acceleration
    type:
      - 'null'
      - float
    doc: acceleration
    inputBinding:
      position: 102
      prefix: -a
  - id: aligned_partition_angle
    type:
      - 'null'
      - boolean
    doc: aligned partition angle
    inputBinding:
      position: 102
      prefix: -l
  - id: asymmetric_trajectory
    type:
      - 'null'
      - boolean
    doc: Asymmetric trajectory [DC sampled]
    inputBinding:
      position: 102
      prefix: -c
  - id: correct_transverse_gradient_error_radial
    type:
      - 'null'
      - boolean
    doc: correct transverse gradient error for radial tajectories
    inputBinding:
      position: 102
      prefix: -O
  - id: double_base_angle
    type:
      - 'null'
      - boolean
    doc: double base angle
    inputBinding:
      position: 102
      prefix: -D
  - id: golden_angle_partition
    type:
      - 'null'
      - boolean
    doc: golden angle in partition direction
    inputBinding:
      position: 102
      prefix: -g
  - id: golden_ratio_sampling
    type:
      - 'null'
      - boolean
    doc: golden-ratio sampling
    inputBinding:
      position: 102
      prefix: -G
  - id: gradient_delays_xy
    type:
      - 'null'
      - type: array
        items: string
    doc: 'gradient delays: x, y, xy'
    inputBinding:
      position: 102
      prefix: -q
  - id: gradient_delays_xz_yz
    type:
      - 'null'
      - type: array
        items: string
    doc: '(gradient delays: z, xz, yz)'
    inputBinding:
      position: 102
      prefix: -Q
  - id: halfcircle_golden_ratio_sampling
    type:
      - 'null'
      - boolean
    doc: halfCircle golden-ratio sampling
    inputBinding:
      position: 102
      prefix: -H
  - id: phase_encoding_lines
    type:
      - 'null'
      - float
    doc: phase encoding lines
    inputBinding:
      position: 102
      prefix: -y
  - id: radial
    type:
      - 'null'
      - boolean
    doc: radial
    inputBinding:
      position: 102
      prefix: -r
  - id: readout_samples
    type:
      - 'null'
      - float
    doc: readout samples
    inputBinding:
      position: 102
      prefix: -x
  - id: sms_multiband_factor
    type:
      - 'null'
      - float
    doc: SMS multiband factor
    inputBinding:
      position: 102
      prefix: -m
  - id: turns
    type:
      - 'null'
      - float
    doc: turns
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_traj.out

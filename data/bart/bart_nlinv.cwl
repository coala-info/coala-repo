cwlVersion: v1.2
class: CommandLineTool
baseCommand: nlinv
label: bart_nlinv
doc: "Jointly estimate image and sensitivities with nonlinear inversion using {iter}
  iteration steps. Optionally outputs the sensitivities.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: kspace
    type: string
    doc: kspace
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 2
  - id: sensitivities
    type:
      - 'null'
      - type: array
        items: string
    doc: sensitivities
    inputBinding:
      position: 3
  - id: debug_level
    type:
      - 'null'
      - int
    doc: Debug level
    inputBinding:
      position: 104
      prefix: -d
  - id: fov
    type:
      - 'null'
      - float
    doc: FOV
    inputBinding:
      position: 104
      prefix: -f
  - id: initialization_file
    type:
      - 'null'
      - File
    doc: File for initialization
    inputBinding:
      position: 104
      prefix: -I
  - id: iter
    type:
      - 'null'
      - int
    doc: Number of Newton steps
    inputBinding:
      position: 104
      prefix: -i
  - id: no_combine_enlive_maps
    type:
      - 'null'
      - boolean
    doc: Do not combine ENLIVE maps in output
    inputBinding:
      position: 104
      prefix: -U
  - id: no_normalize_image
    type:
      - 'null'
      - boolean
    doc: Do not normalize image with coil sensitivities
    inputBinding:
      position: 104
      prefix: -N
  - id: num_enlive_maps
    type:
      - 'null'
      - int
    doc: Number of ENLIVE maps to use in reconsctruction
    inputBinding:
      position: 104
      prefix: -m
  - id: psf
    type:
      - 'null'
      - string
    doc: PSF
    inputBinding:
      position: 104
      prefix: -p
  - id: real_value_constraint
    type:
      - 'null'
      - boolean
    doc: Real-value constraint
    inputBinding:
      position: 104
      prefix: -c
  - id: rescale_image
    type:
      - 'null'
      - boolean
    doc: Re-scale image after reconstruction
    inputBinding:
      position: 104
      prefix: -S
  - id: use_gpu
    type:
      - 'null'
      - boolean
    doc: use gpu
    inputBinding:
      position: 104
      prefix: -g
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_nlinv.out

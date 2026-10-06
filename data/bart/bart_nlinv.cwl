cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, nlinv]
requirements:
  - class: InlineJavascriptRequirement
label: bart_nlinv
doc: "Jointly estimate image and sensitivities with nonlinear inversion using {iter}
  iteration steps. Optionally outputs the sensitivities.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: kspace
    type: File
    doc: kspace
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 11
  - id: sensitivities
    type:
      - 'null'
      - string
    doc: sensitivities
    inputBinding:
      position: 12
  - id: debug_level
    type:
      - 'null'
      - int
    doc: Debug level
    inputBinding:
      position: 1
      prefix: -d
  - id: fov
    type:
      - 'null'
      - float
    doc: FOV
    inputBinding:
      position: 1
      prefix: -f
  - id: initialization_file
    type:
      - 'null'
      - File
    doc: File for initialization
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 1
      prefix: -I
      valueFrom: "$(self === null ? null : self.path.replace(/\\.cfl$/, ''))"
  - id: iter
    type:
      - 'null'
      - int
    doc: Number of Newton steps
    inputBinding:
      position: 1
      prefix: -i
  - id: no_combine_enlive_maps
    type:
      - 'null'
      - boolean
    doc: Do not combine ENLIVE maps in output
    inputBinding:
      position: 1
      prefix: -U
  - id: no_normalize_image
    type:
      - 'null'
      - boolean
    doc: Do not normalize image with coil sensitivities
    inputBinding:
      position: 1
      prefix: -N
  - id: num_enlive_maps
    type:
      - 'null'
      - int
    doc: Number of ENLIVE maps to use in reconsctruction
    inputBinding:
      position: 1
      prefix: -m
  - id: psf
    type:
      - 'null'
      - File
    doc: PSF
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 1
      prefix: -p
      valueFrom: "$(self === null ? null : self.path.replace(/\\.cfl$/, ''))"
  - id: real_value_constraint
    type:
      - 'null'
      - boolean
    doc: Real-value constraint
    inputBinding:
      position: 1
      prefix: -c
  - id: rescale_image
    type:
      - 'null'
      - boolean
    doc: Re-scale image after reconstruction
    inputBinding:
      position: 1
      prefix: -S
  - id: use_gpu
    type:
      - 'null'
      - boolean
    doc: use gpu
    inputBinding:
      position: 1
      prefix: -g
outputs:
  - id: output_file
    type: File
    doc: Array written as output.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output).cfl
  - id: sensitivities_file
    type:
      - 'null'
      - File
    doc: Array written as sensitivities.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.sensitivities).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, poisson]
requirements:
  - class: InlineJavascriptRequirement
label: bart_poisson
doc: "Computes Poisson-disc sampling pattern.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: outfile
    type: string
    doc: Output file name
    inputBinding:
      position: 10
  - id: acceleration_dim1
    type:
      - 'null'
      - float
    doc: acceleration dim 1
    inputBinding:
      position: 1
      prefix: -y
  - id: acceleration_dim2
    type:
      - 'null'
      - float
    doc: acceleration dim 2
    inputBinding:
      position: 1
      prefix: -z
  - id: calibration_region_size
    type:
      - 'null'
      - int
    doc: size of calibration region
    inputBinding:
      position: 1
      prefix: -C
  - id: elliptical_scanning
    type:
      - 'null'
      - boolean
    doc: elliptical scanning
    inputBinding:
      position: 1
      prefix: -e
  - id: random_seed
    type:
      - 'null'
      - int
    doc: random seed
    inputBinding:
      position: 1
      prefix: -s
  - id: size_dim1
    type:
      - 'null'
      - int
    doc: size dimension 1
    inputBinding:
      position: 1
      prefix: -Y
  - id: size_dim2
    type:
      - 'null'
      - int
    doc: size dimension 2
    inputBinding:
      position: 1
      prefix: -Z
  - id: variable_density
    type:
      - 'null'
      - boolean
    doc: variable density
    inputBinding:
      position: 1
      prefix: -v
outputs:
  - id: outfile_out
    type: File
    doc: Output file name
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.outfile).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

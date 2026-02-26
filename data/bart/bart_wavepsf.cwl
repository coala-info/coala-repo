cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_wavepsf
label: bart_wavepsf
doc: "Generate a wave PSF in hybrid space.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: output
    type: string
    doc: Output file name
    inputBinding:
      position: 1
  - id: adc_dt
    type:
      - 'null'
      - float
    doc: ADC sampling rate in seconds
    inputBinding:
      position: 102
      prefix: -t
  - id: adc_t
    type:
      - 'null'
      - int
    doc: Readout duration in microseconds.
    inputBinding:
      position: 102
      prefix: -a
  - id: cosine_gradient_wave
    type:
      - 'null'
      - boolean
    doc: Set to use a cosine gradient wave
    inputBinding:
      position: 102
      prefix: -c
  - id: g_max
    type:
      - 'null'
      - float
    doc: Maximum gradient amplitude in Gauss/cm
    inputBinding:
      position: 102
      prefix: -g
  - id: ncyc
    type:
      - 'null'
      - int
    doc: Number of cycles in the gradient wave
    inputBinding:
      position: 102
      prefix: -n
  - id: pe_dim
    type:
      - 'null'
      - int
    doc: Number of phase encode points
    inputBinding:
      position: 102
      prefix: -y
  - id: pe_res
    type:
      - 'null'
      - float
    doc: Resolution of phase encode in cm
    inputBinding:
      position: 102
      prefix: -r
  - id: ro_dim
    type:
      - 'null'
      - int
    doc: Number of readout points
    inputBinding:
      position: 102
      prefix: -x
  - id: s_max
    type:
      - 'null'
      - float
    doc: Maximum gradient slew rate in Gauss/cm/second
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_wavepsf.out

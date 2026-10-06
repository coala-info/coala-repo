cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, wavepsf]
requirements:
  - class: InlineJavascriptRequirement
label: bart_wavepsf
doc: "Generate a wave PSF in hybrid space.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: output
    type: string
    doc: Output file name
    inputBinding:
      position: 10
  - id: adc_dt
    type:
      - 'null'
      - float
    doc: ADC sampling rate in seconds
    inputBinding:
      position: 1
      prefix: -t
  - id: adc_t
    type:
      - 'null'
      - int
    doc: Readout duration in microseconds.
    inputBinding:
      position: 1
      prefix: -a
  - id: cosine_gradient_wave
    type:
      - 'null'
      - boolean
    doc: Set to use a cosine gradient wave
    inputBinding:
      position: 1
      prefix: -c
  - id: g_max
    type:
      - 'null'
      - float
    doc: Maximum gradient amplitude in Gauss/cm
    inputBinding:
      position: 1
      prefix: -g
  - id: ncyc
    type:
      - 'null'
      - int
    doc: Number of cycles in the gradient wave
    inputBinding:
      position: 1
      prefix: -n
  - id: pe_dim
    type:
      - 'null'
      - int
    doc: Number of phase encode points
    inputBinding:
      position: 1
      prefix: -y
  - id: pe_res
    type:
      - 'null'
      - float
    doc: Resolution of phase encode in cm
    inputBinding:
      position: 1
      prefix: -r
  - id: ro_dim
    type:
      - 'null'
      - int
    doc: Number of readout points
    inputBinding:
      position: 1
      prefix: -x
  - id: s_max
    type:
      - 'null'
      - float
    doc: Maximum gradient slew rate in Gauss/cm/second
    inputBinding:
      position: 1
      prefix: -s
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

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmconvert
label: infernal_cmconvert
doc: "convert CM file to a different Infernal format\n\nTool homepage: http://eddylab.org/infernal"
inputs:
  - id: cmfile
    type: File
    doc: 'Covariance model file'
    inputBinding:
      position: 200
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: 'ascii: output models in INFERNAL 1.1 ASCII format [default]'
    inputBinding:
      position: 101
      prefix: -a
  - id: binary
    type:
      - 'null'
      - boolean
    doc: 'binary: output models in INFERNAL 1.1 binary format'
    inputBinding:
      position: 101
      prefix: -b
  - id: v1_ascii
    type:
      - 'null'
      - boolean
    doc: 'output backward compatible Infernal v0.7-->v1.0.2 ASCII format'
    inputBinding:
      position: 101
      prefix: '-1'
  - id: outfile
    type:
      - 'null'
      - string
    doc: 'save CM file to file <f>, not stdout'
    inputBinding:
      position: 101
      prefix: -o
  - id: mlhmm
    type:
      - 'null'
      - boolean
    doc: 'output maximum likelihood HMM for CM in HMMER3 format'
    inputBinding:
      position: 101
      prefix: --mlhmm
  - id: fhmm
    type:
      - 'null'
      - boolean
    doc: 'output filter HMM for CM in HMMER3 format'
    inputBinding:
      position: 101
      prefix: --fhmm
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_outfile
    type:
      - 'null'
      - File
    doc: 'save CM file to file <f>, not stdout'
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
stdout: infernal_cmconvert.out

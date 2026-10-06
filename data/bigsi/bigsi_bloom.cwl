cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bigsi
  - bloom
label: bigsi_bloom
doc: "Creates a bloom filter from a sequence file or cortex graph.\n\nTool homepage:
  https://github.com/Phelimb/BIGSI"
inputs:
  - id: ctx
    type: File
    doc: Cortex graph (.ctx) of the sample (this version reads only ctx files)
    inputBinding:
      position: 1
  - id: outfile
    type: string
    doc: Output name for the bloom filter (written as a folder holding the filter)
    inputBinding:
      position: 2
  - id: config
    type:
      - 'null'
      - File
    doc: BIGSI configuration YAML file (k, m, h, storage engine)
    inputBinding:
      position: 102
      prefix: --config
outputs:
  - id: out_outfile
    type: Directory
    doc: Bloom filter folder (pass it to bigsi build or insert)
    outputBinding:
      glob: '$(inputs.outfile)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigsi:0.3.1--py_0

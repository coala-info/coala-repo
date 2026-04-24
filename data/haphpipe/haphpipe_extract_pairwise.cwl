cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe extract_pairwise
label: haphpipe_extract_pairwise
doc: "Extract pairwise alignment information from a JSON file.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: align_json
    type: File
    doc: JSON file describing alignment (output of pairwise_align stage)
    inputBinding:
      position: 101
      prefix: --align_json
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Print commands but do not run (default: False)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: outfmt
    type:
      - 'null'
      - string
    doc: 'Format for output (default: nuc_fa)'
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: refreg
    type:
      - 'null'
      - string
    doc: Reference region. String format is ref:start-stop. For example, the 
      region string to extract pol when aligned to HXB2 is 
      HIV_B.K03455.HXB2:2085-5096
    inputBinding:
      position: 101
      prefix: --refreg
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file. Default is stdout
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0

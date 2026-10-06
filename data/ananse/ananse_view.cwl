cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ananse
  - view
label: ananse_view
doc: "Explore the contents of an ANANSE binding file.\n\nTool homepage: https://github.com/vanheeringen-lab/ANANSE"
inputs:
  - id: binding
    type: File
    doc: "TF binding prediction file (ANANSE binding output)"
    inputBinding:
      position: 0
  - id: outfile
    type: ['null', string]
    doc: "Output file (tab-separated text, default: stdout)"
    inputBinding:
      position: 1
      prefix: --outfile
  - id: tfs
    type: ['null', {type: array, items: string}]
    doc: "Transcription factor(s) to display (default: all)"
    inputBinding:
      position: 1
      prefix: --tfs
  - id: regions
    type: ['null', {type: array, items: string}]
    doc: "Region(s) to display (default: all)"
    inputBinding:
      position: 1
      prefix: --regions
  - id: format
    type: ['null', {type: enum, symbols: [wide, long]}]
    doc: "Display format: wide (n columns) or long (3 columns) (default: wide)"
    inputBinding:
      position: 1
      prefix: --format
  - id: n
    type: ['null', int]
    doc: "Number of regions and tfs to display (default: all)"
    inputBinding:
      position: 1
      prefix: -n
  - id: list_regions
    type: ['null', boolean]
    doc: "Return a list of regions"
    inputBinding:
      position: 1
      prefix: --list-regions
  - id: list_tfs
    type: ['null', boolean]
    doc: "Return a list of transcription factors"
    inputBinding:
      position: 1
      prefix: --list-tfs
  - id: activity
    type: ['null', boolean]
    doc: "Return activity scores of transcription factors"
    inputBinding:
      position: 1
      prefix: --activity
outputs:
  - id: output_file
    type: ['null', File]
    doc: Output table, when --outfile is given
    outputBinding:
      glob: $(inputs.outfile)
  - id: view_stdout
    type: stdout
    doc: Output table printed to stdout when no --outfile is given
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ananse:0.5.1--pyhdfd78af_0
stdout: ananse_view.tsv

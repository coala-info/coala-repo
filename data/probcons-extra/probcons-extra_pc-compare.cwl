cwlVersion: v1.2
class: CommandLineTool
baseCommand: pc-compare
label: probcons-extra_pc-compare
doc: "Score a test alignment against a reference alignment (sum-of-pairs and column scores); optionally uses a BAliBASE annotation file.\n\nTool homepage: http://probcons.stanford.edu/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: test_alignment
    type: File
    doc: "Test alignment (MFA, MSF or DIALIGN format)"
    inputBinding:
      position: 1
  - id: reference_alignment
    type: File
    doc: "Reference alignment"
    inputBinding:
      position: 2
  - id: balibase_annot_file
    type:
      - 'null'
      - File
    doc: "BAliBASE annotation file (core blocks)"
    inputBinding:
      position: 3
  - id: col
    type:
      - 'null'
      - boolean
    doc: "report column scores"
    inputBinding:
      position: 4
      prefix: -col
  - id: core
    type:
      - 'null'
      - boolean
    doc: "score core blocks only"
    inputBinding:
      position: 4
      prefix: -core
  - id: caps
    type:
      - 'null'
      - boolean
    doc: "use capitalised residues as the core blocks"
    inputBinding:
      position: 4
      prefix: -caps
  - id: annot_path
    type:
      - 'null'
      - string
    doc: "write annotation to FILENAME"
    inputBinding:
      position: 4
      prefix: -annot
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: annot
    type:
      - 'null'
      - File
    doc: annotation scores
    outputBinding:
      glob: $(inputs.annot_path)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/probcons-extra:v1.12-12-deb_cv1
stdout: probcons-extra_pc-compare.out

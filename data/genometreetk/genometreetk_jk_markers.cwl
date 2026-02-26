cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometreetk jk_markers
label: genometreetk_jk_markers
doc: "Jackknife marker genes.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: input_tree
    type: File
    doc: tree inferred from original data
    inputBinding:
      position: 1
  - id: msa_file
    type: File
    doc: file containing multiple sequence alignment
    inputBinding:
      position: 2
  - id: marker_info_file
    type: File
    doc: file indicating length of each gene in concatenated alignment
    inputBinding:
      position: 3
  - id: mask_file
    type: File
    doc: file indicating masking of multiple sequence alignment
    inputBinding:
      position: 4
  - id: output_dir
    type: Directory
    doc: output directory)
    inputBinding:
      position: 5
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of cpus
    default: 1
    inputBinding:
      position: 106
      prefix: --cpus
  - id: jk_dir
    type:
      - 'null'
      - Directory
    doc: directory containing pre-computed jackknife trees (must have '.tree' or
      '.tre' extension)
    inputBinding:
      position: 106
      prefix: --jk_dir
  - id: model
    type:
      - 'null'
      - string
    doc: model of evolution to use
    default: wag
    inputBinding:
      position: 106
      prefix: --model
  - id: num_replicates
    type:
      - 'null'
      - int
    doc: number of jackknife replicates to perform
    default: 100
    inputBinding:
      position: 106
      prefix: --num_replicates
  - id: perc_markers
    type:
      - 'null'
      - float
    doc: percentage of markers to keep
    default: 0.5
    inputBinding:
      position: 106
      prefix: --perc_markers
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 106
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
stdout: genometreetk_jk_markers.out

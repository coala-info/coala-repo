cwlVersion: v1.2
class: CommandLineTool
baseCommand: makmdm
label: spaln_makmdm
doc: "makmdm: make the mutation-data matrices (mdm) used by spaln for amino acid substitution scoring.\n\nTool homepage: https://github.com/ogotoh/spaln"
inputs:
  - id: no_compositions
    type:
      - 'null'
      - boolean
    doc: "Suppress output of average compositions"
    inputBinding:
      position: 10
      prefix: -c-
      separate: false
  - id: no_mdm_matrix
    type:
      - 'null'
      - boolean
    doc: "Suppress output of mdm matrix"
    inputBinding:
      position: 10
      prefix: -m-
      separate: false
  - id: lu_decomposition
    type:
      - 'null'
      - boolean
    doc: "Output LU-decomposited matrix"
    inputBinding:
      position: 10
      prefix: -l
      separate: false
  - id: power_matrices
    type:
      - 'null'
      - boolean
    doc: "Output power matrices"
    inputBinding:
      position: 10
      prefix: -p
      separate: false
  - id: series_78
    type:
      - 'null'
      - boolean
    doc: "Use the 78 series (-f78)"
    inputBinding:
      position: 10
      prefix: -f78
      separate: false
  - id: series_91
    type:
      - 'null'
      - boolean
    doc: "Use the 91 series (-f91)"
    inputBinding:
      position: 10
      prefix: -f91
      separate: false
  - id: blosum_series
    type:
      - 'null'
      - boolean
    doc: "Brosum series"
    inputBinding:
      position: 10
      prefix: -b
      separate: false
  - id: vt_series
    type:
      - 'null'
      - boolean
    doc: "VT series"
    inputBinding:
      position: 10
      prefix: -v
      separate: false
  - id: destpath
    type:
      - 'null'
      - string
    doc: "Folder where the files are written (created by the wrapper); default is the current directory"
    inputBinding:
      position: 200
outputs:
  - id: matrix_files
    type:
      type: array
      items: File
    doc: Substitution matrix files written by makmdm
    outputBinding:
      glob: "$(inputs.destpath ? inputs.destpath + '/*' : '*')"
  - id: stdout
    type: stdout
    doc: Progress output (PAM series)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.destpath || '.unused_destpath')
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
stdout: spaln_makmdm.out

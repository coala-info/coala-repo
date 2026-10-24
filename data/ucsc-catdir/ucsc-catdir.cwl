cwlVersion: v1.2
class: CommandLineTool
baseCommand: catDir
label: ucsc-catdir
doc: "Concatenate files in directory to stdout.\nFor those times when too many files for cat to handle.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: directories
    type:
      type: array
      items: Directory
    doc: "Directories to concatenate"
    inputBinding:
      position: 1
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: "Recurse into subdirectories"
    inputBinding:
      position: 101
      prefix: -r
  - id: suffix
    type:
      - 'null'
      - string
    doc: "Restrict things to files ending in this suffix (e.g. .txt)"
    inputBinding:
      position: 101
      prefix: -suffix=
      separate: false
  - id: wild
    type:
      - 'null'
      - string
    doc: "Match wildcards (e.g. *.???)"
    inputBinding:
      position: 101
      prefix: -wild=
      separate: false
  - id: nonz
    type:
      - 'null'
      - boolean
    doc: "Prints file name of non-zero length files"
    inputBinding:
      position: 101
      prefix: -nonz
outputs:
  - id: stdout
    type: stdout
    doc: "Concatenated files"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-catdir:482--h0b57e2e_0
stdout: ucsc-catdir.out

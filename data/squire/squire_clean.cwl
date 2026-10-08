cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- squire
- Clean
label: squire_clean
doc: 'Filter the repeatmasker annotation into a clean BED file of transposable elements for the chosen repeat classes, families or subfamilies.


  Tool homepage: https://github.com/wyang17/SQuIRE'
inputs:
- id: rmsk
  type:
  - 'null'
  - File
  doc: Repeatmasker file (optional; will search 'squire_fetch' folder for rmsk.txt or .out file by default)
  inputBinding:
    position: 1
    prefix: --rmsk
- id: build
  type:
  - 'null'
  - string
  doc: UCSC designation for genome build, eg. 'hg37' (optional; will be basename of rmsk.txt file by default)
  inputBinding:
    position: 1
    prefix: --build
- id: fetch_folder
  type:
  - 'null'
  - Directory
  doc: Destination folder for downloaded UCSC file(s) (optional; default='squire_fetch')
  inputBinding:
    position: 1
    prefix: --fetch_folder
- id: clean_folder
  type: string
  doc: Destination folder for output BED file (optional; default = 'squire_clean')
  inputBinding:
    position: 1
    prefix: --clean_folder
  default: squire_clean
- id: repclass
  type:
  - 'null'
  - string
  doc: Comma-separated list of desired repeat class/classes, aka superfamily, eg DNA, LTR. Column 12 in repeatmasker file. Can use UNIX wildcard patterns. (optional; default=False)
  inputBinding:
    position: 1
    prefix: --repclass
- id: family
  type:
  - 'null'
  - string
  doc: Comma-separated list of desired repeat family/families, eg 'ERV1,ERVK,ERVL. Column 13 in repeatmasker file. Can use UNIX wildcard patterns. (optional; default=False)
  inputBinding:
    position: 1
    prefix: --family
- id: subfamily
  type:
  - 'null'
  - string
  doc: Comma-separated list of desired repeat subfamilies, eg 'L1HS,AluYb'. Column 11 in repeatmasker file. Can use UNIX wildcard patterns. (optional; default=False)
  inputBinding:
    position: 1
    prefix: --subfamily
- id: extra
  type:
  - 'null'
  - File
  doc: Filepath of extra file containing non-reference repeat sequences. Columns should be chr, start, stop, strand, subfamily, and sequence (optional)
  inputBinding:
    position: 1
    prefix: --extra
- id: verbosity
  type:
  - 'null'
  - boolean
  doc: Want messages and runtime printed to stderr (optional; default=False)
  inputBinding:
    position: 1
    prefix: --verbosity
outputs:
- id: clean_folder_result
  type: Directory
  doc: Destination folder for output BED file (optional; default = 'squire_clean')
  outputBinding:
    glob: $(inputs.clean_folder)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1

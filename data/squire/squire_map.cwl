cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- squire
- Map
label: squire_map
doc: 'Align RNA-seq reads to the genome with STAR, keeping multi-mapping reads for transposable element quantification.


  Tool homepage: https://github.com/wyang17/SQuIRE'
inputs:
- id: read1
  type:
    type: array
    items: File
  doc: RNASeq data fastq file(s); read1 if providing paired end data. If more than one file, separate with commas, no spaces. Can be gzipped.
  inputBinding:
    position: 1
    prefix: --read1
    itemSeparator: ','
- id: read2
  type:
  - 'null'
  - type: array
    items: File
  doc: RNASeq data read2 fastq file(s). if more than one file, separate with commas, no spaces. Can be gzipped. (optional, can skip or enter 'False' if data is unpaired)
  inputBinding:
    position: 1
    prefix: --read2
    itemSeparator: ','
- id: map_folder
  type: string
  doc: Location of SQuIRE Map outputs (optional, default = 'squire_map')
  inputBinding:
    position: 1
    prefix: --map_folder
  default: squire_map
- id: fetch_folder
  type:
  - 'null'
  - Directory
  doc: Folder location of outputs from SQuIRE Fetch (optional, default = 'squire_fetch'
  inputBinding:
    position: 1
    prefix: --fetch_folder
- id: read_length
  type: int
  doc: Read length (if trim3 selected, after trimming; required).
  inputBinding:
    position: 1
    prefix: --read_length
- id: name
  type:
  - 'null'
  - string
  doc: Common basename for input files (optional; uses basename of read1 as default)
  inputBinding:
    position: 1
    prefix: --name
- id: trim3
  type:
  - 'null'
  - int
  doc: Trim <int> bases from right end of each read before alignment (optional; default=0).
  inputBinding:
    position: 1
    prefix: --trim3
- id: extra
  type:
  - 'null'
  - File
  doc: Filepath of text file containing non-reference repeat sequence and genome information
  inputBinding:
    position: 1
    prefix: --extra
- id: build
  type:
  - 'null'
  - string
  doc: UCSC designation for genome build, eg. 'hg38' (required if more than 1 build in clean_folder)
  inputBinding:
    position: 1
    prefix: --build
- id: pthreads
  type:
  - 'null'
  - int
  doc: Launch <int> parallel threads(optional; default='1')
  inputBinding:
    position: 1
    prefix: --pthreads
- id: verbosity
  type:
  - 'null'
  - boolean
  doc: Want messages and runtime printed to stderr (optional; default=False)
  inputBinding:
    position: 1
    prefix: --verbosity
outputs:
- id: map_folder_result
  type: Directory
  doc: Location of SQuIRE Map outputs (optional, default = 'squire_map')
  outputBinding:
    glob: $(inputs.map_folder)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- squire
- Count
label: squire_count
doc: 'Quantify transposable element expression from the aligned reads (EM-based assignment of multi-mapping reads).


  Tool homepage: https://github.com/wyang17/SQuIRE'
inputs:
- id: map_folder
  type:
  - 'null'
  - Directory
  doc: Folder location of outputs from SQuIRE Map (optional, default = 'squire_map')
  inputBinding:
    position: 1
    prefix: --map_folder
- id: clean_folder
  type:
  - 'null'
  - Directory
  doc: Folder location of outputs from SQuIRE Clean (optional, default = 'squire_clean')
  inputBinding:
    position: 1
    prefix: --clean_folder
- id: count_folder
  type: string
  doc: Destination folder for output files(optional, default = 'squire_count')
  inputBinding:
    position: 1
    prefix: --count_folder
  default: squire_count
- id: tempfolder
  type:
  - 'null'
  - string
  doc: Folder for tempfiles (optional; default=count_folder')
  inputBinding:
    position: 1
    prefix: --tempfolder
- id: fetch_folder
  type:
  - 'null'
  - Directory
  doc: Folder location of outputs from SQuIRE Fetch (optional, default = 'squire_fetch)'
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
  doc: Common basename for input files (required if more than one bam file in map_folder)
  inputBinding:
    position: 1
    prefix: --name
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
- id: strandedness
  type:
  - 'null'
  - int
  doc: '''0'' if unstranded eg Standard Illumina, 1 if first- strand eg Illumina Truseq, dUTP, NSR, NNSR, 2 if second-strand, eg Ligation, Standard SOLiD (optional,default=0)'
  inputBinding:
    position: 1
    prefix: --strandedness
- id: EM
  type:
  - 'null'
  - int
  doc: Run estimation-maximization on TE counts given number of times (optional, specify 0 if no EM desired; default=auto)
  inputBinding:
    position: 1
    prefix: --EM
- id: verbosity
  type:
  - 'null'
  - boolean
  doc: Want messages and runtime printed to stderr (optional; default=False)
  inputBinding:
    position: 1
    prefix: --verbosity
outputs:
- id: count_folder_result
  type: Directory
  doc: Destination folder for output files(optional, default = 'squire_count')
  outputBinding:
    glob: $(inputs.count_folder)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.map_folder)
    writable: true

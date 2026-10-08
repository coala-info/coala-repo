cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- squire
- Draw
label: squire_draw
doc: 'Draw RPM-normalized bedgraph tracks of the aligned reads for visualisation.


  Tool homepage: https://github.com/wyang17/SQuIRE'
inputs:
- id: fetch_folder
  type:
  - 'null'
  - Directory
  doc: Folder location of outputs from SQuIRE Fetch (optional, default = 'squire_fetch')
  inputBinding:
    position: 1
    prefix: --fetch_folder
- id: map_folder
  type:
  - 'null'
  - Directory
  doc: Folder location of outputs from SQuIRE Map (optional, default = 'squire_map')
  inputBinding:
    position: 1
    prefix: --map_folder
- id: draw_folder
  type: string
  doc: Destination folder for output files (optional; default='squire_draw')
  inputBinding:
    position: 1
    prefix: --draw_folder
  default: squire_draw
- id: name
  type:
  - 'null'
  - string
  doc: Basename for bam file (required if more than one bam file in map_folder)
  inputBinding:
    position: 1
    prefix: --name
- id: strandedness
  type:
  - 'null'
  - int
  doc: '''0'' if unstranded, 1 if first-strand eg Illumina Truseq, dUTP, NSR, NNSR, 2 if second-strand, eg Ligation, Standard (optional,default=1)'
  inputBinding:
    position: 1
    prefix: --strandedness
- id: build
  type: string
  doc: UCSC designation for genome build, eg. 'hg38' (required)
  inputBinding:
    position: 1
    prefix: --build
- id: normlib
  type:
  - 'null'
  - boolean
  doc: Normalize bedgraphs by library size (optional; default=False)
  inputBinding:
    position: 1
    prefix: --normlib
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
- id: draw_folder_result
  type: Directory
  doc: Destination folder for output files (optional; default='squire_draw')
  outputBinding:
    glob: $(inputs.draw_folder)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1

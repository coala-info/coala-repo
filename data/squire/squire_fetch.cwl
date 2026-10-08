cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- squire
- Fetch
label: squire_fetch
doc: 'Download genome files (chromosome fasta, repeatmasker annotation, gene annotation) from UCSC and optionally build a STAR index.


  Tool homepage: https://github.com/wyang17/SQuIRE'
inputs:
- id: build
  type: string
  doc: UCSC designation for genome build, eg. 'hg37' (required)
  inputBinding:
    position: 1
    prefix: --build
- id: fetch_folder
  type: string
  doc: Destination folder for downloaded UCSC file(s) (optional; default='squire_fetch')
  inputBinding:
    position: 1
    prefix: --fetch_folder
  default: squire_fetch
- id: fasta
  type:
  - 'null'
  - boolean
  doc: Download chromosome fasta files for build chromosomes (optional; default=False)
  inputBinding:
    position: 1
    prefix: --fasta
- id: chrom_info
  type:
  - 'null'
  - boolean
  doc: Download chrom_info.txt file with lengths of each chromosome (optional; default=False)
  inputBinding:
    position: 1
    prefix: --chrom_info
- id: rmsk
  type:
  - 'null'
  - boolean
  doc: Download Repeatmasker file (optional; default=False)
  inputBinding:
    position: 1
    prefix: --rmsk
- id: gene
  type:
  - 'null'
  - boolean
  doc: Download UCSC gene annotation(optional; default=False)
  inputBinding:
    position: 1
    prefix: --gene
- id: index
  type:
  - 'null'
  - boolean
  doc: Create STAR index, WARNING will take a lot of time and memory (optional; default=False)
  inputBinding:
    position: 1
    prefix: --index
- id: pthreads
  type:
  - 'null'
  - int
  doc: Launch <int> parallel threads(optional; default='1')
  inputBinding:
    position: 1
    prefix: --pthreads
- id: keep
  type:
  - 'null'
  - boolean
  doc: Keep downloaded compressed files (optional; default=False)
  inputBinding:
    position: 1
    prefix: --keep
- id: verbosity
  type:
  - 'null'
  - boolean
  doc: Want messages and runtime printed to stderr (optional; default=False)
  inputBinding:
    position: 1
    prefix: --verbosity
outputs:
- id: fetch_folder_result
  type: Directory
  doc: Destination folder for downloaded UCSC file(s) (optional; default='squire_fetch')
  outputBinding:
    glob: $(inputs.fetch_folder)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
requirements:
- class: NetworkAccess
  networkAccess: true

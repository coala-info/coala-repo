cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmga
label: pmga
doc: "Serotyping, serotyping and MLST of all Neisseria species and Haemophilus influenzae\n\
  \nTool homepage: https://github.com/CDCgov/BMGAP"
inputs:
  - id: fasta
    type: File
    doc: Input FASTA file to analyze
    inputBinding:
      position: 1
  - id: blastdir
    type:
      - 'null'
      - Directory
    doc: Directory containing BLAST DBs built by pmga-build
    inputBinding:
      position: 102
      prefix: --blastdir
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite existing output file
    inputBinding:
      position: 102
      prefix: --force
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to output results to
    inputBinding:
      position: 102
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for outputs
    inputBinding:
      position: 102
      prefix: --prefix
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed.
    inputBinding:
      position: 102
      prefix: --silent
  - id: species
    type:
      - 'null'
      - string
    doc: 'Use this as the input species (Default: use Mash distance). Available Choices:
      neisseria, hinfluenzae'
    inputBinding:
      position: 102
      prefix: --species
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of cores to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print debug related text.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmga:3.0.2--hdfd78af_0
stdout: pmga.out

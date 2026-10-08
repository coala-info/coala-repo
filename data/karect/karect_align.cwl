cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - karect
  - -align
label: karect_align
doc: "Align original assembly reads to a reference genome as pre-processing for evaluation of read correction.\n\nTool homepage: https://github.com/aminallam/karect"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: matchtype
    type: string
    doc: 'Matching type: edit, hamming or insdel. hamming allows substitution errors only; edit allows insertions, deletions and substitutions with equal costs; insdel doubles the substitution cost.'
    inputBinding:
      position: 1
      prefix: -matchtype=
      separate: false
  - id: inputfile
    type:
      type: array
      items: File
      inputBinding:
        prefix: -inputfile=
        separate: false
    doc: Input fasta/fastq file(s); each is passed with its own -inputfile.
    inputBinding:
      position: 1
  - id: refgenomefile
    type: File
    doc: File containing the reference genome (to be aligned with).
    inputBinding:
      position: 1
      prefix: -refgenomefile=
      separate: false
  - id: alignfile
    type: string
    doc: Output alignment file.
    inputBinding:
      position: 1
      prefix: -alignfile=
      separate: false
  - id: inputdir
    type:
      - 'null'
      - string
    doc: Input directory. Ignored if input file paths are complete [Default=.].
    inputBinding:
      position: 1
      prefix: -inputdir=
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads [Default=16].
    inputBinding:
      position: 1
      prefix: -threads=
      separate: false
  - id: circular
    type:
      - 'null'
      - int
    doc: Sequence size to be appended circularly (for circular genomes) [Default=0].
    inputBinding:
      position: 1
      prefix: -circular=
      separate: false
  - id: accuracy
    type:
      - 'null'
      - int
    doc: Alignment accuracy [Default=5].
    inputBinding:
      position: 1
      prefix: -accuracy=
      separate: false
  - id: readsperstep
    type:
      - 'null'
      - int
    doc: Maximum number of processed reads per step [Default=1000].
    inputBinding:
      position: 1
      prefix: -readsperstep=
      separate: false
outputs:
  - id: alignment
    type: File
    doc: Alignment file.
    outputBinding:
      glob: $(inputs.alignfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/karect:1.0--h9948957_9

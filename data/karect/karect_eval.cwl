cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - karect
  - -eval
label: karect_eval
doc: "Evaluate assembly read correction against a reference genome.\n\nTool homepage: https://github.com/aminallam/karect"
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
    doc: Original input fasta/fastq file(s); each is passed with its own -inputfile.
    inputBinding:
      position: 1
  - id: resultfile
    type:
      type: array
      items: File
      inputBinding:
        prefix: -resultfile=
        separate: false
    doc: Corrected fasta/fastq file(s) from karect -correct or another correction tool; each is passed with its own -resultfile.
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
    type: File
    doc: Alignment file from karect -align.
    inputBinding:
      position: 1
      prefix: -alignfile=
      separate: false
  - id: evalfile
    type: string
    doc: Output evaluation file.
    inputBinding:
      position: 1
      prefix: -evalfile=
      separate: false
  - id: inputdir
    type:
      - 'null'
      - string
    doc: Input files directory. Ignored if file paths are complete [Default=.].
    inputBinding:
      position: 1
      prefix: -inputdir=
      separate: false
  - id: resultdir
    type:
      - 'null'
      - string
    doc: Result files directory. Ignored if file paths are complete [Default=.].
    inputBinding:
      position: 1
      prefix: -resultdir=
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
  - id: readsperstep
    type:
      - 'null'
      - int
    doc: Maximum number of processed reads per step [Default=1000].
    inputBinding:
      position: 1
      prefix: -readsperstep=
      separate: false
  - id: trim
    type:
      - 'null'
      - string
    doc: 'Allow/Disallow trimming: yes or no. Allow it if -trim=yes was used for correction (experimental) [Default=no].'
    inputBinding:
      position: 1
      prefix: -trim=
      separate: false
outputs:
  - id: evaluation
    type: File
    doc: Evaluation report.
    outputBinding:
      glob: $(inputs.evalfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/karect:1.0--h9948957_9

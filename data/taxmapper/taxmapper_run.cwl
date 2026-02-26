cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxmapper_run
label: taxmapper_run
doc: "Run Taxmapper\n\nTool homepage: https://bitbucket.org/dbeisser/taxmapper"
inputs:
  - id: database
    type: string
    doc: Database path for RAPseach database index
    inputBinding:
      position: 101
      prefix: --database
  - id: folder
    type: Directory
    doc: Folder with reads in fasta or fastq format
    inputBinding:
      position: 101
      prefix: --folder
  - id: length
    type: int
    doc: Maximum read length
    inputBinding:
      position: 101
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reads also contain reverse read
    default: true
    inputBinding:
      position: 101
      prefix: --reverse
  - id: suffix
    type:
      - 'null'
      - string
    doc: Suffix of paired end reads
    default: _R1,_R2
    inputBinding:
      position: 101
      prefix: --suffix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxmapper:1.0.2--py36_0

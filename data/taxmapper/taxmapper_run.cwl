cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxmapper
  - run
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
      - string
    doc: Reads also contain reverse read
    inputBinding:
      position: 101
      prefix: --reverse
  - id: suffix
    type:
      - 'null'
      - string
    doc: Suffix of paired end reads
    inputBinding:
      position: 101
      prefix: --suffix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxmapper:1.0.2--py36_0

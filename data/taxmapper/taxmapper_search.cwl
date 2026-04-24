cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxmapper_search
label: taxmapper_search
doc: "Search for taxonomic assignments using RAPSearch.\n\nTool homepage: https://bitbucket.org/dbeisser/taxmapper"
inputs:
  - id: database
    type: Directory
    doc: Path to RAPSearch database index
    inputBinding:
      position: 101
      prefix: --database
  - id: forward_file
    type: File
    doc: Forward reads in fasta or fastq format
    inputBinding:
      position: 101
      prefix: --forward
  - id: output
    type:
      - 'null'
      - string
    doc: Basename for output files
    inputBinding:
      position: 101
      prefix: --out
  - id: rapsearch
    type:
      - 'null'
      - string
    doc: Rapsearch path, version >=2.24
    inputBinding:
      position: 101
      prefix: --rapsearch
  - id: reverse_file
    type:
      - 'null'
      - File
    doc: Reads in fasta or fastq format [optional]
    inputBinding:
      position: 101
      prefix: --reverse
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxmapper:1.0.2--py36_0
stdout: taxmapper_search.out

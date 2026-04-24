cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsort
label: gsort
doc: "Sorts genomic interval files.\n\nTool homepage: https://github.com/brentp/gsort"
inputs:
  - id: path
    type:
      - 'null'
      - File
    doc: a tab-delimited file to sort
    inputBinding:
      position: 1
  - id: genome
    type:
      - 'null'
      - File
    doc: a genome file of chromosome sizes and order
    inputBinding:
      position: 2
  - id: chromosome_mappings
    type:
      - 'null'
      - File
    doc: a file used to re-map chromosome names for example from hg19 to GRCh37
    inputBinding:
      position: 103
      prefix: --chromosomemappings
  - id: memory
    type:
      - 'null'
      - int
    doc: megabytes of memory to use before writing to temp files.
    inputBinding:
      position: 103
      prefix: --memory
  - id: parent
    type:
      - 'null'
      - boolean
    doc: for gff only. given rows with same chrom and start put those with a 
      'Parent' attribute first
    inputBinding:
      position: 103
      prefix: --parent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsort:0.1.5--he881be0_0
stdout: gsort.out

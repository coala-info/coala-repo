cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gofasta
  - closest
label: gofasta_closest
doc: "Find the closest sequence(s) to a query by genetic distance\n\nTool homepage:
  https://github.com/cov-ert/gofasta"
inputs:
  - id: max_dist
    type:
      - 'null'
      - string
    doc: (Optional) return all sequences less than or equal to this distance 
      away
    inputBinding:
      position: 101
      prefix: --max-dist
  - id: measure
    type:
      - 'null'
      - string
    doc: Which distance measure to use (raw, snp or tn93)
    default: raw
    inputBinding:
      position: 101
      prefix: --measure
  - id: number
    type:
      - 'null'
      - int
    doc: (Optional) the closest n sequences to each query will be returned
    inputBinding:
      position: 101
      prefix: --number
  - id: query
    type: File
    doc: Alignment of sequences to find neighbours for, in fasta format
    inputBinding:
      position: 101
      prefix: --query
  - id: table
    type:
      - 'null'
      - boolean
    doc: Write a long-form table of the output
    inputBinding:
      position: 101
      prefix: --table
  - id: target
    type: File
    doc: Alignment of sequences to search for neighbours in, in fasta format
    inputBinding:
      position: 101
      prefix: --target
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPUs to use (Default: all available CPUs)'
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: The output file to write (default "stdout")
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0

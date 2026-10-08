cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - meryl-import
label: meryl_import
doc: "Load the kmers and values listed in a text file ('AGTTGCC 4' per line) into a meryl kmer database.\n\nTool homepage: https://github.com/marbl/meryl"
inputs:
  - id: kmer_size
    type: int
    doc: "The size of a kmer, in bases (-k)"
    inputBinding:
      position: 1
      prefix: -k
  - id: kmers
    type: File
    doc: "A file of kmers and values, one per line, separated by white space (-kmers)"
    inputBinding:
      position: 2
      prefix: -kmers
  - id: output
    type: string
    doc: "Name of the meryl database to create (-output db.meryl)"
    inputBinding:
      position: 3
      prefix: -output
  - id: multiset
    type:
      - 'null'
      - boolean
    doc: "Write duplicate kmers in the input as individual entries instead of summing their values (-multiset)"
    inputBinding:
      position: 4
      prefix: -multiset
  - id: maxvalue
    type:
      - 'null'
      - int
    doc: "Optional memory and time optimization: the maximum value in the input (-maxvalue)"
    inputBinding:
      position: 5
      prefix: -maxvalue
  - id: forward
    type:
      - 'null'
      - boolean
    doc: "Load the forward kmer instead of the canonical kmer (-forward)"
    inputBinding:
      position: 6
      prefix: -forward
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: "Load the reverse-complement kmer instead of the canonical kmer (-reverse)"
    inputBinding:
      position: 7
      prefix: -reverse
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of compute threads used when sorting and writing data (-threads)"
    inputBinding:
      position: 8
      prefix: -threads
  - id: memory
    type:
      - 'null'
      - int
    doc: "Accepted but not implemented by the program (-memory)"
    inputBinding:
      position: 9
      prefix: -memory
outputs:
  - id: meryl_database
    type: Directory
    doc: "The new meryl database"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 2048
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meryl:1.4.1--h9948957_2

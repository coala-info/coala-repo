cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - meryl-simple
label: meryl_simple
doc: "Count kmers in a FASTA file with the simple in-memory counter and write a meryl database, a text dump and a histogram.\n\nTool homepage: https://github.com/marbl/meryl"
inputs:
  - id: kmer_size
    type: int
    doc: "Size of the kmer (-k kmerSize)"
    inputBinding:
      position: 1
      prefix: -k
  - id: input_fasta
    type: File
    doc: "Input sequences (-S input.fasta)"
    inputBinding:
      position: 2
      prefix: -S
  - id: output_meryl
    type:
      - 'null'
      - string
    doc: "Name of the output meryl database (-M output.meryl)"
    inputBinding:
      position: 3
      prefix: -M
  - id: output_dump
    type:
      - 'null'
      - string
    doc: "Name of the output text dump of kmers and counts (-D output.dump)"
    inputBinding:
      position: 4
      prefix: -D
  - id: output_histogram
    type:
      - 'null'
      - string
    doc: "Name of the output histogram file (-H output.histogram)"
    inputBinding:
      position: 5
      prefix: -H
  - id: memory_limit
    type:
      - 'null'
      - int
    doc: "Memory limit in MB (-m memLimit_in_MB)"
    inputBinding:
      position: 6
      prefix: -m
outputs:
  - id: meryl_database
    type:
      - 'null'
      - Directory
    doc: "Meryl database written with -M"
    outputBinding:
      glob: $(inputs.output_meryl)
  - id: dump
    type:
      - 'null'
      - File
    doc: "Text dump of kmers and counts written with -D"
    outputBinding:
      glob: $(inputs.output_dump)
  - id: histogram
    type:
      - 'null'
      - File
    doc: "Histogram written with -H"
    outputBinding:
      glob: $(inputs.output_histogram)
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 2048
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meryl:1.4.1--h9948957_2

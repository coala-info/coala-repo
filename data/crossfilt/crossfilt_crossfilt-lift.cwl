cwlVersion: v1.2
class: CommandLineTool
baseCommand: crossfilt-lift
label: crossfilt_crossfilt-lift
doc: "Converts genome coordinates and nucleotide sequence for othologous segments
  in a BAM file\n\nTool homepage: https://github.com/kennethabarr/CrossFilt"
inputs:
  - id: best
    type:
      - 'null'
      - boolean
    doc: Only attempt to lift using the best chain
    inputBinding:
      position: 101
      prefix: --best
  - id: chain
    type: File
    doc: The UCSC chain file
    inputBinding:
      position: 101
      prefix: --chain
  - id: input
    type: File
    doc: The input BAM file to convert
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: Name prefix for the output file
    inputBinding:
      position: 101
      prefix: --output
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Add this flag if the reads are paired
    inputBinding:
      position: 101
      prefix: --paired
  - id: query_fasta
    type: File
    doc: The genomic sequence of the query (the species we are converting to)
    inputBinding:
      position: 101
      prefix: --query-fasta
  - id: target_fasta
    type: File
    doc: The genomic sequence of the target (the species we are converting from)
    inputBinding:
      position: 101
      prefix: --target-fasta
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossfilt:0.2.1--pyhdfd78af_0
stdout: crossfilt_crossfilt-lift.out

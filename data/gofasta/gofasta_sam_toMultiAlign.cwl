cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gofasta
  - sam
  - toMultiAlign
label: gofasta_sam_toMultiAlign
doc: "Convert a SAM file to a multiple alignment in fasta format

Tool homepage: https://github.com/virus-evolution/gofasta"
inputs:
  - id: reference
    type: File
    doc: "Reference fasta file used to generate the sam file"
    inputBinding:
      position: 101
      prefix: --reference
  - id: samfile
    type: File
    doc: "Samfile to read. If none is specified, will read from stdin"
    inputBinding:
      position: 101
      prefix: --samfile
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use"
    inputBinding:
      position: 101
      prefix: --threads
  - id: start
    type:
      - 'null'
      - int
    doc: "1-based first nucleotide position to retain in the output. Bases before this position are omitted, or are replaced with N if --pad"
    inputBinding:
      position: 101
      prefix: --start
  - id: end
    type:
      - 'null'
      - int
    doc: "1-based last nucleotide position to retain the in output. Bases after this position are omitted, or are replaced with N if --pad"
    inputBinding:
      position: 101
      prefix: --end
  - id: pad
    type:
      - 'null'
      - boolean
    doc: "If --start and/or --end, replace the trimmed-out regions with Ns, else replace external deletions with Ns"
    inputBinding:
      position: 101
      prefix: --pad
  - id: wrap
    type:
      - 'null'
      - int
    doc: "Wrap the output alignment to this number of nucleotides wide. Omit this option not to wrap the output."
    inputBinding:
      position: 101
      prefix: --wrap
  - id: fasta_out
    type:
      - 'null'
      - string
    doc: "Where to write the alignment (default stdout)"
    inputBinding:
      position: 102
      prefix: --fasta-out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: alignment
    type:
      - 'null'
      - File
    doc: "Alignment written with fasta_out"
    outputBinding:
      glob: "$(inputs.fasta_out ? inputs.fasta_out : 'no_alignment_file')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
stdout: gofasta_sam_toMultiAlign.out

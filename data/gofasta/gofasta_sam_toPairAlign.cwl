cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gofasta
  - sam
  - toPairAlign
label: gofasta_sam_toPairAlign
doc: "Convert a SAM file to pairwise alignments in fasta format

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
  - id: omit_reference
    type:
      - 'null'
      - boolean
    doc: "Omit the reference sequences from the output alignments"
    inputBinding:
      position: 101
      prefix: --omit-reference
  - id: skip_insertions
    type:
      - 'null'
      - boolean
    doc: "Skip insertions relative to the reference from the output alignments"
    inputBinding:
      position: 101
      prefix: --skip-insertions
  - id: start
    type:
      - 'null'
      - int
    doc: "1-based first nucleotide position (in reference coordinates) to retain in the output. Bases before this position are omitted"
    inputBinding:
      position: 101
      prefix: --start
  - id: end
    type:
      - 'null'
      - int
    doc: "1-based last nucleotide position (in reference coordinates) to retain in the output. Bases after this position are omitted"
    inputBinding:
      position: 101
      prefix: --end
  - id: wrap
    type:
      - 'null'
      - int
    doc: "Wrap the output alignment to this number of nucleotides wide. Omit this option not to wrap the output."
    inputBinding:
      position: 101
      prefix: --wrap
  - id: outpath
    type: string
    doc: "Output path (directory) where fasta files will be written"
    inputBinding:
      position: 102
      prefix: --outpath
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: alignments
    type:
      - 'null'
      - Directory
    doc: "Directory with one pairwise alignment fasta file per sequence"
    outputBinding:
      glob: $(inputs.outpath)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
stdout: gofasta_sam_toPairAlign.out

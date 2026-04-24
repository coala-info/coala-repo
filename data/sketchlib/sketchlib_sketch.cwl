cwlVersion: v1.2
class: CommandLineTool
baseCommand: sketchlib sketch
label: sketchlib_sketch
doc: "Create sketches from input data\n\nTool homepage: https://github.com/bacpop/sketchlib.rust"
inputs:
  - id: seq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of input FASTA files
    inputBinding:
      position: 1
  - id: concat_fasta
    type:
      - 'null'
      - boolean
    doc: Treat every sequence in an input file as a new sample (aa only)
    inputBinding:
      position: 102
      prefix: --concat-fasta
  - id: file_list
    type:
      - 'null'
      - File
    doc: File listing input files (tab separated name, sequences, see README)
    inputBinding:
      position: 102
      prefix: -f
  - id: k_seq
    type:
      - 'null'
      - string
    doc: K-mer linear sequence (start,end,step)
    inputBinding:
      position: 102
      prefix: --k-seq
  - id: k_vals
    type:
      - 'null'
      - string
    doc: K-mer list (comma separated k-mer values to sketch at)
    inputBinding:
      position: 102
      prefix: --k-vals
  - id: level
    type:
      - 'null'
      - string
    doc: aaHash 'level'
    inputBinding:
      position: 102
      prefix: --level
  - id: min_count
    type:
      - 'null'
      - int
    doc: Minimum k-mer count (with reads)
    inputBinding:
      position: 102
      prefix: --min-count
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Minimum k-mer quality (with reads)
    inputBinding:
      position: 102
      prefix: --min-qual
  - id: output
    type: string
    doc: Output prefix
    inputBinding:
      position: 102
      prefix: -o
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't show any messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: seq_type
    type:
      - 'null'
      - string
    doc: Type of sequence to hash
    inputBinding:
      position: 102
      prefix: --seq-type
  - id: single_strand
    type:
      - 'null'
      - boolean
    doc: Ignore reverse complement (all contigs are oriented along same strand)
    inputBinding:
      position: 102
      prefix: --single-strand
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Sketch size
    inputBinding:
      position: 102
      prefix: --sketch-size
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show progress messages
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
stdout: sketchlib_sketch.out

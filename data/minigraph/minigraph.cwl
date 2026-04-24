cwlVersion: v1.2
class: CommandLineTool
baseCommand: minigraph
label: minigraph
doc: "Proof-of-concept bidirected graph aligner and graph constructor\n\nTool homepage:
  https://github.com/lh3/minigraph"
inputs:
  - id: target_file
    type: File
    doc: Target graph (.gfa) or sequence file (.fa/.fasta)
    inputBinding:
      position: 1
  - id: query_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Query sequence file(s) (.fa/.fasta)
    inputBinding:
      position: 2
  - id: call_variants
    type:
      - 'null'
      - boolean
    doc: Generate the graph by calling variants
    inputBinding:
      position: 103
      prefix: -c
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer length
    inputBinding:
      position: 103
      prefix: -k
  - id: min_match_len
    type:
      - 'null'
      - int
    doc: Minimum chaining score
    inputBinding:
      position: 103
      prefix: -m
  - id: preset
    type:
      - 'null'
      - string
    doc: 'Preset: lr (long-read), sr (short-read), or asm (assembly mapping)'
    inputBinding:
      position: 103
      prefix: -x
  - id: show_version
    type:
      - 'null'
      - boolean
    doc: Print version number
    inputBinding:
      position: 103
      prefix: -V
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 103
      prefix: -t
  - id: window_size
    type:
      - 'null'
      - int
    doc: Minimizer window size
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minigraph:0.21--h577a1d6_3

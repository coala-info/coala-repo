cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-filter-rgfa
label: dsh-bio_filter-rgfa
doc: "Filter rGFA graphs.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: fragment_count
    type:
      - 'null'
      - int
    doc: filter segments and links by fragment count
    inputBinding:
      position: 101
      prefix: --fragment-count
  - id: input_rgfa_path
    type:
      - 'null'
      - File
    doc: input rGFA path, default stdin
    inputBinding:
      position: 101
      prefix: --input-rgfa-path
  - id: invalid_segment_references
    type:
      - 'null'
      - boolean
    doc: filter containments, links, and paths that reference missing segments
    inputBinding:
      position: 101
      prefix: --invalid-segment-references
  - id: kmer_count
    type:
      - 'null'
      - int
    doc: filter segments and links by k-mer count
    inputBinding:
      position: 101
      prefix: --kmer-count
  - id: length
    type:
      - 'null'
      - int
    doc: filter segments by length
    inputBinding:
      position: 101
      prefix: --length
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: filter links by mapping quality
    inputBinding:
      position: 101
      prefix: --mapping-quality
  - id: mismatch_count
    type:
      - 'null'
      - int
    doc: filter links by mismatch count
    inputBinding:
      position: 101
      prefix: --mismatch-count
  - id: read_count
    type:
      - 'null'
      - int
    doc: filter segments and links by read count
    inputBinding:
      position: 101
      prefix: --read-count
  - id: script
    type:
      - 'null'
      - string
    doc: filter by script, eval against r
    inputBinding:
      position: 101
      prefix: --script
outputs:
  - id: output_rgfa_file
    type:
      - 'null'
      - File
    doc: output rGFA file, default stdout
    outputBinding:
      glob: $(inputs.output_rgfa_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0

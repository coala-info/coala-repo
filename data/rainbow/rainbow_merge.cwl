cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rainbow
  - merge
label: rainbow_merge
doc: "Merges divided clusters into contigs, optionally assembling them; one line per\
  \ cluster.\n\nTool homepage: https://sourceforge.net/projects/bio-rainbow/"
inputs:
  - id: input_file
    type: File
    doc: Input rbasm output file
    inputBinding:
      position: 101
      prefix: -i
  - id: assemble
    type:
      - 'null'
      - boolean
    doc: output assembly
    inputBinding:
      position: 101
      prefix: -a
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file for merged contigs, one line per cluster [stdout]
    inputBinding:
      position: 101
      prefix: -o
  - id: max_divided_clusters
    type:
      - 'null'
      - int
    doc: Maximum number of divided clusters to merge [300]
    inputBinding:
      position: 101
      prefix: -N
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap when assemble two reads (valid only when '-a' is opened)
      [5]
    inputBinding:
      position: 101
      prefix: -l
  - id: min_similarity
    type:
      - 'null'
      - float
    doc: Minimum fraction of similarity when assembly (valid only when '-a' is opened)
      [0.90]
    inputBinding:
      position: 101
      prefix: -f
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads to assemble (valid only when '-a' is opened) [5]
    inputBinding:
      position: 101
      prefix: -r
  - id: max_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads to assemble (valid only when '-a' is opened) [300]
    inputBinding:
      position: 101
      prefix: -R
outputs:
  - id: stdout
    type: stdout
    doc: Merged contigs (when -o is not used)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rainbow:2.0.4--pl5321h7b50bb2_11
stdout: rainbow_merge.out

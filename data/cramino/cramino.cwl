cwlVersion: v1.2
class: CommandLineTool
baseCommand: cramino
label: cramino
doc: "Tool to extract QC metrics from cram or bam\n\nTool homepage: https://github.com/wdecoster/cramino"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: cram or bam file to check
    default: '-'
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (text, json, or tsv)
    default: text
    inputBinding:
      position: 102
      prefix: --format
  - id: karyotype
    type:
      - 'null'
      - boolean
    doc: Provide normalized number of reads per chromosome
    inputBinding:
      position: 102
      prefix: --karyotype
  - id: min_read_len
    type:
      - 'null'
      - int
    doc: Minimal length of read to be considered
    default: 0
    inputBinding:
      position: 102
      prefix: --min-read-len
  - id: phased
    type:
      - 'null'
      - boolean
    doc: Calculate metrics for phased reads
    inputBinding:
      position: 102
      prefix: --phased
  - id: reference
    type:
      - 'null'
      - File
    doc: reference for decompressing cram
    inputBinding:
      position: 102
      prefix: --reference
  - id: scaled
    type:
      - 'null'
      - boolean
    doc: Scale histogram bins by total basepairs in each bin (not just read count)
    inputBinding:
      position: 102
      prefix: --scaled
  - id: spliced
    type:
      - 'null'
      - boolean
    doc: Provide metrics for spliced data
    inputBinding:
      position: 102
      prefix: --spliced
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel decompression threads to use
    default: 4
    inputBinding:
      position: 102
      prefix: --threads
  - id: ubam
    type:
      - 'null'
      - boolean
    doc: Provide metrics for unaligned reads
    inputBinding:
      position: 102
      prefix: --ubam
outputs:
  - id: hist
    type:
      - 'null'
      - File
    doc: If histograms have to be generated (optionally specify output file)
    outputBinding:
      glob: $(inputs.hist)
  - id: arrow
    type:
      - 'null'
      - File
    doc: Write data to an arrow format file
    outputBinding:
      glob: $(inputs.arrow)
  - id: hist_count
    type:
      - 'null'
      - File
    doc: Output histogram bin counts in TSV format (optionally specify output file)
    outputBinding:
      glob: $(inputs.hist_count)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cramino:1.3.0--h3dc2dae_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - fastq
  - deduplicate
label: capcruncher_fastq_deduplicate
doc: "Identifies PCR duplicate fragments from Fastq files. PCR duplicates are very commonly present in Capture-C/Tri-C/Tiled-C data and must be removed for accurate analysis.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: fastq1
    type:
      type: array
      items: File
    doc: "Read 1 FASTQ files"
    inputBinding:
      position: 2
      prefix: '-1'
  - id: fastq2
    type:
      type: array
      items: File
    doc: "Read 2 FASTQ files"
    inputBinding:
      position: 2
      prefix: '-2'
  - id: output_prefix
    type: string
    default: deduped
    doc: "Output prefix for deduplicated FASTQ files"
    inputBinding:
      position: 2
      prefix: -o
  - id: sample_name
    type:
      - 'null'
      - string
    doc: "Name of sample e.g. DOX_treated_1"
    inputBinding:
      position: 2
      prefix: --sample-name
  - id: statistics
    type: string
    default: stats.csv
    doc: "Statistics output file name"
    inputBinding:
      position: 2
      prefix: -s
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: "Shuffle reads before deduplication"
    inputBinding:
      position: 2
      prefix: --shuffle
outputs:
  - id: deduplicated_fastq
    type:
      type: array
      items: File
    doc: "Deduplicated FASTQ files"
    outputBinding:
      glob: $(inputs.output_prefix)*.fastq*
  - id: statistics_file
    type:
      - 'null'
      - File
    doc: "Deduplication statistics"
    outputBinding:
      glob: $(inputs.statistics)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1

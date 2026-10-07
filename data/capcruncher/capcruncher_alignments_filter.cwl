cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - alignments
  - filter
label: capcruncher_alignments_filter
doc: "Removes unwanted aligned slices and identifies reporters. Parses a BAM file and merges this with a supplied annotation to identify unwanted slices. Filtering can be tuned for Capture-C, Tri-C and Tiled-C data.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: mode
    type: string
    doc: "Assay type: capture, tri or tiled"
    inputBinding:
      position: 1
  - id: bam
    type: File
    doc: "Bam file to process"
    inputBinding:
      position: 2
      prefix: -b
  - id: annotations
    type: File
    doc: "Annotations for the bam file that must contain the required columns"
    inputBinding:
      position: 2
      prefix: -a
  - id: custom_filtering
    type:
      - 'null'
      - File
    doc: "Custom filtering to be used. This must be supplied as a path to a yaml file."
    inputBinding:
      position: 2
      prefix: --custom-filtering
  - id: output_prefix
    type: string
    default: reporters
    doc: "Output prefix for the filtered slices"
    inputBinding:
      position: 2
      prefix: -o
  - id: statistics
    type:
      - 'null'
      - string
    doc: "Output path for stats file"
    inputBinding:
      position: 2
      prefix: --statistics
  - id: sample_name
    type:
      - 'null'
      - string
    doc: "Name of sample e.g. DOX_treated_1"
    inputBinding:
      position: 2
      prefix: --sample-name
  - id: read_type
    type:
      - 'null'
      - string
    doc: "Type of read (flashed or pe)"
    inputBinding:
      position: 2
      prefix: --read-type
  - id: fragments
    type:
      - 'null'
      - boolean
    doc: "Produce read fragment aggregations"
    inputBinding:
      position: 2
      prefix: --fragments
  - id: no_fragments
    type:
      - 'null'
      - boolean
    doc: "Do not produce read fragment aggregations"
    inputBinding:
      position: 2
      prefix: --no-fragments
outputs:
  - id: filtered
    type:
      type: array
      items: File
    doc: "Filtered slices and fragments (parquet) and statistics"
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1

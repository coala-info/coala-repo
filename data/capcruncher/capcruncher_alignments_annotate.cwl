cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - alignments
  - annotate
label: capcruncher_alignments_annotate
doc: "Annotates a bed file with other bed files using bedtools intersect. Interval names and counts can be used to annotate intervals at the same time; duplicate entries/multimapping reads are removed first.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: slices
    type: File
    doc: "Slices to annotate (BAM or bed file)"
    inputBinding:
      position: 1
  - id: actions
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -a
    doc: "Determines if the overlaps are counted (count) or if the name should just be reported (get); one per bed file"
    inputBinding:
      position: 2
  - id: bed_files
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -b
    doc: "Bed file(s) to intersect with slices"
    inputBinding:
      position: 2
  - id: names
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -n
    doc: "Names to use as column names for the output tsv file; one per bed file"
    inputBinding:
      position: 2
  - id: overlap_fractions
    type:
      - 'null'
      - type: array
        items: float
        inputBinding:
          prefix: -f
    doc: "The minimum overlap required for an intersection between two intervals to be reported; one per bed file"
    inputBinding:
      position: 2
  - id: dtypes
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -t
    doc: "Data type for column; one per bed file"
    inputBinding:
      position: 2
  - id: output
    type: string
    default: annotated.slices.parquet
    doc: "Path for the annotated slices to be output."
    inputBinding:
      position: 2
      prefix: -o
  - id: duplicates
    type:
      - 'null'
      - string
    doc: "Method to use for reconciling duplicate slices (i.e. multimapping). Currently only 'remove' is supported."
    inputBinding:
      position: 2
      prefix: --duplicates
  - id: n_cores
    type:
      - 'null'
      - int
    doc: "Intersections are performed in parallel, set this to the number of intersections required"
    inputBinding:
      position: 2
      prefix: -p
  - id: invalid_bed_action
    type:
      - 'null'
      - string
    doc: "Method to deal with invalid bed files (ignore or error)"
    inputBinding:
      position: 2
      prefix: --invalid_bed_action
  - id: blacklist
    type:
      - 'null'
      - File
    doc: "Regions to remove from the BAM file prior to annotation"
    inputBinding:
      position: 2
      prefix: --blacklist
  - id: prioritize_cis_slices
    type:
      - 'null'
      - boolean
    doc: "Attempts to prevent slices on the most common chromosome in a fragment (ideally cis to the viewpoint) being removed by deduplication"
    inputBinding:
      position: 2
      prefix: --prioritize-cis-slices
  - id: priority_chroms
    type:
      - 'null'
      - string
    doc: "A comma separated list of chromosomes to prioritize during deduplication"
    inputBinding:
      position: 2
      prefix: --priority-chroms
outputs:
  - id: annotated_slices
    type: File
    doc: "Annotated slices (parquet)"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1

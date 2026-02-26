cwlVersion: v1.2
class: CommandLineTool
baseCommand: transit_gumbel
label: transit_gumbel
doc: "Runs the Gumbel model for transcript analysis.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: wig_files
    type:
      type: array
      items: File
    doc: Comma-separated .wig files
    inputBinding:
      position: 1
  - id: annotation_file
    type: File
    doc: Annotation .prot_table or GFF3 file
    inputBinding:
      position: 2
  - id: burn_in_samples
    type:
      - 'null'
      - int
    doc: Number of Burn-in samples.
    default: 500
    inputBinding:
      position: 103
      prefix: -b
  - id: ignore_c_terminus_percentage
    type:
      - 'null'
      - float
    doc: Ignore TAs occuring within given percentage (as integer) of the C 
      terminus.
    default: 0.0
    inputBinding:
      position: 103
      prefix: -iC
  - id: ignore_n_terminus_percentage
    type:
      - 'null'
      - float
    doc: Ignore TAs occuring within given percentage (as integer) of the N 
      terminus.
    default: 0.0
    inputBinding:
      position: 103
      prefix: -iN
  - id: min_read_count
    type:
      - 'null'
      - int
    doc: Smallest read-count to consider.
    default: 1
    inputBinding:
      position: 103
      prefix: -m
  - id: num_samples
    type:
      - 'null'
      - int
    doc: Number of samples.
    default: 10000
    inputBinding:
      position: 103
      prefix: -s
  - id: replicates_handling
    type:
      - 'null'
      - string
    doc: How to handle replicates. Sum or Mean.
    default: Sum
    inputBinding:
      position: 103
      prefix: -r
  - id: trim_interval
    type:
      - 'null'
      - int
    doc: Trims all but every t-th value.
    default: 1
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0

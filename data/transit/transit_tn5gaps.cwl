cwlVersion: v1.2
class: CommandLineTool
baseCommand: transit_tn5gaps
label: transit_tn5gaps
doc: "Identify transposon insertion sites and their genomic context.\n\nTool homepage:
  http://github.com/mad-lab/transit"
inputs:
  - id: wig_files
    type:
      type: array
      items: File
    doc: Comma-separated .wig files containing read counts.
    inputBinding:
      position: 1
  - id: annotation_file
    type: File
    doc: Annotation file (.prot_table or GFF3).
    inputBinding:
      position: 2
  - id: ignore_c_terminus_percentage
    type:
      - 'null'
      - float
    doc: Ignore TAs occurring within given percentage of the C terminus.
    inputBinding:
      position: 103
      prefix: -iC
  - id: ignore_n_terminus_percentage
    type:
      - 'null'
      - float
    doc: Ignore TAs occurring within given percentage of the N terminus.
    inputBinding:
      position: 103
      prefix: -iN
  - id: min_read_count
    type:
      - 'null'
      - int
    doc: Smallest read-count to consider.
    inputBinding:
      position: 103
      prefix: -m
  - id: replicates_handling
    type:
      - 'null'
      - string
    doc: How to handle replicates. Sum or Mean.
    inputBinding:
      position: 103
      prefix: -r
outputs:
  - id: output_file
    type: File
    doc: Output file for results.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0

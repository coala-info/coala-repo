cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python3
  - /usr/local/bin/transit
  - hmm
label: transit_hmm
doc: "Transit1 v3.3.20\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: wig_files
    type:
      type: array
      items: File
    doc: comma-separated .wig files
    inputBinding:
      position: 1
  - id: annotation_file
    type: File
    doc: .prot_table or GFF3 annotation file
    inputBinding:
      position: 2
  - id: output_base_filename
    type: string
    doc: 'output BASE filename (will create 2 output files: BASE.sites.txt and BASE.genes.txt)'
    inputBinding:
      position: 3
  - id: ignore_c_terminus_percentage
    type:
      - 'null'
      - float
    doc: Ignore TAs occuring within given percentage (as integer) of the C 
      terminus.
    default: 0.0
    inputBinding:
      position: 104
      prefix: -iC
  - id: ignore_n_terminus_percentage
    type:
      - 'null'
      - float
    doc: Ignore TAs occuring within given percentage (as integer) of the N 
      terminus.
    default: 0.0
    inputBinding:
      position: 104
      prefix: -iN
  - id: normalization_method
    type:
      - 'null'
      - string
    doc: Normalization method.
    default: TTR
    inputBinding:
      position: 104
      prefix: -n
  - id: perform_loess_correction
    type:
      - 'null'
      - boolean
    doc: Perform LOESS Correction; Helps remove possible genomic position bias.
    default: false
    inputBinding:
      position: 104
      prefix: -l
  - id: replicates_handling
    type:
      - 'null'
      - string
    doc: How to handle replicates. Sum, Mean.
    default: Mean
    inputBinding:
      position: 104
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
stdout: transit_hmm.out

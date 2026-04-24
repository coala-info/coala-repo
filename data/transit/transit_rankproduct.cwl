cwlVersion: v1.2
class: CommandLineTool
baseCommand: transit_rankproduct
label: transit_rankproduct
doc: "Performs rank product analysis for differential gene expression between control
  and experimental samples.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: control_files
    type:
      type: array
      items: File
    doc: Comma-separated list of .wig control files
    inputBinding:
      position: 1
  - id: experimental_files
    type:
      type: array
      items: File
    doc: Comma-separated list of .wig experimental files
    inputBinding:
      position: 2
  - id: annotation_file
    type: File
    doc: Annotation file (.prot_table or GFF3)
    inputBinding:
      position: 3
  - id: adaptive_rankproduct
    type:
      - 'null'
      - boolean
    doc: Perform adaptive rankproduct
    inputBinding:
      position: 104
      prefix: -a
  - id: ignore_c_terminus_fraction
    type:
      - 'null'
      - float
    doc: Ignore TAs occurring at given fraction of the C terminus
    inputBinding:
      position: 104
      prefix: -iC
  - id: ignore_n_terminus_fraction
    type:
      - 'null'
      - float
    doc: Ignore TAs occurring at given fraction of the N terminus
    inputBinding:
      position: 104
      prefix: -iN
  - id: loess_correction
    type:
      - 'null'
      - boolean
    doc: Perform LOESS Correction; Helps remove possible genomic position bias
    inputBinding:
      position: 104
      prefix: -l
  - id: normalization_method
    type:
      - 'null'
      - string
    doc: Normalization method
    inputBinding:
      position: 104
      prefix: -n
  - id: num_samples
    type:
      - 'null'
      - int
    doc: Number of samples for permutation
    inputBinding:
      position: 104
      prefix: -s
  - id: output_histogram
    type:
      - 'null'
      - boolean
    doc: Output histogram of the permutations for each gene
    inputBinding:
      position: 104
      prefix: -h
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0

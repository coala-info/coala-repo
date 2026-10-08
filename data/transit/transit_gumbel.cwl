cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - gumbel
label: transit_gumbel
doc: "Bayesian method that estimates the posterior probability of essentiality of each gene from TnSeq data (Gumbel model).\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: wig_files
    type: File[]
    doc: "Comma-separated .wig files"
    inputBinding:
      position: 1
      itemSeparator: ','
  - id: annotation_file
    type: File
    doc: "Annotation .prot_table or GFF3 file"
    inputBinding:
      position: 2
  - id: output_filename
    type: string
    doc: "Output file name"
    inputBinding:
      position: 3
  - id: num_samples
    type: ['null', int]
    doc: "Number of samples. Default: 10000"
    inputBinding:
      position: 20
      prefix: -s
  - id: burn_in_samples
    type: ['null', int]
    doc: "Number of Burn-in samples. Default: 500"
    inputBinding:
      position: 20
      prefix: -b
  - id: min_read_count
    type: ['null', int]
    doc: "Smallest read-count to consider. Default: 1"
    inputBinding:
      position: 20
      prefix: -m
  - id: trim_interval
    type: ['null', int]
    doc: "Trims all but every t-th value. Default: 1"
    inputBinding:
      position: 20
      prefix: -t
  - id: replicates_handling
    type: ['null', string]
    doc: "How to handle replicates. Sum or Mean. Default: Sum"
    inputBinding:
      position: 20
      prefix: -r
  - id: ignore_n_terminus_percentage
    type: ['null', float]
    doc: "Ignore TAs occuring within given percentage (as integer) of the N terminus. Default: 0"
    inputBinding:
      position: 20
      prefix: -iN
  - id: ignore_c_terminus_percentage
    type: ['null', float]
    doc: "Ignore TAs occuring within given percentage (as integer) of the C terminus. Default: 0"
    inputBinding:
      position: 20
      prefix: -iC
outputs:
  - id: output_file
    type: File
    doc: "Output file"
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0

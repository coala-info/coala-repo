cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - griffin
label: transit_griffin
doc: "Method of Griffin et al. that scores genes by the length of the longest run of TA sites without insertions.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: wig_files
    type: File[]
    doc: "Comma-separated .wig files"
    inputBinding:
      position: 1
      itemSeparator: ','
  - id: annotation_file
    type: File
    doc: "Annotation .prot_table file"
    inputBinding:
      position: 2
  - id: output_filename
    type: string
    doc: "Output file name"
    inputBinding:
      position: 3
  - id: min_read_count
    type: ['null', int]
    doc: "Smallest read-count to consider. Default: 1"
    inputBinding:
      position: 20
      prefix: -m
  - id: replicates_handling
    type: ['null', string]
    doc: "How to handle replicates. Sum or Mean. Default: Sum"
    inputBinding:
      position: 20
      prefix: -r
  - id: include_stop_codon
    type: ['null', boolean]
    doc: "Include stop-codon (default is to ignore)."
    inputBinding:
      position: 20
      prefix: -sC
  - id: ignore_n_terminus_fraction
    type: ['null', float]
    doc: "Ignore TAs occuring at given fraction (as integer) of the N terminus. Default: 0"
    inputBinding:
      position: 20
      prefix: -iN
  - id: ignore_c_terminus_fraction
    type: ['null', float]
    doc: "Ignore TAs occuring at given fraction (as integer) of the C terminus. Default: 0"
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

cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann_expand_cluster
label: humann_humann_expand_cluster
doc: "HUMAnN utility for expanding clustered table features. Given a table of UniRef90 values and a specific UniRef90, create a table subset that includes all of the UniRef90s that cluster with the selected UniRef90 in a UniRef50 set.\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann"
inputs:
  - id: input
    type: File
    doc: "UniRef90 gene families table (tsv format)"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: gene
    type: string
    doc: "Gene family (UniRef90) of interest"
    inputBinding:
      position: 102
      prefix: "--gene"
  - id: output_path
    type: string
    doc: "Path for modified output table (tsv format)"
    inputBinding:
      position: 103
      prefix: "--output"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Write status information"
    inputBinding:
      position: 104
      prefix: "--verbose"
outputs:
  - id: output
    type: File
    doc: "table subset with the clustered UniRef90s"
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0

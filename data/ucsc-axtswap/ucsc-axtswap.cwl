cwlVersion: v1.2
class: CommandLineTool
baseCommand: axtSwap
label: ucsc-axtswap
doc: "Swap source and query in an axt file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_axt
    type: File
    doc: Input axt file to be swapped.
    inputBinding:
      position: 1
  - id: target_sizes
    type: File
    doc: Chromosome sizes file (name and size, tab separated) of the target sequences
    inputBinding:
      position: 2
  - id: query_sizes
    type: File
    doc: Chromosome sizes file (name and size, tab separated) of the query sequences
    inputBinding:
      position: 3
  - id: output_path
    type: string
    doc: Name of the output axt file with target and query swapped.
    inputBinding:
      position: 4
outputs:
  - id: output_axt
    type: File
    doc: Output axt file with target and query swapped.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axtswap:482--h0b57e2e_0

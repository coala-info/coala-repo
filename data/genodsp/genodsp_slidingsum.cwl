cwlVersion: v1.2
class: CommandLineTool
baseCommand: genodsp_slidingsum
label: genodsp_slidingsum
doc: "Calculates the sum of values within sliding windows along a genome.\n\nTool
  homepage: https://github.com/rsharris/genodsp"
inputs:
  - id: chromosome_lengths
    type:
      type: array
      items: string
    doc: Chromosome lengths in the format 'chromosome:length' or 
      'chromosome:start:end'. Multiple entries can be provided.
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input file containing genomic data.
    inputBinding:
      position: 2
  - id: step_size
    type: int
    doc: The step size for the sliding window.
    inputBinding:
      position: 103
      prefix: --step-size
  - id: window_size
    type: int
    doc: The size of the sliding window.
    inputBinding:
      position: 103
      prefix: --window-size
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write the results.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genodsp:0.0.10--h7b50bb2_1

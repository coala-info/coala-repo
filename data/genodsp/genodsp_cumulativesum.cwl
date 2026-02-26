cwlVersion: v1.2
class: CommandLineTool
baseCommand: genodsp_cumulativesum
label: genodsp_cumulativesum
doc: "Calculates the cumulative sum of values across a genome, potentially considering
  chromosome lengths and regions.\n\nTool homepage: https://github.com/rsharris/genodsp"
inputs:
  - id: chromosome_lengths
    type:
      type: array
      items: string
    doc: Chromosome lengths in the format 'chromosome:length' or 
      'chromosome:start:end'. This argument is missing in the provided help 
      text, leading to an error.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genodsp:0.0.10--h7b50bb2_1
stdout: genodsp_cumulativesum.out

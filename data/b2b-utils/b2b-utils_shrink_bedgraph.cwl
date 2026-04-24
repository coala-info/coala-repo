cwlVersion: v1.2
class: CommandLineTool
baseCommand: shrink_bedgraph
label: b2b-utils_shrink_bedgraph
doc: "reduce resolution/size of bedgraph files\n\nTool homepage: https://github.com/jvolkening/b2b-utils"
inputs:
  - id: fasta
    type: File
    doc: Path to the input FASTA file corresponding to the input bedgraph
    inputBinding:
      position: 101
      prefix: --fa
  - id: in_bedgraph
    type: File
    doc: Path to the input bedgraph file
    inputBinding:
      position: 101
      prefix: --bg
  - id: n_bins
    type:
      - 'null'
      - int
    doc: Number of bins into which to divide each contig
    inputBinding:
      position: 101
      prefix: --n_bins
  - id: operation
    type:
      - 'null'
      - string
    doc: Summarization operation to apply to each bin. This is passed through 
      directly to the *bedtools map* call.
    inputBinding:
      position: 101
      prefix: --operation
outputs:
  - id: out_bedgraph
    type: File
    doc: Path to which to write the output bedgraph file
    outputBinding:
      glob: $(inputs.out_bedgraph)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/b2b-utils:0.020--pl5321h9ee0642_0

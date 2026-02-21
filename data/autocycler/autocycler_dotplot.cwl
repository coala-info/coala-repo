cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - autocycler
  - dotplot
label: autocycler_dotplot
doc: "generate an all-vs-all dotplot from a unitig graph\n\nTool homepage: https://github.com/rrwick/Autocycler"
inputs:
  - id: input
    type: File
    doc: Input Autocycler GFA file, FASTA file or directory (required)
    inputBinding:
      position: 101
      prefix: --input
  - id: kmer
    type:
      - 'null'
      - int
    doc: K-mer size to use in dotplot
    default: 32
    inputBinding:
      position: 101
      prefix: --kmer
  - id: res
    type:
      - 'null'
      - int
    doc: Size (in pixels) of dotplot image
    default: 2000
    inputBinding:
      position: 101
      prefix: --res
outputs:
  - id: out_png
    type: File
    doc: File path where dotplot PNG will be saved (required)
    outputBinding:
      glob: $(inputs.out_png)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0

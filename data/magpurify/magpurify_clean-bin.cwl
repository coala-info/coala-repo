cwlVersion: v1.2
class: CommandLineTool
baseCommand: magpurify clean-bin
label: magpurify_clean-bin
doc: "Remove putative contaminant contigs from bin.\n\nTool homepage: https://github.com/snayfach/MAGpurify"
inputs:
  - id: fna
    type: File
    doc: Path to input genome in FASTA format
    inputBinding:
      position: 1
  - id: out
    type: Directory
    doc: Output directory to store results and intermediate files
    inputBinding:
      position: 2
outputs:
  - id: out_fna
    type: File
    doc: Path to the output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2

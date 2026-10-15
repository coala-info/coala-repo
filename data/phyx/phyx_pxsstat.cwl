cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxsstat]
label: phyx_pxsstat
doc: |-
  Calculates multinomial alignment test statistics.
  Currently only calculates the test statistic from Bollback (2002) MBE.
  This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: seq_file
    type: File
    doc: "input seq file"
    inputBinding:
      prefix: -s
  - id: out_file_path
    type: string
    doc: "output file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "test statistic"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5

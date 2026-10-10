cwlVersion: v1.2
class: CommandLineTool
baseCommand: pair2tb
label: multiz_pair2tb
doc: "pair2tb: convert a pairwise MAF file to a threaded blockset. The pairwise alignment must be single coverage in both sequences. Usage: pair2tb pairwise.maf seqfile1 seqfile2. The result goes to standard output.\n\nTool homepage: http://www.bx.psu.edu/miller_lab/"
inputs:
  - id: pairwise_maf
    type: File
    doc: Pairwise MAF file
    inputBinding:
      position: 1
  - id: seqfile1
    type: File
    doc: Sequence file of the first species
    inputBinding:
      position: 2
  - id: seqfile2
    type: File
    doc: Sequence file of the second species
    inputBinding:
      position: 3
outputs:
  - id: blockset
    type: stdout
    doc: Threaded blockset in MAF format (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--hec16e2b_3
stdout: pair2tb.maf

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - simucns
label: maq_simucns
doc: "Simulate consensus sequences from true SNPs.\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: input_cns
    type: File
    doc: Input consensus sequence file.
    inputBinding:
      position: 1
  - id: input_true_snp
    type: File
    doc: Input true SNP file.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_simucns.out

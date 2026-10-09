cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - subpos
label: maq_subpos
doc: "Extract a subset of positions\n\nTool homepage: http://maq.sourceforge.net/"
inputs:
  - id: input_cns
    type: File
    doc: Input .cns file
    inputBinding:
      position: 1
  - id: snp_file
    type: File
    doc: SNP position file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_subpos.out

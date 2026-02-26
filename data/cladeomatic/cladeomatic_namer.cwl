cwlVersion: v1.2
class: CommandLineTool
baseCommand: cladeomatic
label: cladeomatic_namer
doc: "Clade-O-Matic: Genotyping scheme genotype namer v. 0.1.1\n\nTool homepage: https://github.com/phac-nml/cladeomatic"
inputs:
  - id: in_names
    type: File
    doc: Tab delimited file of (node, name)
    default: None
    inputBinding:
      position: 101
      prefix: --in_names
  - id: in_scheme
    type: File
    doc: Cladeomatic scheme file
    default: None
    inputBinding:
      position: 101
      prefix: --in_scheme
outputs:
  - id: outfile
    type: File
    doc: Output file for updated scheme
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cladeomatic:0.1.1--pyhdfd78af_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: accusnv
label: accusnv
doc: "AccuSNV is a tool for calling single nucleotide variants (SNVs) from sequencing
  data. (Note: The provided text contains container build logs and error messages
  rather than help documentation; therefore, no arguments could be extracted.)\n\n
  Tool homepage: https://github.com/liaoherui/AccuSNV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/accusnv:1.0.0.5--pyhdfd78af_0
stdout: accusnv.out

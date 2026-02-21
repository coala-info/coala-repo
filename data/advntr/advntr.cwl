cwlVersion: v1.2
class: CommandLineTool
baseCommand: advntr
label: advntr
doc: "adVNTR is a tool for genotyping Variable Number Tandem Repeats (VNTRs) from
  sequence data. (Note: The provided text appears to be a container runtime error
  log rather than help text; no arguments could be extracted from the input.)\n\n
  Tool homepage: https://github.com/mehrdadbakhtiari/adVNTR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/advntr:1.5.0--py310ha6711e0_1
stdout: advntr.out

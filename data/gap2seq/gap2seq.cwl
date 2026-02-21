cwlVersion: v1.2
class: CommandLineTool
baseCommand: gap2seq
label: gap2seq
doc: "Gap2Seq is a tool for filling gaps in draft assemblies using NGS data. (Note:
  The provided text contains system error messages rather than help documentation.)\n
  \nTool homepage: https://www.cs.helsinki.fi/u/lmsalmel/Gap2Seq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gap2seq:3.1.1a--py311hc84137b_6
stdout: gap2seq.out

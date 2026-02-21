cwlVersion: v1.2
class: CommandLineTool
baseCommand: gap2seq_Gap2Seq.sh
label: gap2seq_Gap2Seq.sh
doc: "Gap2Seq is a tool for filling gaps in genome assemblies using NGS data.\n\n
  Tool homepage: https://www.cs.helsinki.fi/u/lmsalmel/Gap2Seq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gap2seq:3.1.1a--py311hc84137b_6
stdout: gap2seq_Gap2Seq.sh.out

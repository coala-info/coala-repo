cwlVersion: v1.2
class: CommandLineTool
baseCommand: ghostz
label: ghostz
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the ghostz tool. As
  a result, no arguments could be extracted.\n\nTool homepage: http://www.bi.cs.titech.ac.jp/ghostz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ghostz:1.0.2--h503566f_7
stdout: ghostz.out

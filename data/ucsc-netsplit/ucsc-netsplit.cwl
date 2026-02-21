cwlVersion: v1.2
class: CommandLineTool
baseCommand: netSplit
label: ucsc-netsplit
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation for the tool. Based on the tool name,
  this utility is part of the UCSC Genome Browser toolset and is used to split a net
  file into multiple files, typically one per query chromosome.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-netsplit:482--h0b57e2e_0
stdout: ucsc-netsplit.out

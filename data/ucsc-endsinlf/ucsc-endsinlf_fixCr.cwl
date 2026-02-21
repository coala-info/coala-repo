cwlVersion: v1.2
class: CommandLineTool
baseCommand: endsInLf
label: ucsc-endsinlf_fixCr
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process. Based on the tool name, this utility (part
  of the UCSC Genome Browser tools) typically checks if a file ends with a line feed.\n
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-endsinlf:377--h199ee4e_0
stdout: ucsc-endsinlf_fixCr.out

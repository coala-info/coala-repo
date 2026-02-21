cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainBridge
label: ucsc-chainbridge
doc: "Bridge gaps in chains. (Note: The provided text appears to be a container build
  error log rather than help text, so no arguments could be extracted.)\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainbridge:377--h199ee4e_0
stdout: ucsc-chainbridge.out

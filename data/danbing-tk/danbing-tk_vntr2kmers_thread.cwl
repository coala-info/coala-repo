cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - danbing-tk
  - vntr2kmers_thread
label: danbing-tk_vntr2kmers_thread
doc: "A tool within the danbing-tk suite (Note: The provided help text contains only
  container runtime error logs and does not list specific arguments or a tool description).\n
  \nTool homepage: https://github.com/ChaissonLab/danbing-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/danbing-tk:1.3.2.5--h9948957_0
stdout: danbing-tk_vntr2kmers_thread.out

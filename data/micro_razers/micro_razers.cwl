cwlVersion: v1.2
class: CommandLineTool
baseCommand: micro_razers
label: micro_razers
doc: "The provided text does not contain help information for micro_razers; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/seqan/seqan/tree/seqan-v2.1.1/apps/micro_razers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/microbiomeutil-data:v20101212dfsg1-2-deb_cv1
stdout: micro_razers.out

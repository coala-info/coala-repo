cwlVersion: v1.2
class: CommandLineTool
baseCommand: varscan
label: varscan
doc: "The provided text does not contain help information or documentation for the
  tool. It consists of error logs from a container runtime (Singularity/Apptainer)
  attempting to fetch a VarScan image.\n\nTool homepage: http://dkoboldt.github.io/varscan/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varscan:2.4.6--hdfd78af_0
stdout: varscan.out

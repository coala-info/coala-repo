cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strainest
  - sickle
label: strainest_sickle
doc: "The provided text contains error logs from a container runtime environment and
  does not include help documentation or usage instructions for the tool. No arguments
  could be extracted.\n\nTool homepage: https://github.com/compmetagen/strainest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainest:1.2.4--py36h2d50403_2
stdout: strainest_sickle.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biodigest
  - digest
label: biodigest_digest
doc: "No help text available. The provided input was a fatal error message indicating
  a failure to pull the container image.\n\nTool homepage: http://pypi.python.org/pypi/biodigest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biodigest:0.2.16--pyhdfd78af_2
stdout: biodigest_digest.out

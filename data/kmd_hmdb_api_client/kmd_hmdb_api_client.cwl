cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmd_hmdb_api_client
label: kmd_hmdb_api_client
doc: "HMDB API client tool. (Note: The provided text is a system error log indicating
  a failure to initialize the container environment and does not contain usage instructions
  or argument definitions.)\n\nTool homepage: https://pypi.org/project/kmd-hmdb-api-client/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmd_hmdb_api_client:1.0.1--pyhdfd78af_0
stdout: kmd_hmdb_api_client.out

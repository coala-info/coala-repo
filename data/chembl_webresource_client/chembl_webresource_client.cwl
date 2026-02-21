cwlVersion: v1.2
class: CommandLineTool
baseCommand: chembl_webresource_client
label: chembl_webresource_client
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container image build failure (no
  space left on device).\n\nTool homepage: https://github.com/chembl/chembl_webresource_client"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chembl_structure_pipeline:1.0.0--2
stdout: chembl_webresource_client.out

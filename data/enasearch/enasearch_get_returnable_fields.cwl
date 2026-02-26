cwlVersion: v1.2
class: CommandLineTool
baseCommand: enasearch_get_returnable_fields
label: enasearch_get_returnable_fields
doc: "Get the fields extractable for a result.\n\n  This function returns the fields
  as a list.\n\nTool homepage: http://bebatut.fr/enasearch/"
inputs:
  - id: result
    type: string
    doc: Id of a result (accessible with get_results)
    inputBinding:
      position: 101
      prefix: --result
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
stdout: enasearch_get_returnable_fields.out

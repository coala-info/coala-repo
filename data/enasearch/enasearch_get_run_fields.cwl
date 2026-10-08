cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enasearch
  - get_run_fields
label: enasearch_get_run_fields
doc: "Get the fields extractable for a run.\n\nThis function returns the fields as a list.\n\nTool homepage: http://bebatut.fr/enasearch/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
stdout: enasearch_get_run_fields.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: enasearch_get_sortable_fields
label: enasearch_get_sortable_fields
doc: "Get the fields of a result that can sorted.\n\n  This function returns the fields
  that can be used to sort the output of a\n  query for a result on ENA. Each field
  is described on a line with field\n  id, its description, its type and to which
  results it is related\n\nTool homepage: http://bebatut.fr/enasearch/"
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
stdout: enasearch_get_sortable_fields.out

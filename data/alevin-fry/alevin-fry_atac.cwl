cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alevin-fry
  - atac
label: alevin-fry_atac
doc: "subcommand for processing scATAC-seq RAD files\n\nTool homepage: https://github.com/COMBINE-lab/alevin-fry"
inputs:
  - id: subcommand
    type:
      - 'null'
      - string
    doc: The subcommand to execute (generate-permit-list, sort, collate, or deduplicate)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
stdout: alevin-fry_atac.out

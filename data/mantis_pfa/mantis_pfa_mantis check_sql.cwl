cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis
label: mantis_pfa_mantis check_sql
doc: "Mantis is a k-mer based sequence analysis tool.\n\nTool homepage: https://github.com/PedroMTQ/Mantis"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Options: build, mst, validatemst, query, validate,
      stats, help.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
stdout: mantis_pfa_mantis check_sql.out

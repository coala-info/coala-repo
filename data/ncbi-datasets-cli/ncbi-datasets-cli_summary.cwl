cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datasets
  - summary
label: ncbi-datasets-cli_summary
doc: Print a data report containing gene, genome or virus metadata in JSON 
  format.
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (gene, genome, or virus)
    inputBinding:
      position: 1
  - id: api_key
    type:
      - 'null'
      - string
    doc: Specify an NCBI API key
    inputBinding:
      position: 102
      prefix: --api-key
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Emit debugging info
    inputBinding:
      position: 102
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-datasets-cli:14.26.0
stdout: ncbi-datasets-cli_summary.out
s:url: https://github.com/metagenlab/assembly_finder
$namespaces:
  s: https://schema.org/

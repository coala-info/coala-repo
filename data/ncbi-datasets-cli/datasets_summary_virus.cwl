cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datasets
  - summary
  - virus
label: datasets_summary_virus
doc: Print a data report containing virus genome metadata by accession or taxon.
  The data report is returned in JSON format.
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: Subcommand to execute (e.g., genome)
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
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: ensemblorg/datasets-cli:latest
stdout: datasets_summary_virus.out
s:url: https://github.com/metagenlab/assembly_finder
$namespaces:
  s: https://schema.org/

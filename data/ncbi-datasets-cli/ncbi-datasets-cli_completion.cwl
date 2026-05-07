cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datasets
  - completion
label: ncbi-datasets-cli_completion
doc: This sub-command generates files needed to enable auto-complete for several
  popular command-line interpreters.
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: The shell for which to generate autocompletion script (bash, zsh, fish,
      or powershell)
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
    dockerPull: ensemblorg/datasets-cli:latest
stdout: ncbi-datasets-cli_completion.out
s:url: https://github.com/metagenlab/assembly_finder
$namespaces:
  s: https://schema.org/

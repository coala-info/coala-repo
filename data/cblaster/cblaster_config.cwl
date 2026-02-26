cwlVersion: v1.2
class: CommandLineTool
baseCommand: cblaster_config
label: cblaster_config
doc: "Configure cblaster (e.g. for setting NCBI e-mail addresses or API keys)\n\n\
  Tool homepage: https://github.com/gamcil/cblaster"
inputs:
  - id: api_key
    type:
      - 'null'
      - string
    doc: NCBI API key
    inputBinding:
      position: 101
      prefix: --api_key
  - id: email
    type:
      - 'null'
      - string
    doc: Your e-mail address, required by NCBI to prevent abuse
    inputBinding:
      position: 101
      prefix: --email
  - id: max_tries
    type:
      - 'null'
      - int
    doc: How many times failed requests are retried
    default: 3
    inputBinding:
      position: 101
      prefix: --max_tries
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
stdout: cblaster_config.out

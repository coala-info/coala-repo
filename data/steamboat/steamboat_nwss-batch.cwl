cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwss-batch
label: steamboat_nwss-batch
doc: "Format data for NWSS submission.\n\nTool homepage: https://github.com/rpetit3/steamboat-py"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing reports
    inputBinding:
      position: 101
      prefix: --force
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to write output
    default: ./
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to use for output files
    default: nwss-batch
    inputBinding:
      position: 101
      prefix: --prefix
  - id: results
    type: string
    doc: A TSV (or CSV) file with the dPCR results
    inputBinding:
      position: 101
      prefix: --results
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed
    inputBinding:
      position: 101
      prefix: --silent
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity of output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: yaml
    type: string
    doc: A YAML formatted file containing constant information for NWSS fields.
    inputBinding:
      position: 101
      prefix: --yaml
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/steamboat:1.1.1--pyhdfd78af_0
stdout: steamboat_nwss-batch.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: sizemeup-main
label: sizemeup
doc: "A simple tool to determine the genome size of an organism\n\nTool homepage:
  https://github.com/rpetit3/sizemeup"
inputs:
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to use for output files
    default: sizemeup
    inputBinding:
      position: 101
      prefix: --prefix
  - id: query
    type: string
    doc: The species name or taxid to determine the size of
    inputBinding:
      position: 101
      prefix: --query
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed
    inputBinding:
      position: 101
      prefix: --silent
  - id: sizes
    type: string
    doc: The built in sizes file to use
    default: /usr/local/bin/../share/sizemeup/sizemeup-sizes.txt
    inputBinding:
      position: 101
      prefix: --sizes
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity of output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to write output
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sizemeup:1.3.0--pyhdfd78af_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: theiacov-gc
label: theiacov-gc
doc: "Run TheiaCoV GC on a set of samples.\n\nTool homepage: https://github.com/theiagen/public_health_viral_genomics"
inputs:
  - id: config
    type:
      - 'null'
      - string
    doc: Custom backend profile to use
    inputBinding:
      position: 101
      prefix: --config
  - id: cromwell_jar
    type:
      - 'null'
      - string
    doc: Path to cromwell.jar (Default use conda install)
    default: use conda install
    inputBinding:
      position: 101
      prefix: --cromwell_jar
  - id: inputs
    type: string
    doc: The JSON file to be used with Cromwell for inputs.
    inputBinding:
      position: 101
      prefix: --inputs
  - id: options
    type:
      - 'null'
      - string
    doc: JSON file containing Cromwell options
    inputBinding:
      position: 101
      prefix: --options
  - id: outdir
    type: string
    doc: Output directory to store the final results in.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: profile
    type:
      - 'null'
      - string
    doc: 'The backend profile to use [options: docker, singularity]'
    inputBinding:
      position: 101
      prefix: --profile
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silence all STDOUT from Cromwell and theiacov-gc-organize
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/theiacov-gc:2.3.2--hdfd78af_0
stdout: theiacov-gc.out

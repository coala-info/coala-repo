cwlVersion: v1.2
class: CommandLineTool
baseCommand: mosca
label: mosca
doc: "MOSCA's main script\n\nTool homepage: https://github.com/iquasere/MOSCA"
inputs:
  - id: configfile
    type:
      - 'null'
      - File
    doc: Configuration file for MOSCA (JSON or YAML). Obtain one at 
      https://iquasere.github.io/MOSGUITO
    inputBinding:
      position: 101
      prefix: --configfile
  - id: snakefile
    type:
      - 'null'
      - File
    doc: Path to Snakefile
    inputBinding:
      position: 101
      prefix: --snakefile
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: If user forced termination of workflow, this might be required
    inputBinding:
      position: 101
      prefix: --unlock
  - id: use_singularity
    type:
      - 'null'
      - boolean
    doc: Use singularity
    inputBinding:
      position: 101
      prefix: --use-singularity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosca:2.3.0--hdfd78af_0
stdout: mosca.out

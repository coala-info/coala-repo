cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - relative_composition_variability
label: phykit_relative_composition_variability
doc: Calculate RCV (relative composition variability) for an alignment. Lower 
  RCV values represent a lower composition bias in an alignment. Statistically, 
  RCV describes the average variability in sequence composition among taxa.
inputs:
  - id: alignment
    type: File
    doc: First argument after function name should be an alignment file
    inputBinding:
      position: 1
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_relative_composition_variability.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/

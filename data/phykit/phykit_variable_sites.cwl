cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - variable_sites
label: phykit_variable_sites
doc: 'Calculate the number of variable sites in an alignment. Reports three tab delimited
  values: number of variable sites, total number of sites, and percentage of variable
  sites.'
inputs:
  - id: alignment
    type: File
    doc: alignment file
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
stdout: phykit_variable_sites.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/

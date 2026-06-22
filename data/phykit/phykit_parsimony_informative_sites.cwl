cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - parsimony_informative_sites
label: phykit_parsimony_informative_sites
doc: 'Calculate the number and percentage of parsimony informative sites in an alignment.
  PhyKIT reports three tab delimited values: number of parsimony informative sites,
  total number of sites, and percentage of parsimony informative sites.'
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
stdout: phykit_parsimony_informative_sites.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/

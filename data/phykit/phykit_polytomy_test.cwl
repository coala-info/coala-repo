cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - polytomy_test
label: phykit_polytomy_test
doc: Conduct a polytomy test for three clades in a phylogeny using gene support 
  frequencies and a chi-squared test.
inputs:
  - id: trees
    type: File
    doc: single column file with names of phylogenies to use for polytomy 
      testing
    inputBinding:
      position: 101
      prefix: --trees
  - id: groups
    type:
      - 'null'
      - File
    doc: a tab-delimited file with the grouping designations to test. Names of 
      individual taxa should be separated by a semi-colon ';'
    inputBinding:
      position: 101
      prefix: --groups
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_polytomy_test.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/

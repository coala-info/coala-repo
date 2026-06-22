cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - degree_of_violation_of_a_molecular_clock
label: phykit_degree_of_violation_of_a_molecular_clock
doc: Calculate degree of violation of a molecular clock (or DVMC) in a 
  phylogeny. Lower DVMC values are thought to be desirable because they are 
  indicative of a lower degree of violation in the molecular clock assumption.
inputs:
  - id: tree
    type: File
    doc: Tree file to calculate DVMC from.
    inputBinding:
      position: 1
  - id: json
    type:
      - 'null'
      - boolean
    doc: Optional argument to output results as JSON
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
stdout: phykit_degree_of_violation_of_a_molecular_clock.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/

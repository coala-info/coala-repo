cwlVersion: v1.2
class: CommandLineTool
baseCommand: consEntropy
label: phast_consentropy
doc: "For use with phastCons. Given phylogenetic models for conserved and non-conserved
  states, the target coverage, and the (prior) expected length of a conserved element,
  compute the relative entropy (H) of the phylogenetic models, the expected minimum
  number of conserved sites required to predict a conserved element (L_min), the phylogenetic
  information threshold (PIT = L_min * H), and the expected maximum number of nonconserved
  sites tolerated within a conserved element (L_max).\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: relative_entropy
    type:
      - 'null'
      - float
    doc: Instead of computing the relative entropy from two .mod files, just use the
      specified value. The .mod files are not required in this case.
    inputBinding:
      position: 1
      prefix: --H
  - id: lminh
    type:
      - 'null'
      - float
    doc: Report the expected length that would produce the specified value of L_min
      * H (the specified PIT), assuming H remains constant.
    inputBinding:
      position: 1
      prefix: --LminH
  - id: target_coverage
    type: float
    doc: Target coverage of conserved elements (fraction between 0 and 1).
    inputBinding:
      position: 2
  - id: expected_length
    type: float
    doc: Prior expected length of a conserved element.
    inputBinding:
      position: 3
  - id: cons_mod
    type:
      - 'null'
      - File
    doc: Tree model (.mod) for the conserved state.
    inputBinding:
      position: 4
  - id: noncons_mod
    type:
      - 'null'
      - File
    doc: Tree model (.mod) for the non-conserved state.
    inputBinding:
      position: 5
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the report file (standard output).
    default: consEntropy.txt
outputs:
  - id: report
    type: File
    doc: Report with H, L_min, PIT and L_max.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
stdout: $(inputs.output_name)

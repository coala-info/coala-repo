cwlVersion: v1.2
class: CommandLineTool
baseCommand: KaKs_Calculator
label: kakscalculator2
doc: "KaKs_Calculator adopts model selection and model averaging to calculate nonsynonymous
  (Ka) and synonymous (Ks) substitution rates.\n\nTool homepage: https://github.com/kullrich/kakscalculator2"
inputs:
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: 'Genetic code table (e.g., 1: Standard, 2: Vertebrate Mitochondrial)'
    inputBinding:
      position: 101
      prefix: -c
  - id: input_file
    type: File
    doc: Name of input file in AXT format
    inputBinding:
      position: 101
      prefix: -i
  - id: method
    type:
      - 'null'
      - string
    doc: 'Method for calculating Ka and Ks: NG, LWL, LPB, MLWL, MLPB, GY, YN, MYN,
      MA, MS, GYN'
    inputBinding:
      position: 101
      prefix: -m
  - id: show_details
    type:
      - 'null'
      - boolean
    doc: Output details of each codon
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: output_file
    type: File
    doc: Name of output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kakscalculator2:2.0.1--h9948957_6

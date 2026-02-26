cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmmrcalculator
label: pmmrcalculator
doc: "Calculate the pairwise mismatch rate of genotyped between all individuals in
  the input eigenstrat dataset.\n\nTool homepage: https://github.com/TCLamnidis/pMMRCalculator"
inputs:
  - id: input_files_prefix
    type:
      - 'null'
      - string
    doc: The desired input file prefix. Input files are assumed to be <INPUT 
      PREFIX>.geno, <INPUT PREFIX>.snp and <INPUT PREFIX>.ind .
    inputBinding:
      position: 101
      prefix: --Input
  - id: input_files_suffix
    type:
      - 'null'
      - string
    doc: The desired input file suffix. Input files are assumed to be <INPUT 
      PREFIX>.geno<INPUT SUFFIX>, <INPUT PREFIX>.snp<INPUT SUFFIX> and <INPUT 
      PREFIX>.ind<INPUT SUFFIX> .
    inputBinding:
      position: 101
      prefix: --Suffix
  - id: json
    type:
      - 'null'
      - boolean
    doc: Create additional json formatted output file named <OUTPUT FILE>.json .
    default: "'pmmrcalculator_output.json'"
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The desired output file name. Omit to print to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmmrcalculator:1.1.0--hdfd78af_0

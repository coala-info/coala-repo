cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmmrcalculator
label: pmmrcalculator
doc: "Calculate the pairwise mismatch rate of genotyped between all individuals in
  the input eigenstrat dataset. The input files are named <prefix>.geno, <prefix>.snp
  and <prefix>.ind: give them in eigenstrat_files so that they are staged in the working
  directory.\n\nTool homepage: https://github.com/TCLamnidis/pMMRCalculator"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.eigenstrat_files)
inputs:
  - id: eigenstrat_files
    type:
      type: array
      items: File
    doc: The .geno, .snp and .ind files of the eigenstrat dataset (names must match
      the input prefix and suffix)
  - id: input_files_prefix
    type: string
    doc: The desired input file prefix. Input files are assumed to be <INPUT PREFIX>.geno,
      <INPUT PREFIX>.snp and <INPUT PREFIX>.ind .
    inputBinding:
      position: 101
      prefix: --Input
  - id: input_files_suffix
    type:
      - 'null'
      - string
    doc: The desired input file suffix. Input files are assumed to be <INPUT PREFIX>.geno<INPUT
      SUFFIX>, <INPUT PREFIX>.snp<INPUT SUFFIX> and <INPUT PREFIX>.ind<INPUT SUFFIX> .
    inputBinding:
      position: 101
      prefix: --Suffix
  - id: json
    type:
      - 'null'
      - boolean
    doc: "Create additional json formatted output file named <OUTPUT FILE>.json .
      [Default: 'pmmrcalculator_output.json']"
    inputBinding:
      position: 101
      prefix: --json
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: The desired output file name. Omit to print to stdout.
    inputBinding:
      position: 102
      prefix: --Output
outputs:
  - id: stdout
    type: stdout
    doc: Pairwise mismatch rates printed to standard output (when no output file is given)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: json_file
    type:
      - 'null'
      - File
    doc: JSON formatted output file
    outputBinding:
      glob: '*.json'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmmrcalculator:1.1.0--hdfd78af_0
stdout: pmmrcalculator.out

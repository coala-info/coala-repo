cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfCheck
label: ngs-bits_VcfCheck
doc: "Checks a VCF file for errors. Checks the input VCF file with SNVs and small InDels for errors and warnings. If the VEP-based CSQ annotation is present, it also checks that the Miso terms in the consequence field are valid.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: duplicates
    type:
      - 'null'
      - boolean
    doc: "Check for variants occuring twice (input VCF needs to be sorted)."
    inputBinding:
      position: 1
      prefix: -duplicates
  - id: info
    type:
      - 'null'
      - boolean
    doc: "Add general information about the input file to the output."
    inputBinding:
      position: 2
      prefix: -info
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input VCF file. If unset, reads from STDIN."
    inputBinding:
      position: 3
      prefix: -in
  - id: lines
    type:
      - 'null'
      - int
    doc: "Number of variant lines to check in the VCF file (unlimited if 0)"
    inputBinding:
      position: 4
      prefix: -lines
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output file. If unset, writes to STDOUT."
    inputBinding:
      position: 5
      prefix: -out
  - id: ref
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 6
      prefix: -ref
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 7
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output file. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0

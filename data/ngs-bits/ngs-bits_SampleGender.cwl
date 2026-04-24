cwlVersion: v1.2
class: CommandLineTool
baseCommand: SampleGender
label: ngs-bits_SampleGender
doc: "Determines the gender of a sample from the BAM/CRAM file.\n\nTool homepage:
  https://github.com/imgag/ngs-bits"
inputs:
  - id: build
    type:
      - 'null'
      - string
    doc: "Genome build used to generate the input (methods hetx and sry).\n      \
      \                Valid: 'hg19,hg38'"
    inputBinding:
      position: 101
      prefix: -build
  - id: input_files
    type:
      type: array
      items: File
    doc: Input BAM/CRAM file(s).
    inputBinding:
      position: 101
      prefix: -in
  - id: long_read
    type:
      - 'null'
      - boolean
    doc: Support long reads (> 1kb) and uses single-end reads for gender 
      calculation.
    inputBinding:
      position: 101
      prefix: -long_read
  - id: max_female
    type:
      - 'null'
      - float
    doc: Maximum Y/X ratio for female (method xy).
    inputBinding:
      position: 101
      prefix: -max_female
  - id: max_male
    type:
      - 'null'
      - float
    doc: Maximum heterozygous SNP fraction for male (method hetx).
    inputBinding:
      position: 101
      prefix: -max_male
  - id: method
    type: string
    doc: "Method selection: Read distribution on X and Y chromosome (xy), fraction
      of heterozygous variants on X chromosome (hetx), or coverage of SRY gene (sry).\n\
      \                      Valid: 'xy,hetx,sry'"
    inputBinding:
      position: 101
      prefix: -method
  - id: min_female
    type:
      - 'null'
      - float
    doc: Minimum heterozygous SNP fraction for female (method hetx).
    inputBinding:
      position: 101
      prefix: -min_female
  - id: min_male
    type:
      - 'null'
      - float
    doc: Minimum Y/X ratio for male (method xy).
    inputBinding:
      position: 101
      prefix: -min_male
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome for CRAM support (mandatory if CRAM is used).
    inputBinding:
      position: 101
      prefix: -ref
  - id: settings
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: sry_cov
    type:
      - 'null'
      - float
    doc: Minimum average coverage of SRY gene for males (method sry).
    inputBinding:
      position: 101
      prefix: -sry_cov
  - id: tdx
    type:
      - 'null'
      - boolean
    doc: Writes a Tool Definition Xml file. The file name is the application 
      name with the suffix '.tdx'.
    inputBinding:
      position: 101
      prefix: --tdx
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output TSV file - one line per input BAM/CRAM file. If unset, writes to
      STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0

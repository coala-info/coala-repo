cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcflatten
label: vcflatten
doc: Convert VCF files to TSV format.
inputs:
  - id: filename
    type: File
    doc: Input VCF filename
    inputBinding:
      position: 1
  - id: filename_prefix
    type:
      - 'null'
      - string
    doc: A filename prefix that can be used in the output pattern. If this is 
      not set, then the prefix is the same as <filename>.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: genotype_keys
    type:
      - 'null'
      - string
    doc: Specify a colon-separated list of FORMAT IDs to output for each sample 
      from the VCF file.
    inputBinding:
      position: 102
      prefix: --genotype
  - id: ignore_errors
    type:
      - 'null'
      - boolean
    doc: If this flag is set, then any errors in the VCF file will be ignored, 
      and the invalid rows will be skipped.
    inputBinding:
      position: 102
      prefix: --ignore-errors
  - id: info_keys
    type:
      - 'null'
      - string
    doc: Specify a semicolon-separated list of INFO IDs to output for each 
      variant from the VCF file.
    inputBinding:
      position: 102
      prefix: --info
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: If this flag is set, the TSV header won't be written to any of the 
      output files.
    inputBinding:
      position: 102
      prefix: --no-header
  - id: one_file
    type:
      - 'null'
      - boolean
    doc: If this flag is set, then only 1 TSV file will be generated for all 
      samples. In addition, this file will have a SAMPLE column which indicates 
      which sample the data belongs to.
    inputBinding:
      position: 102
      prefix: --one-file
  - id: output_pattern
    type:
      - 'null'
      - string
    doc: "The pattern to use when generating output files. The default is \"%p-%s-%d\"\
      . Valid special patterns are: %p Include the \"prefix\" here (either <filename>
      or given in --prefix <prefix>), %s The name of the sample, taken from the header
      of the VCF file., %i The index of the sample (1-based)., %% A single, literal
      '%'. If neither %s nor %d is provided, then the VCF file must have only 1 sample."
    default: '%p-%s-%d'
    inputBinding:
      position: 102
      prefix: --pattern
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcflatten:0.5.2--1
stdout: vcflatten.out

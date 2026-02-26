cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtb-snp-it
label: mtb-snp-it
doc: "A tool to identify the lineage of Mycobacterium tuberculosis isolates from VCF
  files.\n\nTool homepage: https://github.com/samlipworth/snpit"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file containing SNP information
    inputBinding:
      position: 101
      prefix: --input
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write results (defaults to stdout if not specified)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtb-snp-it:1.1--py_0

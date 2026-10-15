cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_snp_screen_vcf_files
label: phyluce_phyluce_snp_screen_vcf_files
doc: "Parse fastq files and drop reads containing Ns.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: File
    doc: "The vcf file to process"
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: "The vcf file to write"
    inputBinding:
      position: 2
      prefix: --output
  - id: complete
    type:
      - 'null'
      - float
    doc: "The percentage of missing data to allow."
    inputBinding:
      position: 3
      prefix: --complete
outputs:
  - id: screened_vcf
    type: File
    doc: "The VCF file with the records that pass the completeness screen."
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout_log
    type: File
    doc: "Standard output of the program (record counter)."
    outputBinding:
      glob: "screen_vcf_files.stdout.txt"
stdout: screen_vcf_files.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0

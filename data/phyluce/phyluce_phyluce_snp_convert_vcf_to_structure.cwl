cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_snp_convert_vcf_to_structure
label: phyluce_phyluce_snp_convert_vcf_to_structure
doc: "Parse fastq files and drop reads containing Ns.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: File
    doc: "The VCF file to process"
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: "The STRUCTURE file to write"
    inputBinding:
      position: 2
      prefix: --output
  - id: filter_identical
    type:
      - 'null'
      - boolean
    doc: "Remove sites with only a single genotype."
    inputBinding:
      position: 3
      prefix: --filter-identical
  - id: filter_informative
    type:
      - 'null'
      - boolean
    doc: "Remove uninformative sites."
    inputBinding:
      position: 4
      prefix: --filter-informative
outputs:
  - id: converted
    type: File
    doc: "The converted SNP matrix."
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout_log
    type: File
    doc: "Standard output of the program (progress dots and the count of individuals and loci)."
    outputBinding:
      glob: "convert_vcf_to_structure.stdout.txt"
stdout: convert_vcf_to_structure.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0

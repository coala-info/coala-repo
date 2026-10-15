cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_snp_summarize_vcf_file
label: phyluce_phyluce_snp_summarize_vcf_file
doc: "Parse fastq files and drop reads containing Ns.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: File
    doc: "The vcf file to process"
    inputBinding:
      position: 1
      prefix: --input
outputs:
  - id: summary
    type: File
    doc: "Number of variable loci and SNPs per locus, printed to standard output."
    outputBinding:
      glob: "summarize_vcf_file.txt"
stdout: summarize_vcf_file.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0

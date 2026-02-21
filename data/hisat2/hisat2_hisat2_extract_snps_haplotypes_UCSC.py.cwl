cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2_extract_snps_haplotypes_UCSC.py
label: hisat2_hisat2_extract_snps_haplotypes_UCSC.py
doc: "A script to extract SNPs and haplotypes from UCSC data for HISAT2. Note: The
  provided help text contains only system error messages and no usage information.\n
  \nTool homepage: http://daehwankimlab.github.io/hisat2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.2--h503566f_0
stdout: hisat2_hisat2_extract_snps_haplotypes_UCSC.py.out

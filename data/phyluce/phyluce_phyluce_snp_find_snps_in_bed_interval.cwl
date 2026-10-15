cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_snp_find_snps_in_bed_interval
label: phyluce_phyluce_snp_find_snps_in_bed_interval
doc: "Match UCE probes to assembled contigs and store the data\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: uce
    type: File
    doc: "The UCE BED file"
    inputBinding:
      position: 1
      prefix: --uce
  - id: snp
    type: File
    doc: "The SNP intersection BED file"
    inputBinding:
      position: 2
      prefix: --snp
  - id: output
    type: string
    doc: "The output file. The program prints to standard output when this is not set; this wrapper always needs a file name so that the result is collected."
    inputBinding:
      position: 3
      prefix: --output
outputs:
  - id: snps_in_intervals
    type: File
    doc: "The CSV table of SNPs that fall inside UCE intervals (written to --output)."
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0

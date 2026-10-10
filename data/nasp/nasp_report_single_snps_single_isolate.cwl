cwlVersion: v1.2
class: CommandLineTool
baseCommand: [report_single_snps_single_isolate.py]
label: nasp_report_single_snps_single_isolate
doc: "Find autapomorphic SNPs for a single isolate from a NASP SNP matrix.\n\nTool homepage: https://github.com/TGenNorth/NASP"
inputs:
  - id: input_matrix
    type: File
    doc: "Path to NASP matrix."
    inputBinding:
      position: 1
      prefix: --input_matrix
  - id: genome_name
    type: string
    doc: "Genome to look for singleton SNPs."
    inputBinding:
      position: 1
      prefix: --genome_name
outputs:
  - id: unique_snps
    type: File
    doc: "List of locus ids with SNPs unique to the genome."
    outputBinding:
      glob: unique_snps.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - MendelScan.jar
  - trio
label: mendelscan_trio
doc: "MendelScan trio analysis\n\nTool homepage: https://github.com/genome/mendelscan"
inputs:
  - id: vcf_file
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: gene_file
    type:
      - 'null'
      - File
    doc: A list of gene expression values for tissue of interest
    inputBinding:
      position: 102
      prefix: --gene-file
  - id: ped_file
    type:
      - 'null'
      - File
    doc: Pedigree file in 6-column tab-delimited format
    inputBinding:
      position: 102
      prefix: --ped-file
  - id: vep_file
    type:
      - 'null'
      - File
    doc: Variant annotation in VEP format
    inputBinding:
      position: 102
      prefix: --vep-file
  - id: output_denovo_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_denovo_path`
    inputBinding:
      position: 103
      prefix: --output-denovo
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 104
      prefix: --output-file
  - id: output_recessive_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_recessive_path`
    inputBinding:
      position: 105
      prefix: --output-recessive
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to contain summary report
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: output_recessive
    type:
      - 'null'
      - File
    doc: Output file to contain scored variants in VCF format
    outputBinding:
      glob: $(inputs.output_recessive_path)
  - id: output_denovo
    type:
      - 'null'
      - File
    doc: Output file for possible de novo variants
    outputBinding:
      glob: $(inputs.output_denovo_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mendelscan:v1.2.2--0

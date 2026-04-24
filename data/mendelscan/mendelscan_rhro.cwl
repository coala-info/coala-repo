cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - MendelScan.jar
  - rhro
label: mendelscan_rhro
doc: "MendelScan RHRO analysis\n\nTool homepage: https://github.com/genome/mendelscan"
inputs:
  - id: vcf_file
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: centromere_file
    type:
      - 'null'
      - File
    doc: A tab-delimited, BED-like file indicating centromere locations by 
      chromosome
    inputBinding:
      position: 102
      prefix: --centromere-file
  - id: inheritance
    type:
      - 'null'
      - string
    doc: 'Presumed model of inheritance: dominant, recessive, x-linked'
    inputBinding:
      position: 102
      prefix: --inheritance
  - id: ped_file
    type:
      - 'null'
      - File
    doc: Pedigree file in 6-column tab-delimited format
    inputBinding:
      position: 102
      prefix: --ped-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to contain informative variants
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_windows
    type:
      - 'null'
      - File
    doc: Output file to contain RHRO windows. Otherwise they print to STDOUT
    outputBinding:
      glob: $(inputs.output_windows)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mendelscan:v1.2.2--0

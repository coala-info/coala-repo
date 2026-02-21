cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp-sites
label: snp-sites
doc: "Finds SNP sites from a multi-fasta alignment file.\n\nTool homepage: https://github.com/sanger-pathogens/snp-sites"
inputs:
  - id: input_file
    type: File
    doc: Input multi-fasta alignment file
    inputBinding:
      position: 1
  - id: only_acgt
    type:
      - 'null'
      - boolean
    doc: Only output columns containing entirely ACGT
    inputBinding:
      position: 102
      prefix: -c
  - id: output_fasta
    type:
      - 'null'
      - boolean
    doc: Output internal multi-fasta alignment file with only SNP sites
    inputBinding:
      position: 102
      prefix: -r
  - id: output_monomorphic
    type:
      - 'null'
      - boolean
    doc: Output monomorphic sites
    inputBinding:
      position: 102
      prefix: -b
  - id: output_phylip
    type:
      - 'null'
      - boolean
    doc: Output phylip file
    inputBinding:
      position: 102
      prefix: -p
  - id: output_vcf
    type:
      - 'null'
      - boolean
    doc: Output VCF file
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp-sites:2.5.1--h577a1d6_7

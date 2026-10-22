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
    doc: Only output columns containing exclusively ACGT
    inputBinding:
      position: 102
      prefix: -c
  - id: output_pseudo_reference
    type:
      - 'null'
      - boolean
    doc: Output internal pseudo reference sequence
    inputBinding:
      position: 102
      prefix: -r
  - id: output_multi_fasta
    type:
      - 'null'
      - boolean
    doc: Output a multi fasta alignment file (default)
    inputBinding:
      position: 102
      prefix: -m
  - id: constant_site_counts
    type:
      - 'null'
      - boolean
    doc: Only output count of constant sites (suitable for IQ-TREE -fconst) and nothing else
    inputBinding:
      position: 102
      prefix: -C
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
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output filename
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the result when no output file name is given)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp-sites:2.5.1--h577a1d6_7
stdout: snp-sites.out

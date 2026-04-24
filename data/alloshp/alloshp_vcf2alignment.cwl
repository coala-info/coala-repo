cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2alignment
label: alloshp_vcf2alignment
doc: "Convert VCF files to multiple sequence alignments (MSA) with optional filtering
  and configuration.\n\nTool homepage: https://github.com/eead-csic-compbio/AlloSHP"
inputs:
  - id: config_file
    type: File
    doc: input TSV config file
    inputBinding:
      position: 101
      prefix: -c
  - id: include_heterozygous
    type:
      - 'null'
      - boolean
    doc: take also heterozygous sites (by default only homozygous are taken)
    inputBinding:
      position: 101
      prefix: -H
  - id: input_vcf
    type: File
    doc: input VCF file
    inputBinding:
      position: 101
      prefix: -v
  - id: max_missing
    type:
      - 'null'
      - int
    doc: max missing samples
    inputBinding:
      position: 101
      prefix: -m
  - id: min_depth
    type:
      - 'null'
      - int
    doc: min read depth at each position for each sample (use -d 0 if VCF file 
      lacks DP)
    inputBinding:
      position: 101
      prefix: -d
  - id: output_format
    type:
      - 'null'
      - string
    doc: output format (e.g., nexus, fasta)
    inputBinding:
      position: 101
      prefix: -f
  - id: polymorphic_only
    type:
      - 'null'
      - boolean
    doc: take only polymorphic sites (by default all sites, constant and SNPs, 
      are taken)
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: report_file
    type: File
    doc: output report file name, 1-based coordinates
    outputBinding:
      glob: $(inputs.report_file)
  - id: output_msa
    type:
      - 'null'
      - File
    doc: output MSA file name
    outputBinding:
      glob: $(inputs.output_msa)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alloshp:2025.09.12--h7b50bb2_0

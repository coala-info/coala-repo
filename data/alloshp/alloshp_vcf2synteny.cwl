cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2synteny
label: alloshp_vcf2synteny
doc: "Convert VCF files to synteny FASTA/VCF formats based on a configuration file
  and reference genome.\n\nTool homepage: https://github.com/eead-csic-compbio/AlloSHP"
inputs:
  - id: config_file
    type: File
    doc: 'input TSV config file (example: -c config.synteny.tsv)'
    inputBinding:
      position: 101
      prefix: -c
  - id: include_heterozygous
    type:
      - 'null'
      - boolean
    doc: take also heterozygous sites (optional, by default only homozygous, 
      requires -l report from vcf2alignment -H)
    inputBinding:
      position: 101
      prefix: -H
  - id: input_vcf
    type: File
    doc: 'input VCF file (example: -v data.vcf.gz)'
    inputBinding:
      position: 101
      prefix: -v
  - id: max_missing
    type:
      - 'null'
      - int
    doc: max missing samples
    default: 10
    inputBinding:
      position: 101
      prefix: -m
  - id: min_depth
    type:
      - 'null'
      - int
    doc: min depth of called SNPs
    default: 3
    inputBinding:
      position: 101
      prefix: -d
  - id: new_temp_files
    type:
      - 'null'
      - boolean
    doc: new temp files, don't re-use (optional, by default temp files are 
      re-used if available at -t)
    inputBinding:
      position: 101
      prefix: -N
  - id: one_based_coords
    type:
      - 'null'
      - boolean
    doc: syntenic coords are 1-based (optional, 0-based/BED by default)
    inputBinding:
      position: 101
      prefix: '-1'
  - id: polymorphic_only
    type:
      - 'null'
      - boolean
    doc: take only polymorphic sites (optional, by default all sites, constant 
      and SNPs, are taken)
    inputBinding:
      position: 101
      prefix: -p
  - id: reference_genome
    type: string
    doc: 'master reference genome (example: -r Bdis)'
    inputBinding:
      position: 101
      prefix: -r
  - id: report_file
    type: File
    doc: 'report file from vcf2alignment, 1-based (example: -l vcf.rport.log.gz)'
    inputBinding:
      position: 101
      prefix: -l
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: path to dir for temp file
    default: /tmp
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_fasta
    type: File
    doc: 'output FASTA file name (example: -o out.fasta)'
    outputBinding:
      glob: $(inputs.output_fasta)
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: 'output VCF file name (coordinates from -r genome, example: -f out.vcf)'
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alloshp:2025.09.12--h7b50bb2_0

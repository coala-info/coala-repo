cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf-assembly-checker
label: vcf-validator_vcf_assembly_checker
doc: "vcf-assembly-checker version 0.10.2\n\nTool homepage: https://github.com/EBIVariation/vcf-validator"
inputs:
  - id: assembly
    type:
      - 'null'
      - string
    doc: Path to the input assembly report used for contig synonym mapping
    inputBinding:
      position: 101
      prefix: --assembly
  - id: fasta
    type:
      - 'null'
      - File
    doc: Path to the input FASTA file; please note that the index file (from 
      samtools faidx) must have the same name as the FASTA file and saved with a
      .fai extension
    inputBinding:
      position: 101
      prefix: --fasta
  - id: input_file
    type:
      - 'null'
      - File
    doc: Path to the input VCF file, or stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: report
    type:
      - 'null'
      - string
    doc: Comma separated values for types of reports (summary, text, valid)
    inputBinding:
      position: 101
      prefix: --report
  - id: require_genbank
    type:
      - 'null'
      - boolean
    doc: Flag to indicate that VCF should be checked for Genbank accessions
    inputBinding:
      position: 101
      prefix: --require-genbank
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-validator:0.10.2--h7a61d87_0
stdout: vcf-validator_vcf_assembly_checker.out

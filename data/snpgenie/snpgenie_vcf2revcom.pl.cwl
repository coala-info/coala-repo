cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie_vcf2revcom.pl
label: snpgenie_vcf2revcom.pl
doc: "Converts a VCF format 1 SNP report to a reverse complement sequence.\n\nTool
  homepage: https://github.com/chasewnelson/SNPGenie"
inputs:
  - id: snp_report_vcf
    type: File
    doc: A '+' strand SNP report in VCF format 1 (SNPGenie descriptions).
    inputBinding:
      position: 1
  - id: sequence_length
    type: int
    doc: The exact length of the sequence in the FASTA file.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_vcf2revcom.pl.out

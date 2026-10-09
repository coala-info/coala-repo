cwlVersion: v1.2
class: CommandLineTool
baseCommand: convertInversion.py
label: manta_convertInversion.py
doc: 'Convert pairs of Manta inversion breakend (BND) records in a VCF into single
  symbolic <INV> records; the converted VCF goes to standard output.


  Tool homepage: https://github.com/Illumina/manta'
inputs:
  - id: samtools_path
    type: string
    default: /usr/local/libexec/samtools
    doc: Path of the samtools executable (the copy bundled with Manta is the default)
    inputBinding:
      position: 1
  - id: reference_fasta
    type: File
    secondaryFiles:
      - pattern: .fai
    doc: Reference FASTA file, indexed with samtools faidx
    inputBinding:
      position: 2
  - id: vcf_file
    type: File
    doc: Manta VCF file (plain or gzipped) with inversion breakend records
    inputBinding:
      position: 3
outputs:
  - id: converted_vcf
    type: stdout
    doc: VCF with inversions as symbolic <INV> records
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/manta:1.6.0--py27h9948957_6
stdout: manta_convertInversion.vcf

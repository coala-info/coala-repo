cwlVersion: v1.2
class: CommandLineTool
baseCommand: popins2 genotype
label: popins2_genotype
doc: "Computes genotype likelihoods for a sample for all insertions given in the input
  VCF file by aligning all reads, which are mapped to the reference genome around
  the insertion breakpoint or to the contig, to the reference and to the alternative
  insertion sequence. VCF records with the genotype likelihoods in GT:PL format for
  the individual are written to a file insertions.vcf in the sample directory.\n\n\
  Tool homepage: https://github.com/kehrlab/PopIns2"
inputs:
  - id: sample_id
    type: string
    doc: Sample ID
    inputBinding:
      position: 1
  - id: contigs
    type:
      - 'null'
      - File
    doc: 'Name of supercontigs file. Valid filetypes are: fa, fna, and fasta.'
    default: supercontigs.fa
    inputBinding:
      position: 102
      prefix: --contigs
  - id: genotyping_model
    type:
      - 'null'
      - string
    doc: Model used for genotyping. One of DUP and RANDOM.
    default: RANDOM
    inputBinding:
      position: 102
      prefix: --model
  - id: insertions
    type:
      - 'null'
      - File
    doc: 'Name of VCF input file. Valid filetype is: vcf.'
    default: insertions.vcf
    inputBinding:
      position: 102
      prefix: --insertions
  - id: prefix
    type:
      - 'null'
      - Directory
    doc: Path to the sample directories.
    default: .
    inputBinding:
      position: 102
      prefix: --prefix
  - id: reference
    type:
      - 'null'
      - File
    doc: 'Name of reference genome file. Valid filetypes are: fa, fna, and fasta.'
    default: genome.fa
    inputBinding:
      position: 102
      prefix: --reference
  - id: window
    type:
      - 'null'
      - int
    doc: Region window size.
    default: 50
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stdout: popins2_genotype.out

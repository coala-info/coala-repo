cwlVersion: v1.2
class: CommandLineTool
baseCommand: alleleCounts.pl
label: perl-sanger-cgp-allelecount_alleleCounter.pl
doc: "Extract allele counts from BAM/CRAM files at specific loci.\n\nTool homepage:
  https://github.com/cancerit/alleleCount"
inputs:
  - id: bam
    type: File
    doc: BAM/CRAM file (expects co-located index) - if CRAM see '-ref'
    inputBinding:
      position: 101
      prefix: -bam
  - id: gender
    type:
      - 'null'
      - boolean
    doc: flag, presence indicates loci file to be treated as gender SNPs. - 
      cannot be used with 's'
    inputBinding:
      position: 101
      prefix: -gender
  - id: loci
    type: File
    doc: Alternate loci file (just needs chr pos) - output is different, counts 
      for each residue
    inputBinding:
      position: 101
      prefix: -loci
  - id: map_qual
    type:
      - 'null'
      - int
    doc: Minimum mapping quality of read (integer)
    default: 35
    inputBinding:
      position: 101
      prefix: -mapqual
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Minimum base quality to include (integer)
    default: 30
    inputBinding:
      position: 101
      prefix: -minqual
  - id: ref
    type:
      - 'null'
      - File
    doc: genome.fa, required for CRAM (with colocated .fai)
    inputBinding:
      position: 101
      prefix: -ref
  - id: snp6
    type:
      - 'null'
      - boolean
    doc: flag, presence indicates loci file is SNP6 format. - cannot be used 
      with 'g' - changes output format
    inputBinding:
      position: 101
      prefix: -snp6
outputs:
  - id: output
    type: File
    doc: Output file [STDOUT]
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-sanger-cgp-allelecount:4.3.0--pl5321h7b50bb2_2

cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-dipcall
label: dipcall
doc: "A variant calling pipeline for diploid assemblies. It takes a reference genome
  and two haploid assemblies (paternal and maternal) to produce a VCF of variants.
  run-dipcall writes a Makefile, which is then run with make.\n\
  \nTool homepage: https://github.com/lh3/dipcall"
inputs:
  - id: prefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 2
  - id: ref_fasta
    type: File
    secondaryFiles:
      - .fai
    doc: Reference genome FASTA file (indexed with samtools faidx)
    inputBinding:
      position: 3
  - id: pat_fasta
    type: File
    doc: Paternal haploid assembly FASTA file
    inputBinding:
      position: 4
  - id: mat_fasta
    type: File
    doc: Maternal haploid assembly FASTA file
    inputBinding:
      position: 5
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads [8]
    inputBinding:
      position: 1
      prefix: -t
  - id: ref_index
    type:
      - 'null'
      - File
    doc: unimap/minimap2 index for ref.fa
    inputBinding:
      position: 1
      prefix: -d
  - id: all_contigs
    type:
      - 'null'
      - boolean
    doc: call on all contigs regardless of naming
    inputBinding:
      position: 1
      prefix: -a
  - id: par_bed
    type:
      - 'null'
      - File
    doc: PAR on chrX; assuming male
    inputBinding:
      position: 1
      prefix: -x
  - id: zdrop
    type:
      - 'null'
      - int
    doc: Z-drop [mapper default]
    inputBinding:
      position: 1
      prefix: -z
  - id: use_minimap2
    type:
      - 'null'
      - boolean
    doc: use minimap2 for mapping (default)
    inputBinding:
      position: 1
      prefix: -m
  - id: use_unimap
    type:
      - 'null'
      - boolean
    doc: use unimap for mapping
    inputBinding:
      position: 1
      prefix: -u
  - id: repetitive_kmers
    type:
      - 'null'
      - File
    doc: repetitive k-mer list; use winnowmap for mapping
    inputBinding:
      position: 1
      prefix: -W
arguments:
  - position: 6
    shellQuote: false
    valueFrom: '> $(inputs.prefix).mak && make -f $(inputs.prefix).mak'
outputs:
  - id: makefile
    type: File
    doc: Makefile written by run-dipcall
    outputBinding:
      glob: $(inputs.prefix).mak
  - id: dip_vcf
    type: File
    doc: Phased diploid variant calls
    outputBinding:
      glob: $(inputs.prefix).dip.vcf.gz
  - id: dip_bed
    type: File
    doc: Confident regions covered by both haplotypes
    outputBinding:
      glob: $(inputs.prefix).dip.bed
  - id: pair_vcf
    type:
      - 'null'
      - File
    doc: Unphased pileup of both haplotypes
    outputBinding:
      glob: $(inputs.prefix).pair.vcf.gz
  - id: hap_bams
    type:
      type: array
      items: File
    doc: Haplotype alignments to the reference
    outputBinding:
      glob: $(inputs.prefix).hap*.bam
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dipcall:0.3--hdfd78af_0

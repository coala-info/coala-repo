cwlVersion: v1.2
class: CommandLineTool
baseCommand: rascaf
label: rascaf
doc: "RASCaf: a tool for scaffolding genome assemblies using BAM alignments.\n\nTool
  homepage: https://github.com/mourisl/Rascaf"
inputs:
  - id: alignment_bam
    type: File
    doc: the path to the coordinate-sorted alignment BAM file
    inputBinding:
      position: 101
      prefix: -b
  - id: assembly_fasta
    type:
      - 'null'
      - File
    doc: the paths to the raw assembly fasta file
    inputBinding:
      position: 101
      prefix: -f
  - id: break_on_ns
    type:
      - 'null'
      - int
    doc: the least number of Ns to break a scaffold in the raw assembly
    inputBinding:
      position: 101
      prefix: -breakN
  - id: clipping_bam
    type:
      - 'null'
      - File
    doc: the path to the alignment BAM file allowing clipping from non-spliced 
      aligner
    inputBinding:
      position: 101
      prefix: -bc
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: the size of a kmer(<=32; <=0 if you do not want to use kmer.
    inputBinding:
      position: 101
      prefix: -k
  - id: min_contig_support
    type:
      - 'null'
      - int
    doc: minimum support for connecting two contigs
    inputBinding:
      position: 101
      prefix: -ms
  - id: min_exonic_length
    type:
      - 'null'
      - int
    doc: minimum exonic length
    inputBinding:
      position: 101
      prefix: -ml
  - id: output_cs_fasta
    type:
      - 'null'
      - boolean
    doc: output the genomic sequence involved in connections in file 
      $prefix_cs.fa
    inputBinding:
      position: 101
      prefix: -cs
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix of the output file
    inputBinding:
      position: 101
      prefix: -o
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rascaf:20180710--h5ca1c30_1
stdout: rascaf.out

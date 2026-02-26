cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicstuff_iteralign
label: hicstuff_iteralign
doc: "Truncate reads from a fastq file to 20 basepairs and iteratively extend and\n\
  \    re-align the unmapped reads to optimize the proportion of uniquely aligned\n\
  \    reads in a 3C library.\n\nTool homepage: https://github.com/koszullab/hicstuff"
inputs:
  - id: reads_fq
    type: File
    doc: Fastq file containing the reads to be aligned
    inputBinding:
      position: 1
  - id: aligner
    type:
      - 'null'
      - string
    doc: Choose alignment software between bowtie2, minimap2 or bwa. minimap2 
      should only be used for reads > 100 bp.
    default: bowtie2
    inputBinding:
      position: 102
      prefix: --aligner
  - id: genome
    type: File
    doc: "The genome on which to map the reads. Must be\n                        \
      \         the path to the bowtie2/bwa index if using bowtie2/bwa\n         \
      \                        or to the genome in fasta format if using minimap2."
    inputBinding:
      position: 102
      prefix: --genome
  - id: min_len
    type:
      - 'null'
      - int
    doc: "Length to which the reads should be\n                                 truncated"
    default: 20
    inputBinding:
      position: 102
      prefix: --min-len
  - id: read_len
    type:
      - 'null'
      - int
    doc: "Read length in input FASTQ file. If not provided,\n                    \
      \             this is estimated from the first read in the file."
    inputBinding:
      position: 102
      prefix: --read-len
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: "Temporary directory. Defaults to current\n                             \
      \    directory."
    inputBinding:
      position: 102
      prefix: --tempdir
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of parallel threads allocated for the\n                         \
      \        alignment"
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: out_bam
    type: File
    doc: "Path where the alignment will be written in\n                          \
      \       BAM format."
    outputBinding:
      glob: $(inputs.out_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicstuff:3.2.4--pyhdfd78af_0

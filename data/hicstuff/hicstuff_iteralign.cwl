cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicstuff
  - iteralign
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
    doc: Choose alignment software between bowtie2, minimap2 or bwa. minimap2 should
      only be used for reads > 100 bp.
    inputBinding:
      position: 102
      prefix: --aligner
  - id: genome
    type: File
    doc: Genome FASTA on which to map the reads, with its bowtie2 index files (same
      prefix, e.g. seq.fa with seq.1.bt2 ...) beside it for bowtie2, or its bwa index
      files for bwa. minimap2 only needs the FASTA.
    inputBinding:
      position: 102
      prefix: --genome
      valueFrom: '${ return (inputs.aligner == ''bwa'' || inputs.aligner == ''minimap2'')
        ? self.path : self.path.replace(/\.[^.\/]*$/, ''''); }'
    secondaryFiles:
      - pattern: ^.1.bt2
        required: false
      - pattern: ^.2.bt2
        required: false
      - pattern: ^.3.bt2
        required: false
      - pattern: ^.4.bt2
        required: false
      - pattern: ^.rev.1.bt2
        required: false
      - pattern: ^.rev.2.bt2
        required: false
      - pattern: .amb
        required: false
      - pattern: .ann
        required: false
      - pattern: .bwt
        required: false
      - pattern: .pac
        required: false
      - pattern: .sa
        required: false
  - id: min_len
    type:
      - 'null'
      - int
    doc: "Length to which the reads should be\n                                 truncated"
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
      - string
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
    inputBinding:
      position: 102
      prefix: --threads
  - id: out_bam_path
    type: string
    doc: Path where the alignment will be written in
    inputBinding:
      position: 103
      prefix: --out-bam
outputs:
  - id: out_bam
    type: File
    doc: "Path where the alignment will be written in\n                          \
      \       BAM format."
    outputBinding:
      glob: $(inputs.out_bam_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicstuff:3.2.4--pyhdfd78af_0

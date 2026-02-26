cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanovar
label: nanovar
doc: "NanoVar is a long-read structural variant (SV) caller.\n\nTool homepage: https://github.com/cytham/nanovar"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Path to long reads or mapped BAM/CRAM file.\n                        Formats:
      fasta/fa/fa.gzip/fa.gz/fastq/fq/fq.gzip/fq.gz/bam/cram"
    inputBinding:
      position: 1
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: "Path to reference genome in FASTA. Genome indexes created \n           \
      \             will overwrite indexes created by other aligners such as bwa."
    inputBinding:
      position: 2
  - id: work_directory
    type:
      - 'null'
      - Directory
    doc: "Path to work directory. Directory will be created \n                   \
      \     if it does not exist."
    inputBinding:
      position: 3
  - id: annotate_ins
    type:
      - 'null'
      - string
    doc: "Enable annotation of INS with NanoINSight, \n                        please
      specify species of sample [None]\n                        Currently supported
      species are:\n                        'human', 'mouse', and 'rattus'."
    default: None
    inputBinding:
      position: 104
      prefix: --annotate_ins
  - id: buffer
    type:
      - 'null'
      - int
    doc: Nucleotide length buffer for SV breakend clustering
    default: 50
    inputBinding:
      position: 104
      prefix: --buffer
  - id: data_type
    type:
      - 'null'
      - string
    doc: "Type of long-read data [ont]\n                        ont - Oxford Nanopore
      Technologies\n                        pacbio-clr - Pacific Biosciences CLR\n\
      \                        pacbio-ccs - Pacific Biosciences CCS"
    default: ont
    inputBinding:
      position: 104
      prefix: --data_type
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Run in debug mode
    inputBinding:
      position: 104
      prefix: --debug
  - id: filter_bed
    type:
      - 'null'
      - File
    doc: "BED file with genomic regions to be excluded [None]\n                  \
      \      (e.g. telomeres and centromeres) Either specify name of in-built \n \
      \                       reference genome filter (i.e. hg38, hg19, mm10) or provide
      full \n                        path to own BED file."
    default: None
    inputBinding:
      position: 104
      prefix: --filter_bed
  - id: hetero
    type:
      - 'null'
      - float
    doc: "Lower limit of a breakend read ratio to classify a heterozygous state [0.35]\n\
      \                        (i.e. Any breakend with hetero<=ratio<homo is classified
      as heterozygous)"
    default: 0.35
    inputBinding:
      position: 104
      prefix: --hetero
  - id: homo
    type:
      - 'null'
      - float
    doc: "Lower limit of a breakend read ratio to classify a homozygous state [0.75]\n\
      \                        (i.e. Any breakend with homo<=ratio<=1.00 is classified
      as homozygous)"
    default: 0.75
    inputBinding:
      position: 104
      prefix: --homo
  - id: mafft_executable
    type:
      - 'null'
      - File
    doc: Specify path to 'mafft' executable for NanoINSight
    inputBinding:
      position: 104
      prefix: --ma
  - id: minalign
    type:
      - 'null'
      - int
    doc: Minimum alignment length for single alignment reads
    default: 200
    inputBinding:
      position: 104
      prefix: --minalign
  - id: mincov
    type:
      - 'null'
      - int
    doc: Minimum number of reads required to call a breakend
    default: 4
    inputBinding:
      position: 104
      prefix: --mincov
  - id: minimap2_executable
    type:
      - 'null'
      - File
    doc: Specify path to 'minimap2' executable
    inputBinding:
      position: 104
      prefix: --mm
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum length of SV to be detected
    default: 25
    inputBinding:
      position: 104
      prefix: --minlen
  - id: model
    type:
      - 'null'
      - File
    doc: Specify path to custom-built model
    inputBinding:
      position: 104
      prefix: --model
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Hide verbose
    inputBinding:
      position: 104
      prefix: --quiet
  - id: repeatmasker_executable
    type:
      - 'null'
      - File
    doc: Specify path to 'RepeatMasker' executable for NanoINSight
    inputBinding:
      position: 104
      prefix: --rm
  - id: samtools_executable
    type:
      - 'null'
      - File
    doc: Specify path to 'samtools' executable
    inputBinding:
      position: 104
      prefix: --st
  - id: score
    type:
      - 'null'
      - float
    doc: "Score threshold for defining PASS/FAIL SVs in VCF [1.0]\n              \
      \          Default score 1.0 was estimated from simulated analysis."
    default: 1.0
    inputBinding:
      position: 104
      prefix: --score
  - id: splitpct
    type:
      - 'null'
      - float
    doc: "Minimum percentage of unmapped bases within a long read \n             \
      \           to be considered as a split-read. 0.05<=p<=0.50"
    default: 0.05
    inputBinding:
      position: 104
      prefix: --splitpct
  - id: sv_bam_out
    type:
      - 'null'
      - boolean
    doc: "Outputs a BAM file containing only SV-supporting reads with \n         \
      \               their corresponding SV-ID(s) stored in the \"nv\" tag separated
      by comma."
    inputBinding:
      position: 104
      prefix: --sv_bam_out
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of available threads for use
    default: 1
    inputBinding:
      position: 104
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanovar:1.8.3--py311haab0aaa_0
stdout: nanovar.out

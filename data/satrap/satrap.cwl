cwlVersion: v1.2
class: CommandLineTool
baseCommand: satrap
label: satrap
doc: "SATRAP - a Solid Assembly TRAnslator Program\n\nTool homepage: http://satrap.cribi.unipd.it/cgi-bin/satrap.pl"
inputs:
  - id: Q
    type:
      - 'null'
      - int
    doc: minimum mean quality for reads [9]
    default: 9
    inputBinding:
      position: 101
      prefix: -Q
  - id: T2
    type:
      - 'null'
      - int
    doc: it trims sequences at 3' end [0]
    default: 0
    inputBinding:
      position: 101
      prefix: -T2
  - id: bin
    type:
      - 'null'
      - string
    doc: Set the directory path where binaries are located [bin/]
    default: bin/
    inputBinding:
      position: 101
      prefix: -bin
  - id: c
    type:
      - 'null'
      - int
    doc: "Minimum coverage required to operate the assembly correction\n         \
      \                              If this parameter is used -z will be not considered."
    inputBinding:
      position: 101
      prefix: -c
  - id: erode
    type:
      - 'null'
      - int
    doc: Minimum coverage considered to erode contig ends [2]
    default: 2
    inputBinding:
      position: 101
      prefix: -erode
  - id: erosion
    type:
      - 'null'
      - boolean
    doc: it doesn't erodes contig ends in any way
    inputBinding:
      position: 101
      prefix: -erosion
  - id: fasta
    type: File
    doc: Double encoded color space assembly in FASTA format.
    inputBinding:
      position: 101
      prefix: -fasta
  - id: file_esten
    type: string
    doc: extension of read files. Example "-file_esten .csfastq"
    inputBinding:
      position: 101
      prefix: -file_esten
  - id: kmer_set
    type:
      - 'null'
      - type: array
        items: int
    doc: Set the kmer to be considered. [23 25 27 29 31]
    default:
      - 23
      - 25
      - 27
      - 29
      - 31
    inputBinding:
      position: 101
      prefix: -kmer_set
  - id: l
    type:
      - 'null'
      - int
    doc: Minimum contig length [100]
    default: 100
    inputBinding:
      position: 101
      prefix: -l
  - id: len
    type:
      - 'null'
      - int
    doc: minimum read size after trimming [30]
    default: 30
    inputBinding:
      position: 101
      prefix: -len
  - id: mate_pair
    type:
      - 'null'
      - boolean
    doc: "The sequences coming from mate pair libraries will be \n               \
      \                        managed as paired-end (for assembling purpose) [disabled]"
    inputBinding:
      position: 101
      prefix: -mate-pair
  - id: max_reads
    type:
      - 'null'
      - float
    doc: Max number of reads per analyzed file or files [10]
    default: 10
    inputBinding:
      position: 101
      prefix: -max_reads
  - id: n
    type:
      - 'null'
      - float
    doc: "Maximum tolerated fraction of Ns for each translated contig[1].\n      \
      \                                 Low values are more conservative when the
      error correction is applied.\n                                       As\n  \
      \                                     consequence of this fact Ns will be introduced
      around color\n                                       incoherence not supported
      by enough sequence coverage."
    default: 1.0
    inputBinding:
      position: 101
      prefix: -n
  - id: no_clustering
    type:
      - 'null'
      - boolean
    doc: For DNA-seq assembly. It doesn't considers the clustering analysis
    inputBinding:
      position: 101
      prefix: -no_clustering
  - id: oases_kmer
    type:
      - 'null'
      - int
    doc: Oases kmer parameter [27]
    default: 27
    inputBinding:
      position: 101
      prefix: -oases_kmer
  - id: oases_path
    type:
      - 'null'
      - string
    doc: 'path to Oases binary - example: path/oases/ '
    inputBinding:
      position: 101
      prefix: -oases_path
  - id: q
    type:
      - 'null'
      - int
    doc: minimum mean quality tolerated for paired_end sequences [15]
    default: 15
    inputBinding:
      position: 101
      prefix: -q
  - id: reads_path
    type: Directory
    doc: directory containing the SOLiD reads in CSFASTQ format
    inputBinding:
      position: 101
      prefix: -reads_path
  - id: step
    type:
      - 'null'
      - type: array
        items: int
    doc: "PLEASE SELECT THE DESIRED STEP OF THE ANALYSIS USING \"-step\" parameter:\n\
      \                                       \"1\" for STEP 1, \"2\" for STEP 2 etc.
      For instance the Oases pipeline\n                                       requires:
      \"-step 1 2\". The steps 3 and 4 are set by default, so the\n              \
      \                         omitting of this parameter will erase the previous
      results in these steps"
    inputBinding:
      position: 101
      prefix: -step
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: Velvet will be set considering specific strand
    inputBinding:
      position: 101
      prefix: -strand_specific
  - id: t1
    type:
      - 'null'
      - int
    doc: it trims the first sequenced end at 3' (if paired-end) [0]
    default: 0
    inputBinding:
      position: 101
      prefix: -t1
  - id: t2
    type:
      - 'null'
      - int
    doc: it trims the second sequenced end at 3' [0]
    default: 0
    inputBinding:
      position: 101
      prefix: -t2
  - id: tags
    type:
      - 'null'
      - type: array
        items: string
    doc: "pair-end tag names for assembling purpose. It enables paired-end\n     \
      \                                  management (-t1) (tag examples: F3, F5-RNA
      ...)"
    inputBinding:
      position: 101
      prefix: -tags
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Set the temporary directory where results will be saved [tmp/].
    default: tmp/
    inputBinding:
      position: 101
      prefix: -tmp_dir
  - id: velvet_path
    type:
      - 'null'
      - string
    doc: 'path to velvet binaries - example: path/velvet/ '
    inputBinding:
      position: 101
      prefix: -velvet_path
  - id: z
    type:
      - 'null'
      - float
    doc: "z-score required to calculate the coverage threshold basing on\n       \
      \                                the statistical analysis of the sequence coverage
      [3]. Low values\n                                       are more conservative
      when the error correction is applied. As\n                                 \
      \      consequence of this fact Ns will be introduced around color\n       \
      \                                incoherence not supported by enough sequence
      coverage."
    default: 3.0
    inputBinding:
      position: 101
      prefix: -z
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satrap:0.2--h9948957_7
stdout: satrap.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: kssd dist
label: kssd_dist
doc: "The dist doc prefix.\n\nTool homepage: https://github.com/yhg926/public_kssd"
inputs:
  - id: query
    type:
      - 'null'
      - string
    doc: query sequence
    inputBinding:
      position: 1
  - id: DimRdcLevel
    type:
      - 'null'
      - int
    doc: Dimension Reduction Level or provide .shuf file
    inputBinding:
      position: 102
      prefix: --DimRdcLevel
  - id: LstKmerOcrs
    type:
      - 'null'
      - int
    doc: Specify the Least Kmer occurence in fastq file
    inputBinding:
      position: 102
      prefix: --LstKmerOcrs
  - id: abundance
    type:
      - 'null'
      - boolean
    doc: abundance estimate mode.
    inputBinding:
      position: 102
      prefix: --abundance
  - id: byread
    type:
      - 'null'
      - boolean
    doc: sketch the file by read
    inputBinding:
      position: 102
      prefix: --byread
  - id: correction
    type:
      - 'null'
      - int
    doc: perform correction for shared k-mer counts or not.
    inputBinding:
      position: 102
      prefix: --correction
  - id: halfKmerlength
    type:
      - 'null'
      - int
    doc: 'set half Kmer length: 2-15'
    inputBinding:
      position: 102
      prefix: --halfKmerlength
  - id: keepcofile
    type:
      - 'null'
      - boolean
    doc: keep intermedia .co files.
    inputBinding:
      position: 102
      prefix: --keepcofile
  - id: keepskf
    type:
      - 'null'
      - boolean
    doc: turn on share_kmer_ct file keep mode.
    inputBinding:
      position: 102
      prefix: --keepskf
  - id: list
    type:
      - 'null'
      - File
    doc: a file contain paths for all query sequences
    inputBinding:
      position: 102
      prefix: --list
  - id: maxMemory
    type:
      - 'null'
      - string
    doc: maximal memory (in G) usage allowed
    inputBinding:
      position: 102
      prefix: --maxMemory
  - id: metric
    type:
      - 'null'
      - int
    doc: 'output metrics: 0: Jaccard/1: Containment'
    inputBinding:
      position: 102
      prefix: --metric
  - id: mutDist_max
    type:
      - 'null'
      - float
    doc: max mutation allowed for distance output.
    inputBinding:
      position: 102
      prefix: --mutDist_max
  - id: neighborN_max
    type:
      - 'null'
      - int
    doc: max number of nearest reference genomes.
    inputBinding:
      position: 102
      prefix: --neighborN_max
  - id: outfields
    type:
      - 'null'
      - int
    doc: 'output fields(latter includes former): Distance/Q-values/Confidence Intervels.'
    inputBinding:
      position: 102
      prefix: --outfields
  - id: pipecmd
    type:
      - 'null'
      - string
    doc: pipe command.
    inputBinding:
      position: 102
      prefix: --pipecmd
  - id: quality
    type:
      - 'null'
      - int
    doc: Filter Kmer with lowest base quality < q (Phred).
    inputBinding:
      position: 102
      prefix: --quality
  - id: reference_dir
    type:
      - 'null'
      - Directory
    doc: reference genome/database search against.
    inputBinding:
      position: 102
      prefix: --reference_dir
  - id: skf
    type:
      - 'null'
      - File
    doc: share_kmer_ct file path.
    inputBinding:
      position: 102
      prefix: --skf
  - id: threadN
    type:
      - 'null'
      - int
    doc: set threads number
    inputBinding:
      position: 102
      prefix: --threadN
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: folder path for results files.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kssd:2.21--h577a1d6_3

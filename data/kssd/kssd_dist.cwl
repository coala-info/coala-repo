cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kssd
  - dist
label: kssd_dist
doc: "Sequence sketching and distance estimation: sketch genomes or reads, index reference sketches, and search queries against them.\n\nTool homepage: https://github.com/yhg926/public_kssd"
inputs:
  - id: query
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: "Query sequence files or directories (or sketch directories); staged writable because the tool may write into a sketch directory"
    inputBinding:
      position: 200
  - id: list_member_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Sequence files named in the --list file, staged into the working directory"
  - id: abundance
    type:
      - 'null'
      - boolean
    doc: "abundance estimate mode"
    inputBinding:
      position: 102
      prefix: --abundance
  - id: byread
    type:
      - 'null'
      - boolean
    doc: "sketch the file by read [false]"
    inputBinding:
      position: 102
      prefix: --byread
  - id: correction
    type:
      - 'null'
      - int
    doc: "perform correction for shared k-mer counts or not (0/1) [0]"
    inputBinding:
      position: 102
      prefix: --correction
  - id: mutDist_max
    type:
      - 'null'
      - float
    doc: "max mutation allowed for distance output [1]"
    inputBinding:
      position: 102
      prefix: --mutDist_max
  - id: skf
    type:
      - 'null'
      - string
    doc: "share_kmer_ct file path"
    inputBinding:
      position: 102
      prefix: --skf
  - id: keepcofile
    type:
      - 'null'
      - boolean
    doc: "keep intermediate .co files"
    inputBinding:
      position: 102
      prefix: --keepcofile
  - id: keepskf
    type:
      - 'null'
      - boolean
    doc: "turn on share_kmer_ct file keep mode [false]"
    inputBinding:
      position: 102
      prefix: --keepskf
  - id: halfKmerlength
    type:
      - 'null'
      - int
    doc: "set half Kmer length: 2-15 [8]"
    inputBinding:
      position: 102
      prefix: --halfKmerlength
  - id: list
    type:
      - 'null'
      - File
    doc: "a file containing paths for all query sequences"
    inputBinding:
      position: 102
      prefix: --list
  - id: DimRdcLevel
    type:
      - 'null'
      - int
      - File
    doc: "Dimension reduction level (integer) or a .shuf file [2]"
    inputBinding:
      position: 102
      prefix: --DimRdcLevel
  - id: maxMemory
    type:
      - 'null'
      - string
    doc: "maximal memory (in G) usage allowed"
    inputBinding:
      position: 102
      prefix: --maxMemory
  - id: metric
    type:
      - 'null'
      - int
    doc: "output metrics: 0: Jaccard/1: Containment [0]"
    inputBinding:
      position: 102
      prefix: --metric
  - id: LstKmerOcrs
    type:
      - 'null'
      - int
    doc: "Specify the least k-mer occurrence in fastq file"
    inputBinding:
      position: 102
      prefix: --LstKmerOcrs
  - id: neighborN_max
    type:
      - 'null'
      - int
    doc: "max number of nearest reference genomes [1]"
    inputBinding:
      position: 102
      prefix: --neighborN_max
  - id: outfields
    type:
      - 'null'
      - int
    doc: "output fields (latter includes former): 0 Distance / 1 Q-values / 2 Confidence Intervals [2]"
    inputBinding:
      position: 102
      prefix: --outfields
  - id: threadN
    type:
      - 'null'
      - int
    doc: "set threads number [all threads]"
    inputBinding:
      position: 102
      prefix: --threadN
  - id: pipecmd
    type:
      - 'null'
      - string
    doc: "pipe command"
    inputBinding:
      position: 102
      prefix: --pipecmd
  - id: quality
    type:
      - 'null'
      - int
    doc: "Filter k-mers with lowest base quality < q (Phred) [0]"
    inputBinding:
      position: 102
      prefix: --quality
  - id: reference_dir
    type:
      - 'null'
      - Directory
    doc: "reference genome/database sketch directory to search against"
    inputBinding:
      position: 102
      prefix: --reference_dir
  - id: outdir_path
    type: string
    doc: "folder path for results files"
    inputBinding:
      position: 103
      prefix: --outdir
outputs:
  - id: outdir
    type: Directory
    doc: "Output folder (sketches and distance.out)"
    outputBinding:
      glob: $(inputs.outdir_path)
  - id: stdout_out
    type: stdout
    doc: "Standard output"
stdout: kssd_dist.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.query ? inputs.query : [])"
        writable: true
      - entry: "$(inputs.list_member_files ? inputs.list_member_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kssd:2.21--h577a1d6_3

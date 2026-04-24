cwlVersion: v1.2
class: CommandLineTool
baseCommand: chisel
label: chisel
doc: "CHISEL command to run the complete pipeline starting from the 4 required data:\n\
  (1) Barcoded single-cell BAM; (2) Matched-normal BAM; (3) Reference genome;\n(4)
  Phased VCF.\n\nTool homepage: https://github.com/raphael-group/chisel"
inputs:
  - id: addgccorr
    type:
      - 'null'
      - boolean
    doc: "Add additional custome correction for GC bias\n(default: disabled)"
    inputBinding:
      position: 101
      prefix: --addgccorr
  - id: bcftools
    type:
      - 'null'
      - Directory
    doc: "Path to the directory to \"bcftools\" executable,\nrequired in default mode
      (default: bcftools is\ndirectly called as it is in user $PATH)"
    inputBinding:
      position: 101
      prefix: --bcftools
  - id: blocksize
    type:
      - 'null'
      - string
    doc: "Size of the haplotype blocks (default: 50kb, use 0 to\ndisable)"
    inputBinding:
      position: 101
      prefix: --blocksize
  - id: cellprefix
    type:
      - 'null'
      - string
    doc: "Prefix of cell barcode field in SAM format (default:\nCB:Z:)"
    inputBinding:
      position: 101
      prefix: --cellprefix
  - id: cellsuffix
    type:
      - 'null'
      - string
    doc: "Suffix of cell barcode field in SAM format (default:\nnone)"
    inputBinding:
      position: 101
      prefix: --cellsuffix
  - id: chromosomes
    type:
      - 'null'
      - string
    doc: "Space-separeted list of chromosomes between apices\n(default: \"chr1 chr2
      chr3 chr4 chr5 chr6 chr7 chr8\nchr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16
      chr17\nchr18 chr19 chr20 chr21 chr22\")"
      chr14 chr15 chr16 chr17\nchr18 chr19 chr20 chr21 chr22"
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: jobs
    type:
      - 'null'
      - int
    doc: "Number of parallele jobs to use (default: equal to\nnumber of available
      processors)"
    inputBinding:
      position: 101
      prefix: --jobs
  - id: listphased
    type: File
    doc: "Phased SNPs file (lines of heterozygous germline SNPs\nmust contain either
      0|1 or 1|0)"
    inputBinding:
      position: 101
      prefix: --listphased
  - id: maxploidy
    type:
      - 'null'
      - int
    doc: "Maximum total copy number to consider for balanced\ncluster (default: 4,
      corresponding to a WGD)"
    inputBinding:
      position: 101
      prefix: --maxploidy
  - id: minreads
    type:
      - 'null'
      - int
    doc: "Minimum number total reads to select cells (default:\n300000)"
    inputBinding:
      position: 101
      prefix: --minreads
  - id: nophasecorr
    type:
      - 'null'
      - boolean
    doc: 'Disable correction for given phasing bias (default: enabled)'
    inputBinding:
      position: 101
      prefix: --nophasecorr
  - id: normal
    type: File
    doc: Matched-normal BAM file
    inputBinding:
      position: 101
      prefix: --normal
  - id: reference
    type: File
    doc: Reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: running_directory
    type:
      - 'null'
      - Directory
    doc: 'Running directory (default: current directory)'
    inputBinding:
      position: 101
      prefix: --rundir
  - id: samtools
    type:
      - 'null'
      - Directory
    doc: "Path to the directory to \"samtools\" executable,\nrequired in default mode
      (default: samtools is\ndirectly called as it is in user $PATH)"
    inputBinding:
      position: 101
      prefix: --samtools
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random seed for replication (default: None)'
    inputBinding:
      position: 101
      prefix: --seed
  - id: size
    type:
      - 'null'
      - string
    doc: Bin size, with or without "kb" or "Mb"
    inputBinding:
      position: 101
      prefix: --size
  - id: tumor
    type: File
    doc: Barcoded single-cell BAM file
    inputBinding:
      position: 101
      prefix: --tumor
  - id: upperk
    type:
      - 'null'
      - int
    doc: "Maximum number of bin clusters (default: 100, use 0 to\nconsider maximum
      number of clusters)"
    inputBinding:
      position: 101
      prefix: --upperk
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chisel:1.1.4--pyhdfd78af_0
stdout: chisel.out

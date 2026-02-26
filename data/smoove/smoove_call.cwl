cwlVersion: v1.2
class: CommandLineTool
baseCommand: smoove
label: smoove_call
doc: "Runs lumpy and sends output to {outdir}/{name}-smoove.vcf.gz if --genotype is
  requested, the output goes to {outdir}/{name}-smoove.genotyped.vcf.gz\n\nTool homepage:
  https://github.com/brentp/smoove"
inputs:
  - id: bams
    type:
      type: array
      items: File
    doc: path to bam(s) to call.
    inputBinding:
      position: 1
  - id: duphold
    type:
      - 'null'
      - boolean
    doc: run duphold on output. only works with --genotype
    inputBinding:
      position: 102
      prefix: --duphold
  - id: exclude
    type:
      - 'null'
      - File
    doc: BED of exclude regions.
    inputBinding:
      position: 102
      prefix: --exclude
  - id: excludechroms
    type:
      - 'null'
      - string
    doc: ignore SVs with either end in this comma-delimited list of chroms. If 
      this starts with ~ it is treated as a regular expression to exclude.
    default: hs37d5,~:,~^GL,~decoy
    inputBinding:
      position: 102
      prefix: --excludechroms
  - id: fasta
    type: File
    doc: fasta file.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: genotype
    type:
      - 'null'
      - boolean
    doc: stream output to svtyper for genotyping
    inputBinding:
      position: 102
      prefix: --genotype
  - id: name
    type: string
    doc: project name used in output files.
    inputBinding:
      position: 102
      prefix: --name
  - id: noextrafilters
    type:
      - 'null'
      - boolean
    doc: use lumpy_filter only without extra smoove filters.
    inputBinding:
      position: 102
      prefix: --noextrafilters
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: output directory.
    inputBinding:
      position: 102
      prefix: --outdir
  - id: processes
    type:
      - 'null'
      - int
    doc: number of processors to parallelize.
    default: 3
    inputBinding:
      position: 102
      prefix: --processes
  - id: removepr
    type:
      - 'null'
      - boolean
    doc: remove PRPOS and PREND tags from INFO (only used with --gentoype).
    inputBinding:
      position: 102
      prefix: --removepr
  - id: support
    type:
      - 'null'
      - int
    doc: mininum support required to report a variant.
    default: 4
    inputBinding:
      position: 102
      prefix: --support
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
stdout: smoove_call.out

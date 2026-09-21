cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2-build
label: hisat2-build
doc: Build HISAT2 index from reference sequences
inputs:
  - id: reference_in
    type:
      type: array
      items: File
    doc: comma-separated list of files with ref sequences
    inputBinding:
      position: 1
      itemSeparator: ','
  - id: ht2_index_base
    type: string
    doc: write ht2 data to files with this dir/basename
    inputBinding:
      position: 2
  - id: reference_cmdline
    type:
      - 'null'
      - boolean
    doc: reference sequences given on cmd line (as <reference_in>)
    inputBinding:
      position: 103
      prefix: -c
  - id: large_index
    type:
      - 'null'
      - boolean
    doc: force generated index to be 'large', even if ref has fewer than 4 
      billion nucleotides
    inputBinding:
      position: 103
      prefix: --large-index
  - id: noauto
    type:
      - 'null'
      - boolean
    doc: disable automatic -p/--bmax/--dcv memory-fitting
    inputBinding:
      position: 103
      prefix: --noauto
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: -p
  - id: bmax
    type:
      - 'null'
      - int
    doc: max bucket sz for blockwise suffix-array builder
    inputBinding:
      position: 103
      prefix: --bmax
  - id: bmaxdivn
    type:
      - 'null'
      - int
    doc: max bucket sz as divisor of ref len
    inputBinding:
      position: 103
      prefix: --bmaxdivn
  - id: dcv
    type:
      - 'null'
      - int
    doc: diff-cover period for blockwise
    inputBinding:
      position: 103
      prefix: --dcv
  - id: nodc
    type:
      - 'null'
      - boolean
    doc: disable diff-cover (algorithm becomes quadratic)
    inputBinding:
      position: 103
      prefix: --nodc
  - id: noref
    type:
      - 'null'
      - boolean
    doc: don't build .3/.4.ht2 (packed reference) portion
    inputBinding:
      position: 103
      prefix: --noref
  - id: justref
    type:
      - 'null'
      - boolean
    doc: just build .3/.4.ht2 (packed reference) portion
    inputBinding:
      position: 103
      prefix: --justref
  - id: offrate
    type:
      - 'null'
      - int
    doc: SA is sampled every 2^offRate BWT chars
    inputBinding:
      position: 103
      prefix: --offrate
  - id: ftabchars
    type:
      - 'null'
      - int
    doc: '# of chars consumed in initial lookup'
    inputBinding:
      position: 103
      prefix: --ftabchars
  - id: localoffrate
    type:
      - 'null'
      - int
    doc: SA (local) is sampled every 2^offRate BWT chars
    inputBinding:
      position: 103
      prefix: --localoffrate
  - id: localftabchars
    type:
      - 'null'
      - int
    doc: '# of chars consumed in initial lookup in a local index'
    inputBinding:
      position: 103
      prefix: --localftabchars
  - id: snp
    type:
      - 'null'
      - File
    doc: SNP file name
    inputBinding:
      position: 103
      prefix: --snp
  - id: haplotype
    type:
      - 'null'
      - File
    doc: haplotype file name
    inputBinding:
      position: 103
      prefix: --haplotype
  - id: ss
    type:
      - 'null'
      - File
    doc: Splice site file name
    inputBinding:
      position: 103
      prefix: --ss
  - id: exon
    type:
      - 'null'
      - File
    doc: Exon file name
    inputBinding:
      position: 103
      prefix: --exon
  - id: repeat_ref
    type:
      - 'null'
      - File
    doc: Repeat reference file name
    inputBinding:
      position: 103
      prefix: --repeat-ref
  - id: repeat_info
    type:
      - 'null'
      - File
    doc: Repeat information file name
    inputBinding:
      position: 103
      prefix: --repeat-info
  - id: repeat_snp
    type:
      - 'null'
      - File
    doc: Repeat snp file name
    inputBinding:
      position: 103
      prefix: --repeat-snp
  - id: repeat_haplotype
    type:
      - 'null'
      - File
    doc: Repeat haplotype file name
    inputBinding:
      position: 103
      prefix: --repeat-haplotype
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for random number generator
    inputBinding:
      position: 103
      prefix: --seed
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable verbose output (for debugging)
    inputBinding:
      position: 103
      prefix: --quiet
outputs:
  - id: out_ht2_index_base
    type: File[]
    doc: write ht2 data to files with this dir/basename
    outputBinding:
      glob: $(inputs.ht2_index_base)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.3--h8471819_0
s:url: https://github.com/DaehwanKimLab/hisat2
$namespaces:
  s: https://schema.org/

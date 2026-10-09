cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat-3n-build
label: hisat-3n_hisat-3n-build
doc: "Build a HISAT-3N index (two HISAT2 indexes, one per conversion strand) from
  a set of DNA sequences.\n\nTool homepage: https://github.com/fulcrumgenomics/hisat-3n"
inputs:
  - id: reference_in
    type:
      type: array
      items: File
    doc: Reference sequences in FASTA format (comma-separated list on the command
      line)
    inputBinding:
      position: 101
      itemSeparator: ','
  - id: index_base
    type: string
    doc: Write ht2 data to files with this dir/basename
    inputBinding:
      position: 102
  - id: base_change
    type: string
    doc: 'The converted nucleotide and converted to nucleotide, for example C,T
      for bisulfite-seq or T,C for SLAM-seq'
    inputBinding:
      position: 1
      prefix: --base-change
  - id: large_index
    type:
      - 'null'
      - boolean
    doc: Force generated index to be 'large', even if ref has fewer than 4 billion
      nucleotides
    inputBinding:
      position: 1
      prefix: --large-index
  - id: noauto
    type:
      - 'null'
      - boolean
    doc: Disable automatic -p/--bmax/--dcv memory-fitting
    inputBinding:
      position: 1
      prefix: --noauto
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 1
      prefix: -p
  - id: bmax
    type:
      - 'null'
      - int
    doc: Max bucket size for blockwise suffix-array builder
    inputBinding:
      position: 1
      prefix: --bmax
  - id: bmaxdivn
    type:
      - 'null'
      - int
    doc: 'Max bucket size as divisor of ref len (default: 4)'
    inputBinding:
      position: 1
      prefix: --bmaxdivn
  - id: dcv
    type:
      - 'null'
      - int
    doc: 'Diff-cover period for blockwise (default: 1024)'
    inputBinding:
      position: 1
      prefix: --dcv
  - id: nodc
    type:
      - 'null'
      - boolean
    doc: Disable diff-cover (algorithm becomes quadratic)
    inputBinding:
      position: 1
      prefix: --nodc
  - id: noref
    type:
      - 'null'
      - boolean
    doc: Do not build .3/.4.ht2 (packed reference) portion
    inputBinding:
      position: 1
      prefix: --noref
  - id: justref
    type:
      - 'null'
      - boolean
    doc: Just build .3/.4.ht2 (packed reference) portion
    inputBinding:
      position: 1
      prefix: --justref
  - id: offrate
    type:
      - 'null'
      - int
    doc: 'SA is sampled every 2^offRate BWT chars (default: 5)'
    inputBinding:
      position: 1
      prefix: --offrate
  - id: ftabchars
    type:
      - 'null'
      - int
    doc: 'Number of chars consumed in initial lookup (default: 10)'
    inputBinding:
      position: 1
      prefix: --ftabchars
  - id: localoffrate
    type:
      - 'null'
      - int
    doc: 'SA (local) is sampled every 2^offRate BWT chars (default: 3)'
    inputBinding:
      position: 1
      prefix: --localoffrate
  - id: localftabchars
    type:
      - 'null'
      - int
    doc: 'Number of chars consumed in initial lookup in a local index (default: 6)'
    inputBinding:
      position: 1
      prefix: --localftabchars
  - id: snp
    type:
      - 'null'
      - File
    doc: SNP file name
    inputBinding:
      position: 1
      prefix: --snp
  - id: haplotype
    type:
      - 'null'
      - File
    doc: Haplotype file name
    inputBinding:
      position: 1
      prefix: --haplotype
  - id: ss
    type:
      - 'null'
      - File
    doc: Splice site file name
    inputBinding:
      position: 1
      prefix: --ss
  - id: exon
    type:
      - 'null'
      - File
    doc: Exon file name
    inputBinding:
      position: 1
      prefix: --exon
  - id: repeat_ref
    type:
      - 'null'
      - File
    doc: Repeat reference file name
    inputBinding:
      position: 1
      prefix: --repeat-ref
  - id: repeat_info
    type:
      - 'null'
      - File
    doc: Repeat information file name
    inputBinding:
      position: 1
      prefix: --repeat-info
  - id: repeat_snp
    type:
      - 'null'
      - File
    doc: Repeat snp file name
    inputBinding:
      position: 1
      prefix: --repeat-snp
  - id: repeat_haplotype
    type:
      - 'null'
      - File
    doc: Repeat haplotype file name
    inputBinding:
      position: 1
      prefix: --repeat-haplotype
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator
    inputBinding:
      position: 1
      prefix: --seed
  - id: repeat_index
    type:
      - 'null'
      - boolean
    doc: Automatically build the repeat database and repeat index
    inputBinding:
      position: 1
      prefix: --repeat-index
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Disable verbose output (for debugging)
    inputBinding:
      position: 1
      prefix: --quiet
outputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: HISAT-3N index files (.ht2) and repeat database files
    outputBinding:
      glob: $(inputs.index_base)*
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat-3n:0.0.3--h503566f_0
stdout: hisat-3n_hisat-3n-build.out

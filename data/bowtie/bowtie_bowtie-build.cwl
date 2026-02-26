cwlVersion: v1.2
class: CommandLineTool
baseCommand: bowtie-build
label: bowtie_bowtie-build
doc: "Builds a Bowtie index from a reference genome.\n\nTool homepage: https://github.com/BenLangmead/bowtie"
inputs:
  - id: reference_in
    type:
      type: array
      items: File
    doc: comma-separated list of files with ref sequences
    inputBinding:
      position: 1
  - id: ebwt_outfile_base
    type: string
    doc: write Ebwt data to files with this dir/basename
    inputBinding:
      position: 2
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
    doc: 'max bucket sz as divisor of ref len (default: 4)'
    default: 4
    inputBinding:
      position: 103
      prefix: --bmaxdivn
  - id: dcv
    type:
      - 'null'
      - int
    doc: 'diff-cover period for blockwise (default: 1024)'
    default: 1024
    inputBinding:
      position: 103
      prefix: --dcv
  - id: fasta_files
    type:
      - 'null'
      - boolean
    doc: reference files are Fasta (default)
    default: true
    inputBinding:
      position: 103
      prefix: -f
  - id: ftabchars
    type:
      - 'null'
      - int
    doc: '# of chars consumed in initial lookup (default: 10)'
    default: 10
    inputBinding:
      position: 103
      prefix: --ftabchars
  - id: justref
    type:
      - 'null'
      - boolean
    doc: just build .3/.4.ebwt (packed reference) portion
    inputBinding:
      position: 103
      prefix: --justref
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
    doc: don't build .3/.4.ebwt (packed reference) portion
    inputBinding:
      position: 103
      prefix: --noref
  - id: ntoa
    type:
      - 'null'
      - boolean
    doc: convert Ns in reference to As
    inputBinding:
      position: 103
      prefix: --ntoa
  - id: offrate
    type:
      - 'null'
      - int
    doc: 'SA is sampled every 2^offRate BWT chars (default: 5)'
    default: 5
    inputBinding:
      position: 103
      prefix: --offrate
  - id: packed
    type:
      - 'null'
      - boolean
    doc: use packed strings internally; slower, uses less mem
    inputBinding:
      position: 103
      prefix: --packed
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: verbose output (for debugging)
    inputBinding:
      position: 103
      prefix: --quiet
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for random number generator
    inputBinding:
      position: 103
      prefix: --seed
  - id: sequences_on_cmdline
    type:
      - 'null'
      - boolean
    doc: reference sequences given on cmd line (as <seq_in>)
    inputBinding:
      position: 103
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: '# of threads'
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bowtie:1.3.1--py312hf8dbd9f_10
stdout: bowtie_bowtie-build.out

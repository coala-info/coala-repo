cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ragtag.py
  - correct
label: ragtag_correct
doc: "Homology-based misassembly correction: Correct sequences in 'query.fa' by comparing\
  \ them to sequences in 'reference.fa'.\n\nTool homepage: https://github.com/malonge/RagTag"
inputs:
  - id: reference
    type: File
    doc: reference fasta file (uncompressed or bgzipped) (staged writable because
      the tool writes a .fai index beside it)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: query
    type: File
    doc: query fasta file (uncompressed or bgzipped) (staged writable because the
      tool writes a .fai index beside it)
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: min_unique_alignment_length
    type:
      - 'null'
      - int
    doc: minimum unique alignment length [1000]
    inputBinding:
      position: 101
      prefix: -f
  - id: remove_small
    type:
      - 'null'
      - boolean
    doc: remove unique alignments shorter than -f
    inputBinding:
      position: 101
      prefix: --remove-small
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapq (NA for Nucmer alignments) [10]
    inputBinding:
      position: 101
      prefix: -q
  - id: max_merge_distance
    type:
      - 'null'
      - int
    doc: maximum alignment merge distance [100000]
    inputBinding:
      position: 101
      prefix: -d
  - id: min_break_distance
    type:
      - 'null'
      - int
    doc: minimum break distance from contig ends [5000]
    inputBinding:
      position: 101
      prefix: -b
  - id: exclude
    type:
      - 'null'
      - File
    doc: list of reference headers to ignore [null]
    inputBinding:
      position: 101
      prefix: -e
  - id: skip
    type:
      - 'null'
      - File
    doc: list of query headers to leave uncorrected [null]
    inputBinding:
      position: 101
      prefix: -j
  - id: inter
    type:
      - 'null'
      - boolean
    doc: only break misassemblies between reference sequences
    inputBinding:
      position: 101
      prefix: --inter
  - id: intra
    type:
      - 'null'
      - boolean
    doc: only break misassemblies within reference sequences
    inputBinding:
      position: 101
      prefix: --intra
  - id: gff
    type:
      - 'null'
      - File
    doc: don't break sequences within gff intervals [null]
    inputBinding:
      position: 101
      prefix: --gff
  - id: output_dir
    type:
      - 'null'
      - string
    doc: output directory (default ragtag_output)
    default: ragtag_output
    inputBinding:
      position: 101
      prefix: -o
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: overwrite intermediate files
    inputBinding:
      position: 101
      prefix: -w
  - id: add_suffix
    type:
      - 'null'
      - boolean
    doc: add suffix to unaltered sequence headers
    inputBinding:
      position: 101
      prefix: -u
  - id: threads
    type:
      - 'null'
      - int
    doc: number of minimap2/unimap threads [1]
    inputBinding:
      position: 101
      prefix: -t
  - id: aligner
    type:
      - 'null'
      - string
    doc: whole genome aligner executable ('nucmer', 'unimap' or 'minimap2') [minimap2]
    inputBinding:
      position: 101
      prefix: --aligner
  - id: mm2_params
    type:
      - 'null'
      - string
    doc: space delimited minimap2 parameters (overrides '-t') ['-x asm5']
    inputBinding:
      position: 101
      prefix: --mm2-params
  - id: unimap_params
    type:
      - 'null'
      - string
    doc: space delimited unimap parameters (overrides '-t') ['-x asm5']
    inputBinding:
      position: 101
      prefix: --unimap-params
  - id: nucmer_params
    type:
      - 'null'
      - string
    doc: space delimted nucmer parameters ['--maxmatch -l 100 -c 500']
    inputBinding:
      position: 101
      prefix: --nucmer-params
  - id: read_aligner
    type:
      - 'null'
      - string
    doc: read aligner executable (only 'minimap2' is allowed) [minimap2]
    inputBinding:
      position: 101
      prefix: --read-aligner
  - id: reads
    type:
      - 'null'
      - File
    doc: validation reads (uncompressed or gzipped) [null]
    inputBinding:
      position: 101
      prefix: -R
  - id: reads_list
    type:
      - 'null'
      - File
    doc: same as '-R', but a list of files [null]
    inputBinding:
      position: 101
      prefix: -F
  - id: read_type
    type:
      - 'null'
      - string
    doc: read type. 'sr', 'ont' and 'corr' accepted for Illumina, nanopore and error
      corrected long-reads, respectively [null]
    inputBinding:
      position: 101
      prefix: -T
  - id: coverage_window
    type:
      - 'null'
      - int
    doc: coverage validation window size [10000]
    inputBinding:
      position: 101
      prefix: -v
  - id: max_cov
    type:
      - 'null'
      - int
    doc: break sequences at regions at or above this coverage level [AUTO]
    inputBinding:
      position: 101
      prefix: --max-cov
  - id: min_cov
    type:
      - 'null'
      - int
    doc: break sequences at regions at or below this coverage level [AUTO]
    inputBinding:
      position: 101
      prefix: --min-cov
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type: Directory
    doc: Output directory with the result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference)
        writable: true
      - entry: $(inputs.query)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
stdout: ragtag_correct.out

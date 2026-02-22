cwlVersion: v1.2
class: CommandLineTool
baseCommand: abacas
label: abacas
doc: "Algorithm Based Automatic Contiguation of Assembled Sequences. Used for ordering
  and orienting contigs against a reference genome.\n\nTool homepage: http://abacas.sourceforge.net/"
inputs:
  - id: append_bin_contigs
    type:
      - 'null'
      - boolean
    doc: append contigs in bin to the pseudomolecule
    inputBinding:
      position: 101
      prefix: -a
  - id: circular_reference
    type:
      - 'null'
      - boolean
    doc: Reference sequence is circular
    inputBinding:
      position: 101
      prefix: -c
  - id: escape_ordering
    type:
      - 'null'
      - boolean
    doc: Escape contig ordering i.e. go to primer design
    inputBinding:
      position: 101
      prefix: -e
  - id: flanking_bases
    type:
      - 'null'
      - int
    doc: number of flanking bases on either side of a gap for primer design
    default: 350
    inputBinding:
      position: 101
      prefix: -f
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: minimum contig length
    default: 1
    inputBinding:
      position: 101
      prefix: -l
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: mimimum contig coverage
    default: 40
    inputBinding:
      position: 101
      prefix: -v
  - id: min_coverage_diff
    type:
      - 'null'
      - int
    doc: minimum contig coverage difference
    default: 1
    inputBinding:
      position: 101
      prefix: -V
  - id: min_identity
    type:
      - 'null'
      - int
    doc: mimimum percent identity
    default: 40
    inputBinding:
      position: 101
      prefix: -i
  - id: min_match_length
    type:
      - 'null'
      - int
    doc: minimum length of exact matching word (nucmer default = 12, promer 
      default = 4)
    inputBinding:
      position: 101
      prefix: -s
  - id: mummer_program
    type:
      - 'null'
      - string
    doc: "MUMmer program to use: 'nucmer' or 'promer'"
    inputBinding:
      position: 101
      prefix: -p
  - id: no_n_pseudomolecule
    type:
      - 'null'
      - boolean
    doc: print a pseudomolecule without 'N's
    inputBinding:
      position: 101
      prefix: -N
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output files will have this prefix
    inputBinding:
      position: 101
      prefix: -o
  - id: pick_primers
    type:
      - 'null'
      - boolean
    doc: pick primer sets to close gaps
    inputBinding:
      position: 101
      prefix: -P
  - id: print_bin_contigs
    type:
      - 'null'
      - boolean
    doc: print contigs in bin to file
    inputBinding:
      position: 101
      prefix: -b
  - id: print_ordered_contigs
    type:
      - 'null'
      - boolean
    doc: print ordered contigs to file in multifasta format
    inputBinding:
      position: 101
      prefix: -m
  - id: query_file
    type: File
    doc: contigs in multi-fasta format or pseudomolecule/ordered sequence file
    inputBinding:
      position: 101
      prefix: -q
  - id: reference_file
    type: File
    doc: reference sequence in a single fasta file
    inputBinding:
      position: 101
      prefix: -r
  - id: run_mummer
    type:
      - 'null'
      - int
    doc: Run mummer [default 1, use -R 0 to avoid running mummer]
    default: 1
    inputBinding:
      position: 101
      prefix: -R
  - id: run_tblastx
    type:
      - 'null'
      - boolean
    doc: run tblastx on contigs that are not mapped
    inputBinding:
      position: 101
      prefix: -t
  - id: use_defaults
    type:
      - 'null'
      - boolean
    doc: use default nucmer/promer parameters
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: gap_file
    type:
      - 'null'
      - File
    doc: print uncovered regions (gaps) on reference to file name
    outputBinding:
      glob: $(inputs.gap_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/abacas:v1.3.1-5-deb_cv1

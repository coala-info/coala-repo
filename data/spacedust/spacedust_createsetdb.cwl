cwlVersion: v1.2
class: CommandLineTool
baseCommand: spacedust_createsetdb
label: spacedust_createsetdb
doc: "Creates a database for spacedust.\n\nTool homepage: https://github.com/soedinglab/spacedust"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: Input FASTA files (.gz|.bz2), a directory containing FASTA files, or a 
      TSV file listing FASTA files.
    inputBinding:
      position: 1
  - id: tmp_dir
    type: Directory
    doc: Temporary directory for intermediate files.
    inputBinding:
      position: 2
  - id: add_orf_stop
    type:
      - 'null'
      - boolean
    doc: Add stop codon '*' at complete start and end.
    default: 0
    inputBinding:
      position: 103
      prefix: --add-orf-stop
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output.
    default: 0
    inputBinding:
      position: 103
      prefix: --compressed
  - id: contig_end_mode
    type:
      - 'null'
      - int
    doc: 'Contig end can be 0: incomplete, 1: complete, 2: both.'
    default: 2
    inputBinding:
      position: 103
      prefix: --contig-end-mode
  - id: contig_start_mode
    type:
      - 'null'
      - int
    doc: 'Contig start can be 0: incomplete, 1: complete, 2: both.'
    default: 2
    inputBinding:
      position: 103
      prefix: --contig-start-mode
  - id: create_lookup
    type:
      - 'null'
      - int
    doc: Create database lookup file (can be very large).
    default: 0
    inputBinding:
      position: 103
      prefix: --create-lookup
  - id: createdb_mode
    type:
      - 'null'
      - int
    doc: 'Createdb mode: 0: copy data, 1: soft link data and write new index (works
      only with single line fasta/q).'
    default: 0
    inputBinding:
      position: 103
      prefix: --createdb-mode
  - id: db_type
    type:
      - 'null'
      - int
    doc: 'Database type: 0: auto, 1: amino acid, 2: nucleotides.'
    default: 0
    inputBinding:
      position: 103
      prefix: --dbtype
  - id: file_exclude
    type:
      - 'null'
      - string
    doc: Exclude file names based on this regex.
    default: ^$
    inputBinding:
      position: 103
      prefix: --file-exclude
  - id: file_include
    type:
      - 'null'
      - string
    doc: Include file names based on this regex.
    default: .*
    inputBinding:
      position: 103
      prefix: --file-include
  - id: forward_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the forward strand to be extracted.
    default: 1,2,3
    inputBinding:
      position: 103
      prefix: --forward-frames
  - id: gff_dir
    type:
      - 'null'
      - string
    doc: Path to gff dir file.
    default: ''
    inputBinding:
      position: 103
      prefix: --gff-dir
  - id: gff_type
    type:
      - 'null'
      - string
    doc: Comma separated list of feature types in the GFF file to select.
    default: ''
    inputBinding:
      position: 103
      prefix: --gff-type
  - id: id_offset
    type:
      - 'null'
      - int
    doc: Numeric ids in index file are offset by this value.
    default: 0
    inputBinding:
      position: 103
      prefix: --id-offset
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: Maximum number of codons with gaps or unknown residues before an open 
      reading frame is rejected.
    default: 2147483647
    inputBinding:
      position: 103
      prefix: --max-gaps
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum codon number in open reading frames.
    default: 32734
    inputBinding:
      position: 103
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum codon number in open reading frames.
    default: 30
    inputBinding:
      position: 103
      prefix: --min-length
  - id: orf_start_mode
    type:
      - 'null'
      - int
    doc: 'Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from
      last encountered start to stop (no start in the middle).'
    default: 1
    inputBinding:
      position: 103
      prefix: --orf-start-mode
  - id: reverse_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the reverse strand to be extracted.
    default: 1,2,3
    inputBinding:
      position: 103
      prefix: --reverse-frames
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: Shuffle input database.
    default: 0
    inputBinding:
      position: 103
      prefix: --shuffle
  - id: stat
    type:
      - 'null'
      - string
    doc: 'One of: linecount, mean, min, max, doolittle, charges, seqlen, firstline.'
    default: ''
    inputBinding:
      position: 103
      prefix: --stat
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default).
    default: 20
    inputBinding:
      position: 103
      prefix: --threads
  - id: translate
    type:
      - 'null'
      - boolean
    doc: Translate ORF to amino acid.
    default: 0
    inputBinding:
      position: 103
      prefix: --translate
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Genetic code table. See help for full list of options.
    default: 1
    inputBinding:
      position: 103
      prefix: --translation-table
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Return output in TSV format.
    default: 0
    inputBinding:
      position: 103
      prefix: --tsv
  - id: use_all_table_starts
    type:
      - 'null'
      - boolean
    doc: Use all alternatives for a start codon in the genetic table, if false -
      only ATG (AUG).
    default: 0
    inputBinding:
      position: 103
      prefix: --use-all-table-starts
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info.'
    default: 3
    inputBinding:
      position: 103
      prefix: -v
  - id: write_lookup
    type:
      - 'null'
      - int
    doc: write .lookup file containing mapping from internal id, fasta id and 
      file number.
    default: 1
    inputBinding:
      position: 103
      prefix: --write-lookup
outputs:
  - id: output_db
    type: Directory
    doc: Output directory for the database.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacedust:2.e56c505--hd6d6fdc_0

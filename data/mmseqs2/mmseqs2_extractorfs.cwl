cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - extractorfs
label: mmseqs2_extractorfs
doc: 'Six-frame extraction of open reading frames.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: sequence_db
    type: Directory
    doc: Input sequence database (nucleotides)
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.sequence_db_name)
  - id: sequence_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum codon number in open reading frames
    inputBinding:
      position: 104
      prefix: --min-length
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum codon number in open reading frames
    inputBinding:
      position: 104
      prefix: --max-length
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: Maximum number of codons with gaps or unknown residues before an open reading frame
      is rejected
    inputBinding:
      position: 104
      prefix: --max-gaps
  - id: contig_start_mode
    type:
      - 'null'
      - int
    doc: 'Contig start can be 0: incomplete, 1: complete, 2: both'
    inputBinding:
      position: 104
      prefix: --contig-start-mode
  - id: contig_end_mode
    type:
      - 'null'
      - int
    doc: 'Contig end can be 0: incomplete, 1: complete, 2: both'
    inputBinding:
      position: 104
      prefix: --contig-end-mode
  - id: orf_start_mode
    type:
      - 'null'
      - int
    doc: 'Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from last encountered
      start to stop (no start in the middle)'
    inputBinding:
      position: 104
      prefix: --orf-start-mode
  - id: forward_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the forward strand to be extracted
    inputBinding:
      position: 104
      prefix: --forward-frames
  - id: reverse_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the reverse strand to be extracted
    inputBinding:
      position: 104
      prefix: --reverse-frames
  - id: translation_table
    type:
      - 'null'
      - int
    doc: 1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL,
      5) INVERT_MITOCHONDRIAL, 6) CILIATE 9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE,
      12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL 15) BLEPHARISMA,
      16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
      23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA,
      26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA 29) MESODINIUM, 30) PERTRICH, 31)
      BLASTOCRITHIDIA
    inputBinding:
      position: 104
      prefix: --translation-table
  - id: translate
    type:
      - 'null'
      - int
    doc: Translate ORF to amino acid
    inputBinding:
      position: 104
      prefix: --translate
  - id: use_all_table_starts
    type:
      - 'null'
      - int
    doc: Use all alternatives for a start codon in the genetic table, if false - only ATG
      (AUG) (0 or 1)
    inputBinding:
      position: 104
      prefix: --use-all-table-starts
  - id: id_offset
    type:
      - 'null'
      - int
    doc: Numeric ids in index file are offset by this value
    inputBinding:
      position: 104
      prefix: --id-offset
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
  - id: create_lookup
    type:
      - 'null'
      - int
    doc: Create database lookup file (can be very large)
    inputBinding:
      position: 104
      prefix: --create-lookup
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the ORF sequence database
    outputBinding:
      glob: out_db
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
arguments:
  - position: 200
    shellQuote: false
    valueFrom: '&& for l in out_db/*; do if [ -L "$l" ]; then t=`readlink -f "$l"`; rm "$l";
      cp -r "$t" "$l"; fi; done'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - extractframes
label: mmseqs2_extractframes
doc: 'Extract the frames of a nucleotide sequence database.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: sequence_db
    type: Directory
    doc: Nucleotide sequence database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.sequence_db_name)
  - id: sequence_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_sequence_db_name
    type: string
    doc: Name (prefix) of the output sequence database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
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
    doc: Directory holding the new database files
    outputBinding:
      glob: out_db
arguments:
  - position: 200
    shellQuote: false
    valueFrom: '&& for f in out_db/*; do if [ -L "$f" ]; then t=`readlink -f "$f"`; rm "$f";
      cp "$t" "$f"; fi; done'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
  - class: ShellCommandRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0

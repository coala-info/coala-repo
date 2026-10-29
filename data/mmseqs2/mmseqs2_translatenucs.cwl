cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - translatenucs
label: mmseqs2_translatenucs
doc: 'Translate nucleotides to proteins.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: sequence_db
    type: Directory
    doc: Input nucleotide sequence database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.sequence_db_name)
  - id: sequence_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_sequence_db_name
    type: string
    doc: Name (prefix) of the output protein sequence database, written inside the output
      directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
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
  - id: add_orf_stop
    type:
      - 'null'
      - int
    doc: Add stop codon '*' at complete start and end (0 or 1)
    inputBinding:
      position: 104
      prefix: --add-orf-stop
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the output database files
    outputBinding:
      glob: out_db
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
arguments:
  - shellQuote: false
    position: 1000
    valueFrom: '&& cp -rL out_db out_db_tmp && rm -rf out_db && mv out_db_tmp out_db'

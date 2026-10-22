cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacepharer
  - createsetdb
label: spacepharer_createsetdb
doc: "Create sequence database from FASTA input\n\nTool homepage: https://github.com/soedinglab/spacepharer"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: "Input FASTA files (.gz allowed)"
    inputBinding:
      position: 1
  - id: set_db
    type: string
    doc: "Output set database name (prefix of the database files)"
    inputBinding:
      position: 2
  - id: tmp_dir
    type: string
    doc: "Temporary directory"
    inputBinding:
      position: 3
  - id: tax_mapping_file
    type:
      - 'null'
      - string
    doc: "File to map sequence identifier to taxonomical identifier []"
    inputBinding:
      position: 104
      prefix: --tax-mapping-file
  - id: ncbi_tax_dump
    type:
      - 'null'
      - string
    doc: "NCBI tax dump directory. The tax dump can be downloaded here \"ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz\" []"
    inputBinding:
      position: 104
      prefix: --ncbi-tax-dump
  - id: reverse_fragments
    type:
      - 'null'
      - int
    doc: "Reverse AA fragments to compute under null [0,1] [0]"
    inputBinding:
      position: 104
      prefix: --reverse-fragments
  - id: extractorf_spacer
    type:
      - 'null'
      - int
    doc: "change parameter settings for extractorfs when createsetdb for spacer db [0,1] [0]"
    inputBinding:
      position: 104
      prefix: --extractorf-spacer
  - id: translation_table
    type:
      - 'null'
      - int
    doc: "1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE 9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL 15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL 23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA 29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]"
    inputBinding:
      position: 104
      prefix: --translation-table
  - id: add_orf_stop
    type:
      - 'null'
      - boolean
    doc: "Add stop codon '*' at complete start and end [0]"
    inputBinding:
      position: 104
      prefix: --add-orf-stop
      valueFrom: '$(self ? 1 : 0)'
  - id: compressed
    type:
      - 'null'
      - int
    doc: "Write compressed output [0]"
    inputBinding:
      position: 104
      prefix: --compressed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of CPU-cores used (all by default) [20]"
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]"
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_db
    type:
      type: array
      items: File
    doc: Files of the output set database
    outputBinding:
      glob: $(inputs.set_db)*
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
arguments:
  - position: 200
    shellQuote: false
    valueFrom: '&& for f in $(inputs.set_db)*; do if [ -L "$f" ]; then cp -L "$f" "$f.tmp" && mv "$f.tmp" "$f"; fi; done'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacepharer:5.c2e680a--hd6d6fdc_7

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - foldmason
  - createdb
label: foldmason_createdb
doc: 'Convert PDB or mmCIF structures into a foldmason database (amino acid, 3Di,
  C-alpha and header sub-databases).


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/steineggerlab/foldmason'
inputs:
  - id: input_structures
    type:
      type: array
      items:
        - File
        - Directory
    doc: Input PDB or mmCIF files (optionally gzip or tar), a directory of them, or
      a TSV file listing them
    inputBinding:
      position: 1
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: chain_name_mode
    type:
      - 'null'
      - int
    doc: 'Add chain to name: 0: auto 1: always add'
    inputBinding:
      position: 104
      prefix: --chain-name-mode
  - id: coord_store_mode
    type:
      - 'null'
      - int
    doc: 'Coordinate storage mode: 1: C-alpha as float 2: C-alpha as difference (uint16_t)'
    inputBinding:
      position: 104
      prefix: --coord-store-mode
  - id: db_extraction_mode
    type:
      - 'null'
      - int
    doc: 'createdb extraction mode: 0: chain 1: interface'
    inputBinding:
      position: 104
      prefix: --db-extraction-mode
  - id: distance_threshold
    type:
      - 'null'
      - float
    doc: Residues with C-beta below this threshold will be part of interface
    inputBinding:
      position: 104
      prefix: --distance-threshold
  - id: file_exclude
    type:
      - 'null'
      - string
    doc: Exclude file names based on this regex
    inputBinding:
      position: 104
      prefix: --file-exclude
  - id: file_include
    type:
      - 'null'
      - string
    doc: Include file names based on this regex
    inputBinding:
      position: 104
      prefix: --file-include
  - id: gpu
    type:
      - 'null'
      - int
    doc: Use GPU (CUDA) if possible
    inputBinding:
      position: 104
      prefix: --gpu
  - id: input_format
    type:
      - 'null'
      - int
    doc: 'Format of input structures: 0: Auto-detect by extension 1: PDB 2: mmCIF
      3: mmJSON 4: ChemComp 5: Foldcomp'
    inputBinding:
      position: 104
      prefix: --input-format
  - id: mask_bfactor_threshold
    type:
      - 'null'
      - float
    doc: mask residues for seeding if b-factor < thr [0,100]
    inputBinding:
      position: 104
      prefix: --mask-bfactor-threshold
  - id: model_name_mode
    type:
      - 'null'
      - int
    doc: 'Add model to name: 0: auto 1: always add'
    inputBinding:
      position: 104
      prefix: --model-name-mode
  - id: prostt5_model
    type:
      - 'null'
      - string
    doc: Path to ProstT5 model
    inputBinding:
      position: 104
      prefix: --prostt5-model
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
  - id: write_lookup
    type:
      - 'null'
      - int
    doc: write .lookup file containing mapping from internal id, fasta id and file
      number
    inputBinding:
      position: 104
      prefix: --write-lookup
  - id: write_mapping
    type:
      - 'null'
      - int
    doc: write _mapping file containing mapping from internal id to taxonomic identifier
    inputBinding:
      position: 104
      prefix: --write-mapping
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the new database files
    outputBinding:
      glob: out_db
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0

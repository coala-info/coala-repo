cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metaeuk
  - createtaxdb
label: metaeuk_createtaxdb
doc: "Add taxonomy (NCBI taxdump and a sequence-to-taxon map) to a MetaEuk sequence database.
  It writes <db>_mapping and <db>_taxonomy beside the database.\n\nTool homepage:
  https://github.com/soedinglab/metaeuk"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.sequence_db)
inputs:
  - id: sequence_db
    type: 'File[]'
    doc: Input sequence database. All files of the MetaEuk database (name, .index, .dbtype,
      .lookup, _h, ...), staged together in the working directory.
    inputBinding:
      position: 1
      valueFrom: |-
        ${ var names = self.map(function(f){return f.basename;}).filter(function(b){return /\.dbtype$/.test(b) && !/_h\.dbtype$/.test(b);}); return names[0].replace(/\.dbtype$/, ''); }
  - id: tmp_dir
    type: string
    doc: Temporary directory
    inputBinding:
      position: 2
  - id: ncbi_tax_dump
    type: ['null', Directory]
    doc: NCBI tax dump directory. The tax dump can be downloaded here
      "ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz"
    inputBinding:
      position: 101
      prefix: --ncbi-tax-dump
  - id: tax_mapping_file
    type: ['null', File]
    doc: File to map sequence identifier to taxonomical identifier
    inputBinding:
      position: 101
      prefix: --tax-mapping-file
  - id: tax_mapping_mode
    type: ['null', int]
    doc: 'Map taxonomy based on sequence database 0: .lookup file 1: .source file [0]'
    inputBinding:
      position: 101
      prefix: --tax-mapping-mode
  - id: tax_db_mode
    type: ['null', int]
    doc: 'Create taxonomy database as: 0: .dmp flat files (human readable) 1: binary dump
      (faster readin) [1]'
    inputBinding:
      position: 101
      prefix: --tax-db-mode
  - id: threads
    type: ['null', int]
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity_level
    type: ['null', int]
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: taxonomy_files
    type: 'File[]'
    doc: Taxonomy files written beside the database (<db>_mapping and <db>_taxonomy)
    outputBinding:
      glob: ["*_mapping", "*_taxonomy"]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2

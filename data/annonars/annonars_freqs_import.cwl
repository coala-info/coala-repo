cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- annonars
- freqs
- import
label: annonars_freqs_import
doc: '"import" sub command: Import merged gnomAD and HelixMtDb frequency data into a RocksDB database.


  Tool homepage: https://github.com/bihealth/annona-rs'
inputs:
- id: genome_release
  type: string
  doc: 'Genome build to use in the build [possible values: grch37, grch38]'
  inputBinding:
    position: 1
    prefix: --genome-release
- id: path_out_rocksdb
  type: string
  doc: Path to the output database to build
  inputBinding:
    position: 1
    prefix: --path-out-rocksdb
- id: path_gnomad_exomes_auto
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --path-gnomad-exomes-auto
  secondaryFiles: &id001
  - pattern: .tbi
    required: false
  doc: Path(s) to the autosomal gnomAD exomes VCF file(s)
  inputBinding:
    position: 1
- id: path_gnomad_genomes_auto
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --path-gnomad-genomes-auto
  secondaryFiles: *id001
  doc: Path(s) to the autosomal gnomAD genomes VCF file(s)
  inputBinding:
    position: 1
- id: path_gnomad_exomes_xy
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --path-gnomad-exomes-xy
  secondaryFiles: *id001
  doc: Path(s) to the gonosomal gnomAD exomes VCF file(s)
  inputBinding:
    position: 1
- id: path_gnomad_genomes_xy
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --path-gnomad-genomes-xy
  secondaryFiles: *id001
  doc: Path(s) to the gonosomal gnomAD genomes VCF file(s)
  inputBinding:
    position: 1
- id: path_gnomad_mtdna
  type:
  - 'null'
  - File
  secondaryFiles: *id001
  doc: Path(s) to the gnomAD mtDNA VCF file(s)
  inputBinding:
    position: 1
    prefix: --path-gnomad-mtdna
- id: path_helixmtdb
  type:
  - 'null'
  - File
  secondaryFiles: *id001
  doc: Path(s) to the HelixMtDb TSV file
  inputBinding:
    position: 1
    prefix: --path-helixmtdb
- id: path_wal_dir
  type:
  - 'null'
  - string
  doc: Optional path to WAL directory
  inputBinding:
    position: 1
    prefix: --path-wal-dir
- id: tbi_window_size
  type:
  - 'null'
  - int
  doc: 'Windows size for TBI-based parallel import [default: 100000]'
  inputBinding:
    position: 1
    prefix: --tbi-window-size
- id: gnomad_genomes_version
  type: string
  doc: Version of gnomAD genomes
  inputBinding:
    position: 1
    prefix: --gnomad-genomes-version
- id: gnomad_exomes_version
  type: string
  doc: Version of gnomAD exomes
  inputBinding:
    position: 1
    prefix: --gnomad-exomes-version
- id: gnomad_mtdna_version
  type: string
  doc: Version of gnomAD mtDNA
  inputBinding:
    position: 1
    prefix: --gnomad-mtdna-version
- id: helixmtdb_version
  type: string
  doc: Version of HelixMtDb
  inputBinding:
    position: 1
    prefix: --helixmtdb-version
- id: verbose
  type:
  - 'null'
  - boolean
  doc: Increase logging verbosity
  inputBinding:
    position: 1
    prefix: --verbose
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Decrease logging verbosity
  inputBinding:
    position: 1
    prefix: --quiet
outputs:
- id: rocksdb
  type: Directory
  doc: Output RocksDB directory
  outputBinding:
    glob: $(inputs.path_out_rocksdb)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/annonars:0.44.1--h13c227e_0

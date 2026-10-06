cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- annonars
- gnomad-sv
- import
label: annonars_gnomad-sv_import
doc: '"import" sub command: Import gnomAD structural variant data into a RocksDB database.


  Tool homepage: https://github.com/bihealth/annona-rs'
inputs:
- id: path_in_vcf
  type:
    type: array
    items: File
    inputBinding:
      prefix: --path-in-vcf
  secondaryFiles:
  - pattern: .tbi
    required: false
  doc: Path to input VCF file(s) -- or TSV in case of ExAC
  inputBinding:
    position: 1
- id: path_out_rocksdb
  type: string
  doc: Path to output RocksDB directory
  inputBinding:
    position: 1
    prefix: --path-out-rocksdb
- id: gnomad_kind
  type: string
  doc: 'Exomes or genomes [possible values: exomes, genomes]'
  inputBinding:
    position: 1
    prefix: --gnomad-kind
- id: gnomad_version
  type: string
  doc: The data version to write out
  inputBinding:
    position: 1
    prefix: --gnomad-version
- id: genome_release
  type: string
  doc: 'Genome build to use in the build [possible values: grch37, grch38]'
  inputBinding:
    position: 1
    prefix: --genome-release
- id: cf_name
  type:
  - 'null'
  - string
  doc: 'Data column family to import into [default: gnomad_sv]'
  inputBinding:
    position: 1
    prefix: --cf-name
- id: path_wal_dir
  type:
  - 'null'
  - string
  doc: Optional path to RocksDB WAL directory
  inputBinding:
    position: 1
    prefix: --path-wal-dir
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

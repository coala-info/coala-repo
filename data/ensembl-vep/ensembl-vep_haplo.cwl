cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplo
label: ensembl-vep_haplo
doc: "HAPLOSAURUS: predict the haplotypes of protein-coding transcripts from phased genotypes, using the VEP cache or database.\n\nTool homepage: https://www.ensembl.org/info/docs/tools/vep/index.html"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input file (VCF with phased genotypes)"
    inputBinding:
      position: 101
      prefix: --input_file
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "Output file"
    inputBinding:
      position: 101
      prefix: --output_file
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "Force overwriting of output file"
    inputBinding:
      position: 101
      prefix: --force_overwrite
  - id: species
    type:
      - 'null'
      - string
    doc: "Species to use [default: \"human\"]"
    inputBinding:
      position: 101
      prefix: --species
  - id: cache
    type:
      - 'null'
      - boolean
    doc: "Use the cache of transcript models"
    inputBinding:
      position: 101
      prefix: --cache
  - id: offline
    type:
      - 'null'
      - boolean
    doc: "Run in offline mode: no database connection"
    inputBinding:
      position: 101
      prefix: --offline
  - id: database
    type:
      - 'null'
      - boolean
    doc: "Use the Ensembl database instead of a cache"
    inputBinding:
      position: 101
      prefix: --database
  - id: dir_cache
    type:
      - 'null'
      - Directory
    doc: "Cache directory (staged writable: haplo writes a transcript coordinate file into the cache)"
    inputBinding:
      position: 101
      prefix: --dir_cache
      valueFrom: $(self.basename)
  - id: cache_version
    type:
      - 'null'
      - int
    doc: "Version of the cache to use"
    inputBinding:
      position: 101
      prefix: --cache_version
  - id: assembly
    type:
      - 'null'
      - string
    doc: "Assembly version to use (for example GRCh38)"
    inputBinding:
      position: 101
      prefix: --assembly
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Reference FASTA file"
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fork
    type:
      - 'null'
      - int
    doc: "Use forking to improve script runtime"
    inputBinding:
      position: 101
      prefix: --fork
  - id: json
    type:
      - 'null'
      - boolean
    doc: "Write output in JSON format"
    inputBinding:
      position: 101
      prefix: --json
  - id: no_stats
    type:
      - 'null'
      - boolean
    doc: "Do not generate a stats file"
    inputBinding:
      position: 101
      prefix: --no_stats
  - id: host
    type:
      - 'null'
      - string
    doc: "Manually define the database host"
    inputBinding:
      position: 101
      prefix: --host
  - id: port
    type:
      - 'null'
      - int
    doc: "Manually define the database port"
    inputBinding:
      position: 101
      prefix: --port
  - id: user
    type:
      - 'null'
      - string
    doc: "Database username"
    inputBinding:
      position: 101
      prefix: --user
  - id: password
    type:
      - 'null'
      - string
    doc: "Database password"
    inputBinding:
      position: 101
      prefix: --password
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Haplotype output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dir_cache)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensembl-vep:115.2--pl5321h2a3209d_1

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vep_convert_cache
label: ensembl-vep_vep_convert_cache
doc: "Convert a VEP cache from the older text format to the faster Sereal / tabix-indexed format.\n\nTool homepage: http://www.ensembl.org/info/docs/tools/vep/script/vep_cache.html#convert"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Shhh!"
    inputBinding:
      position: 101
      prefix: --quiet
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite existing cache files if found"
    inputBinding:
      position: 101
      prefix: --force_overwrite
  - id: remove
    type:
      - 'null'
      - boolean
    doc: "Remove old cache files after conversion"
    inputBinding:
      position: 101
      prefix: --remove
  - id: dir
    type:
      - 'null'
      - Directory
    doc: "Cache directory (default: $HOME/.vep); staged writable because the conversion writes into it"
    inputBinding:
      position: 101
      prefix: --dir
      valueFrom: $(self.basename)
  - id: species
    type:
      - 'null'
      - string
    doc: "Species cache to convert (\"all\" to do all found)"
    inputBinding:
      position: 101
      prefix: --species
  - id: version
    type:
      - 'null'
      - string
    doc: "Cache version to convert (\"all\" to do all found)"
    inputBinding:
      position: 101
      prefix: --version
  - id: compress
    type:
      - 'null'
      - string
    doc: "Path to binary/command to decompress gzipped files. Defaults to \"gzip -dc\", some systems may prefer \"zcat\""
    inputBinding:
      position: 101
      prefix: --compress
  - id: bgzip
    type:
      - 'null'
      - string
    doc: "Path to bgzip binary (default: bgzip)"
    inputBinding:
      position: 101
      prefix: --bgzip
  - id: tabix
    type:
      - 'null'
      - string
    doc: "Path to tabix binary (default: tabix)"
    inputBinding:
      position: 101
      prefix: --tabix
outputs:
  - id: converted_cache
    type: Directory
    doc: The cache directory after conversion
    outputBinding:
      glob: $(inputs.dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensembl-vep:115.2--pl5321h2a3209d_1

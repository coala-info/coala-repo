cwlVersion: v1.2
class: CommandLineTool
baseCommand: metadata
label: seqfu_metadata
doc: "Prepare mapping files from directory containing FASTQ files\n\nTool homepage:
  http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Directories containing FASTQ files
    inputBinding:
      position: 1
  - id: formats
    type:
      - 'null'
      - string
    doc: List available formats
    inputBinding:
      position: 2
  - id: abs
    type:
      - 'null'
      - boolean
    doc: Force absolute path
    inputBinding:
      position: 103
      prefix: --abs
  - id: add_path
    type:
      - 'null'
      - boolean
    doc: Add the reads absolute path as column
    inputBinding:
      position: 103
      prefix: --add-path
  - id: basename
    type:
      - 'null'
      - boolean
    doc: Use basename instead of full path
    inputBinding:
      position: 103
      prefix: --basename
  - id: counts
    type:
      - 'null'
      - boolean
    doc: Add the number of reads as a property column (experimental)
    inputBinding:
      position: 103
      prefix: --counts
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 103
      prefix: --debug
  - id: for_tag
    type:
      - 'null'
      - string
    doc: String found in filename of forward reads
    inputBinding:
      position: 103
      prefix: --for-tag
  - id: force_csv
    type:
      - 'null'
      - boolean
    doc: Force ',' separator, otherwise selected by the format
    inputBinding:
      position: 103
      prefix: --force-csv
  - id: force_tsv
    type:
      - 'null'
      - boolean
    doc: Force '\t' separator, otherwise selected by the format
    inputBinding:
      position: 103
      prefix: --force-tsv
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format: dadaist, irida, manifest,... list to list'
    inputBinding:
      position: 103
      prefix: --format
  - id: meta_default
    type:
      - 'null'
      - string
    doc: Default value for metadata, used in MetaPhage
    inputBinding:
      position: 103
      prefix: --meta-default
  - id: meta_part
    type:
      - 'null'
      - int
    doc: Which part of the SampleID to extract metadata, used in MetaPhage
    inputBinding:
      position: 103
      prefix: --meta-part
  - id: meta_split
    type:
      - 'null'
      - string
    doc: Separator in the SampleID to extract metadata, used in MetaPhage
    inputBinding:
      position: 103
      prefix: --meta-split
  - id: ont
    type:
      - 'null'
      - boolean
    doc: Long reads (Oxford Nanopore)
    inputBinding:
      position: 103
      prefix: --ont
  - id: pe
    type:
      - 'null'
      - boolean
    doc: Enforce paired-end reads (not supported)
    inputBinding:
      position: 103
      prefix: --pe
  - id: pos
    type:
      - 'null'
      - type: array
        items: int
    doc: Which part of the filename is the Sample ID
    inputBinding:
      position: 103
      prefix: --pos
  - id: project
    type:
      - 'null'
      - int
    doc: Project ID (only for irida)
    inputBinding:
      position: 103
      prefix: --project
  - id: rand_meta
    type:
      - 'null'
      - int
    doc: Add a random metadata column with INT categories
    inputBinding:
      position: 103
      prefix: --rand-meta
  - id: rev_tag
    type:
      - 'null'
      - string
    doc: String found in filename of forward reads
    inputBinding:
      position: 103
      prefix: --rev-tag
  - id: split
    type:
      - 'null'
      - string
    doc: Separator used in filename to identify the sample ID
    inputBinding:
      position: 103
      prefix: --split
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of simultaneously opened files (legacy: ignored)'
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_metadata.out

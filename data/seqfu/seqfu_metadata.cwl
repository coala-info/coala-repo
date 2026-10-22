cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - metadata
label: seqfu_metadata
doc: "Prepare mapping files from directory containing FASTQ files\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Directories containing FASTQ files
    inputBinding:
      position: 1
  - id: for_tag
    type:
      - 'null'
      - string
    doc: 'String found in filename of forward reads [default: _R1]'
    inputBinding:
      position: 102
      prefix: --for-tag
  - id: rev_tag
    type:
      - 'null'
      - string
    doc: 'String found in filename of reverse reads [default: _R2]'
    inputBinding:
      position: 102
      prefix: --rev-tag
  - id: split
    type:
      - 'null'
      - string
    doc: 'Separator used in filename to identify the sample ID [default: _]'
    inputBinding:
      position: 102
      prefix: --split
  - id: pos
    type:
      - 'null'
      - int
    doc: 'Which part of the filename is the Sample ID [default: 1]'
    inputBinding:
      position: 102
      prefix: --pos
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format: dadaist, irida, manifest,... [default: manifest]'
    inputBinding:
      position: 102
      prefix: --format
  - id: add_path
    type:
      - 'null'
      - boolean
    doc: Add the reads absolute path as column
    inputBinding:
      position: 102
      prefix: --add-path
  - id: counts
    type:
      - 'null'
      - boolean
    doc: Add the number of reads as a property column (experimental)
    inputBinding:
      position: 102
      prefix: --counts
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of simultaneously opened files (legacy: ignored)'
    inputBinding:
      position: 102
      prefix: --threads
  - id: pe
    type:
      - 'null'
      - boolean
    doc: Enforce paired-end reads (not supported)
    inputBinding:
      position: 102
      prefix: --pe
  - id: ont
    type:
      - 'null'
      - boolean
    doc: Long reads (Oxford Nanopore)
    inputBinding:
      position: 102
      prefix: --ont
  - id: abs
    type:
      - 'null'
      - boolean
    doc: Force absolute path
    inputBinding:
      position: 102
      prefix: --abs
  - id: basename
    type:
      - 'null'
      - boolean
    doc: Use basename instead of full path
    inputBinding:
      position: 102
      prefix: --basename
  - id: force_tsv
    type:
      - 'null'
      - boolean
    doc: Force tab separator, otherwise selected by the format
    inputBinding:
      position: 102
      prefix: --force-tsv
  - id: force_csv
    type:
      - 'null'
      - boolean
    doc: Force comma separator, otherwise selected by the format
    inputBinding:
      position: 102
      prefix: --force-csv
  - id: rand_meta
    type:
      - 'null'
      - int
    doc: Add a random metadata column with INT categories
    inputBinding:
      position: 102
      prefix: --rand-meta
  - id: project
    type:
      - 'null'
      - int
    doc: Project ID (only for irida)
    inputBinding:
      position: 102
      prefix: --project
  - id: meta_split
    type:
      - 'null'
      - string
    doc: 'Separator in the SampleID to extract metadata, used in MetaPhage [default: _]'
    inputBinding:
      position: 102
      prefix: --meta-split
  - id: meta_part
    type:
      - 'null'
      - int
    doc: 'Which part of the SampleID to extract metadata, used in MetaPhage [default: 1]'
    inputBinding:
      position: 102
      prefix: --meta-part
  - id: meta_default
    type:
      - 'null'
      - string
    doc: 'Default value for metadata, used in MetaPhage [default: Cond]'
    inputBinding:
      position: 102
      prefix: --meta-default
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 102
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_metadata.out

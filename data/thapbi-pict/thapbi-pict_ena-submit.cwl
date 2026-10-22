cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - thapbi_pict
  - ena-submit
label: thapbi-pict_ena-submit
doc: "Write paired FASTQ table for upload to ENA (and thus SRA).\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "One or more paired FASTQ filenames (`*.fastq` or `*.fastq.gz`)."
    inputBinding:
      position: 101
      prefix: -i
  - id: ignore_prefixes
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more filename prefixes to ignore, default Undetermined_ unknown_"
    inputBinding:
      position: 101
      prefix: --ignore-prefixes
  - id: md5sums
    type:
      - 'null'
      - type: array
        items: File
    doc: "MD5 checksum files named like the FASTQ files plus .md5 (e.g. example.fastq.gz.md5), or MD5SUM.txt; staged beside the FASTQ files."
  - id: ignore_stems
    type:
      - 'null'
      - File
    doc: "Text file of FASTQ stems to ignore, one per line."
    inputBinding:
      position: 101
      prefix: --ignore-stems
  - id: output
    type:
      - 'null'
      - string
    doc: "File to write to (default '-' meaning stdout)"
    inputBinding:
      position: 101
      prefix: -o
  - id: study
    type: string
    doc: "Value for study field, your PRJEB or ERP number."
    inputBinding:
      position: 101
      prefix: --study
  - id: metadata
    type:
      - 'null'
      - File
    doc: "Optional tab separated table containing metadata indexed by sample name. Must also specify the columns with -c."
    inputBinding:
      position: 101
      prefix: -t
  - id: metaencoding
    type:
      - 'null'
      - string
    doc: "Optional encoding of the metadata table, e.g. 'UTF-8', 'latin1'."
    inputBinding:
      position: 101
      prefix: -e
  - id: metacols
    type:
      - 'null'
      - string
    doc: "Comma separated list of columns from the metadata table to be included."
    inputBinding:
      position: 101
      prefix: -c
  - id: metaindex
    type:
      - 'null'
      - string
    doc: "If using metadata, which column contains the sequenced sample names. Default 1."
    inputBinding:
      position: 101
      prefix: -x
  - id: metafields
    type:
      - 'null'
      - int
    doc: "If using metadata, which row should be used as the field names? Default 1, use 0 for no labels."
    inputBinding:
      position: 101
      prefix: --metafields
  - id: library
    type:
      - 'null'
      - string
    doc: "Value for library_name field, default is '-' meaning take the FASTQ file's parent folder name."
    inputBinding:
      position: 101
      prefix: --library
  - id: instrument
    type:
      - 'null'
      - string
    doc: "Value for instrument_model field, default 'Illumina MiSeq'."
    inputBinding:
      position: 101
      prefix: --instrument
  - id: flat
    type:
      - 'null'
      - boolean
    doc: "Output FASTQ filenames without their directory prefix."
    inputBinding:
      position: 101
      prefix: --flat
  - id: temp
    type:
      - 'null'
      - string
    doc: "Debug option. Specify an (ideally empty) directory to use for temporary files, which will not be deleted."
    inputBinding:
      position: 101
      prefix: --temp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging."
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "ENA submission table"
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
    doc: "Standard output when no output file is given"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.input.concat(inputs.md5sums || []))"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
stdout: thapbi-pict_ena-submit.out

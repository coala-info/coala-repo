cwlVersion: v1.2
class: CommandLineTool
baseCommand: nohuman
label: nohuman
doc: "Remove human reads from a sequencing run\n\nTool homepage: https://github.com/mbhall88/nohuman"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s) to remove human reads from
    inputBinding:
      position: 1
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check that all required dependencies are available and exit
    inputBinding:
      position: 102
      prefix: --check
  - id: conf
    type:
      - 'null'
      - float
    doc: Kraken2 minimum confidence score
    inputBinding:
      position: 102
      prefix: --conf
  - id: db
    type:
      - 'null'
      - Directory
    doc: Path to the database
    inputBinding:
      position: 102
      prefix: --db
  - id: db_version
    type:
      - 'null'
      - string
    doc: Name of the database version to use (defaults to the newest installed).
      When used with `--download`, passing `all` downloads every available 
      version
    inputBinding:
      position: 102
      prefix: --db-version
  - id: download
    type:
      - 'null'
      - boolean
    doc: Download the database
    inputBinding:
      position: 102
      prefix: --download
  - id: human
    type:
      - 'null'
      - boolean
    doc: Output human reads instead of removing them
    inputBinding:
      position: 102
      prefix: --human
  - id: kraken_output
    type:
      - 'null'
      - File
    doc: Write the Kraken2 read classification output to a file
    inputBinding:
      position: 102
      prefix: --kraken-output
  - id: kraken_report
    type:
      - 'null'
      - File
    doc: Write the Kraken2 report with aggregate counts/clade to file
    inputBinding:
      position: 102
      prefix: --kraken-report
  - id: list_db_versions
    type:
      - 'null'
      - boolean
    doc: List available database versions and exit
    inputBinding:
      position: 102
      prefix: --list-db-versions
  - id: output_type
    type:
      - 'null'
      - string
    doc: "Output compression format. u: uncompressed; b: Bzip2; g: Gzip; x: Xz (Lzma);
      z: Zstd\n          \n          If not provided, the format will be inferred
      from the given output file name(s), or the\n          format of the input file(s)
      if no output file name(s) are given."
    inputBinding:
      position: 102
      prefix: --output-type
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use in kraken2 and optional output compression. 
      Cannot be 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set the logging level to verbose
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_1
    type:
      - 'null'
      - File
    doc: "First output file.\n          \n          Defaults to the name of the first
      input file with the suffix \"nohuman\" appended.\n          e.g. \"input_1.fastq\"\
      \ -> \"input_1.nohuman.fq\".\n          Compression of the output file is determined
      by the file extension of the output file name.\n          Or by using the `--output-type`
      option. If no output path is given, the same compression\n          as the input
      file will be used."
    outputBinding:
      glob: $(inputs.output_1)
  - id: output_2
    type:
      - 'null'
      - File
    doc: "Second output file.\n          \n          Defaults to the name of the first
      input file with the suffix \"nohuman\" appended.\n          e.g. \"input_2.fastq\"\
      \ -> \"input_2.nohuman.fq\".\n          Compression of the output file is determined
      by the file extension of the output file name.\n          Or by using the `--output-type`
      option. If no output path is given, the same compression\n          as the input
      file will be used."
    outputBinding:
      glob: $(inputs.output_2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nohuman:0.5.0--hbbf5808_0

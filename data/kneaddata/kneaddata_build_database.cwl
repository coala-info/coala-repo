cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kneaddata_build_database
label: kneaddata_build_database
doc: "Build a BMTagger database (bitmask, srprism index and BLAST database) from a FASTA file\n\nTool homepage: https://huttenhower.sph.harvard.edu/kneaddata"
inputs:
  - id: fasta
    type: File
    doc: input FASTA file
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: prefix for all output files (the directory part must already exist, so use a plain name)
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: bmtool_path
    type:
      - 'null'
      - string
    doc: path to bmtool executable
    inputBinding:
      position: 101
      prefix: --bmtool-path
  - id: srprism_path
    type:
      - 'null'
      - string
    doc: path to srprism executable
    inputBinding:
      position: 101
      prefix: --srprism-path
  - id: makeblastdb_path
    type:
      - 'null'
      - string
    doc: path to makeblastdb executable
    inputBinding:
      position: 101
      prefix: --makeblastdb-path
  - id: logdir
    type:
      - 'null'
      - string
    doc: location to store log files
    inputBinding:
      position: 101
      prefix: --logdir
outputs:
  - id: database_files
    type:
      type: array
      items: File
    doc: BMTagger database files written with the output prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: log files of bmtool, srprism and makeblastdb
    outputBinding:
      glob: |
        ${ return inputs.logdir ? inputs.logdir : "log"; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kneaddata:0.12.4--pyhdfd78af_0

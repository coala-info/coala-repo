cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - taxid-changelog
label: taxonkit_taxid-changelog
doc: "Create TaxId changelog from dump archives\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: archive_dir
    type:
      - 'null'
      - Directory
    doc: directory containing uncompressed dumped archives
    inputBinding:
      position: 101
      prefix: --archive
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: directory containing nodes.dmp and names.dmp
    default: /root/.taxonkit
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: use line buffering on output, i.e., immediately writing to stdin/file 
      for every line of output
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. 4 is enough
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1

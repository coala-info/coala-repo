cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadrep
label: tadrep_detect
doc: "Detects plasmids in a draft genome.\n\nTool homepage: https://github.com/oschwengers/tadrep"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose information
    inputBinding:
      position: 1
      prefix: --verbose
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default = number of available CPUs)
    inputBinding:
      position: 2
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Temporary directory to store blast hits
    inputBinding:
      position: 3
      prefix: --tmp-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for all output files (default = None)
    inputBinding:
      position: 4
      prefix: --prefix
  - id: state_dir
    type:
      - 'null'
      - Directory
    doc: Output directory of a previous TaDReP step (database, extract, characterize, cluster, detect), which is staged writable and used as the working directory
  - id: gap_sequence_length
    type:
      - 'null'
      - int
    doc: Gap sequence N length
    inputBinding:
      position: 101
      prefix: --gap-sequence-length
  - id: genome
    type:
      - 'null'
      - type: array
        items: File
    doc: Draft genome path
    inputBinding:
      position: 101
      prefix: --genome
  - id: min_contig_coverage
    type:
      - 'null'
      - int
    doc: Minimal contig coverage
    inputBinding:
      position: 101
      prefix: --min-contig-coverage
  - id: min_contig_identity
    type:
      - 'null'
      - int
    doc: Maximal contig identity
    inputBinding:
      position: 101
      prefix: --min-contig-identity
  - id: min_plasmid_coverage
    type:
      - 'null'
      - int
    doc: Minimal plasmid coverage
    inputBinding:
      position: 101
      prefix: --min-plasmid-coverage
  - id: min_plasmid_identity
    type:
      - 'null'
      - int
    doc: Minimal plasmid identity
    inputBinding:
      position: 101
      prefix: --min-plasmid-identity
outputs:
  - id: tadrep_out
    type: Directory
    doc: TaDReP output directory (working directory for the next step)
    outputBinding:
      glob: tadrep_out
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 5
    prefix: --output
    valueFrom: tadrep_out
  - position: 10
    valueFrom: detect
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.state_dir ? [{entry: inputs.state_dir, entryname: 'tadrep_out', writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
stdout: tadrep_detect.out

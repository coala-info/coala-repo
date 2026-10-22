cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadrep
label: tadrep_extract
doc: "Extracts sequences from input files based on specified criteria.\n\nTool homepage:
  https://github.com/oschwengers/tadrep"
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
  - id: discard_longest
    type:
      - 'null'
      - int
    doc: Discard n longest sequences in output
    inputBinding:
      position: 101
      prefix: --discard-longest
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: File path
    inputBinding:
      position: 101
      prefix: --files
  - id: header
    type:
      - 'null'
      - string
    doc: 'Template for header description inside input files: e.g.: header: ">pl1234"
      --> --header "pl"'
    inputBinding:
      position: 101
      prefix: --header
  - id: max_length
    type:
      - 'null'
      - int
    doc: Max sequence length (default = 1000000 bp)
    inputBinding:
      position: 101
      prefix: --max-length
  - id: type
    type:
      - 'null'
      - string
    doc: Type of input files
    inputBinding:
      position: 101
      prefix: --type
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
    valueFrom: extract
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.state_dir ? [{entry: inputs.state_dir, entryname: 'tadrep_out', writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
stdout: tadrep_extract.out

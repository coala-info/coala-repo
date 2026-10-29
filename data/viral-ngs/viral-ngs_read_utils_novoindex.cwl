cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - novoindex
label: viral-ngs_read_utils_novoindex
doc: "Index a reference genome with Novoindex (needs a Novoalign licence file).\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: ref_fasta
    type: File
    doc: "Reference genome, FASTA format. It is staged writable because the index is written beside it."
    inputBinding:
      position: 1
  - id: novoalign_license_path
    type:
      - 'null'
      - File
    doc: "A path to the novoalign.lic file. This overrides the NOVOALIGN_LICENSE_PATH environment variable. (default: None)"
    inputBinding:
      position: 20
      prefix: --NOVOALIGN_LICENSE_PATH
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: nix_file
    type: File
    doc: "Novoindex index (.nix)"
    outputBinding:
      glob: $(inputs.ref_fasta.nameroot).nix
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ref_fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_novoindex.out

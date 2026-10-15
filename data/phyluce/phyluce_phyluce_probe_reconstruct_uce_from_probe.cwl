cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_reconstruct_uce_from_probe
label: phyluce_phyluce_probe_reconstruct_uce_from_probe
doc: "From a UCE probe set, reconstruct the UCE sequence used for design\n\nTool homepage:\
  \ https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input_file
    type: File
    doc: The input probe set
    inputBinding:
      prefix: --input
  - id: output_path
    type: string
    doc: The output FASTA file
    inputBinding:
      prefix: --output
  - id: verbosity
    type:
      - 'null'
      - type: enum
        symbols:
          - INFO
          - WARN
          - CRITICAL
    doc: The logging level to use.
    inputBinding:
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: The path to a directory to hold logs (created for you).
    inputBinding:
      prefix: --log-path
outputs:
  - id: output
    type: File
    doc: The FASTA file of reconstructed UCE sequences.
    outputBinding:
      glob: $(inputs.output_path)
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: The log directory (when --log-path is set).
    outputBinding:
      glob: '$(inputs.log_path ? [inputs.log_path] : [])'
  - id: log_file
    type:
      - 'null'
      - File
    doc: The log file written to the working directory (when --log-path is not set).
    outputBinding:
      glob: '*.log'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.log_path ? {class: "Directory", basename: inputs.log_path,
          listing: []} : null)'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0

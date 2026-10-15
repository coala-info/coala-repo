cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_utilities_cleanup_trinity
label: phyluce_phyluce_utilities_cleanup_trinity
doc: "Remove the extra files from trinity assemblies (keeps Trinity.fasta and trinity.log)\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.path_to_clean)
        writable: true
inputs:
  - id: path_to_clean
    type: Directory
    doc: "The directory holding the trinity files to clean. It is staged writable, because the tool deletes files in it."
    inputBinding:
      position: 1
      prefix: --path-to-clean
      valueFrom: $(self.basename)
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "The logging level to use (INFO, WARN or CRITICAL)."
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path to a directory to hold logs. The directory must already exist."
    inputBinding:
      position: 1
      prefix: --log-path
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: cleaned_dir
    type: Directory
    doc: "The cleaned directory"
    outputBinding:
      glob: $(inputs.path_to_clean.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_utilities_cleanup_trinity.out

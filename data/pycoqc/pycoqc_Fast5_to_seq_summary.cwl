cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Fast5_to_seq_summary
label: pycoqc_Fast5_to_seq_summary
doc: "Generate a sequencing summary like file from a directory containing Fast5 files.\n\nTool homepage: https://github.com/a-slide/pycoQC"
inputs:
  - id: fast5_dir
    type: Directory
    doc: "Directory containing fast5 files. Can contain multiple subdirectories."
    inputBinding:
      position: 1
      prefix: --fast5_dir
  - id: seq_summary_fn
    type: string
    doc: "Path of the summary sequencing file where to write the data extracted from the fast5 files. Must include a directory part, for example ./summary.txt."
    inputBinding:
      position: 1
      prefix: --seq_summary_fn
  - id: max_fast5
    type:
      - 'null'
      - int
    doc: "Maximum number of file to try to parse. 0 to deactivate (default: 0)."
    inputBinding:
      position: 1
      prefix: --max_fast5
  - id: threads
    type:
      - 'null'
      - int
    doc: "Total number of threads to use. 1 thread is used for the reader and 1 for the writer. Minimum 3 (default: 4)."
    inputBinding:
      position: 1
      prefix: --threads
  - id: basecall_id
    type:
      - 'null'
      - int
    doc: "Id of the basecalling group (default: 0)."
    inputBinding:
      position: 1
      prefix: --basecall_id
  - id: fields
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of field names corresponding to attributes to try to fetch from the fast5 files."
    inputBinding:
      position: 1
      prefix: --fields
  - id: include_path
    type:
      - 'null'
      - boolean
    doc: "If given, the absolute path to the corresponding file is added in an extra column (default: False)."
    inputBinding:
      position: 1
      prefix: --include_path
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: "Level of verbosity, from 2 (Chatty) to 0 (Nothing) (default: 0)."
    inputBinding:
      position: 1
      prefix: --verbose_level
outputs:
  - id: seq_summary
    type: File
    doc: "Sequencing summary like file."
    outputBinding:
      glob: $(inputs.seq_summary_fn)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycoqc:2.5.2--py_0

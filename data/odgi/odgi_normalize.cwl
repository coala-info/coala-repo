cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi normalize
label: odgi_normalize
doc: "Compact unitigs and simplify redundant furcations.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print information about the normalization process to stdout.
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_file
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: 'Iterate the normalization up to N many times (default: 10).'
    default: 10
    inputBinding:
      position: 101
      prefix: --max-iterations
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: Write the normalized dynamic succinct variation graph in ODGI format to
      this file. A file ending with *.og* is recommended.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0

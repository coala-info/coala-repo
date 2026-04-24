cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ldhelmet
  - find_confs
label: ldhelmet_find_confs
doc: "Finds configurations for LDHelmet.\n\nTool homepage: http://sourceforge.net/projects/ldhelmet/"
inputs:
  - id: seq_files
    type:
      type: array
      items: File
    doc: Sequence file(s) to process.
    inputBinding:
      position: 1
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: --num_threads
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size.
    inputBinding:
      position: 102
      prefix: --window_size
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name for output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldhelmet:1.10--h0704011_8

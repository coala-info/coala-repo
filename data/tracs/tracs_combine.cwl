cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracs_combine
label: tracs_combine
doc: "Combine runs of TRACS'm align ready for distance estimation\n\nTool homepage:
  https://github.com/gtonkinhill/tracs"
inputs:
  - id: input_directories
    type:
      type: array
      items: Directory
    doc: Paths to each directory containing the output of the TRACS align 
      function
    inputBinding:
      position: 101
      prefix: --input
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set the logging threshold.
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_dir_path
    type: Directory
    doc: Output or path parameter `output_dir_path`
    inputBinding:
      position: 102
      prefix: --output-dir
outputs:
  - id: output_dir
    type: Directory
    doc: name of the output driectory to store the combined alignments.
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1

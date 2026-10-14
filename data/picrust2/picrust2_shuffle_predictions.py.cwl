cwlVersion: v1.2
class: CommandLineTool
baseCommand: shuffle_predictions.py
label: picrust2_shuffle_predictions.py
doc: "Shuffles sequence ids of a prediction table for a specified number of replicates. Each predicted genome stays the same, but the sequence ids linked with it are randomized.\n\nTool homepage: https://github.com/picrust/picrust2"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input)
inputs:
  - id: input
    type: File
    doc: 'Input prediction table. It is staged in the working directory and passed by file name, because the tool joins the output folder with the input path and would write beside an absolute input path.'
    inputBinding:
      position: 101
      valueFrom: $(self.basename)
      prefix: --input
  - id: rep
    type:
      - 'null'
      - int
    doc: 'Number of shuffled replicates to create (default: 1).'
    inputBinding:
      position: 101
      prefix: --rep
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random seed for reproducible shuffling.'
    inputBinding:
      position: 101
      prefix: --seed
  - id: outdir_path
    type: string
    doc: 'Path to output directory.'
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: outdir
    type: Directory
    doc: 'Folder with the shuffled tables.'
    outputBinding:
      glob: $(inputs.outdir_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1

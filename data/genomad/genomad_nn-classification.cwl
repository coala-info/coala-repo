cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genomad
  - nn-classification
label: genomad_nn-classification
doc: "Classify the sequences in the INPUT file (FASTA format) using the geNomad neural network and write the results to the OUTPUT directory.\n\nTool homepage: https://portal.nersc.gov/genomad/"
inputs:
  - id: input
    type: File
    doc: "Input FASTA file."
    inputBinding:
      position: 1
  - id: previous_dir
    type:
      - 'null'
      - Directory
    doc: "Optional output directory of earlier geNomad modules (for example annotate or marker-classification) run on the same INPUT. If given, it is copied to the OUTPUT directory (named by output) so that this module adds its results next to the earlier ones. This module does not read them."
  - id: output
    type: string
    doc: "Output directory."
    inputBinding:
      position: 2
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Number of data points per batch of prediction. Use a smaller value to reduce memory comsumption at the cost of speed."
    inputBinding:
      position: 103
      prefix: --batch-size
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: "Delete intermediate files after execution."
    inputBinding:
      position: 103
      prefix: --cleanup
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Display the execution log."
    inputBinding:
      position: 103
      prefix: --quiet
  - id: restart
    type:
      - 'null'
      - boolean
    doc: "Overwrite existing intermediate files."
    inputBinding:
      position: 103
      prefix: --restart
  - id: single_window
    type:
      - 'null'
      - boolean
    doc: "Use only the first window (6,000 bases) of each sequence to perform the classification. This will make execution faster and reduce memory usage, but the classification accuracy will decrease."
    inputBinding:
      position: 103
      prefix: --single-window
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use."
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Display the execution log."
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: out_output
    type: Directory
    doc: "Output directory."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        if (inputs.previous_dir) {
          return [{entry: inputs.previous_dir, entryname: inputs.output, writable: true}];
        }
        return [];
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomad:1.11.2--pyhdfd78af_0

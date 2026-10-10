cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanosim-h-train
label: nanosim-h_train
doc: "NanoSim-H-Train - compute an error profile for NanoSim-H.\n\nTool homepage: https://github.com/karel-brinda/NanoSim-H"
inputs:
  - id: reference
    type: File
    doc: Reference genome of the training reads.
    inputBinding:
      position: 101
  - id: profile_dir
    type: string
    doc: Error profile directory (created by the tool).
    inputBinding:
      position: 102
  - id: infile
    type:
      - 'null'
      - File
    doc: Training ONT real reads, must be fasta files.
    inputBinding:
      position: 1
      prefix: --infile
  - id: maf
    type:
      - 'null'
      - File
    doc: User-provided alignment file, with maf extension.
    inputBinding:
      position: 1
      prefix: --maf
  - id: num_bins
    type:
      - 'null'
      - int
    doc: Number of bins (for development) [20].
    inputBinding:
      position: 1
      prefix: --num-bins
  - id: no_model_fit
    type:
      - 'null'
      - boolean
    doc: No model fitting.
    inputBinding:
      position: 1
      prefix: --no-model-fit
outputs:
  - id: profile
    type: Directory
    doc: The computed error profile directory.
    outputBinding:
      glob: $(inputs.profile_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim-h:1.1.0.4--pyr341h24bf2e0_0

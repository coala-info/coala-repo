cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - mss
label: hyphy_mss
doc: "[MSS] Fits a model with multiple synonymous rates (MSS model) to several genes jointly.\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: cpu
    type:
      - 'null'
      - int
    doc: "Number of threads to use (HyPhy CPU= argument)."
    inputBinding:
      position: 0
      prefix: CPU=
      separate: false
  - id: files
    type:
      type: array
      items: File
    doc: The alignment files named in the file list; they are staged into the working directory so that the names in the list resolve.
  - id: filelist
    type: File
    doc: "List of files to include in this analysis: a text file with one alignment file name per line (each alignment file holds its tree)."
    inputBinding:
      position: 101
      prefix: --filelist
  - id: code
    type:
      - 'null'
      - string
    doc: "Which genetic code should be used (default: Universal)."
    inputBinding:
      position: 101
      prefix: --code
  - id: omega
    type:
      - 'null'
      - string
    doc: "How should alignment-level omega be treated: Fix or Fit (default: Fix)."
    inputBinding:
      position: 101
      prefix: --omega
  - id: model
    type:
      - 'null'
      - string
    doc: "Substitution model to use (default: SynREV)."
    inputBinding:
      position: 101
      prefix: --model
  - id: save_fit
    type:
      - 'null'
      - string
    doc: "Write the resulting model fit file to this (large) file (default: /dev/null)."
    inputBinding:
      position: 101
      prefix: --save-fit
  - id: output
    type: string
    doc: "Write the resulting JSON to this file."
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the analysis results
  - id: json
    type: File
    doc: The resulting JSON file.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
stdout: hyphy_mss.out

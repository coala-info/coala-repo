cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - mss-ga
label: hyphy_mss-ga
doc: "[MSS-GA] Perform a Genetic Algorithm search model selection for a codon MSS model on a collection of alignments.\n\nTool homepage: http://hyphy.org/"
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
  - id: ic
    type:
      - 'null'
      - string
    doc: "Which information criterion should be used for scoring (default: AIC-c)."
    inputBinding:
      position: 101
      prefix: --ic
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
stdout: hyphy_mss-ga.out

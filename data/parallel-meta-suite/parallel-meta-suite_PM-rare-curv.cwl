cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PM-rare-curv
label: parallel-meta-suite_PM-rare-curv
doc: "Make the rarefaction curve\n\nTool homepage: https://github.com/qdu-bioinfo/parallel-meta-suite"
inputs:
  - id: feature_table
    type:
      - 'null'
      - File
    doc: "Input feature count table (*.OTU.Count); rows are samples and columns are features"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: feature_table_upper
    type:
      - 'null'
      - File
    doc: "Input feature count table (*.OTU.Count), read with the table reader"
    inputBinding:
      position: 1
      prefix: "-T"
  - id: output_directory_name
    type:
      - 'null'
      - string
    doc: "Output file directory, default is \"result\""
    default: result
    inputBinding:
      position: 1
      prefix: "-o"
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "Prefix name of output, default is \"out\""
    inputBinding:
      position: 1
      prefix: "-p"
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: "The bootstrap value, default is 20"
    inputBinding:
      position: 1
      prefix: "-b"
  - id: rarefaction_step
    type:
      - 'null'
      - int
    doc: "The rarefaction step, default is 100"
    inputBinding:
      position: 1
      prefix: "-s"
  - id: curve_label
    type:
      - 'null'
      - string
    doc: "The rarefaction curve label, T is enable and F is disable, default is F"
    inputBinding:
      position: 1
      prefix: "-l"
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads, default is auto"
    inputBinding:
      position: 1
      prefix: "-t"
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: "Rarefaction curve tables"
    outputBinding:
      glob: "$(inputs.output_directory_name)"
  - id: stdout
    type: stdout
    doc: "Standard output (screen messages)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
stdout: parallel-meta-suite_PM-rare-curv.out

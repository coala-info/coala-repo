cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svhip
  - combine
label: svhip_combine
doc: "Combine feature vectors from multiple files.\n\nTool homepage: https://github.com/chrisBioInf/Svhip"
inputs:
  - id: input_file
    type: Directory
    doc: The input directory or file (Required).
    inputBinding:
      position: 101
      prefix: --input
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for selection of files to combine. For example, if set to TEST, 
      only valid feature vector containing files with the prefix TEST will be 
      added.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: outfile_path
    type: string
    inputBinding:
      position: 102
      prefix: --outfile
outputs:
  - id: outfile
    type: File
    doc: Combined feature table (the tool adds .tsv to the name when missing).
    outputBinding:
      glob: $(inputs.outfile_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0

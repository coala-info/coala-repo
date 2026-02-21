cwlVersion: v1.2
class: CommandLineTool
baseCommand: fusioncatcher
label: fusioncatcher
doc: "FusionCatcher is used for finding somatic fusion genes in paired-end RNA-seq
  data. (Note: The provided text is an error log and does not contain CLI help information;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/ndaniel/fusioncatcher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusioncatcher:1.33--hdfd78af_6
stdout: fusioncatcher.out

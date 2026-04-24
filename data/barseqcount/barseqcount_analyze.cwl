cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - barseqcount.py
  - analyze
label: barseqcount_analyze
doc: "Analyze barseqcount results\n\nTool homepage: https://github.com/damienmarsic/barseqcount"
inputs:
  - id: configuration_file
    type:
      - 'null'
      - File
    doc: 'Configuration file for the barseqcount analyze program (default: barseqcount_analyze.conf),
      will be created if absent'
    inputBinding:
      position: 101
      prefix: --configuration_file
  - id: file_format
    type:
      - 'null'
      - string
    doc: 'Save each figure in separate file with choice of format instead of the default
      single multipage pdf file. Choices: svg, png, jpg, pdf, ps, eps, pgf, raw, rgba,
      tif'
    inputBinding:
      position: 101
      prefix: --file_format
  - id: new
    type:
      - 'null'
      - boolean
    doc: Create new configuration file and rename existing one
    inputBinding:
      position: 101
      prefix: --new
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barseqcount:0.1.5--pyhdfd78af_0
stdout: barseqcount_analyze.out

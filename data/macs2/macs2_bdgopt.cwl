cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs2
  - bdgopt
label: macs2_bdgopt
doc: "Modify the score column of a bedGraph file using various methods like multiply,
  add, max, min, or p2q conversion.\n\nTool homepage: https://pypi.org/project/MACS2/"
inputs:
  - id: extra_param
    type:
      - 'null'
      - type: array
        items: float
    doc: The extra parameter for METHOD. Check the detail of -m option.
    inputBinding:
      position: 101
      prefix: --extra-param
  - id: ifile
    type: File
    doc: 'MACS score in bedGraph. Note: this must be a bedGraph file covering the
      ENTIRE genome.'
    inputBinding:
      position: 101
      prefix: --ifile
  - id: method
    type:
      - 'null'
      - string
    doc: 'Method to modify the score column of bedGraph file. Available choices are:
      multiply, add, max, min, or p2q.'
    inputBinding:
      position: 101
      prefix: --method
  - id: ofile_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `ofile_path`
    inputBinding:
      position: 102
      prefix: --ofile
  - id: outdir_path
    type:
      - 'null'
      - string
    doc: If specified all output files will be written to that
    inputBinding:
      position: 103
      prefix: --outdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    outputBinding:
      glob: $(inputs.outdir_path)
  - id: ofile
    type: File
    doc: Output BEDGraph filename.
    outputBinding:
      glob: $(inputs.ofile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5

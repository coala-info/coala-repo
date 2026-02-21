cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - bdgopt
label: macs3_bdgopt
doc: "Modify the score column of a bedGraph file using various methods like multiply,
  add, max, min, or p2q conversion.\n\nTool homepage: https://pypi.org/project/MACS3/"
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
      ENTIRE genome. REQUIRED'
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
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Set verbose level of runtime message. 0: only show critical message, 1:
      show additional warning message, 2: show process information, 3: show debug
      messages. DEFAULT:2'
    default: 2
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    outputBinding:
      glob: $(inputs.outdir)
  - id: ofile
    type: File
    doc: Output BEDGraph filename.
    outputBinding:
      glob: $(inputs.ofile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0

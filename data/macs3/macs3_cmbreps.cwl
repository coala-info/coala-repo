cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - cmbreps
label: macs3_cmbreps
doc: "Combine scores from replicates using different methods like Fisher's, max, or
  mean.\n\nTool homepage: https://pypi.org/project/MACS3/"
inputs:
  - id: ifile
    type:
      type: array
      items: File
    doc: MACS score in bedGraph for each replicate. Require at least 2 files 
      such as '-i A B C D'.
    inputBinding:
      position: 101
      prefix: -i
  - id: method
    type:
      - 'null'
      - string
    doc: "Method to use while combining scores from replicates. 1) fisher: Fisher's
      combined probability test. 2) max: take the maximum value. 3) mean: take the
      average value."
    default: fisher
    inputBinding:
      position: 101
      prefix: --method
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Set verbose level of runtime message. 0: only show critical message, 1:
      show additional warning message, 2: show process information, 3: show debug
      messages.'
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
    doc: Output BEDGraph filename for combined scores.
    outputBinding:
      glob: $(inputs.ofile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0

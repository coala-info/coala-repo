cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - bdgopt
label: macs3_bdgopt
doc: Modify the score column of a bedGraph file using various methods.
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
    type: string
    doc: 'Method to modify the score column of bedGraph file. Available choices are:
      multiply, add, max, min, or p2q.'
    inputBinding:
      position: 101
      prefix: --method
  - id: ofile
    type: string
    doc: Output BEDGraph filename.
    inputBinding:
      position: 101
      prefix: --ofile
  - id: outdir
    type: string
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    inputBinding:
      position: 101
      prefix: --outdir
outputs:
  - id: output_outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    outputBinding:
      glob: $(inputs.outdir)
  - id: output_ofile
    type: File
    doc: Output BEDGraph filename.
    outputBinding:
      glob: $(inputs.ofile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.4--py310h5a5e57a_0
s:url: https://pypi.org/project/MACS3/
$namespaces:
  s: https://schema.org/

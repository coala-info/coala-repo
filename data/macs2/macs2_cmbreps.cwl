cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs2
  - cmbreps
label: macs2_cmbreps
doc: "Combine scores from replicates in bedGraph format using various methods like
  Fisher's, max, or mean.\n\nTool homepage: https://pypi.org/project/MACS2/"
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
    doc: Output BEDGraph filename for combined scores.
    outputBinding:
      glob: $(inputs.ofile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5

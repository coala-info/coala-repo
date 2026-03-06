cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - cmbreps
label: macs3_cmbreps
doc: Combine scores from replicates using different methods such as Fisher's, 
  max, or mean.
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
  - id: ofile
    type: string
    doc: Output BEDGraph filename for combined scores.
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
    doc: Output BEDGraph filename for combined scores.
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

cwlVersion: v1.2
class: CommandLineTool
baseCommand: fkeyprint
label: heasoft_fkeyprint
doc: "Display the value of a keyword in a FITS file header. (Note: The provided help
  text contained a system error; parameters are based on standard tool documentation).\n
  \nTool homepage: https://heasarc.gsfc.nasa.gov/lheasoft/"
inputs:
  - id: infile
    type: File
    doc: The name of the FITS file and optional extension to be examined.
    inputBinding:
      position: 1
  - id: keyname
    type: string
    doc: The name of the keyword to be printed.
    inputBinding:
      position: 2
  - id: exact
    type:
      - 'null'
      - boolean
    doc: Should the keyword name match exactly?
    default: false
    inputBinding:
      position: 103
      prefix: exact
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: The name of the output file. If set to STDOUT, the output is sent to the
      standard output device.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/heasoft:6.35.2--hedafe93_1

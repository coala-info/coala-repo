cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cblaster
  - gne
label: cblaster_gne
doc: "Gene neighbourhood estimation.\nRepeatedly recomputes homologue clusters with
  different --gap values.\n\nTool homepage: https://github.com/gamcil/cblaster"
inputs:
  - id: session
    type: File
    doc: cblaster session file
    inputBinding:
      position: 1
  - id: decimals
    type:
      - 'null'
      - int
    doc: Total decimal places to use when printing score values
    inputBinding:
      position: 102
      prefix: --decimals
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Delimiter character to use when printing result output.
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: hide_headers
    type:
      - 'null'
      - boolean
    doc: Hide headers when printing result output.
    inputBinding:
      position: 102
      prefix: --hide_headers
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum intergenic distance
    inputBinding:
      position: 102
      prefix: --max_gap
  - id: plot_path
    type:
      - 'null'
      - string
    doc: Specify this argument without value to dynamically serve te plot. If a 
      file location is provided the plot will be saved there.
    inputBinding:
      position: 102
      prefix: --plot
  - id: samples
    type:
      - 'null'
      - int
    doc: Total samples taken from max_gap
    inputBinding:
      position: 102
      prefix: --samples
  - id: scale
    type:
      - 'null'
      - string
    doc: Draw sampling values from a linear or log scale
    inputBinding:
      position: 102
      prefix: --scale
  - id: output_path
    type: string
    doc: Write results to file
    inputBinding:
      position: 103
      prefix: --output
  - id: ncbi_email
    type:
      - 'null'
      - string
    doc: E-mail address for NCBI Entrez. cblaster refuses to start without an 
      e-mail or NCBI API key in its config file; this CWL writes that file 
      ($HOME/.config/cblaster/config.ini) from ncbi_email / ncbi_api_key.
  - id: ncbi_api_key
    type:
      - 'null'
      - string
    doc: NCBI API key written to the cblaster config file (alternative to 
      ncbi_email)
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write results to file
    outputBinding:
      glob: $(inputs.output_path)
  - id: plot
    type:
      - 'null'
      - File
    doc: Static HTML plot
    outputBinding:
      glob: $(inputs.plot_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - |-
        ${ var s = "[cblaster]\n"; if (inputs.ncbi_email) { s += "email = " + inputs.ncbi_email + "\n"; } if (inputs.ncbi_api_key) { s += "api_key = " + inputs.ncbi_api_key + "\n"; } return {"class": "Directory", "basename": ".config", "listing": [{"class": "Directory", "basename": "cblaster", "listing": [{"class": "File", "basename": "config.ini", "contents": s}]}]}; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0

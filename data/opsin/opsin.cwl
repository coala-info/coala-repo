cwlVersion: v1.2
class: CommandLineTool
baseCommand: opsin
label: opsin
doc: "Open Parser for Systematic IUPAC Nomenclature (OPSIN). A tool for converting chemical names into structure representations (such as SMILES, InChI, or CML).\n\nTool homepage: https://bitbucket.org/dan2097/opsin/"
inputs:
  - id: allow_acids_without_acid
    type:
      - 'null'
      - boolean
    doc: "Allows interpretation of acids without the word acid e.g. \"acetic\""
    inputBinding:
      position: 101
      prefix: "-a"
  - id: detailed_failure_analysis
    type:
      - 'null'
      - boolean
    doc: "Enables reverse parsing to more accurately determine why parsing failed"
    inputBinding:
      position: 101
      prefix: "-f"
  - id: include_name
    type:
      - 'null'
      - boolean
    doc: "Include name in SMILES/InChI output (tab delimited)"
    inputBinding:
      position: 101
      prefix: "-n"
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Sets the output format (default smi). Allowed: cml, smi, extendedsmi, inchi, stdinchi, stdinchikey"
    inputBinding:
      position: 101
      prefix: "-o"
  - id: allow_radicals
    type:
      - 'null'
      - boolean
    doc: "Enables interpretation of radicals"
    inputBinding:
      position: 101
      prefix: "-r"
  - id: allow_uninterpretable_stereo
    type:
      - 'null'
      - boolean
    doc: "Allows stereochemistry uninterpretable by OPSIN to be ignored"
    inputBinding:
      position: 101
      prefix: "-s"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enables debugging"
    inputBinding:
      position: 101
      prefix: "-v"
  - id: wildcard_radicals
    type:
      - 'null'
      - boolean
    doc: "Radicals are output as wildcard atoms"
    inputBinding:
      position: 101
      prefix: "-w"
  - id: input_file
    type: File
    doc: "File of new line delimited chemical names."
    inputBinding:
      position: 1
  - id: output_file_name
    type: string
    doc: "Output file name."
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: "Converted structures, one per input name"
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/opsin:2.4.0--hdfd78af_3

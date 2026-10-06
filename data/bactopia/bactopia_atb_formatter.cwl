cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bactopia-atb-formatter
label: bactopia_atb_formatter
doc: "Restructure All-the-Bacteria assemblies to allow usage with Bactopia Tools\n\
  \nTool homepage: https://github.com/bactopia/bactopia"
inputs:
  - id: assembly_dir
    type: Directory
    doc: Directory where ATB assemblies are stored
    inputBinding:
      position: 1
      prefix: --path
  - id: bactopia_dir
    type: string
    doc: The path you would like to place bactopia structure
    inputBinding:
      position: 1
      prefix: --bactopia-dir
    default: bactopia
  - id: publish_mode
    type:
      - 'null'
      - string
    doc: 'Specifies how assemblies will be saved in the Bactopia directory (symlink
      or copy) [default: symlink]; use copy so the output folder holds real files'
    inputBinding:
      position: 1
      prefix: --publish-mode
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Traverse recursively through provided path
    inputBinding:
      position: 1
      prefix: --recursive
  - id: extension
    type:
      - 'null'
      - string
    doc: 'The extension of the FASTA files [default: .fa]'
    inputBinding:
      position: 1
      prefix: --extension
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity of output
    inputBinding:
      position: 1
      prefix: --verbose
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed
    inputBinding:
      position: 1
      prefix: --silent
outputs:
  - id: bactopia_structure
    type: Directory
    doc: Bactopia directory structure with one folder per assembly
    outputBinding:
      glob: $(inputs.bactopia_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: [searchgui, eu.isas.searchgui.cmd.FastaCLI]
label: searchgui_fasta_cli
doc: "FastaCLI takes a FASTA file as input, generates general information about the database and allows operations on the FASTA file.\n\nTool homepage: https://github.com/compomics/searchgui"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in)
        writable: true
inputs:
  - id: fasta_in
    type: File
    doc: "FASTA file"
    inputBinding:
      position: 1
      prefix: -in
      valueFrom: $(self.basename)
  - id: decoy
    type: ['null', boolean]
    doc: "Create a concatenated target/decoy database."
    inputBinding:
      position: 1
      prefix: -decoy
  - id: decoy_suffix
    type: ['null', string]
    doc: "Target decoy suffix, defaults to _concatenated_target_decoy."
    inputBinding:
      position: 1
      prefix: -decoy_suffix
  - id: temp_folder
    type: ['null', string]
    doc: "A folder for temporary file storage. Use only if you encounter problems with the default configuration."
    inputBinding:
      position: 1
      prefix: -temp_folder
  - id: name
    type: ['null', string]
    doc: "The name of the database, FASTA file name by default."
    inputBinding:
      position: 1
      prefix: -name
  - id: description
    type: ['null', string]
    doc: "The description of the database, FASTA file name by default."
    inputBinding:
      position: 1
      prefix: -description
  - id: version
    type: ['null', string]
    doc: "The version of the database, date of creation of the file by default."
    inputBinding:
      position: 1
      prefix: -version
  - id: decoy_flag
    type: ['null', string]
    doc: "The decoy flag, default: -REVERSED."
    inputBinding:
      position: 1
      prefix: -decoy_flag
  - id: suffix
    type: ['null', string]
    doc: "The location of the decoy flag: (1) prefix, (2) suffix. Inferred if not specified."
    inputBinding:
      position: 1
      prefix: -suffix
outputs:
  - id: decoy_fasta
    type: ['null', File]
    doc: Concatenated target/decoy FASTA written next to the input when -decoy is set
    outputBinding:
      glob: '*_concatenated_target_decoy.fasta'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/searchgui:4.3.15--hdfd78af_0
stdout: searchgui_fasta_cli.out

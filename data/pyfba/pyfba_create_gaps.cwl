cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfba
  - create_gaps
label: pyfba_create_gaps
doc: "Import a list of reactions and then iterate through testing each reaction to see if the model can still grow; reduce them to the smallest set that can run\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: reactions
    type: File
    doc: "reactions file"
    inputBinding:
      position: 1
      prefix: --reactions
  - id: media
    type: string
    doc: "media name (a predefined PyFBA media name or a media file path)"
    inputBinding:
      position: 1
      prefix: --media
  - id: flux_fraction
    type:
      - 'null'
      - float
    doc: "Flux fraction to consider growth. By default we use any flux but you can set it to e.g. 0.75 of the initial flux"
    inputBinding:
      position: 1
      prefix: --flux_fraction
  - id: log
    type:
      - 'null'
      - string
    doc: "log file name to write the detailed output (optional); the tool writes it under logs/"
    inputBinding:
      position: 1
      prefix: --log
  - id: output_path
    type: string
    doc: "file to save new reaction list to"
    inputBinding:
      position: 1
      prefix: --output
  - id: type
    type:
      - 'null'
      - string
    doc: "organism type for the model (currently allowed are ['gramnegative', 'grampositive', 'microbial', 'mycobacteria', 'plant']). Default=gramnegative"
    inputBinding:
      position: 1
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: File
    doc: "Reduced reaction list"
    outputBinding:
      glob: $(inputs.output_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Detailed log (written to logs/<log>)
    outputBinding:
      glob: logs/$(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_create_gaps.out

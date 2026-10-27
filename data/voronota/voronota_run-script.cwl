cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - run-script
label: voronota_run-script
doc: "Runs a Voronota script.

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.data_files ? inputs.data_files : [])'
inputs:
  - id: input_script
    type: File
    doc: "script as plain text (stdin)"
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files used by the script (staged in the working directory so the script can name them)"
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: "flag for interactive mode"
    inputBinding:
      position: 101
      prefix: --interactive
  - id: exit_on_first_failure
    type:
      - 'null'
      - boolean
    doc: "flag to terminate script when a command fails"
    inputBinding:
      position: 101
      prefix: --exit-on-first-failure
  - id: max_unfolding
    type:
      - 'null'
      - int
    doc: "maximum level of output unfolding, default is 6"
    inputBinding:
      position: 101
      prefix: --max-unfolding
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdin: $(inputs.input_script.path)
stdout: voronota_run-script.out

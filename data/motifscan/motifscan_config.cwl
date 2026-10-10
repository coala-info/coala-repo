cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - motifscan
  - config
label: motifscan_config
doc: "Configure data paths for MotifScan.\n\nTool homepage: https://github.com/shao-lab/MotifScan"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Existing MotifScan config file (.motifscanrc). It is staged as
      ~/.motifscanrc so list, uninstall and config commands see it. Without it
      the config starts empty. The default config is not kept between runs.
  - id: get_genome
    type:
      - 'null'
      - string
    doc: Get the genome path of a specific genome assembly.
    inputBinding:
      position: 101
      prefix: --get-genome
  - id: get_motif
    type:
      - 'null'
      - string
    doc: Get the motif path of a specific motif set.
    inputBinding:
      position: 101
      prefix: --get-motif
  - id: rm_genome
    type:
      - 'null'
      - string
    doc: Remove a specific genome assembly.
    inputBinding:
      position: 101
      prefix: --rm-genome
  - id: rm_motif
    type:
      - 'null'
      - string
    doc: Remove a specific motif set.
    inputBinding:
      position: 101
      prefix: --rm-motif
  - id: set_default_genome
    type:
      - 'null'
      - string
    doc: Set the default installation path for genome assemblies.
    inputBinding:
      position: 101
      prefix: --set-default-genome
  - id: set_default_motif
    type:
      - 'null'
      - string
    doc: Set the default installation path for motif sets.
    inputBinding:
      position: 101
      prefix: --set-default-motif
  - id: set_genome
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the genome path for a specific genome assembly.
    inputBinding:
      position: 101
      prefix: --set-genome
  - id: set_motif
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the motif path for a specific motif set.
    inputBinding:
      position: 101
      prefix: --set-motif
  - id: show
    type:
      - 'null'
      - boolean
    doc: Show all configured values.
    inputBinding:
      position: 101
      prefix: --show
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose log messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: config_out
    type:
      - 'null'
      - File
    doc: The MotifScan config file after the command (.motifscanrc).
    outputBinding:
      glob: .motifscanrc
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        return inputs.config_file ? [{entryname: ".motifscanrc", entry: inputs.config_file, writable: true}] : [];
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifscan:1.3.0--py310h4b81fae_3
stdout: motifscan_config.out

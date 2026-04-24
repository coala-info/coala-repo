cwlVersion: v1.2
class: CommandLineTool
baseCommand: hdmi_summary
label: hdmi_summary
doc: "Generates a summary of HDMI validation results.\n\nTool homepage: https://github.com/HaoranPeng21/HDMI"
inputs:
  - id: group_info
    type: File
    doc: Group info file
    inputBinding:
      position: 101
      prefix: --group_info
  - id: hgt_events
    type:
      - 'null'
      - File
    doc: HGT events file (auto-found in output directory if not provided)
    inputBinding:
      position: 101
      prefix: --hgt_events
  - id: samples_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing validation results (auto-found in 
      output/intermediate/02_validation if not provided)
    inputBinding:
      position: 101
      prefix: --samples_dir
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for merged files
    inputBinding:
      position: 101
      prefix: --temp_dir
  - id: threshold
    type:
      - 'null'
      - float
    doc: Abundance threshold
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdmi:1.0.0--pyhdfd78af_0

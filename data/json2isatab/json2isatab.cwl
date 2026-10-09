cwlVersion: v1.2
class: CommandLineTool
label: json2isatab
doc: "Convert an ISA-JSON file to ISA-Tab. The image entrypoint is run_json2tab.py, so the CWL has no baseCommand.\n\nTool homepage: https://github.com/phnmnl/container-json2isatab"
inputs:
  - id: json_file
    type: File
    doc: Path to ISA-JSON file
    inputBinding:
      position: 1
outputs:
  - id: isatab_files
    type:
      type: array
      items: File
    doc: ISA-Tab files (investigation, study and assay tables) written next to the input
    outputBinding:
      glob: '*.txt'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.json_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/json2isatab:phenomenal-v0.9.4_cv0.5.39

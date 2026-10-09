cwlVersion: v1.2
class: CommandLineTool
label: isatab2json
doc: "Converts ISA-Tab files to JSON format. The container entrypoint is isatab2json.py,
  which takes the ISA-Tab directory and the output JSON path as positional arguments.\n\nTool homepage:
  https://github.com/bio-agents/isatab2json_docker"
inputs:
  - id: isatab_dir
    type: Directory
    doc: Directory containing ISA-Tab files (i_*.txt, s_*.txt, a_*.txt)
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    doc: Path to the output JSON file
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: ISA JSON file
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isatab2json:phenomenal-v0.10.0_cv0.6.1.69

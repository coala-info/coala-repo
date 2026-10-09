cwlVersion: v1.2
class: CommandLineTool
label: isatab-create
doc: "Create ISA-Tab files from Galaxy JSON input (study design parameters). The container
  entrypoint is cli.py, so no baseCommand is given. The target directory must exist,
  so it is created before the run.\n\nTool homepage: https://github.com/phnmnl/container-isatab-create"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.target_dir_path)
        entry: '$({"class": "Directory", "basename": inputs.target_dir_path, "listing": []})'
        writable: true
inputs:
  - id: galaxy_parameters_file
    type: File
    doc: Path to JSON file containing input Galaxy JSON
    inputBinding:
      position: 101
      prefix: --galaxy_parameters_file
  - id: target_dir_path
    type: string
    doc: Output path to write
    inputBinding:
      position: 102
      prefix: --target_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: target_dir
    type: Directory
    doc: Directory with the created ISA-Tab files
    outputBinding:
      glob: $(inputs.target_dir_path)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isatab-create:v0.9.5_cv0.3.14
stdout: isatab-create.out

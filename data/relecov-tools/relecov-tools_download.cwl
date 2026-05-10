cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - relecov-tools
  - download
label: relecov-tools_download
doc: "Download files located in sftp server.\n\nTool homepage: https://github.com/BU-ISCIII/relecov-tools"
inputs:
  - id: conf_file
    type:
      - 'null'
      - string
    doc: Configuration file (not params file)
    inputBinding:
      position: 101
      prefix: --conf_file
  - id: download_option
    type:
      - 'null'
      - string
    doc: 'Select the download option: [download_only, download_clean, delete_only].
      download_only will only download the files download_clean will remove files
      from sftp after download delete_only will only delete the files'
    inputBinding:
      position: 101
      prefix: --download_option
  - id: password
    type:
      - 'null'
      - string
    doc: password for the user to login
    inputBinding:
      position: 101
      prefix: --password
  - id: subfolder
    type:
      - 'null'
      - string
    doc: 'Flag: Specify which subfolder to process'
    inputBinding:
      position: 101
      prefix: --subfolder
  - id: target_folders
    type:
      - 'null'
      - string
    doc: 'Flag: Select which folders will be targeted giving [paths] or via prompt.
      For multiple folders use ["folder1", "folder2"]'
    inputBinding:
      position: 101
      prefix: --target_folders
  - id: user
    type:
      - 'null'
      - string
    doc: User name for login to sftp server
    inputBinding:
      position: 101
      prefix: --user
  - id: out_dir_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `out_dir_path`
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: out_folder_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `out_folder_path`
    inputBinding:
      position: 103
      prefix: --out-folder
  - id: output_path2
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path2`
    inputBinding:
      position: 104
      prefix: --output
  - id: output_dir_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `output_dir_path`
    inputBinding:
      position: 105
      prefix: --output-dir
  - id: output_folder_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `output_folder_path`
    inputBinding:
      position: 106
      prefix: --output-folder
  - id: output_folder_alt_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `output_folder_alt_path`
    inputBinding:
      position: 107
      prefix: --output-folder-alt
  - id: output_location_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_location_path`
    inputBinding:
      position: 108
      prefix: --output-location
  - id: output_path_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path_path`
    inputBinding:
      position: 109
      prefix: --output-path
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_folder_path)
  - id: output_folder_alt
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_folder_alt_path)
  - id: out_folder
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.out_folder_path)
  - id: output_location
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_location_path)
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_path_path)
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.out_dir_path)
  - id: output
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_path2)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - suvtk
  - download-database
label: suvtk_download-database
doc: "Download and extract the TAR archive from the fixed Zenodo DOI.\n\nTool homepage:
  https://github.com/LanderDC/suvtk"
inputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to extract the archive into (defaults to archive name)
    inputBinding:
      position: 101
      prefix: --output-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
stdout: suvtk_download-database.out

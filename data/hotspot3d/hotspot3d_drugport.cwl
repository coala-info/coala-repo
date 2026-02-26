cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hotspot3d
  - drugport
label: hotspot3d_drugport
doc: "Drugport parsing tool for HotSpot3D\n\nTool homepage: https://github.com/ding-lab/hotspot3d"
inputs:
  - id: pdb_file_dir
    type: Directory
    doc: PDB file directory
    inputBinding:
      position: 101
      prefix: --pdb-file-dir
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file of drugport parsing
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0

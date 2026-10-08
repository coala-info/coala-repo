cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hotspot3d
  - statis
label: hotspot3d_statis
doc: "Calculate p_values for pairs of mutations (preprocessing step 2b). The step reads and updates the HotSpot3D preprocessing directory in
  place.\n\nTool homepage: https://github.com/ding-lab/hotspot3d"
inputs:
  - id: prep_dir
    type: Directory
    doc: Output directory of proximity files (the preprocessing directory made by
      uppro/calpro; it is updated in place)
    inputBinding:
      position: 101
      prefix: --output-dir
      valueFrom: $(self.basename)
outputs:
  - id: updated_prep_dir
    type: Directory
    doc: Updated preprocessing directory
    outputBinding:
      glob: $(inputs.prep_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.prep_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0

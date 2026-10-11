cwlVersion: v1.2
class: CommandLineTool
baseCommand: nii2dcm
label: nii2dcm
doc: "nii2dcm - NIfTI file to DICOM conversion. Converts a NIfTI file (.nii or .nii.gz)
  into a single-frame DICOM series.\n\nTool homepage: https://github.com/tomaroberts/nii2dcm"
inputs:
  - id: input_file
    type: File
    doc: "[.nii/.nii.gz] input NIfTI file"
    inputBinding:
      position: 1
  - id: output_dir
    type: string
    doc: "[directory] output DICOM path (created before the tool runs)"
    inputBinding:
      position: 2
  - id: dicom_type
    type:
      - 'null'
      - string
    doc: "[string] type of DICOM. Available types: MR, SVR."
    inputBinding:
      position: 3
      prefix: --dicom_type
  - id: ref_dicom
    type:
      - 'null'
      - File
    doc: "[.dcm] Reference DICOM file for Attribute transfer"
    inputBinding:
      position: 3
      prefix: --ref_dicom
outputs:
  - id: output_dicom_dir
    type: Directory
    doc: Directory with the DICOM series
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.output_dir, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nii2dcm:0.1.2--pyhdfd78af_0

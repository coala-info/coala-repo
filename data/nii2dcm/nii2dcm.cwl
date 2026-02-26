cwlVersion: v1.2
class: CommandLineTool
baseCommand: nii2dcm
label: nii2dcm
doc: "Convert NIfTI files to DICOM series.\n\nTool homepage: https://github.com/tomaroberts/nii2dcm"
inputs:
  - id: input_nii
    type: File
    doc: Input NIfTI file or directory.
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: Output directory for DICOM files.
    inputBinding:
      position: 2
  - id: frame_of_reference_uid
    type:
      - 'null'
      - string
    doc: Frame of Reference UID.
    inputBinding:
      position: 103
      prefix: --frame-of-reference-uid
  - id: instance_number_start
    type:
      - 'null'
      - int
    doc: Starting instance number.
    inputBinding:
      position: 103
      prefix: --instance-number-start
  - id: manufacturer
    type:
      - 'null'
      - string
    doc: Manufacturer of the equipment.
    inputBinding:
      position: 103
      prefix: --manufacturer
  - id: manufacturer_model
    type:
      - 'null'
      - string
    doc: Manufacturer's model name.
    inputBinding:
      position: 103
      prefix: --manufacturer-model
  - id: modality
    type:
      - 'null'
      - string
    doc: Modality (e.g., CT, MR).
    inputBinding:
      position: 103
      prefix: --modality
  - id: patient_id
    type:
      - 'null'
      - string
    doc: Patient's ID.
    inputBinding:
      position: 103
      prefix: --patient-id
  - id: patient_name
    type:
      - 'null'
      - string
    doc: Patient's name.
    inputBinding:
      position: 103
      prefix: --patient-name
  - id: series_description
    type:
      - 'null'
      - string
    doc: Series description.
    inputBinding:
      position: 103
      prefix: --series-description
  - id: skip_empty_slices
    type:
      - 'null'
      - boolean
    doc: Skip empty slices.
    inputBinding:
      position: 103
      prefix: --skip-empty-slices
  - id: sop_class_uid
    type:
      - 'null'
      - string
    doc: SOP Class UID for the DICOM instances.
    inputBinding:
      position: 103
      prefix: --sop-class-uid
  - id: study_description
    type:
      - 'null'
      - string
    doc: Study description.
    inputBinding:
      position: 103
      prefix: --study-description
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nii2dcm:0.1.2--pyhdfd78af_0
stdout: nii2dcm.out

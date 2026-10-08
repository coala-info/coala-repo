cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - eido
  - validate
label: eido_validate
doc: "Validate a PEP or its components\n\nTool homepage: https://github.com/pepkit/eido"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.pep_path)
      - $(inputs.pep_files)
inputs:
  - id: pep_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files the PEP configuration names (sample table, subsample table); 
      staged beside the configuration so its relative paths resolve
  - id: pep_path
    type: File
    doc: Path to a PEP configuration file in yaml format.
    inputBinding:
      position: 1
  - id: exclude_case
    type:
      - 'null'
      - boolean
    doc: Whether to exclude the validation case from an error. Only the human 
      readable message explaining the error will be raised. Useful when 
      validating large PEPs.
    inputBinding:
      position: 102
      prefix: --exclude-case
  - id: just_config
    type:
      - 'null'
      - boolean
    doc: Whether samples should be excluded from the validation.
    inputBinding:
      position: 102
      prefix: --just-config
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Name or index of the sample to validate. Only this sample will be 
      validated.
    inputBinding:
      position: 102
      prefix: --sample-name
  - id: schema
    type: File
    doc: Path to a PEP schema file in yaml format.
    inputBinding:
      position: 102
      prefix: --schema
  - id: st_index
    type:
      - 'null'
      - string
    doc: Sample table index to use, samples are identified by 'sample_name' by 
      default.
    inputBinding:
      position: 102
      prefix: --st-index
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Validation report (eido writes "Validation successful" or the errors 
      here)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/eido:0.1.9_cv2
stdout: eido_validate.out
stderr: eido_validate.err

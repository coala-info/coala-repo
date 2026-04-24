cwlVersion: v1.2
class: CommandLineTool
baseCommand: density-fitness
label: density-fitness
doc: "Calculates the density fitness score for a given mtz file and coordinates file.\n\
  \nTool homepage: https://github.com/PDB-REDO/density-fitness"
inputs:
  - id: mtzfile
    type: File
    doc: mtz file
    inputBinding:
      position: 1
  - id: coordinatesfile
    type: File
    doc: coordinates file
    inputBinding:
      position: 2
  - id: aniso_scaling
    type:
      - 'null'
      - string
    doc: Anisotropic scaling (none/observed/calculated)
    inputBinding:
      position: 103
      prefix: --aniso-scaling
  - id: ccd_dict
    type:
      - 'null'
      - type: array
        items: File
    doc: Dictionary file containing information in CCD format for residues in 
      this specific target, can be specified multiple times.
    inputBinding:
      position: 103
      prefix: --ccd-dict
  - id: compounds
    type:
      - 'null'
      - File
    doc: Location of the components.cif file from CCD
    inputBinding:
      position: 103
      prefix: --compounds
  - id: dfmap
    type:
      - 'null'
      - File
    doc: difference map file -- 2(mFo - DFc)
    inputBinding:
      position: 103
      prefix: --dfmap
  - id: electron_scattering
    type:
      - 'null'
      - boolean
    doc: Use electron scattering factors
    inputBinding:
      position: 103
      prefix: --electron-scattering
  - id: fomap
    type:
      - 'null'
      - File
    doc: Fo map file -- 2mFo - DFc
    inputBinding:
      position: 103
      prefix: --fomap
  - id: hklin
    type:
      - 'null'
      - File
    doc: mtz file
    inputBinding:
      position: 103
      prefix: --hklin
  - id: mmcif_dictionary
    type:
      - 'null'
      - File
    doc: Path to the mmcif_pdbx.dic file to use instead of default
    inputBinding:
      position: 103
      prefix: --mmcif-dictionary
  - id: no_bulk
    type:
      - 'null'
      - boolean
    doc: No bulk correction
    inputBinding:
      position: 103
      prefix: --no-bulk
  - id: no_edia
    type:
      - 'null'
      - boolean
    doc: Skip EDIA score calculation
    inputBinding:
      position: 103
      prefix: --no-edia
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format, can be either 'edstats' or 'json'
    inputBinding:
      position: 103
      prefix: --output-format
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print verbose output at all
    inputBinding:
      position: 103
      prefix: --quiet
  - id: recalc
    type:
      - 'null'
      - boolean
    doc: Recalculate Fc from FP/SIGFP in mtz file
    inputBinding:
      position: 103
      prefix: --recalc
  - id: reshi
    type:
      - 'null'
      - float
    doc: High resolution
    inputBinding:
      position: 103
      prefix: --reshi
  - id: reslo
    type:
      - 'null'
      - float
    doc: Low resolution
    inputBinding:
      position: 103
      prefix: --reslo
  - id: restraint_dict
    type:
      - 'null'
      - type: array
        items: File
    doc: File containing restraints for residues in this specific target, can be
      specified multiple times.
    inputBinding:
      position: 103
      prefix: --restraint-dict
  - id: sampling_rate
    type:
      - 'null'
      - float
    doc: Sampling rate
    inputBinding:
      position: 103
      prefix: --sampling-rate
  - id: use_auth_ids
    type:
      - 'null'
      - boolean
    doc: Write auth_ identities instead of label_
    inputBinding:
      position: 103
      prefix: --use-auth-ids
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 103
      prefix: --verbose
  - id: xyzin
    type:
      - 'null'
      - File
    doc: coordinates file
    inputBinding:
      position: 103
      prefix: --xyzin
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to this file instead of stdout
    outputBinding:
      glob: '*.out'
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to this file instead of stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/density-fitness:1.2.0--h077b44d_0

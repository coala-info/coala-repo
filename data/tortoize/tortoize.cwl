cwlVersion: v1.2
class: CommandLineTool
baseCommand: tortoize
label: tortoize
doc: "Tortoize validates protein structure models by checking the Ramachandran plot
  and side-chain rotamer distributions. Quality Z-scores are given at the residue
  level and at the model level (ramachandran-z and torsions-z).\n\nTool homepage:
  https://github.com/PDB-REDO/tortoize"
inputs:
  - id: input
    type: File
    doc: Input protein structure model file
    inputBinding:
      position: 1
  - id: dict
    type:
      - 'null'
      - type: array
        items: File
    doc: Dictionary file containing restraints for residues in this specific 
      target, can be specified multiple times.
    inputBinding:
      position: 102
      prefix: --dict
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file for validation results
    outputBinding:
      glob: '*.out'
  - id: log
    type:
      - 'null'
      - File
    doc: Write log to this file
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tortoize:2.0.16--haf24da9_0

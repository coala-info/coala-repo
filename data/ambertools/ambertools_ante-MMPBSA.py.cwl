cwlVersion: v1.2
class: CommandLineTool
baseCommand: ante-MMPBSA.py
label: ambertools_ante-MMPBSA.py
doc: "A tool to prepare topology files for MMPBSA.py by stripping solvent, ligand,
  or receptor atoms from a complex topology.\n\nTool homepage: https://github.com/quantaosun/Ambertools-OpenMM-MD"
inputs:
  - id: ligand_mask
    type:
      - 'null'
      - string
    doc: Amber mask of atoms needed to be stripped from COMPLEX to create 
      LIGAND. Cannot specify with -m/--receptor-mask
    inputBinding:
      position: 101
      prefix: --ligand-mask
  - id: prmtop
    type:
      - 'null'
      - File
    doc: Input "dry" complex topology or solvated complex topology
    inputBinding:
      position: 101
      prefix: --prmtop
  - id: radii
    type:
      - 'null'
      - string
    doc: PB/GB Radius set to set in the generated topology files. Options are 
      bondi, mbondi2, mbondi3, amber6, and mbondi
    inputBinding:
      position: 101
      prefix: --radii
  - id: receptor_mask
    type:
      - 'null'
      - string
    doc: Amber mask of atoms needed to be stripped from COMPLEX to create 
      RECEPTOR. Cannot specify with -n/--ligand-mask
    inputBinding:
      position: 101
      prefix: --receptor-mask
  - id: strip_mask
    type:
      - 'null'
      - string
    doc: Amber mask of atoms needed to be stripped from PRMTOP to make the 
      COMPLEX topology file
    inputBinding:
      position: 101
      prefix: --strip-mask
  - id: complex_prmtop_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `complex_prmtop_path`
    inputBinding:
      position: 102
      prefix: --complex-prmtop
  - id: ligand_prmtop_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `ligand_prmtop_path`
    inputBinding:
      position: 103
      prefix: --ligand-prmtop
  - id: receptor_prmtop_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `receptor_prmtop_path`
    inputBinding:
      position: 104
      prefix: --receptor-prmtop
outputs:
  - id: complex_prmtop
    type:
      - 'null'
      - File
    doc: Complex topology file created by stripping PRMTOP of solvent
    outputBinding:
      glob: $(inputs.complex_prmtop_path)
  - id: receptor_prmtop
    type:
      - 'null'
      - File
    doc: Receptor topology file created by stripping COMPLEX of ligand
    outputBinding:
      glob: $(inputs.receptor_prmtop_path)
  - id: ligand_prmtop
    type:
      - 'null'
      - File
    doc: Ligand topology file created by stripping COMPLEX of receptor
    outputBinding:
      glob: $(inputs.ligand_prmtop_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ambertools:21.10

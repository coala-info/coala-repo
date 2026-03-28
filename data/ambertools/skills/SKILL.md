---
name: ambertools
description: AmberTools is a collection of programs for preparing, parameterizing, and analyzing biomolecular simulations. Use when user asks to parameterize small molecules with GAFF, set up protein-ligand complexes using TLEAP, or perform binding free energy calculations like MMGBSA and MMPBSA.
homepage: https://github.com/quantaosun/Ambertools-OpenMM-MD
---

# ambertools

## Overview
AmberTools is a collection of programs for the preparation and analysis of biomolecular simulations. This skill enables the setup of protein-ligand complexes, parameterization of small molecules using the General Amber Force Field (GAFF), and post-simulation analysis including binding energy calculations. It is particularly useful for bridging the gap between raw structural data (PDB) and production-ready simulation inputs for engines like OpenMM or Amber.

## System Preparation and Parameterization

### Protein Preparation
1. **Protonation**: Use the H++ web server or the `reduce` tool to add hydrogens.
2. **Cleaning**: Remove redundant chains or non-standard residues that may interfere with parameterization.
3. **Missing Atoms**: Use `pdbfixer` or AlphaFold2 predicted structures if experimental structures have significant gaps.

### Ligand Parameterization (GAFF)
Use `antechamber` to generate parameters for small molecules.
```bash
# Generate mol2 file with BCC charges
antechamber -i ligand.pdb -fi pdb -o ligand.mol2 -fo mol2 -c bcc -s 2

# Generate additional parameters (frcmod)
parmchk2 -i ligand.mol2 -f mol2 -o ligand.frcmod
```

### Complex Building (TLEAP)
Create a `leap.in` script to combine the protein and ligand:
```bash
# Example TLEAP commands
source leaprc.protein.ff14SB
source leaprc.gaff
loadamberparams ligand.frcmod
PROT = loadpdb protein_cleaned.pdb
LIG = loadmol2 ligand.mol2
COMPLEX = combine {PROT LIG}
saveamberparm COMPLEX complex.prmtop complex.inpcrd
quit
```

## Binding Free Energy Analysis (MMGBSA/PBSA)

### 1. Topology Preparation
Generate the required topology files for the complex, receptor, and ligand using `ante-MMPBSA.py`:
```bash
ante-MMPBSA.py -p complex.prmtop -c com.prmtop -r rec.prmtop -l ligand.prmtop -s :WAT:Na+:Cl-:Mg+:K+ -n :LIG --radii mbondi2
```

### 2. Energy Calculation
Create an input file `mmpbsa.in`:
```text
&general
  endframe=1000, interval=10, strip_mask=:WAT:Na+:Cl-:Mg+:K+,
/
&gb
  igb=2, saltcon=0.15,
/
&decomp
  idecomp=1,
/
```

Run the calculation:
```bash
MMPBSA.py -O -i mmpbsa.in -o FINAL_RESULTS_MMPBSA.dat -sp complex.prmtop -cp com.prmtop -rp rec.prmtop -lp ligand.prmtop -y trajectory.dcd
```

## Expert Tips and Troubleshooting

- **Hydrogen Addition Errors**: The `reduce` tool and Open Babel may occasionally add an incorrect number of hydrogens to aromatic rings or carbonyl groups, leading to "odd electron" errors. Verify ligand structures in PyMOL using `h_add` if parameterization fails.
- **Missing Residues**: If PDBfixer cannot resolve structural gaps, prioritize using AlphaFold2 models as starting points to ensure topological continuity.
- **Charge Neutralization**: Always ensure the system is neutralized with counter-ions (Na+ or Cl-) during the TLEAP stage to avoid artifacts in electrostatic calculations.
- **Analysis**: For high-quality visualization and analysis of trajectories, use the `Bio3D` package in R or specific PyMOL scripts for protein-ligand interactions.



## Subcommands

| Command | Description |
|---------|-------------|
| MMPBSA.py | MMPBSA.py calculates binding free energies using end-state free energy methods like MM-PBSA and MM-GBSA. |
| ante-MMPBSA.py | A tool to prepare topology files for MMPBSA.py by stripping solvent, ligand, or receptor atoms from a complex topology. |
| reduce | Add or remove hydrogens to/from a PDB file, with optimization of hydrogen positions and flips of NQH groups. |

## Reference documentation
- [Ambertools-OpenMM-MD Overview](./references/github_com_quantaosun_Ambertools-OpenMM-MD_blob_main_README.md)
- [MMGBSA/PBSA Workflow](./references/github_com_quantaosun_Ambertools-OpenMM-MD_blob_main_Ambertools-OpenMM-MD_GBSA.ipynb.md)
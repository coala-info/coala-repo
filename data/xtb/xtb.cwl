cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtb
label: xtb
doc: "xtb is a fast semi-empirical quantum chemistry method for the calculation of
  molecular geometries, single-point energies, vibrational frequencies and molecular
  dynamics.\n\nTool homepage: https://github.com/grimme-lab/xtb"
inputs:
  - id: geometry
    type: File
    doc: may be provided as valid TM coordinate file (*coord in Bohr), in xmol 
      format (*.xyz in Ångström), sdf or mol file format, PDB format genFormat 
      input or Vasp's POSCAR format.
    inputBinding:
      position: 1
  - id: acc
    type:
      - 'null'
      - float
    doc: accuracy for SCC calculation, lower is better
    inputBinding:
      position: 102
      prefix: --acc
  - id: alpb
    type:
      - 'null'
      - string
    doc: analytical linearized Poisson-Boltzmann (ALPB) model, available 
      solvents are acetone, acetonitrile, aniline, benzaldehyde, benzene, 
      ch2cl2, chcl3, cs2, dioxane, dmf, dmso, ether, ethylacetate, furane, 
      hexandecane, hexane, methanol, nitromethane, octanol, woctanol, phenol, 
      toluene, thf, water. The solvent input is not case-sensitive. The Gsolv 
      reference state can be chosen as reference or bar1M (default).
    inputBinding:
      position: 102
      prefix: --alpb
  - id: bhess
    type:
      - 'null'
      - string
    doc: perform a biased numerical hessian calculation on an ancopt(3) 
      optimized geometry
    inputBinding:
      position: 102
      prefix: --bhess
  - id: ceasefiles
    type:
      - 'null'
      - boolean
    doc: reduce the amount of output and files written
    inputBinding:
      position: 102
      prefix: --ceasefiles
  - id: chrg
    type:
      - 'null'
      - int
    doc: specify molecular charge as INT, overrides .CHRG file and xcontrol 
      option
    inputBinding:
      position: 102
      prefix: --chrg
  - id: citation
    type:
      - 'null'
      - boolean
    doc: print citation and terminate
    inputBinding:
      position: 102
      prefix: --citation
  - id: cma
    type:
      - 'null'
      - boolean
    doc: shifts molecule to center of mass and transforms cartesian coordinates 
      into the coordinate system of the principle axis (not affected by 
      ‘isotopes’-file).
    inputBinding:
      position: 102
      prefix: --cma
  - id: copy
    type:
      - 'null'
      - boolean
    doc: copies the xcontrol file at startup
    inputBinding:
      position: 102
      prefix: --copy
  - id: define
    type:
      - 'null'
      - boolean
    doc: performs automatic check of input and terminate
    inputBinding:
      position: 102
      prefix: --define
  - id: dipole
    type:
      - 'null'
      - boolean
    doc: requests dipole printout
    inputBinding:
      position: 102
      prefix: --dipole
  - id: esp
    type:
      - 'null'
      - boolean
    doc: calculate electrostatic potential on VdW-grid
    inputBinding:
      position: 102
      prefix: --esp
  - id: etemp
    type:
      - 'null'
      - float
    doc: electronic temperature
    inputBinding:
      position: 102
      prefix: --etemp
  - id: fod
    type:
      - 'null'
      - boolean
    doc: requests FOD calculation
    inputBinding:
      position: 102
      prefix: --fod
  - id: gbsa
    type:
      - 'null'
      - string
    doc: generalized born (GB) model with solvent accessable surface (SASA) 
      model, available solvents are acetone, acetonitrile, benzene (only 
      GFN1-xTB), CH2Cl2, CHCl3, CS2, DMF (only GFN2-xTB), DMSO, ether, H2O, 
      methanol, n-hexane (only GFN2-xTB), THF and toluene. The solvent input is 
      not case-sensitive. The Gsolv reference state can be chosen as reference 
      or bar1M (default).
    inputBinding:
      position: 102
      prefix: --gbsa
  - id: gff
    type:
      - 'null'
      - boolean
    doc: specify parametrisation of GFN-FF
    inputBinding:
      position: 102
      prefix: --gff
  - id: gfn
    type:
      - 'null'
      - int
    doc: specify parametrisation of GFN-xTB
    inputBinding:
      position: 102
      prefix: --gfn
  - id: gfnff
    type:
      - 'null'
      - boolean
    doc: specify parametrisation of GFN-FF
    inputBinding:
      position: 102
      prefix: --gfnff
  - id: grad
    type:
      - 'null'
      - boolean
    doc: performs a gradient calculation
    inputBinding:
      position: 102
      prefix: --grad
  - id: hess
    type:
      - 'null'
      - boolean
    doc: perform a numerical hessian calculation on input geometry
    inputBinding:
      position: 102
      prefix: --hess
  - id: input
    type:
      - 'null'
      - File
    doc: use FILE as input source for xcontrol(7) instructions
    inputBinding:
      position: 102
      prefix: --input
  - id: json
    type:
      - 'null'
      - boolean
    doc: write xtbout.json file
    inputBinding:
      position: 102
      prefix: --json
  - id: license
    type:
      - 'null'
      - boolean
    doc: print license and terminate
    inputBinding:
      position: 102
      prefix: --license
  - id: lmo
    type:
      - 'null'
      - boolean
    doc: requests localization of orbitals
    inputBinding:
      position: 102
      prefix: --lmo
  - id: md
    type:
      - 'null'
      - boolean
    doc: molecular dynamics simulation on start geometry
    inputBinding:
      position: 102
      prefix: --md
  - id: metadyn
    type:
      - 'null'
      - int
    doc: meta dynamics simulation on start geometry, saving int snapshots of the
      trajectory to bias the simulation
    inputBinding:
      position: 102
      prefix: --metadyn
  - id: metaopt
    type:
      - 'null'
      - string
    doc: call ancopt(3) to perform a geometry optimization, then try to find 
      other minimas by meta dynamics
    inputBinding:
      position: 102
      prefix: --metaopt
  - id: modef
    type:
      - 'null'
      - int
    doc: modefollowing algorithm. INT specifies the mode that should be used for
      the modefollowing.
    inputBinding:
      position: 102
      prefix: --modef
  - id: molden
    type:
      - 'null'
      - boolean
    doc: requests printout of molden file
    inputBinding:
      position: 102
      prefix: --molden
  - id: namespace
    type:
      - 'null'
      - string
    doc: give this xtb(1) run a namespace. All files, even temporary ones, will 
      be named according to STRING (might not work everywhere).
    inputBinding:
      position: 102
      prefix: --namespace
  - id: no_copy
    type:
      - 'null'
      - boolean
    doc: does not copy the xcontrol file at startup
    inputBinding:
      position: 102
      prefix: --no-copy
  - id: no_restart
    type:
      - 'null'
      - boolean
    doc: does not restart calculation from xtbrestart
    inputBinding:
      position: 102
      prefix: --no-restart
  - id: ohess
    type:
      - 'null'
      - string
    doc: perform a numerical hessian calculation on an ancopt(3) optimized 
      geometry
    inputBinding:
      position: 102
      prefix: --ohess
  - id: omd
    type:
      - 'null'
      - boolean
    doc: molecular dynamics simulation on ancopt(3) optimized geometry, a loose 
      optimization level will be chosen
    inputBinding:
      position: 102
      prefix: --omd
  - id: oniom
    type:
      - 'null'
      - string
    doc: use subtractive embedding via ONIOM method. 'METHOD' is given as 
      'inner:outer' where 'inner' can be 'orca', 'turbomole', 'gfn2', 'gfn1', or
      'gfnff' and 'outer' can be 'gfn2', 'gfn1', or 'gfnff'. The inner region is
      given as a comma separated indices directly in the commandline or in a 
      file with each index on a separate line.
    inputBinding:
      position: 102
      prefix: --oniom
  - id: opt
    type:
      - 'null'
      - string
    doc: call ancopt(3) to perform a geometry optimization, levels from crude, 
      sloppy, loose, normal (default), tight, verytight to extreme can be chosen
    inputBinding:
      position: 102
      prefix: --opt
  - id: parallel
    type:
      - 'null'
      - int
    doc: number of parallel processes
    inputBinding:
      position: 102
      prefix: --parallel
  - id: path
    type:
      - 'null'
      - File
    doc: use meta dynamics to calculate a path from the input geometry to the 
      given product structure
    inputBinding:
      position: 102
      prefix: --path
  - id: pop
    type:
      - 'null'
      - boolean
    doc: requests printout of Mulliken population analysis
    inputBinding:
      position: 102
      prefix: --pop
  - id: restart
    type:
      - 'null'
      - boolean
    doc: restarts calculation from xtbrestart
    inputBinding:
      position: 102
      prefix: --restart
  - id: scc
    type:
      - 'null'
      - boolean
    doc: performs a single point calculation
    inputBinding:
      position: 102
      prefix: --scc
  - id: silent
    type:
      - 'null'
      - boolean
    doc: clutter the screen less (not supported in every unit)
    inputBinding:
      position: 102
      prefix: --silent
  - id: sp
    type:
      - 'null'
      - boolean
    doc: performs a single point calculation
    inputBinding:
      position: 102
      prefix: --sp
  - id: spinpol
    type:
      - 'null'
      - boolean
    doc: enables spin-polarization for xTB methods (tblite required)
    inputBinding:
      position: 102
      prefix: --spinpol
  - id: stm
    type:
      - 'null'
      - boolean
    doc: calculate STM image
    inputBinding:
      position: 102
      prefix: --stm
  - id: strict
    type:
      - 'null'
      - boolean
    doc: turns all warnings into hard errors
    inputBinding:
      position: 102
      prefix: --strict
  - id: tblite
    type:
      - 'null'
      - boolean
    doc: use tblite library as implementation for xTB
    inputBinding:
      position: 102
      prefix: --tblite
  - id: uhf
    type:
      - 'null'
      - int
    doc: specify number of unpaired electrons as INT, overrides .UHF file and 
      xcontrol option
    inputBinding:
      position: 102
      prefix: --uhf
  - id: vea
    type:
      - 'null'
      - boolean
    doc: performs calculation of electron affinity. This needs the 
      param_ipea-xtb.txt parameters and a GFN1 Hamiltonian.
    inputBinding:
      position: 102
      prefix: --vea
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be more verbose (not supported in every unit)
    inputBinding:
      position: 102
      prefix: --verbose
  - id: vfukui
    type:
      - 'null'
      - boolean
    doc: performs calculation of Fukui indices.
    inputBinding:
      position: 102
      prefix: --vfukui
  - id: vip
    type:
      - 'null'
      - boolean
    doc: performs calculation of ionisation potential. This needs the 
      param_ipea-xtb.txt parameters and a GFN1 Hamiltonian.
    inputBinding:
      position: 102
      prefix: --vip
  - id: vipea
    type:
      - 'null'
      - boolean
    doc: performs calculation of electron affinity and ionisation potential. 
      This needs the param_ipea-xtb.txt parameters and a GFN1 Hamiltonian.
    inputBinding:
      position: 102
      prefix: --vipea
  - id: vomega
    type:
      - 'null'
      - boolean
    doc: performs calculation of electrophilicity index. This needs the 
      param_ipea-xtb.txt parameters and a GFN1 Hamiltonian.
    inputBinding:
      position: 102
      prefix: --vomega
  - id: vparam
    type:
      - 'null'
      - File
    doc: Parameter file for vTB calculation
    inputBinding:
      position: 102
      prefix: --vparam
  - id: wbo
    type:
      - 'null'
      - boolean
    doc: requests Wiberg bond order printout
    inputBinding:
      position: 102
      prefix: --wbo
  - id: xparam
    type:
      - 'null'
      - File
    doc: Parameter file for xTB calculation (not used)
    inputBinding:
      position: 102
      prefix: --xparam
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtb:6.6.1
stdout: xtb.out

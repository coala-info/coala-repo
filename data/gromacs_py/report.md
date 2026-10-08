# gromacs_py CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gromacs_py_create_peptide | PASS |  |
| gromacs_py_create_top | Failed | image problem: fails on the package's own test protein 1y0m.pdb; the pdb2pqr step names the N-terminal residue TER and gmx pdb2gmx rejects the chain as mixed type |
| gromacs_py_equi_3_step | PASS |  |
| gromacs_py_extend | Failed | tool bug: extend.py calls GmxSys.extend_equi_prod, which does not exist in gromacs_py 2.0.3 (AttributeError) |
| gromacs_py_insert_mol_no_vmd | PASS |  |
| gromacs_py_minimize_pdb | PASS |  |
| gromacs_py_minimize_pdb_and_cyclic | PASS |  |
| gromacs_py_production | PASS |  |
| gromacs_py_solvate_ions | PASS |  |

## gromacs_py_create_top

### Tool Description
Create the topology file from a structure PDB file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/samuelmurail/gromacs_py
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_py/overview
- **Validation**: PASS

### Original Help Text
```text
usage: create_top.py [-h] -f F -o O [-vsite]

Create the topologie file from a structure pdb file

options:
  -h, --help  show this help message and exit
  -f F        Input PDB file
  -o O        Output directory
  -vsite      Use virtual site for hydrogens
```

## gromacs_py_minimize_pdb

### Tool Description
Minimize a PDB structure in 2 steps, the first step without bond constraints and the second step with.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/samuelmurail/gromacs_py
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_py/overview
- **Validation**: PASS

### Original Help Text
```text
usage: minimize_pdb.py [-h] -f F -p P -o O -n NAME [-m_steps MIN_STEPS]
                       [-box BOX] [-nt NT] [-ntmpi NTMPI] [-gpu_id GPUID]

Minimize a pdb structure in 2 steps,the first step without bonds constraints
and the second step with

options:
  -h, --help          show this help message and exit
  -f F                Input PDB file
  -p P                Topologie in gromacs format .top
  -o O                Output Directory
  -n NAME             Output file name
  -m_steps MIN_STEPS  Minimisation nsteps, default=1000
  -box BOX            Create a box, default=False
  -nt NT              Total number of threads to start, default=0
  -ntmpi NTMPI        Number of thread-MPI threads to start, default=0
  -gpu_id GPUID       List of GPU device id-s to use, default=""
```

## gromacs_py_solvate_ions

### Tool Description
Solvate a gromacs system with water and add ions to neutralize the system charge and to reach an ionic concentration.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/samuelmurail/gromacs_py
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_py/overview
- **Validation**: PASS

### Original Help Text
```text
usage: solvate_ions.py [-h] -f F -p P -o O -n NAME [-d DIST] [-C CONC]

Solvate a gromacs system with water and add ions to neutralize the system
charge and to reach an ionic concentration

options:
  -h, --help  show this help message and exit
  -f F        Input PDB file
  -p P        Topologie in gromacs format .top
  -o O        Output Directory
  -n NAME     Output file name
  -d DIST     Distance between the solute and the box
  -C CONC     Ion concentration (mM), default = 0.15 (150mM)
```

## gromacs_py_equi_3_step

### Tool Description
Equilibrate a system in 3 steps: heavy atom, alpha carbon and weak alpha carbon position restraints.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/samuelmurail/gromacs_py
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_py/overview
- **Validation**: PASS

### Original Help Text
```text
usage: equi_3_step.py [-h] -f F -p P -o O -n NAME [-HA_time HA_TIME]
                      [-CA_time CA_TIME] [-CA_LOW_time CA_LOW_TIME]
                      [-dt_HA DT_HA] [-dt DT] [-maxwarn MAXWARN] [-nt NT]
                      [-ntmpi NTMPI] [-gpu_id GPUID]

Equilibrate in 3 steps a system (coor+top), (i) first equilibration with heavy
atoms position restraints, (ii) second equilibration with alpha carbon
position restraints and (iii) finaly equilibration with weak alpha carbon
position restraints

options:
  -h, --help            show this help message and exit
  -f F                  Input PDB file
  -p P                  Topologie in gromacs format .top
  -o O                  Output Directory
  -n NAME               Output file name
  -HA_time HA_TIME      Equilibration with HA constraint time(ns), default =
                        0.25ns
  -CA_time CA_TIME      Equilibration with HA constraint time(ns), default =
                        1ns
  -CA_LOW_time CA_LOW_TIME
                        Equilibration with HA constraint time(ns), default =
                        5ns
  -dt_HA DT_HA          Equi HA dt, default=0.002 (2 fs)
  -dt DT                Equi CA, CA_LOW, dt, default=0.002 (2 fs)
  -maxwarn MAXWARN      Total number of warnings allowed for the
                        equilibration, default=0
  -nt NT                Total number of threads to start, default=0
  -ntmpi NTMPI          Number of thread-MPI threads to start, default=0
  -gpu_id GPUID         List of GPU device id-s to use, default=""
```

## gromacs_py_production

### Tool Description
Run a production simulation.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/samuelmurail/gromacs_py
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_py/overview
- **Validation**: PASS

### Original Help Text
```text
usage: production.py [-h] -f F -p P -o O -n NAME [-time TIME] [-dt DT]
                     [-maxwarn MAXWARN] [-nt NT] [-ntmpi NTMPI]
                     [-gpu_id GPUID]

Simulation production

options:
  -h, --help        show this help message and exit
  -f F              Input PDB file
  -p P              Topologie in gromacs format .top
  -o O              Output Directory
  -n NAME           Output file name
  -time TIME        Production time, default=10
  -dt DT            Equilibration dt, default=0.002 (2 fs)
  -maxwarn MAXWARN  Total number of warnings allowed for the equilibration,
                    default=0
  -nt NT            Total number of threads to start, default=0
  -ntmpi NTMPI      Number of thread-MPI threads to start, default=0
  -gpu_id GPUID     List of GPU device id-s to use, default=""
```

## gromacs_py_create_peptide

### Tool Description
Create a linear peptide structure, do a minimisation and a vacuum equilibration.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/samuelmurail/gromacs_py
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_py/overview
- **Validation**: PASS

### Original Help Text
```text
usage: create_peptide.py [-h] -seq SEQ -o O [-m_steps MIN_STEPS] [-time TIME]

Create a linear peptide structure, do a minimisation and a vacuum
equilibration

options:
  -h, --help          show this help message and exit
  -seq SEQ            Peptide sequence
  -o O                Output Directory
  -m_steps MIN_STEPS  Minimisation nsteps, default=1000
  -time TIME          Vacuum equilibration time(ns), default = 1ns
```

## gromacs_py_extend

### Tool Description
Extend a production or equilibration simulation.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/samuelmurail/gromacs_py
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_py/overview
- **Validation**: PASS

### Original Help Text
```text
usage: extend.py [-h] -s TPR [-time TIME] [-dt DT] [-nt NT] [-ntmpi NTMPI]
                 [-gpu_id GPUID]

Extend Simulation production/equilibration

options:
  -h, --help     show this help message and exit
  -s TPR         Input tpr
  -time TIME     Extend simulation time, default=10
  -dt DT         integration time step, default=0.005
  -nt NT         Total number of threads to start, default=0
  -ntmpi NTMPI   Number of thread-MPI threads to start, default=0
  -gpu_id GPUID  List of GPU device id-s to use, default=""
```

## gromacs_py_minimize_pdb_and_cyclic

### Tool Description
Minimize a (cyclic) peptide structure in 2 steps.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/samuelmurail/gromacs_py
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_py/overview
- **Validation**: PASS

### Original Help Text
```text
usage: minimize_pdb_and_cyclic.py [-h] -f F -n NAME [-dir OUT_DIR]
                                  [-m_steps MIN_STEPS] [-keep] [-cyclic]
                                  [-nt NT] [-ntmpi NTMPI] [-gpu_id GPUID]
                                  [-keep_segid] [-add_ter]

Minimize a cyclic peptide structure in 2 steps, the first step without bonds
constraints and the second step with bonds constraints

options:
  -h, --help          show this help message and exit
  -f F                Input PDB file
  -n NAME             Output file name
  -dir OUT_DIR        Output directory for intermediate files
  -m_steps MIN_STEPS  Minimisation nsteps, default=1000
  -keep               Flag to keep temporary files (without flag output
                      directory will be delete
  -cyclic             Flag to indicate if the peptide/protein is cyclic
  -nt NT              Total number of threads to start, default=0
  -ntmpi NTMPI        Number of thread-MPI threads to start, default=0
  -gpu_id GPUID       List of GPU device id-s to use, default=""
  -keep_segid         Flag to indicate if the original chain/segid should be
                      kept
  -add_ter            Flag to indicate if TER line should be included between
                      chains and if residues in the input pdb file have non-
                      consecutive residues
```

## gromacs_py_insert_mol_no_vmd

### Tool Description
Insert molecules into a system without using VMD.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/samuelmurail/gromacs_py
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_py/overview
- **Validation**: PASS

### Original Help Text
```text
usage: insert_mol_no_vmd.py [-h] [-fsys F_SYS] [-psys P_SYS] [-fmol F_MOL]
                            [-pmol P_MOL] [-nmol NUM_MOL] [-o O] [-n NAME]

Minimize a pdb structure

options:
  -h, --help     show this help message and exit
  -fsys F_SYS    Input PDB file of the system
  -psys P_SYS    Topologie in gromacs format .top of the system
  -fmol F_MOL    Input PDB file of the molecule to insert
  -pmol P_MOL    Topologie in gromacs format .top of the molecule to insert
  -nmol NUM_MOL  Number of molecule to insert
  -o O           Output Directory
  -n NAME        Output file name
```


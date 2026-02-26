# gromacs_mddb CWL Generation Report

## gromacs_mddb_gmx

### Tool Description
GROMACS command-line tool

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs:2022
- **Homepage**: https://www.gromacs.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_mddb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gromacs_mddb/overview
- **Total Downloads**: 994
- **Last updated**: 2026-01-23
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
SYNOPSIS

gmx [-[no]h] [-[no]quiet] [-[no]version] [-[no]copyright] [-nice <int>]
    [-[no]backup]

OPTIONS

Other options:

 -[no]h                     (no)
           Print help and quit
 -[no]quiet                 (no)
           Do not print common startup info or quotes
 -[no]version               (no)
           Print extended version information and quit
 -[no]copyright             (no)
           Print copyright information on startup
 -nice   <int>              (19)
           Set the nicelevel (default depends on command)
 -[no]backup                (yes)
           Write backups if output files exist

Additional help is available on the following topics:
    commands    List of available commands
    selections  Selection syntax and usage
To access the help, use 'gmx help <topic>'.
For help on a command, use 'gmx help <command>'.
```


## gromacs_mddb_gmx dump

### Tool Description
Reads a run input file (.tpr), a trajectory (.trr/.xtc/tng), an energy file (.edr), a checkpoint file (.cpt) or topology file (.top) and prints that to standard output in a readable format. This program is essential for checking your run input file in case of problems.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs:2022
- **Homepage**: https://www.gromacs.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_mddb/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS

gmx dump [-s <.tpr>] [-f <.xtc/.trr/...>] [-e <.edr>] [-cp <.cpt>]
         [-p <.top>] [-mtx <.mtx>] [-om <.mdp>] [-[no]nr] [-[no]param]
         [-[no]sys] [-[no]orgir]

DESCRIPTION

gmx dump reads a run input file (.tpr), a trajectory (.trr/.xtc/tng), an
energy file (.edr), a checkpoint file (.cpt) or topology file (.top) and
prints that to standard output in a readable format. This program is essential
for checking your run input file in case of problems.

OPTIONS

Options to specify input files:

 -s      <.tpr>                              (Opt.)
           Run input file to dump
 -f      <.xtc/.trr/...>                     (Opt.)
           Trajectory file to dump: xtc trr cpt gro g96 pdb tng
 -e      <.edr>                              (Opt.)
           Energy file to dump
 -cp     <.cpt>                              (Opt.)
           Checkpoint file to dump
 -p      <.top>                              (Opt.)
           Topology file to dump
 -mtx    <.mtx>                              (Opt.)
           Hessian matrix to dump

Options to specify output files:

 -om     <.mdp>                              (Opt.)
           grompp input file from run input file

Other options:

 -[no]nr                    (yes)
           Show index numbers in output (leaving them out makes comparison
           easier, but creates a useless topology)
 -[no]param                 (no)
           Show parameters for each bonded interaction (for comparing dumps,
           it is useful to combine this with -nonr)
 -[no]sys                   (no)
           List the atoms and bonded interactions for the whole system instead
           of for each molecule type
 -[no]orgir                 (no)
           Show input parameters from tpr as they were written by the version
           that produced the file, instead of how the current version reads
           them

KNOWN ISSUES

* The .mdp file produced by -om can not be read by grompp.
```


## gromacs_mddb_gmx grompp

### Tool Description
reads a molecular topology file, checks the validity of the file, expands the topology from a molecular description to an atomic description. The topology file contains information about molecule types and the number of molecules, the preprocessor copies each molecule as needed. There is no limitation on the number of molecule types. Bonds and bond-angles can be converted into constraints, separately for hydrogens and heavy atoms. Then a coordinate file is read and velocities can be generated from a Maxwellian distribution if requested. gmx grompp also reads parameters for gmx mdrun (eg. number of MD steps, time step, cut-off). Eventually a binary file is produced that can serve as the sole input file for the MD program.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs:2022
- **Homepage**: https://www.gromacs.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_mddb/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS

gmx grompp [-f [<.mdp>]] [-c [<.gro/.g96/...>]] [-r [<.gro/.g96/...>]]
           [-rb [<.gro/.g96/...>]] [-n [<.ndx>]] [-p [<.top>]]
           [-t [<.trr/.cpt/...>]] [-e [<.edr>]] [-qmi [<.inp>]]
           [-ref [<.trr/.cpt/...>]] [-po [<.mdp>]] [-pp [<.top>]]
           [-o [<.tpr>]] [-imd [<.gro>]] [-[no]v] [-time <real>]
           [-[no]rmvsbds] [-maxwarn <int>] [-[no]zero] [-[no]renum]

DESCRIPTION

gmx grompp (the gromacs preprocessor) reads a molecular topology file, checks
the validity of the file, expands the topology from a molecular description to
an atomic description. The topology file contains information about molecule
types and the number of molecules, the preprocessor copies each molecule as
needed. There is no limitation on the number of molecule types. Bonds and
bond-angles can be converted into constraints, separately for hydrogens and
heavy atoms. Then a coordinate file is read and velocities can be generated
from a Maxwellian distribution if requested. gmx grompp also reads parameters
for gmx mdrun (eg. number of MD steps, time step, cut-off). Eventually a
binary file is produced that can serve as the sole input file for the MD
program.

gmx grompp uses the atom names from the topology file. The atom names in the
coordinate file (option -c) are only read to generate warnings when they do
not match the atom names in the topology. Note that the atom names are
irrelevant for the simulation as only the atom types are used for generating
interaction parameters.

gmx grompp uses a built-in preprocessor to resolve includes, macros, etc. The
preprocessor supports the following keywords:

    #ifdef VARIABLE
    #ifndef VARIABLE
    #else
    #endif
    #define VARIABLE
    #undef VARIABLE
    #include "filename"
    #include <filename>

The functioning of these statements in your topology may be modulated by using
the following two flags in your .mdp file:

    define = -DVARIABLE1 -DVARIABLE2
    include = -I/home/john/doe

For further information a C-programming textbook may help you out. Specifying
the -pp flag will get the pre-processed topology file written out so that you
can verify its contents.

When using position restraints, a file with restraint coordinates must be
supplied with -r (can be the same file as supplied for -c). For free energy
calculations, separate reference coordinates for the B topology can be
supplied with -rb, otherwise they will be equal to those of the A topology.

Starting coordinates can be read from trajectory with -t. The last frame with
coordinates and velocities will be read, unless the -time option is used. Only
if this information is absent will the coordinates in the -c file be used.
Note that these velocities will not be used when gen_vel = yes in your .mdp
file. An energy file can be supplied with -e to read Nose-Hoover and/or
Parrinello-Rahman coupling variables.

gmx grompp can be used to restart simulations (preserving continuity) by
supplying just a checkpoint file with -t. However, for simply changing the
number of run steps to extend a run, using gmx convert-tpr is more convenient
than gmx grompp. You then supply the old checkpoint file directly to gmx mdrun
with -cpi. If you wish to change the ensemble or things like output frequency,
then supplying the checkpoint file to gmx grompp with -t along with a new .mdp
file with -f is the recommended procedure. Actually preserving the ensemble
(if possible) still requires passing the checkpoint file to gmx mdrun -cpi.

By default, all bonded interactions which have constant energy due to virtual
site constructions will be removed. If this constant energy is not zero, this
will result in a shift in the total energy. All bonded interactions can be
kept by turning off -rmvsbds. Additionally, all constraints for distances
which will be constant anyway because of virtual site constructions will be
removed. If any constraints remain which involve virtual sites, a fatal error
will result.

To verify your run input file, please take note of all warnings on the screen,
and correct where necessary. Do also look at the contents of the mdout.mdp
file; this contains comment lines, as well as the input that gmx grompp has
read. If in doubt, you can start gmx grompp with the -debug option which will
give you more information in a file called grompp.log (along with real debug
info). You can see the contents of the run input file with the gmx dump
program. gmx check can be used to compare the contents of two run input files.

The -maxwarn option can be used to override warnings printed by gmx grompp
that otherwise halt output. In some cases, warnings are harmless, but usually
they are not. The user is advised to carefully interpret the output messages
before attempting to bypass them with this option.

OPTIONS

Options to specify input files:

 -f      [<.mdp>]           (grompp.mdp)
           grompp input file with MD parameters
 -c      [<.gro/.g96/...>]  (conf.gro)
           Structure file: gro g96 pdb brk ent esp tpr
 -r      [<.gro/.g96/...>]  (restraint.gro)  (Opt.)
           Structure file: gro g96 pdb brk ent esp tpr
 -rb     [<.gro/.g96/...>]  (restraint.gro)  (Opt.)
           Structure file: gro g96 pdb brk ent esp tpr
 -n      [<.ndx>]           (index.ndx)      (Opt.)
           Index file
 -p      [<.top>]           (topol.top)
           Topology file
 -t      [<.trr/.cpt/...>]  (traj.trr)       (Opt.)
           Full precision trajectory: trr cpt tng
 -e      [<.edr>]           (ener.edr)       (Opt.)
           Energy file
 -qmi    [<.inp>]           (topol-qmmm.inp) (Opt.)
           Input file for QM program

Options to specify input/output files:

 -ref    [<.trr/.cpt/...>]  (rotref.trr)     (Opt.)
           Full precision trajectory: trr cpt tng

Options to specify output files:

 -po     [<.mdp>]           (mdout.mdp)
           grompp input file with MD parameters
 -pp     [<.top>]           (processed.top)  (Opt.)
           Topology file
 -o      [<.tpr>]           (topol.tpr)
           Portable xdr run input file
 -imd    [<.gro>]           (imdgroup.gro)   (Opt.)
           Coordinate file in Gromos-87 format

Other options:

 -[no]v                     (no)
           Be loud and noisy
 -time   <real>             (-1)
           Take frame at or first after this time.
 -[no]rmvsbds               (yes)
           Remove constant bonded interactions with virtual sites
 -maxwarn <int>             (0)
           Number of allowed warnings during input processing. Not for normal
           use and may generate unstable systems
 -[no]zero                  (no)
           Set parameters for bonded interactions without defaults to zero
           instead of generating an error
 -[no]renum                 (yes)
           Renumber atomtypes and minimize number of atomtypes
```


## gromacs_mddb_gmx mdrun

### Tool Description
gmx mdrun is the main computational chemistry engine within GROMACS. Obviously, it performs Molecular Dynamics simulations, but it can also perform Stochastic Dynamics, Energy Minimization, test particle insertion or (re)calculation of energies. Normal mode analysis is another option. In this case mdrun builds a Hessian matrix from single conformation. For usual Normal Modes-like calculations, make sure that the structure provided is properly energy-minimized. The generated matrix can be diagonalized by gmx nmeig.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs:2022
- **Homepage**: https://www.gromacs.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_mddb/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS

gmx mdrun [-s [<.tpr>]] [-cpi [<.cpt>]] [-table [<.xvg>]] [-tablep [<.xvg>]]
          [-tableb [<.xvg> [...]]] [-rerun [<.xtc/.trr/...>]] [-ei [<.edi>]]
          [-multidir [<dir> [...]]] [-awh [<.xvg>]] [-membed [<.dat>]]
          [-mp [<.top>]] [-mn [<.ndx>]] [-o [<.trr/.cpt/...>]]
          [-x [<.xtc/.tng>]] [-cpo [<.cpt>]] [-c [<.gro/.g96/...>]]
          [-e [<.edr>]] [-g [<.log>]] [-dhdl [<.xvg>]] [-field [<.xvg>]]
          [-tpi [<.xvg>]] [-tpid [<.xvg>]] [-eo [<.xvg>]] [-px [<.xvg>]]
          [-pf [<.xvg>]] [-ro [<.xvg>]] [-ra [<.log>]] [-rs [<.log>]]
          [-rt [<.log>]] [-mtx [<.mtx>]] [-if [<.xvg>]] [-swap [<.xvg>]]
          [-deffnm <string>] [-xvg <enum>] [-dd <vector>] [-ddorder <enum>]
          [-npme <int>] [-nt <int>] [-ntmpi <int>] [-ntomp <int>]
          [-ntomp_pme <int>] [-pin <enum>] [-pinoffset <int>]
          [-pinstride <int>] [-gpu_id <string>] [-gputasks <string>]
          [-[no]ddcheck] [-rdd <real>] [-rcon <real>] [-dlb <enum>]
          [-dds <real>] [-nb <enum>] [-nstlist <int>] [-[no]tunepme]
          [-pme <enum>] [-pmefft <enum>] [-bonded <enum>] [-update <enum>]
          [-[no]v] [-pforce <real>] [-[no]reprod] [-cpt <real>] [-[no]cpnum]
          [-[no]append] [-nsteps <int>] [-maxh <real>] [-replex <int>]
          [-nex <int>] [-reseed <int>]

DESCRIPTION

gmx mdrun is the main computational chemistry engine within GROMACS.
Obviously, it performs Molecular Dynamics simulations, but it can also perform
Stochastic Dynamics, Energy Minimization, test particle insertion or
(re)calculation of energies. Normal mode analysis is another option. In this
case mdrun builds a Hessian matrix from single conformation. For usual Normal
Modes-like calculations, make sure that the structure provided is properly
energy-minimized. The generated matrix can be diagonalized by gmx nmeig.

The mdrun program reads the run input file (-s) and distributes the topology
over ranks if needed. mdrun produces at least four output files. A single log
file (-g) is written. The trajectory file (-o), contains coordinates,
velocities and optionally forces. The structure file (-c) contains the
coordinates and velocities of the last step. The energy file (-e) contains
energies, the temperature, pressure, etc, a lot of these things are also
printed in the log file. Optionally coordinates can be written to a compressed
trajectory file (-x).

The option -dhdl is only used when free energy calculation is turned on.

Running mdrun efficiently in parallel is a complex topic, many aspects of
which are covered in the online User Guide. You should look there for
practical advice on using many of the options available in mdrun.

ED (essential dynamics) sampling and/or additional flooding potentials are
switched on by using the -ei flag followed by an .edi file. The .edi file can
be produced with the make_edi tool or by using options in the essdyn menu of
the WHAT IF program. mdrun produces a .xvg output file that contains
projections of positions, velocities and forces onto selected eigenvectors.

When user-defined potential functions have been selected in the .mdp file the
-table option is used to pass mdrun a formatted table with potential
functions. The file is read from either the current directory or from the
GMXLIB directory. A number of pre-formatted tables are presented in the GMXLIB
dir, for 6-8, 6-9, 6-10, 6-11, 6-12 Lennard-Jones potentials with normal
Coulomb. When pair interactions are present, a separate table for pair
interaction functions is read using the -tablep option.

When tabulated bonded functions are present in the topology, interaction
functions are read using the -tableb option. For each different tabulated
interaction type used, a table file name must be given. For the topology to
work, a file name given here must match a character sequence before the file
extension. That sequence is: an underscore, then a 'b' for bonds, an 'a' for
angles or a 'd' for dihedrals, and finally the matching table number index
used in the topology. Note that, these options are deprecated, and in future
will be available via grompp.

The options -px and -pf are used for writing pull COM coordinates and forces
when pulling is selected in the .mdp file.

The option -membed does what used to be g_membed, i.e. embed a protein into a
membrane. This module requires a number of settings that are provided in a
data file that is the argument of this option. For more details in membrane
embedding, see the documentation in the user guide. The options -mn and -mp
are used to provide the index and topology files used for the embedding.

The option -pforce is useful when you suspect a simulation crashes due to too
large forces. With this option coordinates and forces of atoms with a force
larger than a certain value will be printed to stderr. It will also terminate
the run when non-finite forces are present.

Checkpoints containing the complete state of the system are written at regular
intervals (option -cpt) to the file -cpo, unless option -cpt is set to -1. The
previous checkpoint is backed up to state_prev.cpt to make sure that a recent
state of the system is always available, even when the simulation is
terminated while writing a checkpoint. With -cpnum all checkpoint files are
kept and appended with the step number. A simulation can be continued by
reading the full state from file with option -cpi. This option is intelligent
in the way that if no checkpoint file is found, GROMACS just assumes a normal
run and starts from the first step of the .tpr file. By default the output
will be appending to the existing output files. The checkpoint file contains
checksums of all output files, such that you will never loose data when some
output files are modified, corrupt or removed. There are three scenarios with
-cpi:

* no files with matching names are present: new output files are written

* all files are present with names and checksums matching those stored in the
checkpoint file: files are appended

* otherwise no files are modified and a fatal error is generated

With -noappend new output files are opened and the simulation part number is
added to all output file names. Note that in all cases the checkpoint file
itself is not renamed and will be overwritten, unless its name does not match
the -cpo option.

With checkpointing the output is appended to previously written output files,
unless -noappend is used or none of the previous output files are present
(except for the checkpoint file). The integrity of the files to be appended is
verified using checksums which are stored in the checkpoint file. This ensures
that output can not be mixed up or corrupted due to file appending. When only
some of the previous output files are present, a fatal error is generated and
no old output files are modified and no new output files are opened. The
result with appending will be the same as from a single run. The contents will
be binary identical, unless you use a different number of ranks or dynamic
load balancing or the FFT library uses optimizations through timing.

With option -maxh a simulation is terminated and a checkpoint file is written
at the first neighbor search step where the run time exceeds -maxh*0.99 hours.
This option is particularly useful in combination with setting nsteps to -1
either in the mdp or using the similarly named command line option (although
the latter is deprecated). This results in an infinite run, terminated only
when the time limit set by -maxh is reached (if any) or upon receiving a
signal.

Interactive molecular dynamics (IMD) can be activated by using at least one of
the three IMD switches: The -imdterm switch allows one to terminate the
simulation from the molecular viewer (e.g. VMD). With -imdwait, mdrun pauses
whenever no IMD client is connected. Pulling from the IMD remote can be turned
on by -imdpull. The port mdrun listens to can be altered by -imdport.The file
pointed to by -if contains atom indices and forces if IMD pulling is used.

OPTIONS

Options to specify input files:

 -s      [<.tpr>]           (topol.tpr)
           Portable xdr run input file
 -cpi    [<.cpt>]           (state.cpt)      (Opt.)
           Checkpoint file
 -table  [<.xvg>]           (table.xvg)      (Opt.)
           xvgr/xmgr file
 -tablep [<.xvg>]           (tablep.xvg)     (Opt.)
           xvgr/xmgr file
 -tableb [<.xvg> [...]]     (table.xvg)      (Opt.)
           xvgr/xmgr file
 -rerun  [<.xtc/.trr/...>]  (rerun.xtc)      (Opt.)
           Trajectory: xtc trr cpt gro g96 pdb tng
 -ei     [<.edi>]           (sam.edi)        (Opt.)
           ED sampling input
 -multidir [<dir> [...]]    (rundir)         (Opt.)
           Run directory
 -awh    [<.xvg>]           (awhinit.xvg)    (Opt.)
           xvgr/xmgr file
 -membed [<.dat>]           (membed.dat)     (Opt.)
           Generic data file
 -mp     [<.top>]           (membed.top)     (Opt.)
           Topology file
 -mn     [<.ndx>]           (membed.ndx)     (Opt.)
           Index file

Options to specify output files:

 -o      [<.trr/.cpt/...>]  (traj.trr)
           Full precision trajectory: trr cpt tng
 -x      [<.xtc/.tng>]      (traj_comp.xtc)  (Opt.)
           Compressed trajectory (tng format or portable xdr format)
 -cpo    [<.cpt>]           (state.cpt)      (Opt.)
           Checkpoint file
 -c      [<.gro/.g96/...>]  (confout.gro)
           Structure file: gro g96 pdb brk ent esp
 -e      [<.edr>]           (ener.edr)
           Energy file
 -g      [<.log>]           (md.log)
           Log file
 -dhdl   [<.xvg>]           (dhdl.xvg)       (Opt.)
           xvgr/xmgr file
 -field  [<.xvg>]           (field.xvg)      (Opt.)
           xvgr/xmgr file
 -tpi    [<.xvg>]           (tpi.xvg)        (Opt.)
           xvgr/xmgr file
 -tpid   [<.xvg>]           (tpidist.xvg)    (Opt.)
           xvgr/xmgr file
 -eo     [<.xvg>]           (edsam.xvg)      (Opt.)
           xvgr/xmgr file
 -px     [<.xvg>]           (pullx.xvg)      (Opt.)
           xvgr/xmgr file
 -pf     [<.xvg>]           (pullf.xvg)      (Opt.)
           xvgr/xmgr file
 -ro     [<.xvg>]           (rotation.xvg)   (Opt.)
           xvgr/xmgr file
 -ra     [<.log>]           (rotangles.log)  (Opt.)
           Log file
 -rs     [<.log>]           (rotslabs.log)   (Opt.)
           Log file
 -rt     [<.log>]           (rottorque.log)  (Opt.)
           Log file
 -mtx    [<.mtx>]           (nm.mtx)         (Opt.)
           Hessian matrix
 -if     [<.xvg>]           (imdforces.xvg)  (Opt.)
           xvgr/xmgr file
 -swap   [<.xvg>]           (swapions.xvg)   (Opt.)
           xvgr/xmgr file

Other options:

 -deffnm <string>
           Set the default filename for all file options
 -xvg    <enum>             (xmgrace)
           xvg plot formatting: xmgrace, xmgr, none
 -dd     <vector>           (0 0 0)
           Domain decomposition grid, 0 is optimize
 -ddorder <enum>            (interleave)
           DD rank order: interleave, pp_pme, cartesian
 -npme   <int>              (-1)
           Number of separate ranks to be used for PME, -1 is guess
 -nt     <int>              (0)
           Total number of threads to start (0 is guess)
 -ntmpi  <int>              (0)
           Number of thread-MPI ranks to start (0 is guess)
 -ntomp  <int>              (0)
           Number of OpenMP threads per MPI rank to start (0 is guess)
 -ntomp_pme <int>           (0)
           Number of OpenMP threads per MPI rank to start (0 is -ntomp)
 -pin    <enum>             (auto)
           Whether mdrun should try to set thread affinities: auto, on, off
 -pinoffset <int>           (0)
           The lowest logical core number to which mdrun should pin the first
           thread
 -pinstride <int>           (0)
           Pinning distance in logical cores for threads, use 0 to minimize
           the number of threads per physical core
 -gpu_id <string>
           List of unique GPU device IDs available to use
 -gputasks <string>
           List of GPU device IDs, mapping each PP task on each node to a
           device
 -[no]ddcheck               (yes)
           Check for all bonded interactions with DD
 -rdd    <real>             (0)
           The maximum distance for bonded interactions with DD (nm), 0 is
           determine from initial coordinates
 -rcon   <real>             (0)
           Maximum distance for P-LINCS (nm), 0 is estimate
 -dlb    <enum>             (auto)
           Dynamic load balancing (with DD): auto, no, yes
 -dds    <real>             (0.8)
           Fraction in (0,1) by whose reciprocal the initial DD cell size will
           be increased in order to provide a margin in which dynamic load
           balancing can act while preserving the minimum cell size.
 -nb     <enum>             (auto)
           Calculate non-bonded interactions on: auto, cpu, gpu
 -nstlist <int>             (0)
           Set nstlist when using a Verlet buffer tolerance (0 is guess)
 -[no]tunepme               (yes)
           Optimize PME load between PP/PME ranks or GPU/CPU
 -pme    <enum>             (auto)
           Perform PME calculations on: auto, cpu, gpu
 -pmefft <enum>             (auto)
           Perform PME FFT calculations on: auto, cpu, gpu
 -bonded <enum>             (auto)
           Perform bonded calculations on: auto, cpu, gpu
 -update <enum>             (auto)
           Perform update and constraints on: auto, cpu, gpu
 -[no]v                     (no)
           Be loud and noisy
 -pforce <real>             (-1)
           Print all forces larger than this (kJ/mol nm)
 -[no]reprod                (no)
           Try to avoid optimizations that affect binary reproducibility
 -cpt    <real>             (15)
           Checkpoint interval (minutes)
 -[no]cpnum                 (no)
           Keep and number checkpoint files
 -[no]append                (yes)
           Append to previous output files when continuing from checkpoint
           instead of adding the simulation part number to all file names
 -nsteps <int>              (-2)
           Run this number of steps (-1 means infinite, -2 means use mdp
           option, smaller is invalid)
 -maxh   <real>             (-1)
           Terminate after 0.99 times this time (hours)
 -replex <int>              (0)
           Attempt replica exchange periodically with this period (steps)
 -nex    <int>              (0)
           Number of random exchanges to carry out each exchange interval (N^3
           is one suggestion).  -nex zero or not specified gives neighbor
           replica exchange.
 -reseed <int>              (-1)
           Seed for replica exchange, -1 is generate a seed
```


## gromacs_mddb_gmx trjconv

### Tool Description
gmx trjconv can convert trajectory files in many ways:

* from one format to another
* select a subset of atoms
* change the periodicity representation
* keep multimeric molecules together
* center atoms in the box
* fit atoms to reference structure
* reduce the number of frames
* change the timestamps of the frames (-t0 and -timestep)
* select frames within a certain range of a quantity given in an .xvg file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs:2022
- **Homepage**: https://www.gromacs.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs_mddb/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS

gmx trjconv [-f [<.xtc/.trr/...>]] [-s [<.tpr/.gro/...>]] [-n [<.ndx>]]
            [-fr [<.ndx>]] [-sub [<.ndx>]] [-drop [<.xvg>]]
            [-o [<.xtc/.trr/...>]] [-b <time>] [-e <time>] [-tu <enum>]
            [-[no]w] [-xvg <enum>] [-skip <int>] [-dt <time>] [-[no]round]
            [-dump <time>] [-t0 <time>] [-timestep <time>] [-pbc <enum>]
            [-ur <enum>] [-[no]center] [-boxcenter <enum>] [-box <vector>]
            [-trans <vector>] [-shift <vector>] [-fit <enum>] [-ndec <int>]
            [-[no]vel] [-[no]force] [-trunc <time>] [-exec <string>]
            [-split <time>] [-[no]sep] [-nzero <int>] [-dropunder <real>]
            [-dropover <real>] [-[no]conect]

DESCRIPTION

gmx trjconv can convert trajectory files in many ways:

* from one format to another
* select a subset of atoms
* change the periodicity representation
* keep multimeric molecules together
* center atoms in the box
* fit atoms to reference structure
* reduce the number of frames
* change the timestamps of the frames (-t0 and -timestep)
* select frames within a certain range of a quantity given in an .xvg file.

The option to write subtrajectories (-sub) based on the information obtained
from cluster analysis has been removed from gmx trjconv and is now part of
[gmx extract-cluster]

gmx trjcat is better suited for concatenating multiple trajectory files.

The following formats are supported for input and output: .xtc, .trr, .gro,
.g96, .pdb and .tng. The file formats are detected from the file extension.
The precision of the .xtc output is taken from the input file for .xtc, .gro
and .pdb, and from the -ndec option for other input formats. The precision is
always taken from -ndec, when this option is set. All other formats have fixed
precision. .trr output can be single or double precision, depending on the
precision of the gmx trjconv binary. Note that velocities are only supported
in .trr, .tng, .gro and .g96 files.

Option -sep can be used to write every frame to a separate .gro, .g96 or .pdb
file. By default, all frames all written to one file. .pdb files with all
frames concatenated can be viewed with rasmol -nmrpdb.

It is possible to select part of your trajectory and write it out to a new
trajectory file in order to save disk space, e.g. for leaving out the water
from a trajectory of a protein in water. ALWAYS put the original trajectory on
tape! We recommend to use the portable .xtc format for your analysis to save
disk space and to have portable files. When writing .tng output the file will
contain one molecule type of the correct count if the selection name matches
the molecule name and the selected atoms match all atoms of that molecule.
Otherwise the whole selection will be treated as one single molecule
containing all the selected atoms.

There are two options for fitting the trajectory to a reference either for
essential dynamics analysis, etc. The first option is just plain fitting to a
reference structure in the structure file. The second option is a progressive
fit in which the first timeframe is fitted to the reference structure in the
structure file to obtain and each subsequent timeframe is fitted to the
previously fitted structure. This way a continuous trajectory is generated,
which might not be the case when using the regular fit method, e.g. when your
protein undergoes large conformational transitions.

Option -pbc sets the type of periodic boundary condition treatment:

 * mol puts the center of mass of molecules in the box, and requires a run
   input file to be supplied with -s.
 * res puts the center of mass of residues in the box.
 * atom puts all the atoms in the box.
 * nojump checks if atoms jump across the box and then puts them back. This
   has the effect that all molecules will remain whole (provided they were
   whole in the initial conformation). Note that this ensures a continuous
   trajectory but molecules may diffuse out of the box. The starting
   configuration for this procedure is taken from the structure file, if one
   is supplied, otherwise it is the first frame.
 * cluster clusters all the atoms in the selected index such that they are all
   closest to the center of mass of the cluster, which is iteratively updated.
   Note that this will only give meaningful results if you in fact have a
   cluster. Luckily that can be checked afterwards using a trajectory viewer.
   Note also that if your molecules are broken this will not work either.
 * whole only makes broken molecules whole.

Option -ur sets the unit cell representation for options mol, res and atom of
-pbc. All three options give different results for triclinic boxes and
identical results for rectangular boxes. rect is the ordinary brick shape.
tric is the triclinic unit cell. compact puts all atoms at the closest
distance from the center of the box. This can be useful for visualizing e.g.
truncated octahedra or rhombic dodecahedra. The center for options tric and
compact is tric (see below), unless the option -boxcenter is set differently.

Option -center centers the system in the box. The user can select the group
which is used to determine the geometrical center. Option -boxcenter sets the
location of the center of the box for options -pbc and -center. The center
options are: tric: half of the sum of the box vectors, rect: half of the box
diagonal, zero: zero. Use option -pbc mol in addition to -center when you want
all molecules in the box after the centering.

Option -box sets the size of the new box. This option only works for leading
dimensions and is thus generally only useful for rectangular boxes. If you
want to modify only some of the dimensions, e.g. when reading from a
trajectory, you can use -1 for those dimensions that should stay the same It
is not always possible to use combinations of -pbc, -fit, -ur and -center to
do exactly what you want in one call to gmx trjconv. Consider using multiple
calls, and check out the GROMACS website for suggestions.

With -dt, it is possible to reduce the number of frames in the output. This
option relies on the accuracy of the times in your input trajectory, so if
these are inaccurate use the -timestep option to modify the time (this can be
done simultaneously). For making smooth movies, the program gmx filter can
reduce the number of frames while using low-pass frequency filtering, this
reduces aliasing of high frequency motions.

Using -trunc gmx trjconv can truncate .trr in place, i.e. without copying the
file. This is useful when a run has crashed during disk I/O (i.e. full disk),
or when two contiguous trajectories must be concatenated without having double
frames.

Option -dump can be used to extract a frame at or near one specific time from
your trajectory. If the frames in the trajectory are not in temporal order,
the result is unspecified.

Option -drop reads an .xvg file with times and values. When options -dropunder
and/or -dropover are set, frames with a value below and above the value of the
respective options will not be written.

OPTIONS

Options to specify input files:

 -f      [<.xtc/.trr/...>]  (traj.xtc)
           Trajectory: xtc trr cpt gro g96 pdb tng
 -s      [<.tpr/.gro/...>]  (topol.tpr)      (Opt.)
           Structure+mass(db): tpr gro g96 pdb brk ent
 -n      [<.ndx>]           (index.ndx)      (Opt.)
           Index file
 -fr     [<.ndx>]           (frames.ndx)     (Opt.)
           Index file
 -sub    [<.ndx>]           (cluster.ndx)    (Opt.)
           Index file
 -drop   [<.xvg>]           (drop.xvg)       (Opt.)
           xvgr/xmgr file

Options to specify output files:

 -o      [<.xtc/.trr/...>]  (trajout.xtc)
           Trajectory: xtc trr gro g96 pdb tng

Other options:

 -b      <time>             (0)
           Time of first frame to read from trajectory (default unit ps)
 -e      <time>             (0)
           Time of last frame to read from trajectory (default unit ps)
 -tu     <enum>             (ps)
           Unit for time values: fs, ps, ns, us, ms, s
 -[no]w                     (no)
           View output .xvg, .xpm, .eps and .pdb files
 -xvg    <enum>             (xmgrace)
           xvg plot formatting: xmgrace, xmgr, none
 -skip   <int>              (1)
           Only write every nr-th frame
 -dt     <time>             (0)
           Only write frame when t MOD dt = first time (ps)
 -[no]round                 (no)
           Round measurements to nearest picosecond
 -dump   <time>             (-1)
           Dump frame nearest specified time (ps)
 -t0     <time>             (0)
           Starting time (ps) (default: don't change)
 -timestep <time>           (0)
           Change time step between input frames (ps)
 -pbc    <enum>             (none)
           PBC treatment (see help text for full description): none, mol, res,
           atom, nojump, cluster, whole
 -ur     <enum>             (rect)
           Unit-cell representation: rect, tric, compact
 -[no]center                (no)
           Center atoms in box
 -boxcenter <enum>          (tric)
           Center for -pbc and -center: tric, rect, zero
 -box    <vector>           (0 0 0)
           Size for new cubic box (default: read from input)
 -trans  <vector>           (0 0 0)
           All coordinates will be translated by trans. This can
           advantageously be combined with -pbc mol -ur compact.
 -shift  <vector>           (0 0 0)
           All coordinates will be shifted by framenr*shift
 -fit    <enum>             (none)
           Fit molecule to ref structure in the structure file: none,
           rot+trans, rotxy+transxy, translation, transxy, progressive
 -ndec   <int>              (3)
           Number of decimal places to write to .xtc output
 -[no]vel                   (yes)
           Read and write velocities if possible
 -[no]force                 (no)
           Read and write forces if possible
 -trunc  <time>             (-1)
           Truncate input trajectory file after this time (ps)
 -exec   <string>
           Execute command for every output frame with the frame number as
           argument
 -split  <time>             (0)
           Start writing new file when t MOD split = first time (ps)
 -[no]sep                   (no)
           Write each frame to a separate .gro, .g96 or .pdb file
 -nzero  <int>              (0)
           If the -sep flag is set, use these many digits for the file numbers
           and prepend zeros as needed
 -dropunder <real>          (0)
           Drop all frames below this value
 -dropover <real>           (0)
           Drop all frames above this value
 -[no]conect                (no)
           Add CONECT PDB records when writing .pdb files. Useful for
           visualization of non-standard molecules, e.g. coarse grained ones
```


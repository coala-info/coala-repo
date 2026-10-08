# gromacs CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gromacs_editconf | PASS |  |
| gromacs_genion | PASS |  |
| gromacs_pdb2gmx | PASS |  |
| gromacs_solvate | PASS |  |

## gromacs_pdb2gmx

### Tool Description
Convert a .pdb (or .gro) file to GROMACS format: adds hydrogens, generates coordinates and a topology.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs:2022
- **Homepage**: https://www.gromacs.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs/overview
- **Validation**: PASS

### Original Help Text
```text
:-) GROMACS - gmx help, 2022-conda_forge (-:

Executable:   /usr/local/bin.AVX2_256/gmx
Data prefix:  /usr/local
Working dir:  /
Command line:
  gmx help pdb2gmx

SYNOPSIS

gmx pdb2gmx [-f [<.gro/.g96/...>]] [-o [<.gro/.g96/...>]] [-p [<.top>]]
            [-i [<.itp>]] [-n [<.ndx>]] [-q [<.gro/.g96/...>]]
            [-chainsep <enum>] [-merge <enum>] [-ff <string>] [-water <enum>]
            [-[no]inter] [-[no]ss] [-[no]ter] [-[no]lys] [-[no]arg]
            [-[no]asp] [-[no]glu] [-[no]gln] [-[no]his] [-angle <real>]
            [-dist <real>] [-[no]una] [-[no]ignh] [-[no]missing] [-[no]v]
            [-posrefc <real>] [-vsite <enum>] [-[no]heavyh] [-[no]deuterate]
            [-[no]chargegrp] [-[no]cmap] [-[no]renum] [-[no]rtpres]

DESCRIPTION

gmx pdb2gmx reads a .pdb (or .gro) file, reads some database files, adds
hydrogens to the molecules and generates coordinates in GROMACS (GROMOS), or
optionally .pdb, format and a topology in GROMACS format. These files can
subsequently be processed to generate a run input file.

gmx pdb2gmx will search for force fields by looking for a forcefield.itp file
in subdirectories <forcefield>.ff of the current working directory and of the
GROMACS library directory as inferred from the path of the binary or the
GMXLIB environment variable. By default the forcefield selection is
interactive, but you can use the -ff option to specify one of the short names
in the list on the command line instead. In that case gmx pdb2gmx just looks
for the corresponding <forcefield>.ff directory.

After choosing a force field, all files will be read only from the
corresponding force field directory. If you want to modify or add a residue
types, you can copy the force field directory from the GROMACS library
directory to your current working directory. If you want to add new protein
residue types, you will need to modify residuetypes.dat in the library
directory or copy the whole library directory to a local directory and set the
environment variable GMXLIB to the name of that directory. Check Chapter 5 of
the manual for more information about file formats.

Note that a .pdb file is nothing more than a file format, and it need not
necessarily contain a protein structure. Every kind of molecule for which
there is support in the database can be converted. If there is no support in
the database, you can add it yourself.

The program has limited intelligence, it reads a number of database files,
that allow it to make special bonds (Cys-Cys, Heme-His, etc.), if necessary
this can be done manually. The program can prompt the user to select which
kind of LYS, ASP, GLU, CYS or HIS residue is desired. For Lys the choice is
between neutral (two protons on NZ) or protonated (three protons, default),
for Asp and Glu unprotonated (default) or protonated, for His the proton can
be either on ND1, on NE2 or on both. By default these selections are done
automatically. For His, this is based on an optimal hydrogen bonding
conformation. Hydrogen bonds are defined based on a simple geometric
criterion, specified by the maximum hydrogen-donor-acceptor angle and
donor-acceptor distance, which are set by -angle and -dist respectively.

The protonation state of N- and C-termini can be chosen interactively with the
-ter flag.  Default termini are ionized (NH3+ and COO-), respectively.  Some
force fields support zwitterionic forms for chains of one residue, but for
polypeptides these options should NOT be selected. The AMBER force fields have
unique forms for the terminal residues, and these are incompatible with the
-ter mechanism. You need to prefix your N- or C-terminal residue names with
"N" or "C" respectively to use these forms, making sure you preserve the
format of the coordinate file. Alternatively, use named terminating residues
(e.g. ACE, NME).

The separation of chains is not entirely trivial since the markup in
user-generated PDB files frequently varies and sometimes it is desirable to
merge entries across a TER record, for instance if you want a disulfide bridge
or distance restraints between two protein chains or if you have a HEME group
bound to a protein. In such cases multiple chains should be contained in a
single moleculetype definition. To handle this, gmx pdb2gmx uses two separate
options. First, -chainsep allows you to choose when a new chemical chain
should start, and termini added when applicable. This can be done based on the
existence of TER records, when the chain id changes, or combinations of either
or both of these. You can also do the selection fully interactively. In
addition, there is a -merge option that controls how multiple chains are
merged into one moleculetype, after adding all the chemical termini (or not).
This can be turned off (no merging), all non-water chains can be merged into a
single molecule, or the selection can be done interactively.

gmx pdb2gmx will also check the occupancy field of the .pdb file. If any of
the occupancies are not one, indicating that the atom is not resolved well in
the structure, a warning message is issued. When a .pdb file does not
originate from an X-ray structure determination all occupancy fields may be
zero. Either way, it is up to the user to verify the correctness of the input
data (read the article!).

During processing the atoms will be reordered according to GROMACS
conventions. With -n an index file can be generated that contains one group
reordered in the same way. This allows you to convert a GROMOS trajectory and
coordinate file to GROMOS. There is one limitation: reordering is done after
the hydrogens are stripped from the input and before new hydrogens are added.
This means that you should not use -ignh.

The .gro and .g96 file formats do not support chain identifiers. Therefore it
is useful to enter a .pdb file name at the -o option when you want to convert
a multi-chain .pdb file.

The option -vsite removes hydrogen and fast improper dihedral motions. Angular
and out-of-plane motions can be removed by changing hydrogens into virtual
sites and fixing angles, which fixes their position relative to neighboring
atoms. Additionally, all atoms in the aromatic rings of the standard amino
acids (i.e. PHE, TRP, TYR and HIS) can be converted into virtual sites,
eliminating the fast improper dihedral fluctuations in these rings (but this
feature is deprecated). Note that in this case all other hydrogen atoms are
also converted to virtual sites. The mass of all atoms that are converted into
virtual sites, is added to the heavy atoms.

Also slowing down of dihedral motion can be done with -heavyh done by
increasing the hydrogen-mass by a factor of 4. This is also done for water
hydrogens to slow down the rotational motion of water. The increase in mass of
the hydrogens is subtracted from the bonded (heavy) atom so that the total
mass of the system remains the same. As a special case, ring-closed (or
cyclic) molecules are considered. gmx pdb2gmx automatically determines if a
cyclic molecule is present by evaluating the distance between the terminal
atoms of a given chain. If this distance is greater than the -sb ("Short bond
warning distance", default 0.05 nm) and less than the -lb ("Long bond warning
distance", default 0.25 nm) the molecule is considered to be ring closed and
will be processed as such. Please note that this does not detect cyclic bonds
over periodic boundaries.

OPTIONS

Options to specify input files:

 -f      [<.gro/.g96/...>]  (protein.pdb)
           Structure file: gro g96 pdb brk ent esp tpr

Options to specify output files:

 -o      [<.gro/.g96/...>]  (conf.gro)
           Structure file: gro g96 pdb brk ent esp
 -p      [<.top>]           (topol.top)
           Topology file
 -i      [<.itp>]           (posre.itp)
           Include file for topology
 -n      [<.ndx>]           (index.ndx)      (Opt.)
           Index file
 -q      [<.gro/.g96/...>]  (clean.pdb)      (Opt.)
           Structure file: gro g96 pdb brk ent esp

Other options:

 -chainsep <enum>           (id_or_ter)
           Condition in PDB files when a new chain should be started (adding
           termini): id_or_ter, id_and_ter, ter, id, interactive
 -merge  <enum>             (no)
           Merge multiple chains into a single [moleculetype]: no, all,
           interactive
 -ff     <string>           (select)
           Force fi
GROMACS reminds you: "What Kind Of Guru are You, Anyway ?" (F. Zappa)

eld, interactive by default. Use -h for information.
 -water  <enum>             (select)
           Water model to use: select, none, spc, spce, tip3p, tip4p, tip5p,
           tips3p
 -[no]inter                 (no)
           Set the next 8 options to interactive
 -[no]ss                    (no)
           Interactive SS bridge selection
 -[no]ter                   (no)
           Interactive termini selection, instead of charged (default)
 -[no]lys                   (no)
           Interactive lysine selection, instead of charged
 -[no]arg                   (no)
           Interactive arginine selection, instead of charged
 -[no]asp                   (no)
           Interactive aspartic acid selection, instead of charged
 -[no]glu                   (no)
           Interactive glutamic acid selection, instead of charged
 -[no]gln                   (no)
           Interactive glutamine selection, instead of charged
 -[no]his                   (no)
           Interactive histidine selection, instead of checking H-bonds
 -angle  <real>             (135)
           Minimum hydrogen-donor-acceptor angle for a H-bond (degrees)
 -dist   <real>             (0.3)
           Maximum donor-acceptor distance for a H-bond (nm)
 -[no]una                   (no)
           Select aromatic rings with united CH atoms on phenylalanine,
           tryptophane and tyrosine
 -[no]ignh                  (no)
           Ignore hydrogen atoms that are in the coordinate file
 -[no]missing               (no)
           Continue when atoms are missing and bonds cannot be made, dangerous
 -[no]v                     (no)
           Be slightly more verbose in messages
 -posrefc <real>            (1000)
           Force constant for position restraints
 -vsite  <enum>             (none)
           Convert atoms to virtual sites: none, hydrogens, aromatics
 -[no]heavyh                (no)
           Make hydrogen atoms heavy
 -[no]deuterate             (no)
           Change the mass of hydrogens to 2 amu
 -[no]chargegrp             (yes)
           Use charge groups in the .rtp file
 -[no]cmap                  (yes)
           Use cmap torsions (if enabled in the .rtp file)
 -[no]renum                 (no)
           Renumber the residues consecutively in the output
 -[no]rtpres                (no)
           Use .rtp entry names as residue names
```

## gromacs_editconf

### Tool Description
Edit the box and write subgroups: converts and manipulates structure files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs:2022
- **Homepage**: https://www.gromacs.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs/overview
- **Validation**: PASS

### Original Help Text
```text
:-) GROMACS - gmx help, 2022-conda_forge (-:

Executable:   /usr/local/bin.AVX2_256/gmx
Data prefix:  /usr/local
Working dir:  /
Command line:
  gmx help editconf

SYNOPSIS

gmx editconf [-f [<.gro/.g96/...>]] [-n [<.ndx>]] [-bf [<.dat>]]
             [-o [<.gro/.g96/...>]] [-mead [<.pqr>]] [-[no]w] [-[no]ndef]
             [-bt <enum>] [-box <vector>] [-angles <vector>] [-d <real>]
             [-[no]c] [-center <vector>] [-aligncenter <vector>]
             [-align <vector>] [-translate <vector>] [-rotate <vector>]
             [-[no]princ] [-scale <vector>] [-density <real>] [-[no]pbc]
             [-resnr <int>] [-[no]grasp] [-rvdw <real>] [-[no]sig56]
             [-[no]vdwread] [-[no]atom] [-[no]legend] [-label <string>]
             [-[no]conect]

DESCRIPTION

gmx editconf converts generic structure format to .gro, .g96 or .pdb.

The box can be modified with options -box, -d and -angles. Both -box and -d
will center the system in the box, unless -noc is used. The -center option can
be used to shift the geometric center of the system from the default of (x/2,
y/2, z/2) implied by -c to some other value.

Option -bt determines the box type: triclinic is a triclinic box, cubic is a
rectangular box with all sides equal dodecahedron represents a rhombic
dodecahedron and octahedron is a truncated octahedron. The last two are
special cases of a triclinic box. The length of the three box vectors of the
truncated octahedron is the shortest distance between two opposite hexagons.
Relative to a cubic box with some periodic image distance, the volume of a
dodecahedron with this same periodic distance is 0.71 times that of the cube,
and that of a truncated octahedron is 0.77 times.

Option -box requires only one value for a cubic, rhombic dodecahedral, or
truncated octahedral box.

With -d and a triclinic box the size of the system in the x-, y-, and
z-directions is used. With -d and cubic, dodecahedron or octahedron boxes, the
dimensions are set to the diameter of the system (largest distance between
atoms) plus twice the specified distance.

Option -angles is only meaningful with option -box and a triclinic box and
cannot be used with option -d.

When -n or -ndef is set, a group can be selected for calculating the size and
the geometric center, otherwise the whole system is used.

-rotate rotates the coordinates and velocities.

-princ aligns the principal axes of the system along the coordinate axes, with
the longest axis aligned with the x-axis. This may allow you to decrease the
box volume, but beware that molecules can rotate significantly in a
nanosecond.

Scaling is applied before any of the other operations are performed. Boxes and
coordinates can be scaled to give a certain density (option -density). Note
that this may be inaccurate in case a .gro file is given as input. A special
feature of the scaling option is that when the factor -1 is given in one
dimension, one obtains a mirror image, mirrored in one of the planes. When one
uses -1 in three dimensions, a point-mirror image is obtained.

Groups are selected after all operations have been applied.

Periodicity can be removed in a crude manner. It is important that the box
vectors at the bottom of your input file are correct when the periodicity is
to be removed.

When writing .pdb files, B-factors can be added with the -bf option. B-factors
are read from a file with with following format: first line states number of
entries in the file, next lines state an index followed by a B-factor. The
B-factors will be attached per residue unless the number of B-factors is
larger than the number of the residues or unless the -atom option is set.
Obviously, any type of numeric data can be added instead of B-factors. -legend
will produce a row of CA atoms with B-factors ranging from the minimum to the
maximum value found, effectively making a legend for viewing.

With the option -mead a special .pdb (.pqr) file for the MEAD electrostatics
program (Poisson-Boltzmann solver) can be made. A further prerequisite is that
the input file is a run input file. The B-factor field is then filled with the
Van der Waals radius of the atoms while the occupancy field will hold the
charge.

The option -grasp is similar, but it puts the charges in the B-
GROMACS reminds you: "What Kind Of Guru are You, Anyway ?" (F. Zappa)

factor and the
radius in the occupancy.

Option -align allows alignment of the principal axis of a specified group
against the given vector, with an optional center of rotation specified by
-aligncenter.

Finally, with option -label, editconf can add a chain identifier to a .pdb
file, which can be useful for analysis with e.g. Rasmol.

To convert a truncated octrahedron file produced by a package which uses a
cubic box with the corners cut off (such as GROMOS), use:

  gmx editconf -f in -rotate 0 45 35.264 -bt o -box veclen -o out

where veclen is the size of the cubic box times sqrt(3)/2.

OPTIONS

Options to specify input files:

 -f      [<.gro/.g96/...>]  (conf.gro)
           Structure file: gro g96 pdb brk ent esp tpr
 -n      [<.ndx>]           (index.ndx)      (Opt.)
           Index file
 -bf     [<.dat>]           (bfact.dat)      (Opt.)
           Generic data file

Options to specify output files:

 -o      [<.gro/.g96/...>]  (out.gro)        (Opt.)
           Structure file: gro g96 pdb brk ent esp
 -mead   [<.pqr>]           (mead.pqr)       (Opt.)
           Coordinate file for MEAD

Other options:

 -[no]w                     (no)
           View output .xvg, .xpm, .eps and .pdb files
 -[no]ndef                  (no)
           Choose output from default index groups
 -bt     <enum>             (triclinic)
           Box type for -box and -d: triclinic, cubic, dodecahedron,
           octahedron
 -box    <vector>           (0 0 0)
           Box vector lengths (a,b,c)
 -angles <vector>           (90 90 90)
           Angles between the box vectors (bc,ac,ab)
 -d      <real>             (0)
           Distance between the solute and the box
 -[no]c                     (no)
           Center molecule in box (implied by -box and -d)
 -center <vector>           (0 0 0)
           Shift the geometrical center to (x,y,z)
 -aligncenter <vector>      (0 0 0)
           Center of rotation for alignment
 -align  <vector>           (0 0 0)
           Align to target vector
 -translate <vector>        (0 0 0)
           Translation
 -rotate <vector>           (0 0 0)
           Rotation around the X, Y and Z axes in degrees
 -[no]princ                 (no)
           Orient molecule(s) along their principal axes
 -scale  <vector>           (1 1 1)
           Scaling factor
 -density <real>            (1000)
           Density (g/L) of the output box achieved by scaling
 -[no]pbc                   (no)
           Remove the periodicity (make molecule whole again)
 -resnr  <int>              (-1)
            Renumber residues starting from resnr
 -[no]grasp                 (no)
           Store the charge of the atom in the B-factor field and the radius
           of the atom in the occupancy field
 -rvdw   <real>             (0.12)
           Default Van der Waals radius (in nm) if one can not be found in the
           database or if no parameters are present in the topology file
 -[no]sig56                 (no)
           Use rmin/2 (minimum in the Van der Waals potential) rather than
           sigma/2
 -[no]vdwread               (no)
           Read the Van der Waals radii from the file vdwradii.dat rather than
           computing the radii based on the force field
 -[no]atom                  (no)
           Force B-factor attachment per atom
 -[no]legend                (no)
           Make B-factor legend
 -label  <string>           (A)
           Add chain label for all residues
 -[no]conect                (no)
           Add CONECT records to a .pdb file when written. Can only be done
           when a topology is present

KNOWN ISSUES

* For complex molecules, the periodicity removal routine may break down,
* in that case you can use gmx trjconv.
```

## gromacs_solvate

### Tool Description
Solvate a system: fills a box with solvent molecules around a solute and updates the topology.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs:2022
- **Homepage**: https://www.gromacs.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs/overview
- **Validation**: PASS

### Original Help Text
```text
:-) GROMACS - gmx help, 2022-conda_forge (-:

Executable:   /usr/local/bin.AVX2_256/gmx
Data prefix:  /usr/local
Working dir:  /
Command line:
  gmx help solvate

GROMACS reminds you: "It Doesn't Seem Right, No Computers in Sight" (Faun Fables)

SYNOPSIS

gmx solvate [-cp [<.gro/.g96/...>]] [-cs [<.gro/.g96/...>]] [-p [<.top>]]
            [-o [<.gro/.g96/...>]] [-box <vector>] [-radius <real>]
            [-scale <real>] [-shell <real>] [-maxsol <int>] [-[no]vel]

DESCRIPTION

gmx solvate can do one of 2 things:

1) Generate a box of solvent. Specify -cs and -box. Or specify -cs and -cp
with a structure file with a box, but without atoms.

2) Solvate a solute configuration, e.g. a protein, in a bath of solvent
molecules. Specify -cp (solute) and -cs (solvent). The box specified in the
solute coordinate file (-cp) is used, unless -box is set. If you want the
solute to be centered in the box, the program gmx editconf has sophisticated
options to change the box dimensions and center the solute. Solvent molecules
are removed from the box where the distance between any atom of the solute
molecule(s) and any atom of the solvent molecule is less than the sum of the
scaled van der Waals radii of both atoms. A database (vdwradii.dat) of van der
Waals radii is read by the program, and the resulting radii scaled by -scale.
If radii are not found in the database, those atoms are assigned the
(pre-scaled) distance -radius. Note that the usefulness of those radii depends
on the atom names, and thus varies widely with force field.

The default solvent is Simple Point Charge water (SPC), with coordinates from
$GMXLIB/spc216.gro. These coordinates can also be used for other 3-site water
models, since a short equibilibration will remove the small differences
between the models. Other solvents are also supported, as well as mixed
solvents. The only restriction to solvent types is that a solvent molecule
consists of exactly one residue. The residue information in the coordinate
files is used, and should therefore be more or less consistent. In practice
this means that two subsequent solvent molecules in the solvent coordinate
file should have different residue number. The box of solute is built by
stacking the coordinates read from the coordinate file. This means that these
coordinates should be equlibrated in periodic boundary conditions to ensure a
good alignment of molecules on the stacking interfaces. The -maxsol option
simply adds only the first -maxsol solvent molecules and leaves out the rest
that would have fitted into the box. This can create a void that can cause
problems later. Choose your volume wisely.

Setting -shell larger than zero will place a layer of water of the specified
thickness (nm) around the solute. Hint: it is a good idea to put the protein
in the center of a box first (using gmx editconf).

Finally, gmx solvate will optionally remove lines from your topology file in
which a number of solvent molecules is already added, and adds a line with the
total number of solvent molecules in your coordinate file.

OPTIONS

Options to specify input files:

 -cp     [<.gro/.g96/...>]  (protein.gro)    (Opt.)
           Structure file: gro g96 pdb brk ent esp tpr
 -cs     [<.gro/.g96/...>]  (spc216.gro)     (Lib.)
           Structure file: gro g96 pdb brk ent esp tpr

Options to specify input/output files:

 -p      [<.top>]           (topol.top)      (Opt.)
           Topology file

Options to specify output files:

 -o      [<.gro/.g96/...>]  (out.gro)
           Structure file: gro g96 pdb brk ent esp

Other options:

 -box    <vector>           (0 0 0)
           Box size (in nm)
 -radius <real>             (0.105)
           Default van der Waals distance
 -scale  <real>             (0.57)
           Scale factor to multiply Van der Waals radii from the database in
           share/gromacs/top/vdwradii.dat. The default value of 0.57 yields
           density close to 1000 g/l for proteins in water.
 -shell  <real>             (0)
           Thickness of optional water layer around solute
 -maxsol <int>              (0)
           Maximum number of solvent molecules to add if they fit in the box.
           If zero (default) this is ignored
 -[no]vel                   (no)
           Keep velocities from input solute and solvent

KNOWN ISSUES

* Molecules must be whole in the initial configurations.
```

## gromacs_genion

### Tool Description
Generate monoatomic ions: replaces solvent molecules by ions.

### Metadata
- **Docker Image**: quay.io/biocontainers/gromacs:2022
- **Homepage**: https://www.gromacs.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/gromacs/overview
- **Validation**: PASS

### Original Help Text
```text
:-) GROMACS - gmx help, 2022-conda_forge (-:

Executable:   /usr/local/bin.AVX2_256/gmx
Data prefix:  /usr/local
Working dir:  /
Command line:
  gmx help genion

GROMACS reminds you: "It Doesn't Seem Right, No Computers in Sight" (Faun Fables)

SYNOPSIS

gmx genion [-s [<.tpr>]] [-n [<.ndx>]] [-p [<.top>]] [-o [<.gro/.g96/...>]]
           [-np <int>] [-pname <string>] [-pq <int>] [-nn <int>]
           [-nname <string>] [-nq <int>] [-rmin <real>] [-seed <int>]
           [-conc <real>] [-[no]neutral]

DESCRIPTION

gmx genion randomly replaces solvent molecules with monoatomic ions. The group
of solvent molecules should be continuous and all molecules should have the
same number of atoms. The user should add the ion molecules to the topology
file or use the -p option to automatically modify the topology.

The ion molecule type, residue and atom names in all force fields are the
capitalized element names without sign. This molecule name should be given
with -pname or -nname, and the [molecules] section of your topology updated
accordingly, either by hand or with -p. Do not use an atom name instead!

Ions which can have multiple charge states get the multiplicity added, without
sign, for the uncommon states only.

For larger ions, e.g. sulfate we recommended using gmx insert-molecules.

OPTIONS

Options to specify input files:

 -s      [<.tpr>]           (topol.tpr)
           Portable xdr run input file
 -n      [<.ndx>]           (index.ndx)      (Opt.)
           Index file

Options to specify input/output files:

 -p      [<.top>]           (topol.top)      (Opt.)
           Topology file

Options to specify output files:

 -o      [<.gro/.g96/...>]  (out.gro)
           Structure file: gro g96 pdb brk ent esp

Other options:

 -np     <int>              (0)
           Number of positive ions
 -pname  <string>           (NA)
           Name of the positive ion
 -pq     <int>              (1)
           Charge of the positive ion
 -nn     <int>              (0)
           Number of negative ions
 -nname  <string>           (CL)
           Name of the negative ion
 -nq     <int>              (-1)
           Charge of the negative ion
 -rmin   <real>             (0.6)
           Minimum distance between ions and non-solvent
 -seed   <int>              (0)
           Seed for random number generator (0 means generate)
 -conc   <real>             (0)
           Specify salt concentration (mol/liter). This will add sufficient
           ions to reach up to the specified concentration as computed from
           the volume of the cell in the input .tpr file. Overrides the -np
           and -nn options.
 -[no]neutral               (no)
           This option will add enough ions to neutralize the system. These
           ions are added on top of those specified with -np/-nn or -conc.

KNOWN ISSUES

* If you specify a salt concentration existing ions are not taken into
  account. In effect you therefore specify the amount of salt to be added.
```


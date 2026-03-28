[![haconLab](https://chaconlab.org/images/favicon.png)](/)haconLab

* [Home](/)
* [People](/people)
* [Publications](/publications)
* [Research](/research)
* [Tools](/methods-bioinformatics-tools)
* [Servers](/servers)
* [Download](/downloads)
* [Contact](/contact)

Search

Here we give a brief overview of the necessary commands to use iMOD, but we strongly encourage to follow the tutorials. Right now, there are three different executables:

* [iMODE](#iMODE) to obtain IC Normal Modes.
* [iMOVE](#iMOVE) to animate IC Normal Modes.
* [iMODVIEW](#iMODVIEW) to visualize Normal Modes.
* [iMC](#iMC) to perform a Monte-Carlo simulation.
* [iMORPH](#iMORPH) to perform Morphing.

This user guide describes the usage of these iMOD components.

**iMODE - obtaining IC Normal Modes**

---

To obtain the IC modes, enter the following command at the prompt.

imode <pdb>

where:

|  |  |
| --- | --- |
| pdb | PDB input file (required) |

The default output is:

* *imode.log* --> Log-file.
* *imode\_model.pdb* --> Used PDB model.
* ***imode\_ic.evec*** --> IC Normal modes file.

To enable deformability computations use the −d option. In this case, additional files will be saved:

* *imode\_def.pdb* --> PDB file with deformability data in B-factor column.
* *imode\_mob.pdb* --> PDB file with mobility data in B-factor column.
* *imode\_defmob.txt* --> Plain text file with deformabiliy, mobility and B-factor data.

Basic Options

---

 In this section, the basic options to customize the IC modes generation are detailed. Just add them after the minimum command shown above.

|  |  |
| --- | --- |
| −h | Displays usage information and exits. |
| −m <int> | Coarse-Grained model: 0=CA, 1=C5, 2=Heavy-Atom (default=2). |
| −o <string> | Output files basename (default=imode). |
| -d | Turn on deformability calculations (default=disabled). |
| -r <float> | Randomly fixed ratio of Dihedral Coordinates (default=disabled).  Example: 0.7 = 70% of dihedrals will be randomly removed.  Rotational/translational coordinates always mobile. |
| -f <string> | ASCII file defining the ICs to be fixed with the format:  Protein: "n phi chi psi"  NAcid: "n alpha beta gamma chi epsilon zeta"  Inter-chain: "n 6D"  Where "n" is the residue index (0,1,..) and the coordinate name (phi, psi, etc...) can be set to 0(fixed) or 1(mobile). Each one of the 6 inter-chain variables should be specified on separate lines in the following order: x,y,z,Rx,Ry,Rz. Note "n" is just the sequential residue index (starting with 0) and NOT the PDB's residue index.  A demo file can be generated using the --save\_fixfile option. |
| -P <int> | Pairwise interaction potential: (default=0)  0= Sigmoid function (= k/(1+(x/x0)^p), if x < c, else k=0).  1= Tirion's cutoff (= k, if x < c, else k=0).  2= Hinsen's function.  3= Topology & Secondary Structure (--func is mandatory).  4= edNMA formalism (CA-model only).  By default an extra torsional potential will be added. |
| -K <string> | Force constants ASCII file with 3 cols.:   Where  *are the corresponding atomic indices (1,2,...)  A demo file can be generated using --save\_Kfile option.* |
| -n <int/float> | Used modes range, either number [1,N] <integer>, or ratio [0,1) <float> (default=20). |
| -x | Considers first CHI dihedral angle (default=disabled). |
| -S <string> | All dihedral coordinates with a given secondary structure (SS) will be removed (see --ss).  Example: "HE" will fix the dihedrals corresponding to alpha-helices and beta-sheets. |

Advanced options

---

Only for real expert users!

```
   --ss <string>
      Secondary Structure ASCII file with 2 cols.: <n> <char>
     Where <n> is the corresponding residue index (0,1,...), and <char> is
     the single character SS identifier. By default SS will be computed
     internally (H=helix, E=strand, C=coil).
   --save_fixfile
      Save fixation file as <basename.fix> (to be used with -r or -S
     options; otherwise a fully mobile file will be generated)
     (default=disabled).
   --save_cart
      Save Cartesian modes as <basename_cart.evec> (default=disabled)
   --save_wcart
      Save Mass-weighted Cartesian modes as <basename_wcart.evec>
     (default=disabled).
   --save_Kfile
      Save atom-pairwise force constants file as <basename_Kfile.dat> (to
     be used with -K option) (default=disabled).
   --save_SSfile
      Save secondary structure file as <basename.ss> (to be used with -S or
     -P=2 options) (default=disabled).
   --save_covar
      Saves the predicted covariance matrix at selected Temperature in
     binary packed storage format as <basename_covar.evec>. If --save_wcart
     selected, then mass-weighted covariance matrix will be computed
     instead (default=disabled).
   --k0_c <float>
      Sigmoid function distance cutoff (default=10A).
   --k0_k <float>
      Sigmoid function stiffness constant (default=1.0).
   --k0_x0 <float>
      Sigmoid function inflexion point (default=3.8A).
   --k0_p <float>
      Sigmoid function power term (default=6).
   --k1_c <float>
      Tirion's method distance cutoff (default=10A).
   --k1_k <float>
      Tirion's method stiffness constant (default=1.0).
   --k2_c <float>
      Non-bonding distance cutoff applied to --func option (default=10A).
   --nomodel
      Disables PDB model building. Warning: introduced PDB model must match
     the CG selected with the -m option (default=disabled).
   --nomass
      Disables mass weighting (default=disabled).
   --notors
      Disables extra torsional potential (default=disabled).
   --norm
      Enables (norm=1) eigenvector normalization. Note this does not change
     vector direction (default=disabled).
   --func <string>
      ASCII file defining the force constant functions to be applied
     according to Topology and/or Secondary Structure. The 5 cols. format
     is: <SS> <t> <k> <x0> <pow>
     Where <SS> is the two character pairwise interaction identifier, <t>
     is the topology, and <k>,<x0>,<pow> are the corresponding sigmoid
     function parameters (see -P option). If --ss is not specified, the XX
     pairwise interaction identifier must be introduced. This way, only
     topologies will be considered. If <t> is "-1", any previously
     not-matched topology will be considered.
   --model_out <int>
      Output Coarse-Graining model: 0=CA, 1=C5, 2=Heavy-Atom
     (default=disabled).
   --chi_out
      Considers first CHI dihedral angle in output modes
     (default=disabled).
   --save_covar_out
      Computes and Saves the predicted covariance matrix for the output
     model at selected Temperature in binary packed storage format as
     <basename_covarf.evec>. If --save_wcart selected, then mass-weighted
     covariance matrix will be computed instead (default=disabled).
   -T <double>,  --temperature <double>
      Temperature [K] for covariance matrix computation (default=300).
   --seed <unsigned>
      Pre-define the random number generator SEED (Mersenne Twister)
     (default=random-seed from /dev/urandom)
   --verb <int>
      Verbose level (0=low, 1=medium, 2=high) (default=0).
   --,  --ignore_rest
      Ignores the rest of the labeled arguments following this flag.
   -v,  --version
      Displays version information and exits.
   -h,  --help
      Displays usage information and exits.
```

**iMOVE - animating IC normal modes**

---

To show the vibrational motion of a given mode, just enter the following command at the prompt:

imove <in\_pdb> <ptraj> <out\_pdb> <int>

where:

|  |  |
| --- | --- |
| <in\_pdb> | PDB input file. (required) |
| <ptraj> | Normal Modes input file name (.evec). (required) |
| <out\_pdb> | Output Multi-PDB file. (required) |
| <int> | Mode number to be moved (1,2,...,size). (required) |

The unique output is the Multi-PDB file named <out\_pdb>

Basic Options

---

In this section, the basic options to customize animations are detailed.

|  |  |
| --- | --- |
| −h | Displays usage information and exits. |
| −m <int> | Coarse-Graining model: 0=CA, 1=C5, 2=Heavy-Atom, 3=NCAC, 4=CA-only (default=2). |
| −x | Considers first CHI dihedral angle (default=disabled). |
| −c <int> | Number of conformations generated (default=11). It should be an odd number! |
| −a <float> | Amplitude linear factor to scale motion (default=2). |
| −T <float> | Temperature [K] (default=300). |
| −f <string> | Input ASCII file defining the ICs that were fixed during NMA (default=disabled). If modes were computed removing arbitrary ICs, the user must introduce here the file generated by iMode's --save\_fixfile option. |

Advanced options

---

Only for real expert users!

```
   --cart
      Mandatory if Cartesian modes are supplied, otherwise moving in
     Internal Coordinates (default=disabled).
   --model_out <int>
      Output Coarse-Graining model: 0=CA, 1=C5, 2=Heavy-Atom. The default
     output model will be that selected with the -m option.
   --linear
      Enables linear motion instead of sinusoidal bounce
     (default=disabled).
   --mov <int>
      Motion Type (default=2): 0=K-matrix, 1=V/W-arrays, 2=Simple-Rotations
     , 3=Linear (if Cartesian modes).
   --chi_out
      Considers first CHI dihedral angle in output models
     (default=disabled) (DEVELOPER's).
   --fixIC <string>
      Plain-text file defining the fixed Internal Coordinates. Each line
     will contain the index (0,1,...) of the ICs to be removed
     (DEVELOPER's).
   --,  --ignore_rest
      Ignores the rest of the labeled arguments following this flag.
   -v,  --version
      Displays version information and exits.
```

**iMODVIEW - normal modes visualization**

---

An alternative way to visualize a normal mode motion is the arrow representation. To this end type at the prompt:

imodview <pdb> <ptraj/Kfile> <filename>

where:

|  |  |
| --- | --- |
| <pdb> | PDB input file. Warning: This model must match exactly the one used in modes computation. (required) |
| <ptraj/Kfile> | Input eigenvectors file (ptraj). Warning: Only Cartesian modes allowed. |
| <filename> | Output VMD file. (required) |

The unique output file (<filename>) can be loaded into VMD using the following command in VMD's terminal:

```
source <filename>
```

Basic Options

---

In this section, the basic options to customize mode visualization are detailed.

|  |  |
| --- | --- |
| −h | Displays usage information and exits. |
| −n <int> | Normal Mode index (1,2,...,size) (default=1) |

Advanced options

---

Only for real expert users!

```
   --color <string>
      Set color. All VMD colors available (default=white).
   --op <int>>
      Sets the operation method, 1=arrows, 2=springs (default=1).
   --max <float>>
      Maximum arrow length [A] (default=10).
   --thick <float>
      Arrow/spring thickness factor (default=0.05).
   --level <int>
      Sets the averaging level to compute arrows, 0=atoms, 1=residues,
     2=segments, 3=chains (default=0).
   --pthr <float>
      Minimum percentual amplitude (from maximum) to show arrows
     (default=0, all arrows).
   --kthr <float>
      Only those springs with force constants above this threshold will be
     shown (default=disabled).
   --kthr2 <float>
      Only those springs with force constants below this threshold will be
     shown (default=disabled).
   --,  --ignore_rest
      Ignores the rest of the labeled arguments following this flag.
   -v,  --version
      Displays version information and exits.

```

**iMC - performing Monte-Carlo simulations.**

---

To carry out a basic Monte-Carlo simulation, enter the following command at the prompt:

imc <pdb> <ptraj>

where:

|  |  |
| --- | --- |
| <pdb> | PDB input file. (required) |
| <ptraj> | Normal modes input file (.evec), either from NMA or PCA. (required) |

The default output trajectory will be named **imc.pdb**

Basic Options

---

In this section, the basic options to customize trajectories are detailed.

|  |  |
| --- | --- |
| −h | Displays usage information and exits |
| −m <int> | Input Coarse-Graining model: 0=CA, 1=C5, 2=Heavy-Atom (default=2). |
| −o <string> | Output files basename. (default=imc) |
| −f <string> | Input ASCII file defining the ICs that were fixed during NMA (default=disabled). If modes were computed removing arbitrary ICs, the user must introduce here the file generated by iMode's --save\_fixfile option. |
| −p <int> | Finds the optimal energy/stiffness scaling factor to obtain the desired average RMSD (Å) from the initial model (default=disabled). |
| −−Rg <float> | Filter models by target radius of gyration (default=disabled). |
| −n <int> | Number of eigenvectors to be employed, either number [1,N] <integer>, or ratio from maximum available [0,1) <float> (default=5). |
| −c <int> | Number of output conformations (default= 100). |
| −E <float> | Energy/Stiffness scaling factor (mode energy will be multiplied by this value) (default=1.0). |
| −i <int> | Number of MC iterations per output structure (default=1000). |
| −x | Considers first CHI dihedral angle (default=disabled). |
| −T <float> | Temperature [K] (default=300). |
| −a <float> | Amplitude linear factor to scale motion (default=1). |

Advanced options

---

Only for real expert users!

```
   --thr <float>
      Enable filtering by absolute tolerance (default=disabled).
   --Rmsd <float>
      Filter models by target RMSD (default=disabled).
   --otraj <int>
      Output trajectory format: 0-Normal-Mode, 1-Multi-PDB, 2-AMBER
     (default=1).
   --cart
      Mandatory if Cartesian modes are supplied, otherwise moving in
     Internal Coordinates (default=disabled).
   --seed <unsigned int>
      Set the random number generator SEED (Mersenne Twister)
     (default=random-seed from /dev/urandom).
   --include_first
      Includes input model as first frame in the Multi-PDB trajectory
     (default=disabled).
   --var
      Input eigenvalues will be considered as variance (pca), otherwise the
     will be force constants (nma) (default=false).
   --unweight
      Un-mass-weights the input vectors (default=false). The Mass-weighted
     modes (wcart) will be converted into Cartesian coordiantes (cart)
     (DEVELOPER's).
   --optf <float>
      Factor to scale the optimal energy/stiffness factor
     (default=disabled) (DEVELOPER's).
   --rfact <float>
      Agressivity factor (default=7.778) (DEVELOPER's).
   --mov <int>
      Motion Type (default=2): 0=K-matrix, 1=V/W-arrays, 2=Simple-Rotations
     , 3=Linear (if Cartesian modes) (DEVELOPER's).
   --fixIC <string>
      Plain-text file defining the fixed Internal Coordinates. Each line
     will contain the index (0,1,...) of the ICs to be removed
     (DEVELOPER's).
   --verb
      Enables verbose.
   --,  --ignore_rest
      Ignores the rest of the labeled arguments following this flag.
   -v,  --version
      Displays version information and exits.
```

**iMORPH - performing Morphing**

---

To generate a plausible continuous trajectory between two given conformations enter the following command at the prompt.

imorph <initial\_pdb
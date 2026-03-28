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

The iMOD Tutorial is a practical guide for researchers who want to perform NMA in Internal Coordinates to explore feasible conformations of protein and nucleic acids. We included four small tutorials with basic instructions for:

* [**iMODE** Performing NMA in IC](#Tuto_iMode)
* [**iMOVE** Animating modes](#Tuto_iMove)
* [**iMODVIEW** Visualizing modes](#Tuto_iModview)
* [**iMC**      Monte-Carlo in IC modal space](#Tuto_iMC)
* [**iMORPH**  Morphing](#Tuto_iMorph)

We will use the structure of the ribosomal RNA binding protein S15 (1ab3, cyan) to illustrate a simple NMA calculation

|  |
| --- |
| [![](/images/sbg/imod/1ab3b_320.jpg "Ribosomal RNA binding protein S15 (1ab3) (Click to enlarge)")](/images/sbg/imod/1ab3b_640.jpg) |

In the [Download](/component/zoo/category/?Itemid=248) section you can be found all the binaries and example files to complete the tutorial. Please, uncompress and untar the corresponding tutorial file. You will have all the necessary files to follow the tutoriales. We recommend to create a new working directory, so all the output files will be stored on it.

**1) Performing NMA in IC.**

---

To compute the normal modes of a macromolecule, only the protein or nucleic acid structure is required in PDB format:

imode 1ab3.pdb

Please, ensure that input coordinates conform PDB format. The presence of all heavy atoms is mandatory; so be aware of missing atoms, alternative conformations, bad placed atoms and a long etc... that can eventually jeopardize your results. Use your favorite PDB checker to anticipate and fix any PDB error. We typically employ [Molprobity](http://molprobity.biochem.duke.edu/) (online), [pdb2pqr](http://pdb2pqr.sourceforge.net/) (e.g. pdb2pqr file.pdb --ff=CHARMM ), profix from [Jackal](http://wiki.c2b2.columbia.edu/honiglab_public/index.php/Software%3AJackal) package or a combination of them.

Here is the screen output:

```
imode>
imode> Welcome to the NMA in Internal Coordinates tool v1.10
imode>
imode> Reading PDB file: 1ab3.pdb
molinf> Protein   1 chain  1   segment  1 residues: 88 atoms: 744
molinf> SUMMARY:
molinf> Number of Molecules ... 1
molinf> Number of Chain ....... 1
molinf> Number of Segments .... 1
molinf> Number of Groups ...... 88
molinf> Number of Atoms ....... 744
molinf>
imode> Coarse-Graining model: Full-Atom (no coarse-graining)
imode> Selected model residues: 88
imode> Selected model (pseudo)atoms: 744
imode> Number of Dihedral angles: 174
imode> Number of Inter-segment coords: 0 (Rot+Trans)
imode> Number of Internal Coordinates: 174 (Hessian rank)
imode> Range of computed modes: 1-20
imode> Creating pairwise interaction potential:
imode> Inverse Exponential (38974 nipas) cutoff= 10.0, k= 1.000000, x0= 3.8
imode> Packed-Hessian/Kinetic matrices mem.= 0.122 Mb (rank= 174)
imode> Fast Hessian Matrix Building O(n^2) 0.01 sec
imode> Fast Kinetic-Energy matrix Building O(n^2) 0.00 sec
imode> Eigenvector matrix mem. = 0.028 Mb
imode> Diagonalization with XSPGVX()... 0.25 sec
imode> Showing the first 10 eigenvalues:
imode>
imode> MODE   EIGENVALUE
imode>    1  4.88224e-04
imode>    2  8.38843e-04
imode>    3  1.45977e-03
imode>    4  1.94916e-03
imode>    5  2.10617e-03
imode>    6  3.41256e-03
imode>    7  3.54337e-03
imode>    8  4.74782e-03
imode>    9  5.23973e-03
imode>   10  6.38150e-03
imode>
imode>
imode> SAVED FILES:
imode> Log file:                                                      imode.log
imode> Model PDB:                                               imode_model.pdb
imode> ICS eigenvectors:                                          imode_ic.evec
imode>
imode> Bye!
```

By default, it saves the following files:

* *imode.log* --> Log-file.
* *imode\_model.pdb* --> Used PDB model.
* *imode\_ic.evec* --> Normal modes file.

With the normal modes files (eigenvectors and eigenvalues) you can either animate them to see how they look or perform a MC simulation. See next sections for details.

**2) Animating modes.**

---

Once the modes were computed (iMODE), we are ready to see how is the motion that they describe. To animate the first mode (number 1)  type at the command prompt:

imove imode\_model.pdb imode\_ic.evec imove\_1.pdb 1

Here is the screen output:

```
imove>
imove> Welcome to the Internal Coordinates Motion Tool  v1.07
imove>
imove> Input PDB-file imode_model.pdb
imove> Multi-PDB output file imove_1.pdb
imove> Number of frames to be generated 11
imove> Normal Mode choosen 1
imove> Reading PDB file imode_model.pdb
imove> Formatting residues names
imove> Coarse-Graining model: Full-Atom (no coarse-graining)
imove> Selected model number of residues: 88
imove> Selected model number of (pseudo)atoms: 744
imove> Ptraj info: imode_ic.evec  vectors=20  components=174
imove> Maximum internal coordinate displacement: 156.272797
imove> Dihedral coordinates found = 174
imove> Internal coordinates found (size) = 174
imove> Moving analiticaly (moving internal coordinates)
imove> Added frame    -5 to Multi-PDB
imove> Added frame    -4 to Multi-PDB
imove> Added frame    -3 to Multi-PDB
imove> Added frame    -2 to Multi-PDB
imove> Added frame    -1 to Multi-PDB
imove> Added frame     0 to Multi-PDB <-- 1st model (imode_model.pdb)
imove> Added frame     1 to Multi-PDB
imove> Added frame     2 to Multi-PDB
imove> Added frame     3 to Multi-PDB
imove> Added frame     4 to Multi-PDB
imove> Added frame     5 to Multi-PDB
imove>
imove> Success!
imove> Written movie: imove_1.pdb (11 frames)
imove> Bye!
```

The program output is a Multi-PDB file named: *imove\_1.pdb*, with 11 MODELs. The motion is represented by equally spaced snapshots going from the negative end (MODEL -5) to the positive end (MODEL 5). The initial structure is the middle model (MODEL 0).

Below, you can see how the two lowest energy modes look like, either by clicking [![](/images/sbg/jmol_icon.bmp) mode1](http://chaconlab.org/ "Click here to view in Jmol") and [![](/images/sbg/jmol_icon.bmp) mode2](http://chaconlab.org/ "Click here to view in Jmol"), or watching the corresponding flash movies.

|  |  |
| --- | --- |
| Your browser does not support HTML5 video. | Your browser does not support HTML5 video. |

By default, the amplitude (−a option) is set to twice its thermodynamic value predicted at room temperature (300K). Since true motion amplitude is unknown we encourage you to test different values in order to get the desired appearance. Also the number of modes is a interesting variable to investigate. In Lopez-Blanco et al. we found nice results with Cα and ED potential with default amplitude and number of modes. However, remember that iMC is a **proof of concept sampling procedure** and not ball-proof conformation ensemble generator, therefore you need to parametrize a bit the input variables. To this respect, any experimental evidence (Rg, distance constraints, etc. ) will be very helpful.

More modes can be observed clicking the following links: [![](/images/sbg/jmol_icon.bmp) Mode3](http://chaconlab.org/ "Click here to view in Jmol"), [![](/images/sbg/jmol_icon.bmp) Mode5](http://chaconlab.org/ "Click here to view in Jmol"), [![](/images/sbg/jmol_icon.bmp) Mode10](http://chaconlab.org/ "Click here to view in Jmol") and [![](/images/sbg/jmol_icon.bmp) Mode20](http://chaconlab.org/ "Click here to view in Jmol").

**3) Visualizing modes**

---

Any normal mode can be depicted as a 3D vector set. Each of them representing the relative atomic motion. The following command visualizes the first normal mode using red arrows. Note any VMD color can be used instead.

imodview 1ab3\_model.pdb imode\_cart.evec 1ab3\_1.vmd -n 1 -c red

The unique output file ***1ab3\_1.vmd*** can be loaded into VMD using the following command in VMD's terminal:

vmd>    cd <work\_directory>
vmd>    source <out\_vmd>

Since iMODVIEW only plots Cartesian normal modes, the use of --save\_cart option in iMODE is mandatory. This way, an additional file with the Cartesian space modes will be generated: ***imode\_cart.evec***

In addition, the averaged displacement vectors can be computed at several graining levels. To compute the average displacement over each atom (0), residue (1), segment (2) or chain (3), use the --level option followed by the corresponding number between brackets. Vectors will be located on the geometric center of averaged atoms. For example, the following command will compute the average displacement vectors over all residue atoms.

imodview 1ab3\_model.pdb imode\_cart.evec 1ab3\_1b.vmd -n 1 -c red --level 1

Below you can check previous commands results, for atomic and residue levels (left and right, respectively).

|  |  |
| --- | --- |
| [![](/images/sbg/imod/1ab3_arrows0_1_320.jpg "atom level (Click to enlarge)")](/images/sbg/imod/1ab3_arrows0_1_640.jpg) | [![](/images/sbg/imod/1ab3_arrows1_1_320.jpg "residue level (Click to enlarge)")](/images/sbg/imod/1ab3_arrows1_1_640.jpg) |

In addition, iMODVIEW can represent the spring network using straight segments. Their thickness will be proportional to their force constant (it can be adjusted using the --thick option).

imodview 1ab3\_model.pdb 1ab3\_Kfile.dat 1ab3\_springs.vmd -c red --op 2

This command will depict all available springs in force constants file. Also, you can adjust the range of plotted springs adding the --kthr and --kthr2 options to the basic command. For example:

imodview 1ab3\_model.pdb 1ab3\_Kfile.dat 1ab3\_springs2.vmd -c red --op 2 --kthr 0.5

In this case, only those springs with force constants above 0.5 will be represented. Results obtained from previous commands are shown below.

|  |  |
| --- | --- |
| [![](/images/sbg/imod/1ab3_springs_320.jpg "All springs (Click to enlarge)")](/images/sbg/imod/1ab3_springs_640.jpg) | [![](/images/sbg/imod/1ab3_springs2_320.jpg "Springs range (Click to enlarge)")](/images/sbg/imod/1ab3_springs2_640.jpg) |

**4) Monte-Carlo in IC modal space.**

---

Once the modes are computed (iMODE) a MC trajectory can be obtained easily typing at the command prompt:

imc 1ab3.pdb imode\_ic.evec

Here is the screen output:

```
imc>
imc> Mon's Monte-Carlo NMA-based trajectory program v1.07 (ADP-Platform)
imc>
imc> Reading Input PDB file
molinf> Protein   1 chain  1   segment  1 residues: 88 atoms: 744
molinf> SUMMARY:
molinf> Number of Molecules ... 1
molinf> Number of Chain ....... 1
molinf> Number of Segments .... 1
molinf> Number of Groups ...... 88
molinf> Number of Atoms ....... 744
molinf>
imc> Coarse-Graining model: Full-Atom (no coarse-graining)
imc> Selected model number of (pseudo)atoms: 744
imc> Opening output trajectory file: imc.pdb
imc> Dihedral coordinates found = 174
imc> Internal coordinates found (size) = 174
imc> Ptraj info: imode_ic.evec  vectors=20  components=174
imc> Number of used modes: 20
imc> ACEPTANCE RATIO(%): 40.319000
imc>
imc> Success!
imc> Written MC-trajectory: imc.pdb (100 frames)
imc> Bye!
```

The resulting Multi-PDB with the MC trajectory is: ***imc.pdb***. The MC flash movie can be watched below; in addition you can see it in Jmol by following this link: [![](/images/sbg/jmol_icon.bmp) MC trajectory](http://chaconlab.org/ "Click here to view in Jmol").

|  |
| --- |
| Your browser does not support HTML5 video. |

**5) Morphing in IC modal space.**

---

To illustrate the basic procedure and the method performance, we are going to morph the GroEL monomer in an open state (1aon, cyan) into the closed structure (1oel, yellow).

|  |  |  |
| --- | --- | --- |
| [![](/images/sbg/imod/1aon_1oel_initial_320c.jpg "GroEL open (1aon)  										(Click to enlarge)")](/images/sbg/imod/1aon_1oel_initial_640.jpg) | M O R P H I N G   open-->closed | [![](/images/sbg/imod/1oel_yellow_320c.jpg "GroEL closed (1oel) (Click to enlarge)")](/images/sbg/imod/1oel_yellow_640.jpg) |

The required input is minimal, just two protein or nucleic acid PDB structures with the same atoms. Input coordinates should conform to PDB format. Given the use of Internal Coordinates the presence of all heavy atoms is mandatory; so be aware of missing atoms, alternative conformations, bad placed atoms and a long etc... that can eventually jeopardize your results. Use your favorite PDB checker to anticipate and fix any PDB error. We typically employ [Molprobity](http://molprobity.biochem.duke.edu/) (online), [pdb2pqr](http://pdb2pqr.sourceforge.net/) (e.g. pdb2pqr file.pdb --ff=CHARMM ), profix from [Jackal](http://wiki.c2b2.columbia.edu/honiglab_public/index.php/Software%3AJackal) package or a combination of them.

To perform the morphing just prompt:

imorph 1aon.pdb 1oel.pdb

Here is the screen output:

```
imorph>
imorph> Welcome to iMORPH v1.27
imorph>
imorph> Model PDB file: 1aon.pdb
molinf> Protein   1 chain  1   segment  1 residues: 524 atoms: 3847
molinf> SUMMARY:
molinf> Number of Molecules ... 1
molinf> Number of Chain ....... 1
molinf> Number of Segments .... 1
molinf> Number of Groups ...... 524
molinf> Number of Atoms ....... 3847
molinf>
imorph> Coarse-Graining model: Full-Atom (no coarse-graining)
imorph> Selected model number of residues: 524
imorph> Selected model number of (pseudo)atoms: 3847
imorph> Target PDB file: 1oel.pdb
imorph> Number of Inter-segment coords: 0 (Rot+Trans)
imorph> Number of Internal Coordinates: 1033 (Hessian rank)
imorph> Range of used modes: 1-206 (19.9%)
imorph> Number of excited/selected modes: 4(nex)
imorph>
imorph>  Iter      RMSD  RMSD(CA) NMA   NMA_time
imorph>     0 16.434504 16.013224   0       none
imorph>    53 15.610546 15.202492   1   3.74 sec
................................................
imorph>  1858  3.092514  2.640378  16   3.99 sec
imorph>  2631  2.268762  1.699723  17   4.60 sec
imorph> 10000  1.808299  1.151047            END
imorph>
imorph> Movie file:                            1aon_1oel_movie.pdb
imorph> Score file:                            1aon_1oel_score.txt
imorph> Log file:                                    1aon_1oel.log
imorph>
imorph> Success! Time elapsed 136.000
imorph> Bye!
```

By default, it saves the following files:

* *imorph.log* --> used command and parameters log
* *imorph\_score.txt* --> score file to check for convergence
* *imorph\_movie.pdb* --> morphing trajectory Multi-PDB

Below some morphing snapshots (cyan) are represented simultaneously with the target structure (yellow):

|  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- |
| [![](/images/sbg/imod/1aon_1oel_motion_320c.jpg "Initial Model (Click to enlarge)")](/images/sbg/imod/1aon_1oel_motion_640.jpg) | [![](/images/sbg/imod/1aon_1oel_s12b_320c.jpg "Intermediate Model (Click to enlarge)")](/images/sbg/imod/1aon_1oel_s12b_640.jpg) | [![](/images/sbg/imod/1aon_1oel_s29b_320c.jpg "Intermediate Model (Click to enlarge)")](/images/sbg/imod/1aon_1oel_s29b_640.jpg) | [![](/i
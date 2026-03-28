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

# **How are defined Coarse Grained (CG) levels?**

|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| The Coarse Graining model representation determines both the system mass distribution and the springs network. The available Coarse-Graining models for **proteins** are listed below:  |  |  | | --- | --- | | **Cα** (−m 0)  Only Cα atoms accounting for whole residue mase are considered.This CG model has two extra atoms per chain, one N atom at the begining and one C atom at the ending. | ![](/images/sbg/imod/CA_modelR_320.jpg) | | **3BB2R** (−m 1)  There are five atoms per residue. Three representing the backbone: N, Cα and carbonylic C; and two representing the side chains: Cβ and a pseudo-atom (R) placed on the center of mass of the remaining side chain atoms. Note that Glycine and Alanine will be modeled by 3 and 4 atoms, respectively. | ![](/images/sbg/imod/3BB2R_modelR_320.jpg) | | **Full-atom** (−m 2, ***default***)  All heavy atoms are considered, each one accounting for its own mass. | ![](/images/sbg/imod/Fullatom_modelR_320.jpg) |  Next figures illustrate the appearance of the Cα and 3BB2R CG models:  |  |  | | --- | --- | | **Cα-model** | **3BB2R-model** | | ![](/images/sbg/imod/1ab3CA_320.jpg) | ![](/images/sbg/imod/1ab33BB2R_320.jpg) |  On the left model only Cα atoms (yellow) are considered. On the right, the 3BB2R model (right) have five atoms per residue: three representing the backbone (N, Cα and carbonylic C, in blue, yellow and cyan, respectively), and two representing the side chains (Cβ and a pseudo-atom placed on the center of mass of the remaining side chain, in cyan and red, respectively).  At this moment, only the Full-atom representation is available for **nucleic acids**:  |  |  | | --- | --- | | **RNA** | **DNA** | | ![](/images/sbg/imod/RNA_model_320.jpg) | ![](/images/sbg/imod/DNA_model_320.jpg) | |

# **How to use CG models?**

To illustrate the usage of different CG models lets try the following examples:

* [Computing modes at different CG levels.](#iMODE_CG)
* [Monte-Carlo at different CG levels.](#iMC_CG)

  --------------- Computing desired Normal Modes in different CG models. ---------------

To choose the desired CG model -m option must be added to the basic command followed by model identifier. The basename option (-o) will be used to avoid overwriting of previous re.

Ca       -> imode 1ab3.pdb -m 0 -o imodeCA
3BB2R-> imode 1ab3.pdb -m 1 -o imode3BB2R

You can check the CG models using Jmol: [![](/images/sbg/jmol_icon.bmp) Ca model](http://chaconlab.org/ "Click here to view in Jmol") and [![](/images/sbg/jmol_icon.bmp) 3BB2R model](http://chaconlab.org/ "Click here to view in Jmol").

In **Ca** case, an extra file is produced: **imodeCA\_ncac.pdb**. This PDB file is just a standard PDB containing the coordinates of backbone nitrogen (N), and alpha (Ca) and carbonylic carbons (C), i.e. those atoms needed to define the f and ? dihedral angles. This is the **minimum required structure to use our Ca model**. A structure with only Ca atoms will not work. In this case, an external software to generate backbone N and C atoms is mandatory. For example, you can use the on-line server: [SABBAC](http://bioserv.rpbs.univ-paris-diderot.fr/cgi-bin/SABBAC).

To animate this modes, the CG model introduced to iMOVE should be the same used in iMODE:

Ca       -> imove imodeCA\_ncac.pdb imodeCA\_ic.evec imoveCA\_1.pdb 1 -m 0 -a 0.4
3BB2R-> imove 1ab3.pdb imode3BB2R\_ic.evec imove3BB2R\_1.pdb 1 -m 1

In Ca case there are less springs than in full-atom. Thus, the amplitude was lowered (-a 0.4). In 3BB2R case it is not neccessary such modification since the number of springs is similar to full-atom.

Its convenient to convert CG models to a full atom representation to avoid problems of compatibility with visualization software:

Ca       ->
imove 1ab3.pdb imodeCA\_ic.evec imoveCA\_FULL\_1.pdb 1 -m 0 -a 0.4 --model\_out 2
3BB2R->
imove 1ab3.pdb imode3BB2R\_ic.evec imove3BB2R\_FULL\_1.pdb 1 -m 1 --model\_out 2

--------------- Monte-Carlo in different CG models. ---------------

To compute MC trajectories:

Ca       -> imc imodeCA\_ncac.pdb imodeCA\_ic.evec -m 0 -a 0.1 -o imcCA
3BB2R-> imc 1ab3.pdb imode3BB2R\_ic.evec -m 1 -o imc3BB2R

As before, to maintain the motion appearance the amplitude was lowered (-a 0.1) in Ca case.

To obtain full-atom trajectories from Ca or 3BB2R modes:

Ca      ->
imode 1ab3.pdb -m 0 -o imodeCA --model\_out 2
imc 1ab3.pdb imodeCA\_icf.evec -m 2 -a 0.1 -o imcCA\_FULL
3BB2R->
imode 1ab3.pdb -m 1 -o imode3BB2R --model\_out 2
imc 1ab3.pdb imode3BB2R\_icf.evec -m 2 -o imc3BB2R\_FULL

An extra output file named **<basename>\_icf.evec** will contain the output modes of the corresponding CG level.

# **How to customize the potential energy model?**

For a given structure and CG model, normal modes are determined by its potential energy, i.e. the spring network. In iMODE the potential energy can be customized several ways:

* [By distance dependant functions.](#P_DIST)
* [By topology and SS.](#P_TSS)
* [User custom potential.](#P_K)

Distance dependant functions

|  |  |  |
| --- | --- | --- |
| **Functions** | **Options\*** | **Description** |
| Inverse exponential (default)  K = k/(1+(x/x0)^p),  if x < c, else K=0 | **-P 0** --k0\_c 10 --k0\_k 1 --k0\_x0 3.8 --k0\_p 6 | Distance cutoff (Å) Scale factor Inverse exponential center Power term |
| Simple distance cutoff  K = k,  if x < c, else K=0 | **-P 1** --k1\_c 10 --k1\_k 1 | Distance cutoff (Å)  Scale factor |

*\*Bold options are mandatory.*

For example, to use a Ca model with potential energy based on distance dependant functions, type:

imode 1ab3.pdb -m 0 -P 0 -o imodeCA\_IE
imode 1ab3.pdb -m 0 -P 1 -o imodeCA\_C

The appearance of this potential energy models with default parameters is shown below. Springs are represented by red segments with thickness proportional to the force constant.

|  |  |
| --- | --- |
| **Inverse exponential** (Stiffness inversely proportional to distance) | **Simple distance cutoff** (Constant stiffness) |
| ![](/images/sbg/imod/1ab3CAki_320.jpg "Inverse exponential") | ![](/images/sbg/imod/1ab3CAkc_320.jpg "Simple distance cutoff") |

To customize the potential energy funcitons modify the default options; for example:

imode 1ab3.pdb -m 0 -P 0 --k0\_c 8 --k0\_k 2 -k0\_x0 2.5 -k0\_p 4 -o imodeCA\_IE2
imode 1ab3.pdb -m 0 -P 1 --k1\_c 5 --k1\_k 2 -o imodeCA\_C2

Topology and Secondary Structure

iMODE permits the specification of customized inverse exponential functions according to both topology and SS.

The basic command for topology and SS would be:

imode 1ab3.pdb -P 2 --func funcTSS.txt -o imodeTSS

A functions file ([funcTSS.txt](/media/files/funcTSS.txt)) is mandatory. It should conform the following format:
(Note, "#"-begining lines will be omitted)

```
# SS  n  k  x0 p
HH    0  2 3.8 6
HH    1  5 3.8 6
HH    2  3 3.8 6
HH   -1  2 3.8 6
EE    0  2 3.8 6
EE    1  5 3.8 6
EE    2  3 3.8 6
EE   -1  5 3.8 6
XX   -1  1 3.8 6
```

Each line represents an inverse exponential function. First column specifies the SS. For example, "HH" indicates that both atoms should belong to residues with a-helix SS. By default SS identifiers are: "H" helix, "E" strand, and "C" coil; and any pair of them is allowed. Second column specifies the topology. Here topology represents the sequential distance between two residues; for example, if our protein sequence were ...AGKTLV..., the topology between underlined residues would be 3. Remaining columns define the inverse exponential functional parameters: k, x0 and p, (see the table above).

The wildcards for SS and topology are "XX" and "-1", respectively.

By default, the SS is computed internally, but any user defined SS can be provided using the --ss option:

imode 1ab3.pdb -P 2 --func funcTSS.txt --ss 1ab3.ss -o imodeTSSE

For example, you can use DSSP to compute SS ([1ab3.dssp](/files/1ab3.dssp)) and with the aid of [this](/files/dssp2ss.pl) simple perl script you can convert it into our SS file format ([1ab3.ss](/files/1ab3.ss))

perl dssp2ss.pl 1ab3.dssp 1ab3.ss

Our SS file format ([1ab3.ss](/files/1ab3.ss)) is a simple two column ASCII file. The first column corresponds to the sequence index, and the second one to a single character SS identifiers.

Customize potential energy by topology only.

The basic command for topology is:

imode 1ab3.pdb -P 2 --func funcTOP.txt -o imodeTOP

The topology functions file ([funcTOP.txt](/media/files/funcTOP.txt)) is:

```
# SS  n  k  x0 p
XX    0  2 3.8 6
XX    1  9 3.8 6
XX    2  5 3.8 6
XX    3  3 3.8 6
XX    4  2 3.8 6
XX   -1  1 3.8 6
```

Customize potential energy by SS only.

The command to take into account SS only would look like this way:

imode 1ab3.pdb -P 2 --func funcHE.txt -o imodeHE

The functions file ([funcHE.txt](/media/files/funcHE.txt)) is:

```
# SS (j-i) k  x0 p
HH     -1  2 3.8 6
EE     -1  5 3.8 6
HE     -1  3 3.8 6
XX     -1  1 3.8 6
```

This file applies different functions to atom pairs belonging to residues with SS: H vs. H (HH), E vs. E (EE) and H vs. E (HE). The XX function will be applied to remaining pairs of atoms.

Given the non-Helical or non-Sheet regions are more flexible than the rest, some times may be interesting to increase flexibility in those regions. Corresponding command would be:

imode 1ab3.pdb -P 2 --func funcCX.txt -o imodeCX

The functions file ([funcCX.txt](/media/files/funcCX.txt)) is:

```
# SS (j-i)   k  x0 p
CC     -1  0.2 3.8 6
XX     -1    1 3.8 6
```

The springs associated to last example are represented below. First and second function springs are colored in orange and red, respectively. For clarity bo th kinds of springs were shown with similar thickness.

|  |
| --- |
| ![](/images/sbg/imod/1ab3CAkCCXX_320.jpg) |

--------------- User custom potential. ---------------

The user can define its own potential thought a file using the -K option. Type at the command prompt:

imode 1ab3.pdb -K imodeKi\_Kfile.dat -o imodeCP

This ASCII file ([imodeKi\_Kfile.dat](/media/files/imodeKi_Kfile.dat)) has three columns to define the force constants (K) for each atomic pair:

```
1 2 9.962940E-01
1 3 9.292819E-01
1 4 6.086772E-01
1 5 9.329874E-01
1 6 8.701856E-01
...........
```

Each line represents one spring. The first and second colums are the atomic indices (begining with 1), and the third is the force constant.

To obtain a Kfile template for your macromolecule that you can adapt to your convenience, use:

imode 1ab3.pdb -P 1 --k1\_c 10 --save\_Kfile -o imodeKc

The resulting file, **[imodeKc\_Kfile.dat](/media/files/imodeKc_Kfile.dat)**, will contain the force constants for current potential energy model, in this case, the simple cutoff model.

# **How to deal with huge systems?**

In iMOD, the maximum macromolecular size allowed to perform NMA is constrained by the amount of memory needed to diagonalize the Hessian matrix, and it depends on the employed architecture. For example, in a standard 32-bit linux box (the maximum memory addressed per program is about 2Gb) so it can solve systems up to approximately 15000 degrees of freedom (DoF), i.e. about 7000-8000 aminoacids in proteins or 3000 nucleotids in nucleic acids. On the other hand, 64-bit machines are only limited by available RAM. For example, NMA of a 50000 DoFs system would need a 64-bit computer with about 30Gb of RAM memory. Therefore  a dimensionality reduction is mandatory when the system under study becomes huge for standard computers. To this end, we can fix some internal coordinates (ICs)  to reduce the number of degrees of freedom and fit the matrices into memory. There are three ways to accomplish this:

* Fixing custom ICs.
* Fixing by secondary structure
* Fixing ICs randomly.

Here we are going to comment the simplest way to reduce the dimensionality, which is to fix randomly some ratio of dihedral angles. Other possibilites to fix IC will be discussed in the next section.  **Fixing ICs randomly** For fixing randomly some ratio of dihedral angles, just type:

imode 1aon.pdb -r 0.5 -o imodeR05

This will fix the 50% of available dihedral angles. Note the inter-chain rotational/translational degrees of freedom are always maintained mobile. To illustrate this reductionist approach we purpose the following practical examples with a HUGE viral system:

* [NMA of the closed CCMV capsid](#FAQ_CCMV_NMA)
* [Morphing the closed CCMV capsid into the swollen form](#FAQ_CCMV_MORPH)

NMA of the closed CCMV capsid

---

The capsid of the Cowpea Chlorotic Mottle Virus (CCMV) is a huge protein structure composed of 180 chains, 28620 aminoacids and 214440 atoms. In terms of ICs it means about 58000 ICs: 56994 dihedral angles (f and ?) and 1074 inter-chain rotational/translational variables. Perform NMA with 58000 ICs it's impractical in  standard PC box, since there would be needed a 64-bit computer with about 30Gb of RAM memory, and each diagonalization step would last even days. To overcome this we are going to fix the 90% of dihedral angles while keeping mobile all rotational/traslational degrees of freedom:

imode [1cwp\_prot.pdb](/media/files/1cwp_prot.pdb.gz) -o 1cwpDH09 -r 0.9 --save\_fixfile

```
imode>
imode> Welcome to the NMA in Internal Coordinates tool v1.10
imode>
imode> Reading PDB file: 1cwp_prot.pdb
molinf> Protein   1 chain  1 A segment  1 residues: 149 atoms: 1122
molinf>                    2 B segment  1 residues: 164 atoms: 1226
molinf>                    3 C segment  1 residues: 164 atoms: 1226
molinf> Protein   2 chain  1 A segment  1 residues: 149 atoms: 1122
...................................................................
molinf> Protein  60 chain  1 A segment  1 residues: 149 atoms: 1122
molinf>                    2 B segment  1 residues: 164 atoms: 1226
molinf>                    3 C segment  1 residues: 164 atoms: 1226
molinf> SUMMARY:
molinf> Number of Molecules ... 60
molinf> Number of Chain ....... 180
molinf> Number of Segments .... 180
molinf> Number of Groups ...... 28620
molinf> Number of Atoms ....... 214440
molinf>
imode> Coarse-Graining model: Full-Atom (no coarse-graining)
imode> Selected model residues: 28620
imode> Selected model (pseudo)atoms: 214440
imode> Number of Dihedral angles: 55920
imode> Number of Inter-segment coords: 1074 (Rot+Trans)
imode> Number of Internal Coordinates: 56994 (Hessian rank)
imode> Input CG-model Fixed Internal Coordinates: 50328
imode> Input CG-model Final Internal Coordinates (sizei) = 6666
imode> Range of computed modes: 1-20
imode> Creating pairwise interaction potential:
imode> Inverse Exponential (16245240 nipas) cutoff= 10.0, k= 1.000000, x0= 3.8
imode> Packed-Hessian/
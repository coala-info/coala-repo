cwlVersion: v1.2
class: CommandLineTool
baseCommand: imode_gcc
label: imods_imode_gcc
doc: "iMODE: Internal coordinates normal MODE analysis tool (NMA in internal coordinates).\n\nTool homepage: https://chaconlab.org/multiscale-simulations/imod"
inputs:
  - id: pdb
    type: File
    doc: "PDB input file (required)"
    inputBinding:
      position: 1
  - id: model
    type:
      - 'null'
      - int
    doc: "Coarse-Grained model: 0=CA, 1=C5, 2=Heavy-Atom (default=2)."
    inputBinding:
      position: 102
      prefix: --model
  - id: name
    type:
      - 'null'
      - string
    doc: "Output files basename (default=imode)."
    default: imode
    inputBinding:
      position: 103
      prefix: --name
  - id: deform
    type:
      - 'null'
      - boolean
    doc: "Turn on deformability calculations. CAUTION, only suitable for CA-model. (default=disabled)."
    inputBinding:
      position: 104
      prefix: --deform
  - id: fix_rand
    type:
      - 'null'
      - float
    doc: "Randomly fixed ratio of Dihedral Coordinates (default=disabled). Example: 0.7 = 70% of dihedrals will be randomly removed. Rotational/translational coords. always mobile."
    inputBinding:
      position: 105
      prefix: --fixRand
  - id: fix_file
    type:
      - 'null'
      - File
    doc: "ASCII file defining the ICs to be fixed with the format: Protein: \"n phi chi psi\" NAcid: \"n alpha beta gamma chi epsilon zeta\" Inter-chain: \"n 6D\" Where \"n\" is the residue index (0,1,..) and the coordinate name (phi, psi, etc...) can be set to 0(fixed) or 1(mobile). Each one of the 6 inter-chain variables should be specified on separate lines in the following order: x,y,z,Rx,Ry,Rz. Note \"n\" is just the sequential residue index (starting with 0) and NOT the PDB's residue index. A demo file can be generated using the --save_fixfile option."
    inputBinding:
      position: 106
      prefix: --fixFile
  - id: potential
    type:
      - 'null'
      - int
    doc: "Pairwise interaction potential: (default=0) 0= Sigmoid function (= k/(1+(x/x0)^p), if x < c, else k=0). 1= Tirion's cutoff (= k, if x < c, else k=0). 2= Hinsen's function. 3= Topology & Secondary Structure (--func is mandatory). 4= edNMA formalism (CA-model only). By default an extra torsional potential will be added."
    inputBinding:
      position: 107
      prefix: --potential
  - id: kfile
    type:
      - 'null'
      - File
    doc: "Force constants ASCII file with 3 cols.: <i-atom> <j-atom> <K> Where <i/j-atom> are the corresponding atomic indices (1,2,...) A demo file can be generated using --save_Kfile option."
    inputBinding:
      position: 108
      prefix: --Kfile
  - id: nevs
    type:
      - 'null'
      - string
    doc: "Used modes range, either number [1,N] <integer>, or ratio [0,1) <float> (default=20)."
    inputBinding:
      position: 109
      prefix: --nevs
  - id: chi
    type:
      - 'null'
      - boolean
    doc: "Considers first CHI dihedral angle (default=disabled)."
    inputBinding:
      position: 110
      prefix: --chi
  - id: fix_ss
    type:
      - 'null'
      - string
    doc: "All dihedral coordinates with a given secondary structure (SS) will be removed (see --ss). Ex: \"HE\" will fix the dihedrals corresponding to alpha-helices and beta-sheets."
    inputBinding:
      position: 111
      prefix: --fixSS
  - id: ss
    type:
      - 'null'
      - File
    doc: "Secondary Structure ASCII file with 2 cols.: <n> <char> Where <n> is the corresponding residue index (0,1,...), and <char> is the single character SS identifier. By default SS will be computed internally (H=helix, E=strand, C=coil)."
    inputBinding:
      position: 112
      prefix: --ss
  - id: save_fixfile
    type:
      - 'null'
      - boolean
    doc: "Save fixation file as <basename.fix> (to be used with -r or -S options; otherwise a fully mobile file will be generated) (default=disabled)"
    inputBinding:
      position: 113
      prefix: --save_fixfile
  - id: save_cart
    type:
      - 'null'
      - boolean
    doc: "Save Cartesian modes as <basename_cart.evec> (default=disabled)"
    inputBinding:
      position: 114
      prefix: --save_cart
  - id: save_wcart
    type:
      - 'null'
      - boolean
    doc: "Save Mass-weighted Cartesian modes as <basename_wcart.evec> (default=disabled)"
    inputBinding:
      position: 115
      prefix: --save_wcart
  - id: save_ca
    type:
      - 'null'
      - boolean
    doc: "Save CA-based Cartesian modes as <basename_ca.evec> (default=disabled)"
    inputBinding:
      position: 116
      prefix: --save_ca
  - id: save_kfile
    type:
      - 'null'
      - boolean
    doc: "Save atom-pairwise force constants file as <basename_Kfile.dat> (to be used with -K option) (default=disabled)"
    inputBinding:
      position: 117
      prefix: --save_Kfile
  - id: save_ssfile
    type:
      - 'null'
      - boolean
    doc: "Save secondary structure file as <basename.ss> (to be used with -S or -P=2 options) (default=disabled)."
    inputBinding:
      position: 118
      prefix: --save_SSfile
  - id: save_covar
    type:
      - 'null'
      - boolean
    doc: "Saves the predicted covariance matrix at selected Temperature in binary packed storage format as <basename_covar.bin>. If --save_wcart selected, then mass-weighted covariance matrix will be computed instead (default=disabled)."
    inputBinding:
      position: 119
      prefix: --save_covar
  - id: save_dcovar
    type:
      - 'null'
      - boolean
    doc: "Saves the CA-based distance-covariance matrix at selected Temperature"
    inputBinding:
      position: 120
      prefix: --save_dcovar
  - id: save_covar_text
    type:
      - 'null'
      - boolean
    doc: "Enables plain text output for the covariance matrices (default=disabled)."
    inputBinding:
      position: 121
      prefix: --save_covar_text
  - id: k0_c
    type:
      - 'null'
      - float
    doc: "Sigmoid function distance cutoff (default=10A)."
    inputBinding:
      position: 122
      prefix: --k0_c
  - id: k0_k
    type:
      - 'null'
      - float
    doc: "Sigmoid function stiffness constant (default=1.0)."
    inputBinding:
      position: 123
      prefix: --k0_k
  - id: k0_x0
    type:
      - 'null'
      - float
    doc: "Sigmoid function inflexion point (default=3.8A)."
    inputBinding:
      position: 124
      prefix: --k0_x0
  - id: k0_p
    type:
      - 'null'
      - float
    doc: "Sigmoid function power term (default=6)."
    inputBinding:
      position: 125
      prefix: --k0_p
  - id: k1_c
    type:
      - 'null'
      - float
    doc: "Tirion's method distance cutoff (default=10A)."
    inputBinding:
      position: 126
      prefix: --k1_c
  - id: k1_k
    type:
      - 'null'
      - float
    doc: "Tirion's method stiffness constant (default=1.0)."
    inputBinding:
      position: 127
      prefix: --k1_k
  - id: k2_c
    type:
      - 'null'
      - float
    doc: "Non-bonding distance cutoff applied to --func option (default=10A)."
    inputBinding:
      position: 128
      prefix: --k2_c
  - id: nomodel
    type:
      - 'null'
      - boolean
    doc: "Disables PDB model building. Warning: introduced PDB model must match the CG selected with the -m option (default=disabled)."
    inputBinding:
      position: 129
      prefix: --nomodel
  - id: nomass
    type:
      - 'null'
      - boolean
    doc: "Disables mass weighting (default=disabled)."
    inputBinding:
      position: 130
      prefix: --nomass
  - id: notors
    type:
      - 'null'
      - boolean
    doc: "Disables extra torsional potential (default=disabled)."
    inputBinding:
      position: 131
      prefix: --notors
  - id: norm
    type:
      - 'null'
      - boolean
    doc: "Enables (norm=1) eigenvector normalization. Note this does not change vector direction (default=disabled)."
    inputBinding:
      position: 132
      prefix: --norm
  - id: func
    type:
      - 'null'
      - File
    doc: "ASCII file defining the force constant functions to be applied according to Topology and/or Secondary Structure. The 5 cols. format is: <SS> <t> <k> <x0> <pow> Where <SS> is the two character pairwise interaction identifier, <t> is the topology, and <k>,<x0>,<pow> are the corresponding sigmoid function parameters. If --ss is not specified, the XX pairwise interaction identifier must be introduced. This way, only topologies will be considered. If <t> is \"-1\", any previously not-matched topology will be considered."
    inputBinding:
      position: 133
      prefix: --func
  - id: model_out
    type:
      - 'null'
      - int
    doc: "Output Coarse-Graining model: 0=CA, 1=C5, 2=Heavy-Atom (default=disabled)."
    inputBinding:
      position: 134
      prefix: --model_out
  - id: chi_out
    type:
      - 'null'
      - boolean
    doc: "Considers first CHI dihedral angle in output modes (default=disabled)."
    inputBinding:
      position: 135
      prefix: --chi_out
  - id: save_covar_out
    type:
      - 'null'
      - boolean
    doc: "Computes and Saves the predicted covariance matrix for the output model at selected Temperature in binary packed storage format as <basename_covarf.bin>. If --save_wcart selected, then mass-weighted covariance matrix will be computed instead (default=disabled)."
    inputBinding:
      position: 136
      prefix: --save_covar_out
  - id: temperature
    type:
      - 'null'
      - double
    doc: "Temperature [K] for covariance matrix computation (default=300)."
    inputBinding:
      position: 137
      prefix: --temperature
  - id: seed
    type:
      - 'null'
      - int
    doc: "Pre-define the random number generator SEED (Mersenne Twister) (default=random-seed from /dev/urandom)"
    inputBinding:
      position: 138
      prefix: --seed
  - id: keep_hydrogens
    type:
      - 'null'
      - boolean
    doc: "Disables Hydrogen atoms deletion (default=disabled)."
    inputBinding:
      position: 139
      prefix: --keep_hydrogens
  - id: keep_waters
    type:
      - 'null'
      - boolean
    doc: "Disables Water molecules deletion (default=disabled)."
    inputBinding:
      position: 140
      prefix: --keep_waters
  - id: delete_heteros
    type:
      - 'null'
      - boolean
    doc: "Delete Hetero-atoms, including waters (default=disabled)."
    inputBinding:
      position: 141
      prefix: --delete_heteros
  - id: verb
    type:
      - 'null'
      - int
    doc: "Verbose level (0=low, 1=medium, 2=high) (default=0)."
    inputBinding:
      position: 142
      prefix: --verb
  - id: fix_rand2
    type:
      - 'null'
      - float
    doc: "Randomly fixed ratio of Internal Coordinates (default=disabled). Example: 0.7 = 70% of the ICs will be randomly fixed (DEVELOPER's)."
    inputBinding:
      position: 143
      prefix: --fixRand2
  - id: save_matrices
    type:
      - 'null'
      - boolean
    doc: "Saves both Hessian and Kinetic energy matrices in binary packed storage format (default=disabled) (DEVELOPER's)."
    inputBinding:
      position: 144
      prefix: --save_matrices
  - id: just_matrices
    type:
      - 'null'
      - boolean
    doc: "Just computes and saves both matrices, then exit... (default=disabled) (DEVELOPER's)."
    inputBinding:
      position: 145
      prefix: --just_matrices
  - id: swapmatrix_mem
    type:
      - 'null'
      - float
    doc: "Amount of RAM memory (in GB) to be used during Hessian matrix swapping (default=1GB) (DEVELOPER's)."
    inputBinding:
      position: 146
      prefix: --swapmatrix_mem
  - id: hessian
    type:
      - 'null'
      - int
    doc: "Hessian matrix building method (DEVELOPER's) (default=2)."
    inputBinding:
      position: 147
      prefix: --hessian
  - id: kinetic
    type:
      - 'null'
      - int
    doc: "Kinetic energy matrix building method (DEVELOPER's) (default=2)."
    inputBinding:
      position: 148
      prefix: --kinetic
  - id: convert
    type:
      - 'null'
      - int
    doc: "Conversion method from ICS to CCS: 0=K-matrix, 1=VW-arrays (DEVELOPER's) (default=1)."
    inputBinding:
      position: 149
      prefix: --convert
  - id: debug
    type:
      - 'null'
      - int
    doc: "Debug code <int> (default=disabled)."
    inputBinding:
      position: 150
      prefix: --debug
  - id: fix_ic
    type:
      - 'null'
      - File
    doc: "Plain-text file defining the fixed Internal Coordinates. Each line will contain the index (0,1,...) of the ICs to be removed (DEVELOPER's)."
    inputBinding:
      position: 151
      prefix: --fixIC
  - id: nthreads
    type:
      - 'null'
      - int
    doc: "Number of threads for parallel processing (experimental)"
    inputBinding:
      position: 152
      prefix: --nthreads
  - id: eigensolver
    type:
      - 'null'
      - int
    doc: "Eigensolver (pay attention to this option specially for large systems): 0= LAPACK/BLAS, fastest if more than 10% modes requested [DSPGVX], 1= ARPACK, fastest if less than 5% modes requested [dsdrv1_AP_BP_W_mon] (default), 2= ARPACK-square, [dsdrv1_A_B_W_mon] (experimental)."
    inputBinding:
      position: 153
      prefix: --eigensolver
  - id: inter_molec
    type:
      - 'null'
      - float
    doc: "Sets the inter-molecular force constant factor (default=disabled)"
    inputBinding:
      position: 154
      prefix: --inter_molec
  - id: inevec
    type:
      - 'null'
      - File
    doc: "Input IC Eigenvectors/values file (.evec). This disables Hessian and Kinetic energy matrices calculation and diagonalization."
    inputBinding:
      position: 155
      prefix: --inevec
  - id: dc
    type:
      - 'null'
      - double
    doc: "Characteristic Distance of the Hardy's Quadric Interpolation used in Deformability computations (default=15). It should be > 0."
    inputBinding:
      position: 156
      prefix: --dc
outputs:
  - id: result_files
    type:
      type: array
      items: File
    doc: Files written with the output basename
    outputBinding:
      glob: $(inputs.name)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imods:1.0.4--h9ee0642_3

# phyml CWL Generation Report

## phyml

### Tool Description
A simple, fast, and accurate algorithm to estimate large phylogenies by maximum likelihood

### Metadata
- **Docker Image**: quay.io/biocontainers/phyml:3.3.20220408--h9bc3f66_3
- **Homepage**: http://www.atgc-montpellier.fr/phyml/
- **Package**: https://anaconda.org/channels/bioconda/packages/phyml/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phyml/overview
- **Total Downloads**: 116.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/stephaneguindon/phyml
- **Stars**: N/A
### Original Help Text
```text
[00;01mNAME
[00;00m	- PhyML 3.3.20220408 - 

[00;00m	''A simple, fast, and accurate algorithm to estimate
[00;00m	large phylogenies by maximum likelihood''

[00;00m	Stephane Guindon and Olivier Gascuel,
[00;00m	Systematic Biology 52(5):696-704, 2003.

[00;00m	Please cite this paper if you use this software in your publications.
[00;01m
SYNOPSIS:

[00;01m	phyml [00;01m[command args]
[00;00m
	All the options below are optional (except '[00;01m-i[00;00m' if you want to use the command-line interface).

[00;01m
Command options:
[00;00m
	[00;01m-i (or --input) [00;04mseq_file_name[00;00m
		[00;04mseq_file_name[00;00m is the name of the nucleotide or amino-acid sequence file in PHYLIP format.

[00;01m
	-d (or --datatype) [00;04mdata_type[00;00m
		[00;04mdata_type[00;00m is 'nt' for nucleotide (default), 'aa' for amino-acid sequences, or 'generic',
		(use NEXUS file format and the 'symbols' parameter here).

[00;01m
	-q (or --sequential)
[00;00m		Changes interleaved format (default) to sequential format.

[00;01m
	-n (or --multiple) [00;04mnb_data_sets[00;00m
		[00;04mnb_data_sets[00;00m is an integer corresponding to the number of data sets to analyse.

[00;01m
	-p (or --pars)[00;00m
[00;00m		Use a minimum parsimony starting tree. This option is taken into account when the '-u' option
[00;00m		is absent and when tree topology modifications are to be done.

[00;01m
	-b (or --bootstrap) [00;04mint[00;00m
		[00;04mint[00;00m >  0: [00;04mint[00;00m is the number of bootstrap replicates.
		[00;04mint[00;00m =  0: neither approximate likelihood ratio test nor bootstrap values are computed.
		[00;04mint[00;00m = -1: approximate likelihood ratio test returning aLRT statistics.
		[00;04mint[00;00m = -2: approximate likelihood ratio test returning Chi2-based parametric branch supports.
		[00;04mint[00;00m = -4: SH-like branch supports alone.
		[00;04mint[00;00m = -5: (default) approximate Bayes branch supports.

[00;01m
	--tbe[00;00m
		Computes TBE instead of FBP (standard) bootstrap support
		Has no effect with -b <= 0
[00;01m
	-m (or --model) [00;04mmodel[00;00m
		model[00;00m : substitution model name.
		[00;00m- [00;04mNucleotide[00;00m-based models : [00;04mHKY85[00;00m (default) | [00;04mJC69[00;00m | [00;04mK80[00;00m | [00;04mF81[00;00m | [00;04mF84[00;00m 
		 [00;04mTN93[00;00m | [00;04mGTR[00;00m | [00;04mcustom (*)[00;00m
		(*) : for the custom option, a string of six digits identifies the model. For instance, 000000
		 corresponds to F81 (or JC69 provided the distribution of nucleotide frequencies is uniform).
		 012345 corresponds to GTR. This option can be used for encoding any model that is a nested within GTR.

		[00;00m- [00;04mAmino-acid[00;00m based models : [00;04mLG[00;00m (default) | [00;04mWAG[00;00m | [00;04mJTT[00;00m | [00;04mMtREV[00;00m | [00;04mDayhoff[00;00m | [00;04mDCMut[00;00m 
		 [00;04mRtREV[00;00m | [00;04mCpREV[00;00m | [00;04mVT[00;00m | [00;04mAB[00;00m | [00;04mBlosum62[00;00m | [00;04mMtMam[00;00m | [00;04mMtArt[00;00m
		 [00;04mHIVw[00;00m |  [00;04mHIVb[00;00m | [00;04mcustom[00;00m

[00;01m
	--aa_rate_file [00;04mfilename[00;00m
		[00;04mfilename[00;00m is the name of the file that provides the amino acid substitution rate matrix in PAML format.
		It is compulsory to use this option when analysing amino acid sequences with the `custom' model.

[00;01m
	-f [00;04me[00;01m, [00;04mm[00;01m, [00;04mo[00;00m or [00;00mfA,fC,fG,fT[00;00m
		[00;04me[00;00m : the character frequencies are determined by counting the number of amino-acids 
		 or nucleotides from the sequence alignment. 

		[00;04mm[00;00m : the character frequencies are determined as follows : 
[00;00m		- [00;04mNucleotide[00;00m sequences: the equilibrium base frequencies are optimized using maximum likelihood.
[00;00m		- [00;04mAmino-acid[00;00m sequences: the equilibrium amino-acid frequencies are estimated using
		 the frequencies defined by the substitution model.

		[00;04mo[00;00m : the character frequencies (amino-acids or nucleotides) are optimized using maximum likelihood 

		[00;04mfA,fC,fG,fT[00;00m : only valid for nucleotide-based models. fA, fC, fG and fT are floating numbers that 
		 correspond to the frequencies of A, C, G and T respectively (WARNING: do not use any blank space between
		 your values of nucleotide frequencies, only commas!)

[00;01m
	-t (or --ts/tv) [00;04mts/tv_ratio[00;00m
		ts/tv_ratio[00;00m : transition/transversion ratio. DNA sequences only.
		Can be a fixed positive value (ex:4.0) or [00;04me[00;00m to get the maximum likelihood estimate.

[00;01m
	-v (or --pinv) [00;04mprop_invar[00;00m
		prop_invar[00;00m : proportion of invariable sites.
		Can be a fixed value in the [0,1] range or [00;04me[00;00m to get the maximum likelihood estimate.

[00;01m
	-c (or --nclasses) [00;04mnb_subst_cat[00;00m
		nb_subst_cat[00;00m : number of relative substitution rate categories. Default : [00;04mnb_subst_cat[00;00m=4.
		Must be a positive integer.

[00;01m
	--freerates (or --free_rates or --freerate or --free_rate)
		[00;00m FreeRate model of substitution rate variation across sites.

[00;01m
	-a (or --alpha) [00;04mgamma[00;00m
		gamma[00;00m : distribution of the gamma distribution shape parameter.
		Can be a fixed positive value or [00;04me[00;00m to get the maximum likelihood estimate.

[00;01m
	-s (or --search) [00;04mmove[00;00m
		 Deprecated option.
		Tree topology search operation option.
		Can be either [00;04mNNI[00;00m (default, fast) or [00;04mSPR[00;00m (a bit slower than NNI) or [00;04mBEST[00;00m (best of NNI and SPR search).

[00;01m
	-u (or --inputtree) [00;04muser_tree_file[00;00m
		user_tree_file[00;00m : starting tree filename. The tree must be in Newick format.

[00;01m
	-o [00;04mparams[00;00m
		This option focuses on specific parameter optimisation.
		[00;04mparams[00;00m=tlr : tree topology (t), branch length (l) and rate parameters (r) are optimised.
		[00;04mparams[00;00m=tl  : tree topology and branch length are optimised.
		[00;04mparams[00;00m=lr  : branch length and rate parameters are optimised.
		[00;04mparams[00;00m=l   : branch length are optimised.
		[00;04mparams[00;00m=r   : rate parameters are optimised.
		[00;04mparams[00;00m=n   : no parameter is optimised.

[00;01m
	--rand_start[00;00m
		This option sets the initial tree to random.
		It is only valid if SPR searches are to be performed.

[00;01m
	--n_rand_starts [00;04mnum[00;00m
		num[00;00m is the number of initial random trees to be used.
		It is only valid if SPR searches are to be performed.

[00;01m
	--r_seed [00;04mnum[00;00m
		num[00;00m is the seed used to initiate the random number generator.
		Must be an integer.

[00;01m
	--print_site_lnl[00;00m
		[00;00mPrint the likelihood for each site in file *_phyml_lk.txt.

[00;01m
	--print_trace[00;00m
		[00;00mPrint each phylogeny explored during the tree search process
		[00;00min file *_phyml_trace.txt.

[00;01m
	--run_id [00;04mID_string[00;00m
		[00;00mAppend the string [00;04mID_string[00;00m at the end of each PhyML output file.
		[00;00mThis option may be useful when running simulations involving PhyML.

[00;01m
	--quiet[00;00m
		[00;00mNo interactive question (for running in batch mode) and quiet output.

[00;01m
	--no_memory_check[00;00m
		[00;00mNo interactive question for memory usage (for running in batch mode). Normal output otherwise.

[00;01m
	--leave_duplicates[00;00m
		[00;00mPhyML removes duplicate sequences by default. Use this option to leave them in.

[00;01m
	--alias_subpatt[00;00m
		[00;00mSite aliasing is generalized at the subtree level. Sometimes lead to faster calculations.
		[00;00mSee Kosakovsky Pond SL, Muse SV, Sytematic Biology (2004) for an example.

[00;01m
	--boot_progress_display [00;04mnum[00;00m (default=20)
		[00;04mnum[00;00m is the frequency at which the bootstrap progress bar will be updated.
		Must be an integer.

[00;01mPHYLIP-LIKE INTERFACE
[00;00m
	You can also use PhyML with no argument, in this case change the value of
[00;00m	a parameter by typing its corresponding character as shown on screen.

[00;01mEXAMPLES

[00;00m	DNA interleaved sequence file, default parameters : [00;01m  ./phyml -i seqs1[00;00m
	AA interleaved sequence file, default parameters :  [00;01m  ./phyml -i seqs2 -d aa[00;00m
	AA sequential sequence file, with customization :   [00;01m  ./phyml -i seqs3 -q -d aa -m JTT -c 4 -a e[00;00m
```


## Metadata
- **Skill**: generated

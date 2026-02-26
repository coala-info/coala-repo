# igphyml CWL Generation Report

## igphyml

### Tool Description
IgPhyML 1.1.5 09022

### Metadata
- **Docker Image**: quay.io/biocontainers/igphyml:1.1.5--h7b50bb2_2
- **Homepage**: https://igphyml.readthedocs.io/en/latest/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/igphyml/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/igphyml/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
COMMAND: igphyml --help 

[00;01mIgPhyML 1.1.5 09022
	[00;01mKB Hoehn, JA Vander Heiden, JQ Zhou, G Lunter, OG Pybus, SH Kleinstein.
[00;00m	Please cite: https://doi.org/10.1073/pnas.1906020116 and 10.1534/genetics.116.196303
[00;01m
	For detail and usage information: https://igphyml.readthedocs.io
[00;01m
Usage:[00;00m
	igphyml --repfile [lineages file] -m [model] [other options]
[00;00m
	igphyml -i [sequence file] -m [model] [other options]
[00;01m
Input/output options:
[00;00m
	[00;01m--repfile [00;04mlineage_file_name[00;01m (required if no -i specified)
		[00;04mlineage_file_name[00;00m: File specifying input files for repertoire analysis (see docs).
		Use BuildTrees.py (https://changeo.readthedocs.io) to generate lineages file.

	[00;01m-i [00;04mseq_file_name[00;01m (required if no --repfile specified)
		[00;04mseq_file_name[00;00m: Codon-aligned sequence file in FASTA or PHYLIP format.
[00;01m
	--run_id [00;04mID_string[00;00m
		[00;00mAppend the string [00;04mID_string[00;00m at the end of each output file.
[00;01m
	-u [00;04muser_tree_file[00;00m (only if -i used)
		[00;04muser_tree_file[00;00m : starting tree filename. The tree must be in Newick format.
[00;01m
	--partfile [00;04mpartition_file[00;00m (only if -i used)
		[00;04mpartition_file[00;00m : Partition file specifying CDRs/FWRs for sequence file.
[00;01m
Model options:
[00;00m[00;01m
	-m [00;04mmodel[00;00m [00;01m(required)
		[00;04mmodel[00;00m : substitution model name.
		[00;00mCodon[00;00m based models: [00;04mHLP[00;00m (HLP19) | [00;04mGY[00;00m | [00;04mHLP17[00;00m
		[00;00mUse GY for quick tree construction.
		HLP for B cell specific features (see docs).
[00;01m
	Model parameterization arguments:[00;04m
[00;01m
	 (!) -t, --omega, and --hotness have the following options.[00;04m
		[00;00mAny combination of these may be specified in a comma separated list
		when multiple parameters are estimated e.g. --omega ce,1
		[00;04mparameter[00;00m = e: Estimate single value by ML across all lineages (default).
		[00;04mparameter[00;00m = ce: Same as 'e' but also find 95% confidence intervals.
		[00;04mparameter[00;00m = i: Estimate by ML for each lineage individually (experimental).
		[00;04mparameter[00;00m = ci: Same as 'i' but also find 95% confidence intervals (experimental).
		[00;04mparameter[00;00m > -1: Fix parameter to specified value for all lineages (see below).
[00;01m
	-t [00;04mts/tv_ratio[00;00m = [e|ce|i|ci|>0]
		Set the transition/transversion ratio.
[00;01m
	--omega [00;04momega[00;00m = [e|ce|i|ci|>0]
		Set number/value of omegas to estimate.
		First value (0) corresponds to FWRs, second (1) to CDRs.
		May specify multiple omegas if partition file(s) specified.
[00;01m
	--hotness [00;04mhotness[00;00m = [e|ce|i|ci|>-1]
		Set number hot- and coldspot rates to estimate.
		May specify multiple values according to --motifs option.
		'e,e,e,e,e,e' is default.
[00;01m
	--motifs [00;04mmotifs[00;00m
		Specify hot- and coldspot motifs to be modeled.
		[00;04mmotifs[00;00m = FCH (default) : Free coldspots and hotspots. Estimate separate rates for six canonical motifs.
		Otherwise, motifs specified by <motif>_<mutable position>:<index_in_hotness>.
		[00;04mmotifs[00;00m = WRC_2:0 | GYW_0:0 | WA_1:0 | TW_0:0 | SYC_2:0 | GRS_0:0 : Model rate specific motif(s).
		e.g. [00;04mmotifs[00;00m = WRC_2:0,GYW_0:0 symmetric WR[00;04mC[00;00m/[00;04mG[00;00mYW motifs.
		e.g. [00;04mmotifs[00;00m = WRC_2:0,GYW_0:1 asymmetric WR[00;04mC[00;00m/[00;04mG[00;00mYW motifs. Must specify two values in --hotness.
[00;01m
	-f (or --frequencies) [00;04mempirical[00;01m, [00;04mmodel[00;00m, [00;04moptimized[00;00m, [00;04mfT,fC,fA,fG[00;00m,
		[00;04mfT1,fC1,fA1,fG1,fT2,fC2,fA2,fG2,fT3,fC3,fA3,fG3[00;00m
	                       [00;01mor[00;00m [00;04mfC1,fC2, ... ,fC64[00;00m
		[00;04mempirical[00;00m: (GY default) the equilibrium codon frequencies are estimated by counting
		 the occurence of bases or codons in the alignment.
		[00;04moptimize[00;00m : (HLP17 default) codon frequencies are estimated using maximum likelihood
[00;01m
	--fmodel [00;04mfrequency model[00;00m
		Which frequency model to use.
		[00;04mfrequency model[00;00m = [00;04mF1XCODONS[00;00m | [00;04mF1X4[00;00m | [00;04mF3X4[00;00m | [00;04mCF3X4[00;00m (default)
[00;01m
Optimization options:
[00;00m[00;01m
	-o (or --optimize) [00;04mparams[00;00m
		This option focuses on specific parameter optimisation.
		[00;04mparams[00;00m = tlr : (default) tree topology (t), branch length (l) and rate parameters (r) are optimised.
		[00;04mparams[00;00m = tl  : tree topology and branch length are optimised.
		[00;04mparams[00;00m = lr  : branch length and rate parameters are optimised.
		[00;04mparams[00;00m = l   : branch length are optimised.
		[00;04mparams[00;00m = r   : rate parameters are optimised.
		[00;04mparams[00;00m = n   : no parameter is optimised.
[00;01m
	-s (or --search) [00;04mmove[00;00m
		Tree topology search operation option.
		Can be either [00;04mNNI[00;00m (default, fast) or [00;04mSPR[00;00m (thorough, slow).
[00;01m
	--threads [00;04mnum_threads[00;00m
		Number of threads to use for parallelization. Default is 1.
[00;01m
	--minSeq [00;04mminimum_sequences[00;00m
		Minimum number of sequences (including germline) per lineage for inclusion in analysis.
[00;01m
	-h (or --help)[00;00m
		[00;00mShow this help message and exit.
```


## Metadata
- **Skill**: generated

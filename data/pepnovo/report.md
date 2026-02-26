# pepnovo CWL Generation Report

## pepnovo_PepNovo_bin

### Tool Description
PepNovo+ - de Novo peptide sequencing and MS-Filter - spectal quality scoring, precursor mass correction and chage determination.

### Metadata
- **Docker Image**: biocontainers/pepnovo:v20120423_cv3
- **Homepage**: https://github.com/jmchilton/pepnovo
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pepnovo/overview
- **Total Downloads**: 29.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jmchilton/pepnovo
- **Stars**: N/A
### Original Help Text
```text
**********************************************************

Error: Unkown command line option: --help

***************************************************************************



PepNovo+ - de Novo peptide sequencing and
MS-Filter - spectal quality scoring, precursor mass correction and chage determination.
Release 20101117.
All rights reserved to the Regents of the University of California.

Required arguments:
-------------------

-model <model name>

-file <path to input file>  - PepNovo can analyze dta,mgf and mzXML files
   OR
-list <path to text file listing input files>


Optional PepNovo arguments: 
----------------------------- 
-prm		- only print spectrum graph nodes with scores.
-prm_norm   - prints spectrum graph scores after normalization and removal of negative scores.
-correct_pm - finds optimal precursor mass and charge values.
-use_spectrum_charge - does not correct charge.
-use_spectrum_mz     - does not correct the precursor m/z value that appears in the file.
-no_quality_filter   - does not remove low quality spectra.
-output_aa_probs	 - calculates the probabilities of individual amino acids.
-output_cum_probs    - calculates the cumulative probabilities (that at least one sequence upto rank X is correct).
-fragment_tolerance < 0-0.75 > - the fragment tolerance (each model has a default setting)
-pm_tolerance       < 0-5.0 > - the precursor masss tolerance (each model has a default setting)
-PTMs   <PTM string>    - seprated  by a colons (no spaces) e.g., M+16:S+80:N+1
-digest <NON_SPECIFIC,TRYPSIN> - default TRYPSIN
-num_solutions < 1-2000 > - default 20
-tag_length < 3-6> - returns peptide sequence of the specified length (only lengths 3-6 are allowed).
-model_dir  < path > - directory where model files are kept (default ./Models)

-max_pm	         <X> - X is the maximal precursor mass to be considered (good for shorty searhces).

Optional MS-Filter arguments:
-----------------------------
-min_filter_prob <xx=0-1.0> - filter out spectra from denovo/tag/prm run with a quality probability less than x (e.g., x=0.1)
-pmcsqs_only   - only output the corrected precursor mass, charge and filtering values
-filter_spectra <sqs thresh> <out dir>  - outputs MGF files for spectra that have a minimal qulaity score above *thresh* (it is recomended to use a value of 0.05-0.1). These MGF files will be sent to the directory given in out_dir and have a name with the prefix given in the third argument.
 NOTE: this option must be used in conjuction with  "-pmcsqs_only" the latter option will also correct the m/z value and assign a charge to the spectrum.

-pmcsqs_and_prm <min prob> - print spectrum graph nodes for spectra that have an SQS probability score of at least <min prob> (typically should have a value 0-0.2)


Predicting fragmentation patterns:
----------------------------------
-predict_fragmentation <X> - X is the input file with a list of peptides and charges (one per line)
-num_peaks             <N> - N is the maximal number of fragment peaks to predict


Parameters for Blast:
---------------------
-msb_generate_query   - performs denovo sequencing and generates a BLAST query.
-msb_merge_queries    -	takes a list of PepNovo "_full.txt" files, merges them and creates queries(list should be given with -list flag).
-msb_query_name       <X> - the name to be given to the main output file.
-msb_query_size       <X> - max size of MSB query allowed (default X=1000000).
-msb_num_solutions    <X> - number of sequences to generate per spectrum (default X=7).
-msb_min_score        <X> - the minimal MS-Blast score to be included in the query, default X=4.0 .

Citations:
----------
- Frank, A. and Pevzner, P. "PepNovo: De Novo Peptide Sequencing via Probabilistic Network Modeling", Analytical Chemistry 77:964-973, 2005.
- Frank, A., Tanner, S., Bafna, V. and Pevzner, P. "Peptide sequence tags for fast database search in mass-spectrometry", J. Proteome Res. 2005 Jul-Aug;4(4):1287-95.
- Frank, A.M., Savitski, M.M., Nielsen, L.M., Zubarev, R.A., Pevzner, P.A. "De Novo Peptide Sequencing and Identification with Precision Mass Spectrometry", J. Proteome Res. 6:114-123, 2007.
- Frank, A.M. "A Ranking-Based Scoring Function for Peptide-Spectrum Matches", J.Proteome Res. 8:2241-2252, 2009.

Please send comments and bug reports to Ari Frank (arf@cs.ucsd.edu).
```


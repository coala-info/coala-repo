# transit CWL Generation Report

## transit_example

### Tool Description
Generates an example configuration for Transit1.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Total Downloads**: 34.8K
- **Last updated**: 2025-12-26
- **GitHub**: https://github.com/mad-lab/transit
- **Stars**: N/A
### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: list index out of range
python3 /usr/local/bin/transit example <comma-separated .wig files> <annotation .prot_table> <output file>
```


## transit_gumbel

### Tool Description
Runs the Gumbel model for transcript analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: list index out of range
python3 /usr/local/bin/transit gumbel <comma-separated .wig files> <annotation .prot_table or GFF3> <output file> [Optional Arguments]
    
        Optional Arguments:
        -s <integer>    :=  Number of samples. Default: -s 10000
        -b <integer>    :=  Number of Burn-in samples. Default -b 500
        -m <integer>    :=  Smallest read-count to consider. Default: -m 1
        -t <integer>    :=  Trims all but every t-th value. Default: -t 1
        -r <string>     :=  How to handle replicates. Sum or Mean. Default: -r Sum
        -iN <float>     :=  Ignore TAs occuring within given percentage (as integer) of the N terminus. Default: -iN 0
        -iC <float>     :=  Ignore TAs occuring within given percentage (as integer) of the C terminus. Default: -iC 0
```


## transit_binomial

### Tool Description
Performs binomial transit analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: list index out of range
python3 /usr/local/bin/transit binomial <comma-separated .wig files> <annotation .prot_table or GFF3> <output file> [Optional Arguments]

        Optional Arguments:
            -s <int>        :=  Number of samples to take. Default: -s 10000
            -b <int>        :=  Number of burn-in samples to take. Default: -b 500
            -iN <float>     :=  Ignore TAs occuring at given percentage (as integer) of the N terminus. Default: -iN 0
            -iC <float>     :=  Ignore TAs occuring at given percentage (as integer) of the C terminus. Default: -iC 0

            Hyper-parameters:
            -pi0 <float>     :=  Hyper-parameters for rho, non-essential genes. Default: -pi0 0.5
            -pi1 <float>     :=  Hyper-parameters for rho, essential genes. Default: -pi1 0.5
            -M0 <float>     :=  Hyper-parameters for rho, non-essential genes. Default: -M0 1.0
            -M1 <float>     :=  Hyper-parameters for rho, essential genes. Default: -M1 1.0

            -a0 <float>     :=  Hyper-parameters for kappa, non-essential genes. Default: -a0 10
            -a1 <float>     :=  Hyper-parameters for kappa, essential genes. Default: -a1 10
            -b0 <float>     :=  Hyper-parameters for kappa, non-essential genes. Default: -b0 1.0
            -b1 <float>     :=  Hyper-parameters for kappa, essential genes. Default: -b1 1.0

            -aw <float>     :=  Hyper-parameters for prior prob of gene being essential. Default: -aw 0.5
            -bw <float>     :=  Hyper-parameters for prior prob of gene being essential. Default: -bw 0.5
```


## transit_griffin

### Tool Description
Transit1 v3.3.20

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: list index out of range
python3 /usr/local/bin/transit griffin <comma-separated .wig files> <annotation .prot_table> <output file> [Optional Arguments]

        Optional Arguments:
        -m <integer>    :=  Smallest read-count to consider. Default: -m 1
        -r <string>     :=  How to handle replicates. Sum or Mean. Default: -r Sum
        -sC             :=  Include stop-codon (default is to ignore).
        -iN <float>     :=  Ignore TAs occuring at given fraction (as integer) of the N terminus. Default: -iN 0
        -iC <float>     :=  Ignore TAs occuring at given fraction (as integer) of the C terminus. Default: -iC 0
```


## transit_hmm

### Tool Description
Transit1 v3.3.20

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: list index out of range
python3 /usr/local/bin/transit hmm <comma-separated .wig files> <annotation .prot_table or GFF3> <output_BASE_filename>
        (will create 2 output files: BASE.sites.txt and BASE.genes.txt)

        Optional Arguments:
            -r <string>     :=  How to handle replicates. Sum, Mean. Default: -r Mean
            -n <string>     :=  Normalization method. Default: -n TTR
            -l              :=  Perform LOESS Correction; Helps remove possible genomic position bias. Default: Off.
            -iN <float>     :=  Ignore TAs occuring within given percentage (as integer) of the N terminus. Default: -iN 0
            -iC <float>     :=  Ignore TAs occuring within given percentage (as integer) of the C terminus. Default: -iC 0
```


## transit_resampling

### Tool Description
Performs resampling for differential analysis of transit data.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: Incorrect number of args. See usage

        python3 /usr/local/bin/transit resampling <comma-separated .wig control files> <comma-separated .wig experimental files> <annotation .prot_table or GFF3> <output file> [Optional Arguments]
        ---
        OR
        ---
        python3 /usr/local/bin/transit resampling -c <combined wig file> <samples_metadata file> <ctrl condition name> <exp condition name> <annotation .prot_table> <output file> [Optional Arguments]
        NB: The ctrl and exp condition names should match Condition names in samples_metadata file.

        Optional Arguments:
        -s <integer>    :=  Number of samples. Default: -s 10000
        -n <string>     :=  Normalization method. Default: -n TTR
        -h              :=  Output histogram of the permutations for each gene. Default: Turned Off.
        -a              :=  Perform adaptive resampling. Default: Turned Off.
        -ez             :=  Exclude rows with zero across conditions. Default: Turned off
                            (i.e. include rows with zeros).
        -PC <float>     :=  Pseudocounts used in calculating LFC. (default: 1)
        -l              :=  Perform LOESS Correction; Helps remove possible genomic position bias.
                            Default: Turned Off.
        -iN <int>       :=  Ignore TAs occuring within given percentage (as integer) of the N terminus. Default: -iN 0
        -iC <int>       :=  Ignore TAs occuring within given percentage (as integer) of the C terminus. Default: -iC 0
        --ctrl_lib      :=  String of letters representing library of control files in order
                            e.g. 'AABB'. Default empty. Letters used must also be used in --exp_lib
                            If non-empty, resampling will limit permutations to within-libraries.

        --exp_lib       :=  String of letters representing library of experimental files in order
                            e.g. 'ABAB'. Default empty. Letters used must also be used in --ctrl_lib
                            If non-empty, resampling will limit permutations to within-libraries.
        -winz           :=  winsorize insertion counts for each gene in each condition 
                            (replace max cnt in each gene with 2nd highest; helps mitigate effect of outliers)
        -sr             :=  site-restricted resampling; more sensitive, might find a few more significant conditionally essential genes"
```


## transit_tn5gaps

### Tool Description
Identify transposon insertion sites and their genomic context.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: list index out of range
python3 /usr/local/bin/transit tn5gaps <comma-separated .wig files> <annotation .prot_table or GFF3> <output file> [Optional Arguments]
    
        Optional Arguments:
        -m <integer>    :=  Smallest read-count to consider. Default: -m 1
        -r <string>     :=  How to handle replicates. Sum or Mean. Default: -r Sum
        -iN <float>     :=  Ignore TAs occuring within given percentage (as integer) of the N terminus. Default: -iN 0
        -iC <float>     :=  Ignore TAs occuring within given percentage (as integer) of the C terminus. Default: -iC 0
```


## transit_rankproduct

### Tool Description
Performs rank product analysis for differential gene expression between control and experimental samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: list index out of range
python3 /usr/local/bin/transit rankproduct <comma-separated .wig control files> <comma-separated .wig experimental files> <annotation .prot_table or GFF3> <output file> [Optional Arguments]
    
        Optional Arguments:
        -s <integer>    :=  Number of samples. Default: -s 100
        -n <string>     :=  Normalization method. Default: -n TTR
        -h              :=  Output histogram of the permutations for each gene. Default: Turned Off.
        -a              :=  Perform adaptive rankproduct. Default: Turned Off.
        -l              :=  Perform LOESS Correction; Helps remove possible genomic position bias. Default: Turned Off.
        -iN <float>     :=  Ignore TAs occuring at given fraction (as integer) of the N terminus. Default: -iN 0
        -iC <float>     :=  Ignore TAs occuring at given fraction (as integer) of the C terminus. Default: -iC 0
```


## transit_utest

### Tool Description
Performs differential analysis of transcription-associated sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: list index out of range
python3 /usr/local/bin/transit utest <comma-separated .wig control files> <comma-separated .wig experimental files> <annotation .prot_table or GFF3> <output file> [Optional Arguments]

        Optional Arguments:
        -n <string>     :=  Normalization method. Default: -n TTR
        -iz             :=  Include rows with zero accross conditions.
        -l              :=  Perform LOESS Correction; Helps remove possible genomic position bias. Default: Turned Off.
        -iN <float>     :=  Ignore TAs occuring at given fraction (as integer) of the N terminus. Default: -iN 0
        -iC <float>     :=  Ignore TAs occuring at given fraction (as integer) of the C terminus. Default: -iC 0
```


## transit_gi

### Tool Description
Transit1 is a tool for analyzing high-throughput sequencing data. This specific invocation seems to be related to selecting a method for analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: The 'gi' method is unknown.
Please use one of the known methods (or see documentation to add a new one):
	 - example
	 - gumbel
	 - binomial
	 - griffin
	 - hmm
	 - resampling
	 - tn5gaps
	 - rankproduct
	 - utest
	 - GI
	 - anova
	 - zinb
	 - normalize
	 - pathway_enrichment
	 - tnseq_stats
	 - corrplot
	 - heatmap
	 - ttnfitness
	 - CGI
Usage: python /usr/local/bin/transit <method>
```


## transit_anova

### Tool Description
Performs ANOVA analysis on combined wig files based on samples metadata and annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: list index out of range
Usage: python3 transit.py anova <combined wig file> <samples_metadata file> <annotation .prot_table> <output file> [Optional Arguments]
 Optional Arguments:
  -n <string>         :=  Normalization method. Default: -n TTR
  --include-conditions <cond1,...> := Comma-separated list of conditions to use for analysis (Default: all)
  --exclude-conditions <cond1,...> := Comma-separated list of conditions to exclude (Default: none)
  --ref <cond> := which condition(s) to use as a reference for calculating LFCs (comma-separated if multiple conditions)
  -iN <N> :=  Ignore TAs within given percentage (e.g. 5) of N terminus. Default: -iN 0
  -iC <N> :=  Ignore TAs within given percentage (e.g. 5) of C terminus. Default: -iC 0
  -PC <N> := pseudocounts to use for calculating LFCs. Default: -PC 5
  -alpha <N> := value added to MSE in F-test for moderated anova (makes genes with low counts less significant). Default: -alpha 1000
  -winz   := winsorize insertion counts for each gene in each condition (replace max cnt with 2nd highest; helps mitigate effect of outliers)
```


## transit_zinb

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: R and rpy2 (~= 3.0) required to run ZINB analysis.
After installing R, you can install rpy2 using the command "pip install 'rpy2~=3.0'"
```


## transit_pathway_enrichment

### Tool Description
Performs pathway enrichment analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: list index out of range
python3 /usr/local/bin/transit pathway_enrichment <resampling_file> <associations> <pathways> <output_file> [-M <FET|GSEA|GO>] [-PC <int>] [-ranking SLPV|LFC] [-p <float>] [-Nperm <int>] [-Pval_col <int>] [-Qval_col <int>]  [-LFC_col <int>]

Optional parameters:
 -M FET|GSEA|ONT:     method to use, FET for Fisher's Exact Test (default), GSEA for Gene Set Enrichment Analysis (Subramaniam et al, 2005), or ONT for Ontologizer (Grossman et al, 2007)
 -Pval_col <int>    : indicate column with *raw* P-values (starting with 0; can also be negative, i.e. -1 means last col) (used for sorting) (default: -2)
 -Qval_col <int>    : indicate column with *adjusted* P-values (starting with 0; can also be negative, i.e. -1 means last col) (used for significant cutoff) (default: -1)
 for GSEA...
   -ranking SLPV|LFC  : SLPV is signed-log-p-value (default); LFC is log2-fold-change from resampling 
   -LFC_col <int>     : indicate column with log2FC (starting with 0; can also be negative, i.e. -1 means last col) (used for ranking genes by SLPV or LFC) (default: 6)
   -p <float>         : exponent to use in calculating enrichment score; recommend trying 0 or 1 (as in Subramaniam et al, 2005)
   -Nperm <int>       : number of permutations to simulate for null distribution to determine p-value (default=10000)
 for FET...
   -focusLFC pos|neg  :  filter the output to focus on results with positive (pos) or negative (neg) LFCs (default: "all", no filtering)
   -minLFC <float>    :  filter the output to include only genes that have a magnitude of LFC greater than the specified value (default: 0) (e.g. '-minLFC 1' means analyze only genes with 2-fold change or greater)
   -qval <float>      :  filter the output to include only genes that have Qval less than to the value specified (default: 0.05)
   -topk <int>        :  calculate enrichment among top k genes ranked by significance (Qval) regardless of cutoff (can combine with -focusLFC)
   -PC <int>          :  pseudo-counts to use in calculating p-value based on hypergeometric distribution (default=2)
```


## transit_tnseq_stats

### Tool Description
Calculate statistics for TnSeq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
usage: python3 /usr/local/bin/transit tnseq_stats <file.wig>+ [-o <output_file>]
       python /usr/local/bin/transit tnseq_stats -c <combined_wig> [-o <output_file>]
```


## transit_corrplot

### Tool Description
Generates a correlation plot using R and rpy2.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: R and rpy2 (~= 3.0) required to run corrplot.
After installing R, you can install rpy2 using the command "pip install 'rpy2~=3.0'"
```


## transit_heatmap

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: R and rpy2 (~= 3.0) required to run heatmap.
After installing R, you can install rpy2 using the command "pip install 'rpy2~=3.0'"
```


## transit_ttnfitness

### Tool Description
Calculates fitness based on transit data.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: list index out of range
python3 /usr/local/bin/transit ttnfitness <comma-separated .wig files> <annotation .prot_table> <genome .fna> <gumbel output file> <output1 file> <output2 file>
```


## transit_cgi

### Tool Description
Transit1 v3.3.20

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: The 'cgi' method is unknown.
Please use one of the known methods (or see documentation to add a new one):
	 - example
	 - gumbel
	 - binomial
	 - griffin
	 - hmm
	 - resampling
	 - tn5gaps
	 - rankproduct
	 - utest
	 - GI
	 - anova
	 - zinb
	 - normalize
	 - pathway_enrichment
	 - tnseq_stats
	 - corrplot
	 - heatmap
	 - ttnfitness
	 - CGI
Usage: python /usr/local/bin/transit <method>
```


## transit_normalize

### Tool Description
Normalize wig files

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: Must provide all necessary arguments

python3 /usr/local/bin/transit normalize <input.wig> <output.wig> [-n TTR|betageom]
---
OR
---
python3 /usr/local/bin/transit normalize -c <input combined_wig> <output.wig> [-n TTR|betageom]

        Optional Arguments:
        -n <string>     :=  Normalization method. Default: -n TTR
```


## transit_convert

### Tool Description
Convert between different data formats. Please use one of the known methods (or see documentation to add a new one).

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: Need to specify the convert method.
Please use one of the known methods (or see documentation to add a new one):
	 - gff_to_prot_table
Usage: python /usr/local/bin/transit convert <method>
```


## transit_export

### Tool Description
Export data from Transit1. Please use one of the known methods (or see documentation to add a new one).

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
=== Transit1 v3.3.20 ===
Error: Need to specify the export method.
Please use one of the known methods (or see documentation to add a new one):
	 - combined_wig
	 - igv
	 - mean_counts
Usage: python /usr/local/bin/transit export <method>
```


## Metadata
- **Skill**: not generated

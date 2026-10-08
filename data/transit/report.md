# transit CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| transit_anova | PASS |  |
| transit_binomial | PASS |  |
| transit_cgi | Failed | image problem: R and rpy2 are missing, and this version says CGI moved to Transit2 |
| transit_convert_gff_to_prot_table | PASS |  |
| transit_corrplot | Failed | image problem: R and rpy2 are missing |
| transit_example | PASS |  |
| transit_export_combined_wig | PASS |  |
| transit_export_igv | PASS |  |
| transit_export_mean_counts | PASS |  |
| transit_gi | PASS |  |
| transit_griffin | PASS |  |
| transit_gumbel | PASS |  |
| transit_heatmap | Failed | image problem: R and rpy2 missing in the image (Error: R and rpy2 (~= 3.0) required to run heatmap) |
| transit_hmm | PASS |  |
| transit_normalize | PASS |  |
| transit_pathway_enrichment | PASS |  |
| transit_rankproduct | PASS | crashes when control and experimental replicate counts differ (tool bug); works with equal counts |
| transit_resampling | PASS |  |
| transit_tn5gaps | PASS |  |
| transit_tnseq_stats | PASS |  |
| transit_ttnfitness | Failed | image problem: pandas 0.24 is too old (sort_values ignore_index fails) |
| transit_utest | PASS |  |
| transit_zinb | Failed | image problem: R and rpy2 missing in the image (Error: R and rpy2 (~= 3.0) required to run ZINB analysis) |

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

## transit_export_combined_wig

### Tool Description
Export several wig files as one combined wig file (normalized).

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Incorrect number of args. See usage
python /usr/local/bin/transit export combined_wig <comma-separated .wig files> <annotation .prot_table> <output file> [-n normalization_method]
default normalization_method=TTR
```

## transit_export_igv

### Tool Description
Export wig files to the IGV format.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
Error: list index out of range
python /usr/local/bin/transit export igv <comma-separated .wig files> <annotation .prot_table> <output file>
```

## transit_export_mean_counts

### Tool Description
Export the mean insertion counts of each gene from wig files or a combined wig file.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
ARGS=[]
KWARGS={}
Error: list index out of range
python /usr/local/bin/transit export mean_counts <comma-separated .wig files>|<combined_wig> <annotation .prot_table> <output file> [-c]
 note: append -c if inputing a combined_wig file
```

## transit_convert_gff_to_prot_table

### Tool Description
Convert an annotation in GFF format to the .prot_table format used by Transit.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Please specify Input and Output paths
python /usr/local/bin/transit convert gff_to_prot_table <annotation in gff format> <output file>
```

## transit_gi

### Tool Description
Genetic interaction analysis comparing two strains in two conditions.

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
Error: list index out of range
python3 /usr/local/bin/transit GI <wigs_for_strA_cond1> <wigs_for_strA_cond2> <wigs_for_strB_cond1> <wigs_for_strB_cond2> <annotation .prot_table or GFF3> <output file> [Optional Arguments]

        GI performs a comparison among 4 groups of datasets, strain A and B assessed in conditions 1 and 2 (e.g. control vs treatment).
        It looks for interactions where the response to the treatment (i.e. effect on insertion counts) depends on the strain (output variable: delta_LFC).
        Provide replicates in each group as a comma-separated list of wig files.
        HDI is highest density interval for posterior distribution of delta_LFC, which is like a confidence interval on difference of slopes.
        Genes are sorted by probability of HDI overlapping with ROPE. (genes with the highest abs(mean_delta_logFC) are near the top, approximately)
        Significant genes are indicated by 'Type of Interaction' column (No Interaction, Aggravating, Alleviating, Suppressive).
          By default, hits are defined as "Is HDI outside of ROPE?"=TRUE (i.e. non-overlap of delta_LFC posterior distritbuion with Region of Probably Equivalence around 0)
          Alternative methods for significance: use -signif flag with prob, BFDR, or FWER. These affect 'Type of Interaction' (i.e. which genes are labeled 'No Interaction')

        Optional Arguments:
        -s <integer>    :=  Number of samples. Default: -s 10000
        --rope <float>  :=  Region of Practical Equivalence. Area around 0 (i.e. 0 +/- ROPE) that is NOT of interest. Can be thought of similar to the area of the null-hypothesis. Default: --rope 0.5
        -n <string>     :=  Normalization method. Default: -n TTR
        -iz             :=  Include rows with zero across conditions.
        -l              :=  Perform LOESS Correction; Helps remove possible genomic position bias. Default: Turned Off.
        -iN <float>     :=  Ignore TAs occuring at given percentage (as integer) of the N terminus. Default: -iN 0
        -iC <float>     :=  Ignore TAs occuring at given percentage (as integer) of the C terminus. Default: -iC 0
        -signif HDI     :=  (default) Significant if HDI does not overlap ROPE; if HDI overlaps ROPE, 'Type of Interaction' is set to 'No Interaction'
        -signif prob    :=  Optionally, significant hits are re-defined based on probability (degree) of overlap of HDI with ROPE, prob<0.05 (no adjustment)
        -signif BFDR    :=  Apply "Bayesian" FDR correction (see doc) to adjust HDI-ROPE overlap probabilities so that significant hits are re-defined as BFDR<0.05
        -signif FWER    :=  Apply "Bayesian" FWER correction (see doc) to adjust HDI-ROPE overlap probabilities so that significant hits are re-defined as FWER<0.05
```

## transit_cgi

### Tool Description
CRISPRi chemical genetic analysis (CRISPRi-DR).

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
usage (6 sub-commands):
    python3 ../src/transit.py CGI extract_counts <fastq file> <ids file> > <counts file>
    python3 ../src/transit.py CGI create_combined_counts <comma seperated headers> <counts file 1> <counts file 2> ... <counts file n> > <combined counts file>
    python3 ../src/transit.py CGI extract_abund <combined counts file> <metadata file> <control condition> <sgRNA efficiency file> <uninduced ATC file> <drug> <days>  >  <fractional abundundance file>
    python3 ../src/transit.py CGI run_model <fractional abundundance file>  >  <CRISPRi DR results file>
    python3 ../src/transit.py CGI visualize <fractional abundance> <gene> <output figure location>
    note: redirect output from stdout to output files as shown above
```

## transit_corrplot

### Tool Description
Correlation plot of the gene means of the samples (needs R and rpy2).

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: python3 transit.py corrplot <gene_means> <output.png> [-anova|-zinb]
```

## transit_zinb

### Tool Description
Zero-inflated negative binomial test for differences in essentiality among several conditions (needs R and rpy2).

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
python3 transit.py zinb <combined wig file> <samples_metadata file> <annotation .prot_table> <output file> [Optional Arguments]

        Optional Arguments:
        -n <string>         :=  Normalization method. Default: -n TTR
        --exclude-conditions <cond1,cond2> :=  Comma separated list of conditions to exclude, for the analysis.
        --include-conditions <cond1,cond2> :=  Comma separated list of conditions to include, for the analysis. Conditions not in this list, will be excluded.
        --ref <cond> := which condition(s) to use as a reference for calculating LFCs (comma-separated if multiple conditions)
        -iN <float>     := Ignore TAs occuring within given percentage (as integer) of the N terminus. Default: -iN 5
        -iC <float>     := Ignore TAs occuring within given percentage (as integer) of the C terminus. Default: -iC 5
        -winz           := winsorize insertion counts for each gene in each condition (replace max cnt with 2nd highest; helps mitigate effect of outliers)
        -PC <N>         := pseudocounts to use for calculating LFCs. Default: -PC 5
        --condition     := columnname (in samples_metadata) to use as the Condition. Default: "Condition"
        --covars <covar1,covar2...>       := Comma separated list of covariates (in metadata file) to include, for the analysis.
        --interactions <covar1,covar2...> := Comma separated list of covariates to include, that interact with the condition for the analysis. Must be factors
        --prot_table <filename>           := for appending annotations of genes
        --gene <RV number or Gene name>   := Run method for one gene and print model output.
```

## transit_heatmap

### Tool Description
Heatmap of gene means from the output of the anova or zinb analysis (needs R and rpy2).

### Metadata
- **Docker Image**: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
- **Homepage**: http://github.com/mad-lab/transit
- **Package**: https://anaconda.org/channels/bioconda/packages/transit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: python3 transit.py heatmap <anova_or_zinb_output> <heatmap.png> -anova|-zinb [-topk <int>] [-qval <float>] [-low_mean_filter <int>]
 note: genes are selected based on qval<0.05 by default
```

## Metadata
- **Skill**: not generated

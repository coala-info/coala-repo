# scoary CWL Generation Report

## scoary

### Tool Description
Screen pan-genome for trait-associated variants

### Metadata
- **Docker Image**: biocontainers/scoary:v1.6.16-1-deb_cv1
- **Homepage**: https://github.com/AdmiralenOla/Scoary
- **Package**: https://anaconda.org/channels/bioconda/packages/scoary/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scoary/overview
- **Total Downloads**: 16.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AdmiralenOla/Scoary
- **Stars**: N/A
### Original Help Text
```text
usage: scoary [-h] [-t TRAITS] [-g GENES] [-n NEWICKTREE] [-s START_COL]
              [--delimiter DELIMITER] [-r RESTRICT_TO] [-o OUTDIR] [-u]
              [-p P_VALUE_CUTOFF [P_VALUE_CUTOFF ...]]
              [-c [{I,B,BH,PW,EPW,P} [{I,B,BH,PW,EPW,P} ...]]] [-m MAX_HITS]
              [--include_input_columns GRABCOLS] [-w] [--no-time] [-e PERMUTE]
              [--no_pairwise] [--collapse] [--threads THREADS] [--test]
              [--citation] [--version]

Scoary version 1.6.16 - Screen pan-genome for trait-associated variants

optional arguments:
  -h, --help            show this help message and exit

Input options:
  -t TRAITS, --traits TRAITS
                        Input trait table (comma-separated-values). Trait
                        presence is indicated by 1, trait absence by 0.
                        Assumes strain names in the first column and trait
                        names in the first row
  -g GENES, --genes GENES
                        Input gene presence/absence table (comma-separated-
                        values) from ROARY. Strain names must be equal to
                        those in the trait table
  -n NEWICKTREE, --newicktree NEWICKTREE
                        Supply a custom tree (Newick format) for phylogenetic
                        analyses instead instead of calculating it internally.
  -s START_COL, --start_col START_COL
                        On which column in the gene presence/absence file do
                        individual strain info start. Default=15. (1-based
                        indexing)
  --delimiter DELIMITER
                        The delimiter between cells in the gene
                        presence/absence and trait files, as well as the
                        output file.
  -r RESTRICT_TO, --restrict_to RESTRICT_TO
                        Use if you only want to analyze a subset of your
                        strains. Scoary will read the provided comma-separated
                        table of strains and restrict analyzes to these.

Output options:
  -o OUTDIR, --outdir OUTDIR
                        Directory to place output files. Default = .
  -u, --upgma_tree      This flag will cause Scoary to write the calculated
                        UPGMA tree to a newick file
  -p P_VALUE_CUTOFF [P_VALUE_CUTOFF ...], --p_value_cutoff P_VALUE_CUTOFF [P_VALUE_CUTOFF ...]
                        P-value cut-off / alpha level. For Fishers,
                        Bonferronis, and Benjamini-Hochbergs tests, SCOARY
                        will not report genes with higher p-values than this.
                        For empirical p-values, this is treated as an alpha
                        level instead. I.e. 0.02 will filter all genes except
                        the lower and upper percentile from this test. Run
                        with "-p 1.0" to report all genes. Accepts standard
                        form (e.g. 1E-8). Provide a single value (applied to
                        all) or exactly as many values as correction criteria
                        and in corresponding order. (See example under
                        correction). Default = 0.05
  -c [{I,B,BH,PW,EPW,P} [{I,B,BH,PW,EPW,P} ...]], --correction [{I,B,BH,PW,EPW,P} [{I,B,BH,PW,EPW,P} ...]]
                        Apply the indicated filtration measure. Allowed values
                        are I, B, BH, PW, EPW, P. I=Individual (naive)
                        p-value. B=Bonferroni adjusted p-value. BH=Benjamini-
                        Hochberg adjusted p. PW=Best (lowest) pairwise
                        comparison. EPW=Entire range of pairwise comparison
                        p-values. P=Empirical p-value from permutations. You
                        can enter as many correction criteria as you would
                        like. These will be associated with the
                        p_value_cutoffs you enter. For example "-c I EPW -p
                        0.1 0.05" will apply the following cutoffs: Naive
                        p-value must be lower than 0.1 AND the entire range of
                        pairwise comparison values are below 0.05 for this
                        gene. Note that the empirical p-values should be
                        interpreted at both tails. Therefore, running "-c P -p
                        0.05" will apply an alpha of 0.05 to the empirical
                        (permuted) p-values, i.e. it will filter everything
                        except the upper and lower 2.5 percent of the
                        distribution. Default = Individual p-value. (I)
  -m MAX_HITS, --max_hits MAX_HITS
                        Maximum number of hits to report. SCOARY will only
                        report the top max_hits results per trait
  --include_input_columns GRABCOLS
                        Grab columns from the input Roary file. and puts them
                        in the output. Handles comma and ranges, e.g.
                        --include_input_columns 4,6,8,16-23. The special
                        keyword ALL will include all relevant input columns in
                        the output
  -w, --write_reduced   Use with -r if you want Scoary to create a new gene
                        presence absence file from your reduced set of
                        isolates. Note: Columns 1-14 (No. sequences, Avg group
                        size nuc etc) in this file do not reflect the reduced
                        dataset. These are taken from the full dataset.
  --no-time             Output file in the form TRAIT.results.csv, instead of
                        TRAIT_TIMESTAMP.csv. When used with the -w argument
                        will output a reduced gene matrix in the form
                        gene_presence_absence_reduced.csv rather than
                        gene_presence_absence_reduced_TIMESTAMP.csv

Analysis options:
  -e PERMUTE, --permute PERMUTE
                        Perform N number of permutations of the significant
                        results post-analysis. Each permutation will do a
                        label switching of the phenotype and a new p-value is
                        calculated according to this new dataset. After all N
                        permutations are completed, the results are ordered in
                        ascending order, and the percentile of the original
                        result in the permuted p-value distribution is
                        reported.
  --no_pairwise         Do not perform pairwise comparisons. Inthis mode,
                        Scoary will perform population structure-naive
                        calculations only. (Fishers test, ORs etc). Useful for
                        summary operations and exploring sets. (Genes unique
                        in groups, intersections etc) but not causal analyses.
  --collapse            Add this to collapse correlated genes (genes that have
                        identical distribution patterns in the sample) into
                        merged units.

Misc options:
  --threads THREADS     Number of threads to use. Default = 1
  --test                Run Scoary on the test set in exampledata, overriding
                        all other parameters.
  --citation            Show citation information, and exit.
  --version             Display Scoary version, and exit.

by Ola Brynildsrud (olbb@fhi.no)
```


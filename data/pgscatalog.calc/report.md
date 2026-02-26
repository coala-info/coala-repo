# pgscatalog.calc CWL Generation Report

## pgscatalog.calc_pgscatalog-aggregate

### Tool Description
Aggregate plink .sscore files into a combined TSV table.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog.calc:0.3.1--pyhdfd78af_1
- **Homepage**: https://github.com/PGScatalog/pygscatalog/
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog.calc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pgscatalog.calc/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2026-01-12
- **GitHub**: https://github.com/PGScatalog/pygscatalog
- **Stars**: N/A
### Original Help Text
```text
usage: pgscatalog-aggregate [-h] -s SCORES [SCORES ...] -o OUTDIR --split |
                            --no-split [-v] [--verify_variants]

Aggregate plink .sscore files into a combined TSV table.

This aggregation sums scores that were calculated from plink
.scorefiles. Scorefiles may be split to calculate scores over different
chromosomes or effect types. The PGS Catalog calculator automatically splits
scorefiles where appropriate, and uses this script to combine them.

Input .sscore files can be optionally compressed with zstd or gzip. 

The aggregated output scores are compressed with gzip.

options:
  -h, --help            show this help message and exit
  -s SCORES [SCORES ...], --scores SCORES [SCORES ...]
                        <Required> List of scorefile paths. Use a wildcard (*)
                        to select multiple files.
  -o OUTDIR, --outdir OUTDIR
                        <Required> Output directory to store downloaded files
  --split, --no-split   Make one aggregated file per sampleset
  -v, --verbose         <Optional> Extra logging information
  --verify_variants     <Optional> Verify variants from scoring file match
                        scored variants perfectly. Note: requires
                        .scorefile.gz files used by plink to create the
                        calculated score, and a .sscore.vars file output by
                        plink after scoring It's assumed that these files have
                        a common file name prefix (this is default plink
                        behaviour) e.g. cineca_22_additive_0.sscore.zst needs
                        cineca_22_additive_0.scorefile.gz &
                        cineca_22_additive_0.sscore.vars
```


## pgscatalog.calc_pgscatalog-ancestry-adjust

### Tool Description
Program to analyze ancestry outputs of the pgscatalog/pgsc_calc pipeline. Current inputs: 
  - PCA projections from reference and target datasets (*.pcs) 
  - calculated polygenic scores (e.g. aggregated_scores.txt.gz), 
  - information about related samples in the reference dataset (e.g. deg2_hg38.king.cutoff.out.id).

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog.calc:0.3.1--pyhdfd78af_1
- **Homepage**: https://github.com/PGScatalog/pygscatalog/
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog.calc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgscatalog-ancestry-adjust [-h] -d D_TARGET -r D_REF --ref_pcs REF_PCS
                                  [REF_PCS ...] --target_pcs TARGET_PCS
                                  [TARGET_PCS ...] --psam PSAM
                                  [-x REF_RELATED] [-p REF_LABEL]
                                  [-s SCOREFILE]
                                  [-a {RandomForest,Mahalanobis}]
                                  [--n_popcomp [1-20]] [-t PTHRESHOLD]
                                  [-n {empirical,mean,mean+var} [{empirical,mean,mean+var} ...]]
                                  [--n_normalization [1-20]] --outdir OUTDIR
                                  [-v]

Program to analyze ancestry outputs of the pgscatalog/pgsc_calc pipeline. Current inputs: 
  - PCA projections from reference and target datasets (*.pcs)
  - calculated polygenic scores (e.g. aggregated_scores.txt.gz), 
  - information about related samples in the reference dataset (e.g. deg2_hg38.king.cutoff.out.id).

options:
  -h, --help            show this help message and exit
  -d D_TARGET, --dataset D_TARGET
                        <Required> Label of the TARGET genomic dataset
  -r D_REF, --reference D_REF
                        <Required> Label of the REFERENCE genomic dataset
  --ref_pcs REF_PCS [REF_PCS ...]
                        <Required> Principal components path (output from
                        fraposa_pgsc)
  --target_pcs TARGET_PCS [TARGET_PCS ...]
                        <Required> Principal components path (output from
                        fraposa_pgsc)
  --psam PSAM           <Required> Reference sample information file path in
                        plink2 psam format)
  -x REF_RELATED, --reference_related REF_RELATED
                        File of related sample IDs (excluded from training
                        ancestry assignments)
  -p REF_LABEL, --pop_label REF_LABEL
                        Population labels in REFERENCE psam to use for
                        assignment
  -s SCOREFILE, --agg_scores SCOREFILE
                        Aggregated scores in PGS Catalog format ([sampleset,
                        IID] indexed)
  -a {RandomForest,Mahalanobis}, --ancestry_method {RandomForest,Mahalanobis}
                        Method used for population/ancestry assignment
  --n_popcomp [1-20]    Number of PCs used for population comparison (default
                        = 5)
  -t PTHRESHOLD, --pval_threshold PTHRESHOLD
                        p-value threshold used to identify low-confidence
                        ancestry similarities
  -n {empirical,mean,mean+var} [{empirical,mean,mean+var} ...], --normalization_method {empirical,mean,mean+var} [{empirical,mean,mean+var} ...]
                        Method used for adjustment of PGS using genetic
                        ancestry
  --n_normalization [1-20]
                        Number of PCs used for population NORMALIZATION
                        (default = 4)
  --outdir OUTDIR       <Required> Output directory
  -v, --verbose         <Optional> Extra logging information
```


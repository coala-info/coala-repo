# rvtests CWL Generation Report

## rvtests_rvtest

### Tool Description
RVTESTS is a powerful and flexible software package for association testing of genetic variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Total Downloads**: 10.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/zhanxw/rvtests
- **Stars**: N/A
### Original Help Text
```text
WARNING: long parameter should have two lead dashes: "-help"?
Basic Input/Output
                 --inVcf: Input VCF File
                --inBgen: Input BGEN File
          --inBgenSample: Input Sample IDs for the BGEN File
                 --inKgg: Input KGG File
                   --out: Output prefix
             --outputRaw: Output genotypes, phenotype, covariates(if any); and
                          collapsed genotype to tabular files
Specify Covariate
                 --covar: Specify covariate file
            --covar-name: Specify the column name in covariate file to be
                          included in analysis
                   --sex: Include sex (5th column in the PED file) as a covariate
Specify Phenotype
                 --pheno: Specify phenotype file
         --inverseNormal: Transform phenotype like normal distribution
--useResidualAsPhenotype: Fit covariate ~ phenotype, use residual to replace
                          phenotype
                --mpheno: Specify which phenotype column to read (default: 1);
            --pheno-name: Specify which phenotype column to read by header
                   --qtl: Treat phenotype as quantitative trait
         --multiplePheno: Specify aa template file for analyses of more than one
                          phenotype
Specify Genotype
                --dosage: Specify which dosage tag to use. (e.g. EC or DS);
        --multipleAllele: Support multi-allelic genotypes
Chromosome X Options
                --xLabel: Specify X chromosome label (default: 23|X);
            --xParRegion: Specify PAR region (default: hg19);, can be build
                          number e.g. hg38, b37; or specify region, e.g.
                          '60001-2699520,154931044-155260560'
People Filter
       --peopleIncludeID: List IDs of people that will be included in study
     --peopleIncludeFile: From given file, set IDs of people that will be
                          included in study
       --peopleExcludeID: List IDs of people that will be included in study
     --peopleExcludeFile: From given file, set IDs of people that will be
                          included in study
Site Filter
             --rangeList: Specify some ranges to use, please use chr:begin-end
                          format.
             --rangeFile: Specify the file containing ranges, please use
                          chr:begin-end format.
              --siteFile: Specify the file containing sites to include, please
                          use "chr pos" format.
          --siteDepthMin: Specify minimum depth(inclusive); to be included in
                          analysis
          --siteDepthMax: Specify maximum depth(inclusive); to be included in
                          analysis
            --siteMACMin: Specify minimum Minor Allele Count(inclusive); to be
                          included in analysis
              --annoType: Specify annotation type that is followed by ANNO= in
                          the VCF INFO field, regular expression is allowed
Genotype Filter
          --indvDepthMin: Specify minimum depth(inclusive); of a sample to be
                          included in analysis
          --indvDepthMax: Specify maximum depth(inclusive); of a sample to be
                          included in analysis
           --indvQualMin: Specify minimum depth(inclusive); of a sample to be
                          included in analysis
Association Model
                --single: Single variant tests, choose from: score, wald, exact,
                          famScore, famLrt, famGrammarGamma, firth
                --burden: Burden tests, choose from: cmc, zeggini, mb, exactCMC,
                          rarecover, cmat, cmcWald
                    --vt: Variable threshold tests, choose from: price, analytic
                --kernel: Kernal-based tests, choose from: SKAT, KBAC, FamSKAT,
                          SKATO
                  --meta: Meta-analysis related functions to generate summary
                          statistics, choose from: score, cov, dominant,
                          recessive
Family-based Models
               --kinship: Specify a kinship file for autosomal analysis, use
                          vcf2kinship to generate
          --xHemiKinship: Provide kinship for the chromosome X hemizygote region
          --kinshipEigen: Specify eigen decomposition results of a kinship file
                          for autosomal analysis
     --xHemiKinshipEigen: Specify eigen decomposition results of a kinship file
                          for X analysis
             --boltPlink: Specify a prefix of binary PLINK inputs for BoltLMM
      --boltPlinkNoCheck: Not checking MAF and missingness for binary PLINK file
Grouping Unit 
              --geneFile: Specify a gene file (for burden tests);
                  --gene: Specify which genes to test
               --setList: Specify a list to test (for burden tests);
               --setFile: Specify a list file (for burden tests, first 2 columns:
                          setName chr:beg-end);
                   --set: Specify which set to test (1st column);
Frequency Cutoff
             --freqUpper: Specify upper minor allele frequency bound to be
                          included in analysis
             --freqLower: Specify lower minor allele frequency bound to be
                          included in analysis
Missing Data
                --impute: Impute missing genotype (default:mean):  mean, hwe, and
                          drop
           --imputePheno: Impute phenotype to mean of those have genotypes but no
                          phenotypes
             --imputeCov: Impute each covariate to its mean, instead of drop
                          samples with missing covariates
Conditional Analysis
             --condition: Specify markers to be conditions (specify range);
Auxiliary Functions
                 --noweb: Skip checking new version
            --hide-covar: Surpress output lines of covariates
             --numThread: Specify number of threads (default:1)
              --outputID: Output VCF IDs in single-variant assocition results
                  --help: Print detailed help message
```


## rvtests_vcf2kinship

### Tool Description
Calculate kinship from VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
WARNING: long parameter should have two lead dashes: "-help"?
Input/Output
                 --inVcf: Input VCF File
                   --out: Output prefix for autosomal kinship calculation
Chromsome X Analysis Options
                 --xHemi: Calculate kinship using non-PAR region X chromosome
                          markers.
                --xLabel: Specify X chromosome label (default: 23,X
               --xRegion: Specify PAR region (default: hg19), can be build number
                          e.g. hg38, b37; or specify region, e.g.
                          '60001-2699520,154931044-155260560'
Algorithm
                   --ped: Use pedigree method or specify ped file for X
                          chromosome analysis.
                   --ibs: Use IBS method.
                    --bn: Use Balding-Nicols method.
                   --pca: Decomoposite calculated kinship matrix.
         --storeGenotype: Store genotye matrix (sample by genotype).
Specify Genotype
                --dosage: Specify which dosage tag to use (e.g. EC/DS). Typical
                          dosage are between 0.0 and 2.0.
People Filter
       --peopleIncludeID: List IDs of people that will be included in study
     --peopleIncludeFile: From given file, set IDs of people that will be
                          included in study
       --peopleExcludeID: List IDs of people that will be included in study
     --peopleExcludeFile: From given file, set IDs of people that will be
                          included in study
Range Filter
             --rangeList: Specify some ranges to use, please use chr:begin-end
                          format.
             --rangeFile: Specify the file containing ranges, please use
                          chr:begin-end format.
Site Filter
                --minMAF: Specify the minimum MAF threshold to be included in
                          calculating kinship.
               --maxMiss: Specify the maximum allows missing rate to be inclued
                          in calculating kinship.
           --minSiteQual: Specify minimum site qual
                  --anno: Specify the annotation type to be included in
                          calculating kinship.
Genotype Filter
                 --minGQ: Specify the minimum genotype quality, otherwise marked
                          as missing genotype
                 --minGD: Specify the minimum genotype depth, otherwise marked as
                          missing genotype
Other Function
             --update-id: Update VCF sample id using given file (column 1 and 2
                          are old and new id).
                --thread: Specify number of parallel threads to speed up
                  --help: Print detailed help message
```


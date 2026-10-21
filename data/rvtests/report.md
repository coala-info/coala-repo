# rvtests CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rvtests_bgen2vcf | Failed | tool bug: --siteFile is ignored and --peopleIncludeID/--peopleExcludeID lists are not split; plain conversion matches the expected VCF |
| rvtests_bgenFileInfo | PASS |  |
| rvtests_combineKinship | PASS |  |
| rvtests_kinshipDecompose | PASS |  |
| rvtests_plink2vcf | PASS |  |
| rvtests_rvtest | PASS | fixed baseCommand rvtest; single wald beta matches independent least squares; burden and kernel tests ran |
| rvtests_vcf2geno | Failed | tool bug: --peopleExcludeID with several IDs is silently ignored (one ID works); the genotype table itself matches the VCF |
| rvtests_vcf2kinship | PASS | fixed baseCommand vcf2kinship |
| rvtests_vcf2ld_gene | Failed | tool bug: --siteFile is silently ignored and --peopleExcludeID with several IDs is ignored; the gene covariance matches a numpy check |
| rvtests_vcf2ld_neighbor | Failed | tool bug: --siteID and --siteFile never match (the position is appended as a character), so the LD table is empty |
| rvtests_vcf2ld_window | Failed | tool bug: --siteFile is silently ignored and --peopleExcludeID with several IDs is ignored; the window covariance matches a numpy check |
| rvtests_vcf2plink | Failed | tool bug: --minCallRate never filters (missing calls are not counted) and --peopleExcludeID with several IDs is ignored; the bed file matches the VCF |
| rvtests_vcfAnnoSummaryLite | Failed | tool bug: --rangeList and --rangeFile are silently ignored (range code is commented out); the summary counts are correct |
| rvtests_vcfConcordance | Failed | tool bug: --rangeList crashes and --rangeFile is not applied to the comparison VCFs; the plain concordance is correct |
| rvtests_vcfExtractSite | PASS |  |
| rvtests_vcfIndvSummary | PASS |  |
| rvtests_vcfPair | Failed | tool bug: --peopleExcludeID with several IDs is silently ignored (one ID works); the pair counts match an independent count |
| rvtests_vcfPeek | Failed | tool bug: --peopleExcludeID with several IDs is silently ignored (one ID works); the VCF summary is correct |
| rvtests_vcfSummary | PASS |  |
| rvtests_vcfSummaryLite | Failed | tool bug: --rangeList and --rangeFile are silently ignored (range code is commented out); the summary counts are correct |
| rvtests_vcfVariantSummaryLite | Failed | tool bug: --rangeList and --rangeFile are silently ignored (range code is commented out); the summary counts are correct |

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


## rvtests_bgen2vcf

### Tool Description
Convert a BGEN file to a bgzip-compressed VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] bgen2vcf: ok via bgen2vcf --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Basic Input/Output
                --inBgen: Input BGEN File
          --inBgenSample: Input SAMPLE file for the BGEN File
                   --out: Output prefix
People Filter
       --peopleIncludeID: give IDs of people that will be included in study
     --peopleIncludeFile: from given file, set IDs of people that will be
                          included in study
       --peopleExcludeID: give IDs of people that will be included in study
     --peopleExcludeFile: from given file, set IDs of people that will be
                          included in study
Site Filter
             --rangeList: Specify some ranges to use, please use chr:begin-end
                          format.
             --rangeFile: Specify the file containing ranges, please use
                          chr:begin-end format.
              --siteFile: Specify the file containing site to extract, please use
                          chr:pos format.
Specify Options
             --hideVarId: Do not output Variant ID (only output rsid)
                --hideGT: Do not call genotypes by skipping the GT tag
                --showDS: Calculate bi-allelic dosage using the DS tag
                  --help: Print detailed help message
```

## rvtests_bgenFileInfo

### Tool Description
Display file information of one BGEN input file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] bgenFileInfo: ok via bgenFileInfo --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Basic Input/Output
                --inBgen: Input BGEN File
              --inSample: Input Sample File
                  --help: Print detailed help message
```

## rvtests_combineKinship

### Tool Description
Combine several kinship matrices made by vcf2kinship into one.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] combineKinship: ok via combineKinship --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Input/Output
                   --out: Output prefix for autosomal kinship calculation
                   --pca: Decomoposite calculated kinship matrix.
                --thread: Specify number of parallel threads to speed up
                  --help: Print detailed help message
```

## rvtests_kinshipDecompose

### Tool Description
Spectral decomposition of a kinship matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] kinshipDecompose: ok via kinshipDecompose --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Input/Output
                    --in: Input kinship file
                   --out: Output prefix for autosomal kinship calculation
Other Function
                  --help: Print detailed help message
```

## rvtests_plink2vcf

### Tool Description
Convert binary PLINK files to a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] plink2vcf: ok via plink2vcf -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:00:47 2026
The following parameters are available.  Ones with "[]" are in effect:

Available Options
            Input/Output: --inPlink [], --outVcf [], --reference []

Effective Options

Unparsed arguments:  -h
```

## rvtests_vcf2geno

### Tool Description
Convert a VCF file to a genotype table.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcf2geno: ok via vcf2geno -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:00:49 2026
The following parameters are available.  Ones with "[]" are in effect:

Available Options
            Input/Output: --inVcf []
           People Filter: --peopleIncludeID [], --peopleIncludeFile []
                          --peopleExcludeID [], --peopleExcludeFile []
             Site Filter: --rangeList [], --rangeFile []
          Gene Extractor: --geneFile [], --gene [], --annoType []
          Other Function: --variantOnly, --update-id []

Effective Options

Unparsed arguments:  -h
```

## rvtests_vcf2ld_gene

### Tool Description
Calculate the covariance (LD) matrix of the variants in each gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcf2ld_gene: ok via vcf2ld_gene --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:00:50 2026
Input/Output
                 --inVcf: input VCF File
                   --out: output prefix
People Filter
       --peopleIncludeID: give IDs of people that will be included in study
     --peopleIncludeFile: from given file, set IDs of people that will be
                          included in study
       --peopleExcludeID: give IDs of people that will be included in study
     --peopleExcludeFile: from given file, set IDs of people that will be
                          included in study
Site Filter
             --rangeList: Specify some ranges to use, please use chr:begin-end
                          format.
             --rangeFile: Specify the file containing ranges, please use
                          chr:begin-end format.
              --siteFile: Specify the file containing sites to include, please
                          use "chr pos" format.
Gene Parameter
              --geneFile: specify a gene file (for burden tests)
                  --gene: specify which genes to test
Auxilliary Functions
                  --help: Print detailed help message
```

## rvtests_vcf2ld_neighbor

### Tool Description
Calculate LD between selected sites and the previous variant in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcf2ld_neighbor: ok via vcf2ld_neighbor -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:00:52 2026
The following parameters are available.  Ones with "[]" are in effect:

Available Options
            Input/Output: --inVcf [], --outLD []
           People Filter: --peopleIncludeID [], --peopleIncludeFile []
                          --peopleExcludeID [], --peopleExcludeFile []
            Range Filter: --rangeList [], --rangeFile []
             Site Filter: --siteID [], --siteFile []

Effective Options

Unparsed arguments:  -h
```

## rvtests_vcf2ld_window

### Tool Description
Calculate the covariance (LD) matrix of variants in sliding windows.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcf2ld_window: ok via vcf2ld_window --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Input/Output
                 --inVcf: input VCF File
                   --out: output prefix
People Filter
       --peopleIncludeID: give IDs of people that will be included in study
     --peopleIncludeFile: from given file, set IDs of people that will be
                          included in study
       --peopleExcludeID: give IDs of people that will be included in study
     --peopleExcludeFile: from given file, set IDs of people that will be
                          included in study
Site Filter
             --rangeList: Specify some ranges to use, please use chr:begin-end
                          format.
             --rangeFile: Specify the file containing ranges, please use
                          chr:begin-end format.
              --siteFile: Specify the file containing sites to include, please
                          use "chr pos" format.
Window Parameter
                --window: specify sliding window size to calculate covariance
Anchor SNPs
                --anchor: specify anchors SNPs to compare with. e.g. 1:20-20
Auxilliary Functions
                  --help: Print detailed help message
```

## rvtests_vcf2plink

### Tool Description
Convert a VCF file to PLINK binary files with site, people, quality and frequency filters.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcf2plink: ok via vcf2plink -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:00:57 2026
The following parameters are available.  Ones with "[]" are in effect:

Available Options
            Input/Output: --inVcf [], --outVcf [], --make-bed []
           People Filter: --peopleIncludeID [], --peopleIncludeFile []
                          --peopleExcludeID [], --peopleExcludeFile []
             Site Filter: --rangeList [], --rangeFile [], --siteFile []
          Gene Extractor: --geneFile [], --gene [], --annoType []
          Quality Filter: --minSiteQual [], --minGQ [], --minGD []
           Filter Option: --pass
        Quality Controls: --biallelic, --plinkChrom, --minMAF [], --maxMAF []
                          --minHWE [], --minCallRate []
          Other Function: --variantOnly, --update-id []

Effective Options

Unparsed arguments:  -h
```

## rvtests_vcfAnnoSummaryLite

### Tool Description
Summarize a VCF file per annotation type.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcfAnnoSummaryLite: ok via vcfAnnoSummaryLite -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:01:00 2026
The following parameters are available.  Ones with "[]" are in effect:

Available Options
            Input/Output: --inVcf [], --snp [], --hapmap []
             Site Filter: --rangeList [], --rangeFile []

Effective Options

Unparsed arguments:  -h
```

## rvtests_vcfConcordance

### Tool Description
Calculate genotype concordance between a standard VCF file and comparison VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcfConcordance: ok via vcfConcordance --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:01:03 2026
The following parameters are available.  Ones with "[]" are in effect:

Available Options
            Input/Output: -s []
             Site Filter: --rangeList [], --rangeFile [], --siteFile []

Effective Options

Cannot find required parameter [ Please provide input file using: -s ]
```

## rvtests_vcfExtractSite

### Tool Description
Extract the sites listed in a site file from a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcfExtractSite: ok via vcfExtractSite -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:01:07 2026
The following parameters are available.  Ones with "[]" are in effect:

Available Options
            Input/Output: --inVcf [], --outVcf []
             Site Filter: --site [], --inverse, --rangeList [], --rangeFile []
                          --snpOnly

Effective Options

Unparsed arguments:  -h
```

## rvtests_vcfIndvSummary

### Tool Description
Summarize a VCF file per individual.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcfIndvSummary: ok via vcfIndvSummary -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:01:12 2026
The following parameters are available.  Ones with "[]" are in effect:

Available Options
            Input/Output: --inVcf [], --snp [], --hapmap []
             Site Filter: --rangeList [], --rangeFile []

Effective Options

Unparsed arguments:  -h
```

## rvtests_vcfPair

### Tool Description
Count genotype differences between every pair of people in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcfPair: ok via vcfPair -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:01:17 2026
The following parameters are available.  Ones with "[]" are in effect:

Available Options
            Input/Output: --inVcf [], --out []
           People Filter: --peopleIncludeID [], --peopleIncludeFile []
                          --peopleExcludeID [], --peopleExcludeFile []
             Site Filter: --rangeList [], --rangeFile []
          Gene Extractor: --geneFile [], --gene [], --annoType []
         Genotype Filter: --minGQ []
          Other Function: --variantOnly, --update-id []

Effective Options

Unparsed arguments:  -h
```

## rvtests_vcfPeek

### Tool Description
Summarize the content of a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcfPeek: ok via vcfPeek -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:01:20 2026
The following parameters are available.  Ones with "[]" are in effect:

Available Options
            Input/Output: --inVcf []
           People Filter: --peopleIncludeID [], --peopleIncludeFile []
                          --peopleExcludeID [], --peopleExcludeFile []
             Site Filter: --rangeList [], --rangeFile [], --checkGeno

Effective Options

Unparsed arguments:  -h
```

## rvtests_vcfSummary

### Tool Description
Summarize a VCF file (counts, dbSNP and HapMap overlap, Ts/Tv) per filter.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcfSummary: ok via vcfSummary -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:01:23 2026
The following parameters are available.  Ones with "[]" are in effect:

Available Options
            Input/Output: --inVcf [], --snp [], --hapmap []
             Site Filter: --rangeList [], --rangeFile []

Effective Options

Unparsed arguments:  -h
```

## rvtests_vcfSummaryLite

### Tool Description
Summarize a VCF file (counts, dbSNP and HapMap overlap, Ts/Tv) per filter, lite version.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcfSummaryLite: ok via vcfSummaryLite -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:01:26 2026
The following parameters are available.  Ones with "[]" are in effect:

Available Options
            Input/Output: --inVcf [], --snp [], --hapmap []
             Site Filter: --rangeList [], --rangeFile []

Effective Options

Unparsed arguments:  -h
```

## rvtests_vcfVariantSummaryLite

### Tool Description
Summarize a VCF file per variant class, lite version.

### Metadata
- **Docker Image**: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
- **Homepage**: https://github.com/zhanxw/rvtests
- **Package**: https://anaconda.org/channels/bioconda/packages/rvtests/overview
- **Validation**: PASS

### Original Help Text
```text
[help] vcfVariantSummaryLite: ok via vcfVariantSummaryLite -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
Analysis started at: Wed Oct 21 18:01:29 2026
The following parameters are available.  Ones with "[]" are in effect:

Available Options
            Input/Output: --inVcf [], --snp [], --hapmap []
             Site Filter: --rangeList [], --rangeFile []

Effective Options

Unparsed arguments:  -h
```

## Metadata
- **Skill**: generated

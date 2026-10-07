# consplice CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| consplice_ML_score-vcf | PASS | Synthetic data: invented SpliceAI and SQUIRLS annotations on the real GIAB chr22 VCF; the two planted high-score variants ranked highest (0.96) with the bundled model. |
| consplice_ML_train | PASS | Synthetic data: invented pathogenic and benign training tables; the trained model directory scored planted high-risk variants at 0.74 and 1.0. |
| consplice_constraint_agg-overlapping-reg | Failed | tool bug: the code passes agg_type to the wrong function, so every run stops with 'aggregate_intersecting_regions() missing 1 required positional argument: agg_type'. |
| consplice_constraint_calculate-oe | Not completed | Needs the outputs of oe-counts and sub-matrix, which could not be produced without the gnomAD and SpliceAI data. |
| consplice_constraint_oe-counts | Not completed | Needs genome-wide gnomAD VCF and coverage files, precomputed SpliceAI scores (Illumina BaseSpace login) and a sub-matrix output, too large for this test. |
| consplice_constraint_score-bed | PASS | Synthetic data: synthetic ConSplice scores on real GIAB chr22 variants; by-gene mode added the expected maximum region score; max mode crashes on variants outside all scored regions (tool bug). |
| consplice_constraint_score-txt | PASS | Synthetic data: synthetic ConSplice scores on real GIAB chr22 variants; by-gene mode added the expected maximum region score; max mode crashes on variants outside all scored regions (tool bug). |
| consplice_constraint_score-vcf | PASS | Synthetic data: synthetic ConSplice scores on the real GIAB chr22 VCF; the 28 variants inside scored genes got the expected gene and percentile in the ConSplice INFO field. |
| consplice_constraint_select-score | PASS | Synthetic data: ConSplice scores invented for real GRCh38 chr22 gene regions; the chosen O/E and percentile columns were kept and renamed correctly. |
| consplice_constraint_sub-matrix | Not completed | Needs genome-wide gnomAD VCF and coverage files plus precomputed SpliceAI scores (Illumina BaseSpace login), too large for this test. |
| consplice_constraint_to-bed | PASS | Synthetic data: ConSplice scores invented for real GRCh38 chr22 gene regions; start positions were shifted to 0-based for bed and bed.gz output. |

## consplice_constraint_sub-matrix

### Tool Description
Build a substitution matrix using gnomAD variants and SpliceAI scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
- **Homepage**: https://github.com/mikecormier/ConSplice
- **Package**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikecormier/ConSplice
- **Stars**: N/A

### Original Help Text
```text
usage: ConSplice constraint sub-matrix [-h] --gnomad-vcf gnomAD VCF/BCF File
                                       --coverage gnomAD Coverage file
                                       --gtf-file GTF file --spliceai-vcf
                                       SpliceAI SNV prediction File
                                       --alt-gene-symbol Alternative Gene
                                       Symbol File --fasta Fasta file
                                       --seg-dups Segmental Duplications File
                                       --self-chains Self Chains --out-file
                                       Output file
                                       [--chrom [Chromosomes [Chromosomes ...]]]
                                       [-cc Coverage Cutoff]
                                       [--coverage-label Coverage Label]
                                       [--n-cpu Number of CPUs]
                                       [--repeat-score-cutoff Repeat Score Cutoff]
                                       [--spliceai-score-type {max,sum,splicing_unaware}]

	***********************************
	* ConSplice - Substitution Matrix *
	***********************************

	Create a splicing-aware substitution matrix
	from variation in gnomAD combined with per-
	nucleotide splicing predictions from SpliceAI.

optional arguments:
  -h, --help            show this help message and exit
  --chrom [Chromosomes [Chromosomes ...]]
                        Which chromosomes to use to build the count matrix.
                        For autosome only choose chromosomes 1-22, for X
                        choose only X, All for all, etc., meaning all
                        reference chromosomes. Multiple chromosomes should be
                        provided as each chromosome separated by a space
                        (chrom 1-5 example: 1 2 3 4 5). (Default = ALL).
  -cc Coverage Cutoff   A number between 0.0 and 1.0 that represents the
                        required number of samples with coverage at each site
                        looked at in gnomAD. Default = 0.5.
  --coverage-label Coverage Label
                        The label/column in the coverage file to use for the
                        selected position coverage. Default = 'over_10'.
  --n-cpu Number of CPUs
                        The number of CPUs to use for multi-threading.
                        (Default = 3).
  --repeat-score-cutoff Repeat Score Cutoff
                        The cutoff score to use for seg dups or self chain
                        repeats. Regions of a gene with a seg dup or self
                        chain at or above this cutoff will be skipped while
                        regions of a gene below this cutoff will not be
                        skipped during O and E score calculations. (Default =
                        0.95, meaning 95 PERCENT. The score will be 0.95 for
                        seg dups and 95.0 for self chains).
  --spliceai-score-type {max,sum,splicing_unaware}
                        (Optional) How to use the SpliceAI score. Choices =
                        'max', 'sum', 'splicing_unaware'. 'max' will use the
                        max SpliceAI score for a specific variant. 'sum' will
                        use the sum SpliceAI score for a specific variant.
                        'splicing_unaware' will use a single bin for SpliceAI,
                        which is the same as an unaware splicing model.
                        Default = 'sum'

Required Arguments:
  --gnomad-vcf gnomAD VCF/BCF File
                        (Required) The path to and name of the gnomAD vcf/bcf
                        file.
  --coverage gnomAD Coverage file
                        (Required) The gnomAD coverage file for the gnomAD vcf
                        file. The coverage files should be in a bed formatted,
                        bgzipped, and tabixed.
  --gtf-file GTF file   (Required) A gtf file to get gene specific genomic
                        coordinates from to build the count matrix.
  --spliceai-vcf SpliceAI SNV prediction File
                        (Required) The path to and name of the SpliceAI delta
                        score predictions for every snv (vcf file).
  --alt-gene-symbol Alternative Gene Symbol File
                        (Required) A file that contains mappings between a
                        canonical gene symbol to alternative gene symbols.
                        NOTE: The file needs to have a header!. This script is
                        set up to use the HGNC protein-coding gene mapping
                        file: ftp://ftp.ebi.ac.uk/pub/databases/genenames/hgnc
                        /tsv/locus_types/gene_with_protein_product.txt,
                        however, you are welcome to try others. There is no
                        guarantee it will work with other mapping files.
  --fasta Fasta file    (Required) A fasta file to get reference alleles by
                        position from.
  --seg-dups Segmental Duplications File
                        (Required) The file path to the segmental duplications
                        file. This file will be used to identify repeat
                        regions that should be excluded from the O and E
                        calculation. (We suggest using the ggd segmental
                        duplications data package 'grch38-segmental-dups-
                        ucsc-v1').
  --self-chains Self Chains
                        (Required) The file path to the high identity self
                        chain repeat file. This file will be used to identify
                        repeat regions that should be excluded from the O and
                        E calculation. (We suggest using the ggd self chain
                        data package 'grch38-self-chain-ucsc-v1').
  --out-file Output file
                        (Required) The name of the output file to create.
```

## consplice_constraint_oe-counts

### Tool Description
Calculate Observed and Expected splicing variant counts for genic or intragenic regions of genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
- **Homepage**: https://github.com/mikecormier/ConSplice
- **Package**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikecormier/ConSplice
- **Stars**: N/A

### Original Help Text
```text
usage: ConSplice constraint oe-counts [-h] --gnomad-vcf gnomAD VCF/BCF File
                                      --coverage gnomAD Coverage file
                                      --gtf-file GTF file --spliceai-vcf
                                      SpliceAI SNV prediction File
                                      --alt-gene-symbol Alternative Gene
                                      Symbol File --fasta Fasta file
                                      --seg-dups Segmental Duplications File
                                      --self-chains Self Chains --out-file
                                      Output file -sm SpliceAI aware
                                      Substitution Matrix --region-type
                                      {gene,region}
                                      [--window-size Window Size]
                                      [--step-size Step Size]
                                      [--chrom [Chromosomes [Chromosomes ...]]]
                                      [-cc Coverage Cutoff]
                                      [--coverage-label Coverage Label]
                                      [--n-cpu Number of CPUs]
                                      [--repeat-score-cutoff Repeat Score Cutoff]
                                      [--spliceai-score-type {max,sum,splicing_unaware}]

	********************************************
	* ConSplice - Observed and Expected Counts *
	********************************************

	Calculate the Observed (O) splicing variation from genetic
	variation in gnomAD, and calculate the Expected (E)
	splicing variation using a matrix of Substitution
	rates based on evidence of alternative splicing.
	O and E counts are based on a gene or window based region
	designated by the user.

optional arguments:
  -h, --help            show this help message and exit
  --chrom [Chromosomes [Chromosomes ...]]
                        Which chromosomes to use to build the count matrix.
                        For autosome only choose chromosomes 1-22, for X
                        choose only X, All for all, etc., meaning all
                        reference chromosomes. Multiple chromosomes should be
                        provided as each chromosome separated by a space
                        (chrom 1-5 example: 1 2 3 4 5). (Default = ALL).
  -cc Coverage Cutoff   A number between 0.0 and 1.0 that represents the
                        required number of samples with coverage at each site
                        looked at in gnomAD. Default = 0.5
  --coverage-label Coverage Label
                        The label/column in the coverage file to use for the
                        selected position coverage. Default = 'over_10'
  --n-cpu Number of CPUs
                        The number of CPUs to use for multi-threading.
                        (Default = 3)
  --repeat-score-cutoff Repeat Score Cutoff
                        The cutoff score to use for seg dups or self chain
                        repeats. Regions of a gene with a seg dup or self
                        chain at or above this cutoff will be skipped while
                        regions of a gene below this cutoff will not be
                        skipped during O and E score calculations. (Default =
                        0.95, meaning 95 percent. The score will be 0.95 for
                        seg dups and 95.0 for self chains)
  --spliceai-score-type {max,sum,splicing_unaware}
                        (Optional) How to use the SpliceAI score. Choices =
                        'max', 'sum', 'splicing_unaware'. 'max' will use the
                        max SpliceAI score for a specific variant. 'sum' will
                        use the sum SpliceAI score for a specific variant.
                        'splicing_unaware' will use a single bin for SpliceAI,
                        which is the same as an unaware splicing model.
                        Default = 'sum'

Required Arguments:
  --gnomad-vcf gnomAD VCF/BCF File
                        (Required) The path to the gnomAD vcf/bcf file.
                        (bgzipped and tabixed required)
  --coverage gnomAD Coverage file
                        (Required) The gnomAD coverage file for the gnomAD vcf
                        file. The coverage files should be in bed format,
                        bgzipped, and tabixed.
  --gtf-file GTF file   (Required) A gtf file to get gene specific genomic
                        coordinates from.
  --spliceai-vcf SpliceAI SNV prediction File
                        (Required) The path to SpliceAI delta score
                        predictions for every snv (vcf file).
  --alt-gene-symbol Alternative Gene Symbol File
                        (Required) A file that contains mappings between a
                        canonical gene symbol to alternative gene symbols.
                        NOTE: The file needs to have a header!. This script is
                        set up to use the HGNC protein-coding gene mapping
                        file: ftp://ftp.ebi.ac.uk/pub/databases/genenames/hgnc
                        /tsv/locus_types/gene_with_protein_product.txt,
                        however, you are welcome to try others. There is no
                        guarantee it will work with other mapping files.
  --fasta Fasta file    (Required) A fasta file to get reference alleles by
                        position from.
  --seg-dups Segmental Duplications File
                        (Required) The file path to the segmental duplications
                        file. This file will be used to identify repeat
                        regions that should be excluded from the O and E
                        calculation. (We suggest using the ggd segmental
                        duplications data package 'grch38-segmental-dups-
                        ucsc-v1').
  --self-chains Self Chains
                        (Required) The file path to the high identity self
                        chain repeat file. This file will be used to identify
                        repeat regions that should be excluded from the O and
                        E calculation. (We suggest using the ggd self chain
                        data package 'grch38-self-chain-ucsc-v1').
  --out-file Output file
                        (Required) The name of the output file to create.
  -sm SpliceAI aware Substitution Matrix, --substitution-matrix SpliceAI aware Substitution Matrix
                        (Required) Path and name of the Substitution matrix
                        created using SpliceAI predictions and gnomAD observed
                        variants. (Created from sub-command: sub-matrix).
  --region-type {gene,region}
                        (Required) Calculate observed and expected counts
                        using the entire gene as a region or intragenic
                        regions based on a window size. (Choices = 'gene' or
                        'region')

Required Arguments for 'Region':
  --window-size Window Size
                        (Required if --region-type set to 'region') The window
                        size in bp used for the sliding window. Region from a
                        gene will be created using this window size
  --step-size Step Size
                        (Required if --region-type set to 'region') The step
                        size in bp used to slide the window along a gene. The
                        step size will be the number of bases the window is
                        slid before a new region is created. (NOTE: To exclude
                        overlapping windows set the step size to the same size
                        as the window size. For example, a window size of 25
                        and a step size of 25 will create non-overlapping 25bp
                        regions without missing extra bases. If the step size
                        is larger than the window size then missing regions
                        will arise)
```

## consplice_constraint_calculate-oe

### Tool Description
Calculate the O/E and Percentile constraint scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
- **Homepage**: https://github.com/mikecormier/ConSplice
- **Package**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikecormier/ConSplice
- **Stars**: N/A

### Original Help Text
```text
usage: ConSplice constraint calculate-oe [-h] --o-and-e-scores Observed and
                                         Expected Score File
                                         --substitution-matrix Mutation Table
                                         --out-file Output File
                                         [--pct-rec-rate Percent Recovery Rate]
                                         [--remove-duplicate]
                                         [--pct-col-name Percentile Column Name]
                                         [--sort-by-pos]
                                         [--weights Weights [Weights ...]]
                                         [--spliceai-score-type {max,sum,splicing_unaware}]

	******************************************
	* ConSplice - O/E and Percentile Scoring *
	******************************************

	Calculate the Observed over Expected (O/E) score and
	the Percentile constraint scores for each constraint region

	 - The percentile score is calculated after all regions have an O/E score
	   and represent the genome-wide constraint percentile of one region to all
	   other regions.

optional arguments:
  -h, --help            show this help message and exit
  --pct-rec-rate Percent Recovery Rate
                        The percent/fraction of bases of the total bases of a
                        region that are required to be recovered (bases that
                        were used for the region score). The O/E score along
                        with the percentile score will be calculated for any
                        region with a percent recovery rate >= this value.
                        (Default = 0.8, meaning 80% Recovery Rate)
  --remove-duplicate    Whether or not to remove duplicate gene entries if
                        they exists. Default is set to False. This argument
                        should not be set if there are multiple regions with
                        scores for a single gene. This argument should be set
                        if each region is a single gene and where multiple
                        scores for a single gene is bad
  --pct-col-name Percentile Column Name
                        The name of the column to create the represents the
                        ConSplice percentile score. (Default =
                        'ConSplice_percentile')
  --sort-by-pos         If the `--sort-by-pos` argument is set, the output
                        file will be sorted by the chromosome and genomic
                        positions. If this argument is not set then the output
                        will be sorted by increasing percentile score.
                        (Default = sort by increasing percentile score)
  --weights Weights [Weights ...]
                        The weights to apply when calculating the O/E scores.
                        Options = 'unweighted', 'linear', 'PHRED',
                        'One_minus_proportion', 'One_over_proportion', and
                        'One_over_mutation_rate'. Using 'unweighted' results
                        in no weights being applied (Default). 'linear' uses a
                        linear weighting approached based on SpliceAI binning.
                        'PHRED' transforms the by bin proportions into PHRED
                        scores and weights. 'One_minus_proportion' uses a
                        normalized to 1 proportion for each bin as a weight.
                        'One_over_proportion' uses the inverse proportion of
                        each bin as a weight. 'One_over_mutation_rate' uses
                        the inverse mutation rate for each bin as weight.
                        Default is 'unweighted'. Add as many weights as
                        desired. (Example: --weights linear PHRED
                        one_over_prop unweighted)
  --spliceai-score-type {max,sum,splicing_unaware}
                        (Optional) How to use the SpliceAI score. Choices =
                        'max', 'sum', 'splicing_unaware'. 'max' will use the
                        max SpliceAI score for a specific variant. 'sum' will
                        use the sum SpliceAI score for a specific variant.
                        'splicing_unaware' will use a single bin for SpliceAI,
                        which is the same as an unaware splicing model.
                        Defulat = 'sum'

Required Arguments:
  --o-and-e-scores Observed and Expected Score File
                        (Required) The path to the observed over expected
                        scores file.
  --substitution-matrix Mutation Table
                        (Required) The substitution matrix used to calculate
                        the substitution rate. The different weights used to
                        calculate the O/E scores will be calculated from this
                        substitution frequency table
  --out-file Output File
                        (Required) The path and/or the name of the output file
                        to create. This output file will contain the same
                        content as the original file with additional columns
                        for O/E scores and Percentile Scores
```

## consplice_constraint_select-score

### Tool Description
Select an O/E and matching Percentile score to filter on and remove all other non-essential columns after ConSplice scoring.

### Metadata
- **Docker Image**: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
- **Homepage**: https://github.com/mikecormier/ConSplice
- **Package**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikecormier/ConSplice
- **Stars**: N/A

### Original Help Text
```text
usage: ConSplice constraint select-score [-h] --score-file Regional Score File
                                         --o-over-e-field O/E Field
                                         --pctl-field Percentile Field
                                         --out-file Output file
                                         [--new-oe-name New O/E Column Name]
                                         [--new-pctl-name New Percentile Score Column Name]

	****************************
	* ConSplice - Select Score *
	****************************

	Reduce unnecessary columns in the scored ConSplice file by filter
	out non-essential columns while keeping the desired O/E and Percentile
	ConSplice scores.
	Any extra O/E scores and Percentile scores will be removed along with
	all other non-essential columns in the output file.

optional arguments:
  -h, --help            show this help message and exit
  --new-oe-name New O/E Column Name
                        (Optional) The new name of the O/E score field/column
                        in the output file. Default = 'ConSplice_O/E'
  --new-pctl-name New Percentile Score Column Name
                        (Optional) The new name of the Percentile score
                        field/column in the output file. Default =
                        'ConSplice_Percentile'

Required Arguments:
  --score-file Regional Score File
                        (Required) The path to the scored ConSplice file to
                        filter
  --o-over-e-field O/E Field
                        (Required) The name of the O/E score field/column
                        within the scored ConSplice file to select/keep.
  --pctl-field Percentile Field
                        (Required) The name of the Percentile score
                        field/column within the scored ConSplice file to
                        select/keep.
  --out-file Output file
                        (Required) The name of the output file to create.
```

## consplice_constraint_agg-overlapping-reg

### Tool Description
Aggregate scores from overlapping regions where the step size of a region is less than the window size of the region.

### Metadata
- **Docker Image**: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
- **Homepage**: https://github.com/mikecormier/ConSplice
- **Package**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikecormier/ConSplice
- **Stars**: N/A

### Original Help Text
```text
usage: ConSplice constraint agg-overlapping-reg [-h] --score-file Regional
                                                Score File --score-field O/E
                                                Score Field --step-size Step
                                                Size --out-file Output file
                                                [--new-score-name New O/E Score Column Name]
                                                [--new-pctl-name New Percentile Score Column Name]
                                                [--invert-pctl]
                                                [--agg-type {mean,median}]

	***************************************
	* Aggregate Overlapping Region Scores *
	***************************************

	Combine overlapping regional constraint scores into an aggregated score
	using the region's step size. All regions that intersect the user defined
	step size will be combined together into a single score.

optional arguments:
  -h, --help            show this help message and exit
  --new-score-name New O/E Score Column Name
                        (Optional) The name of the new score column that is
                        created. Default = 'Aggregated_ConSplice_O/E'
  --new-pctl-name New Percentile Score Column Name
                        (Optional) The name of the new percentile score column
                        that is created. Default =
                        'Aggregated_ConSplice_Percentile'
  --invert-pctl         (Optional) Whether or not to invert the new scores
                        before converting the scores to percentiles. By
                        default, the percentile score will correlate with
                        increasing scores from the new aggregated score
                        created during the intersection process. If the
                        smaller (and/or more negative) a score is correlates
                        with a higher percentile then this argument should be
                        set
  --agg-type {mean,median}
                        (Optional) How to aggregate the overlapping scores
                        together. Choices = 'mean' or 'median'. Default =
                        'median'

Required Arguments:
  --score-file Regional Score File
                        (Required) The path to the regional score file to
                        combine scores for
  --score-field O/E Score Field
                        (Required) The name of the O/E score field within the
                        regional score file to combine based on intersecting
                        regions.
  --step-size Step Size
                        (Required) The step size used to create the
                        overlapping regions. This step size is used to step
                        through each gene in the score file and the scores
                        from all region that intersects with a step region
                        will be combined together.
  --out-file Output file
                        (Required) The name of the output file to create.
```

## consplice_constraint_to-bed

### Tool Description
Convert the 1-based scored ConSplice txt file to a 0-based bed file.

### Metadata
- **Docker Image**: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
- **Homepage**: https://github.com/mikecormier/ConSplice
- **Package**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikecormier/ConSplice
- **Stars**: N/A

### Original Help Text
```text
usage: ConSplice constraint to-bed [-h] --score-file Regional Score File
                                   --out-file Output file
                                   [--out-type Output file type]

	**********************
	* ConSplice - to bed *
	**********************

	Convert the scored ConSplice txt file, where the genomic positions are
	1-based like a vcf file, to a bed file, where the genomic positions will
	be 0-based

optional arguments:
  -h, --help            show this help message and exit
  --out-type Output file type
                        (Optional) The output file type. Whether the output
                        file should be a normal bed file or a bgzipped bed
                        file. Choices = 'bed' or 'bedgz'. Default = 'bed'

Required Arguments:
  --score-file Regional Score File
                        (Required) The path to the scored ConSplice txt file
                        to convert to 0-based bed file
  --out-file Output file
                        (Required) The name of the output bed file to create.
```

## consplice_constraint_score-txt

### Tool Description
Add ConSplice scores to a tab-delimited txt variant file.

### Metadata
- **Docker Image**: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
- **Homepage**: https://github.com/mikecormier/ConSplice
- **Package**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikecormier/ConSplice
- **Stars**: N/A

### Original Help Text
```text
usage: ConSplice constraint score-txt [-h] --consplice-file ConSplice Score
                                      bed File --txt-file Variant txt file
                                      [--score-type {by-gene,max}] --out-file
                                      Ouput File
                                      [--txt-chrom txt chromosome column]
                                      [--txt-pos txt position column]
                                      [--txt-gene-name txt gene name column]
                                      [--alt-gene-symbol Alternative Gene Symbol File]
                                      [--consplice-col ConSplice Column Name]
                                      [--out-consplice-col ConSplice Score Column]

	***************************************
	* ConSplice - Score tab-delimited txt *
	***************************************

	Score a 1-based variant file in tab-delimited txt format with ConSplice scores
	 - Expecting a tab delimited file with a header line that start with a #
	 - The last header line with a # will be treated as a column index based
	    on the tab separated names in that line.
	 - The variant position will be treated as 1-based genomic position
	 - The ConSplice score will be assigned by either a gene name or the 
	    max ConSplice score for that position based on input parameters.

optional arguments:
  -h, --help            show this help message and exit
  --txt-chrom txt chromosome column
                        The name of the chromosome column in the txt file.
                        (Default = chrom) (NOTE: Expecting tab delimited file
                        with a header line)
  --txt-pos txt position column
                        The name of the position column in the txt file.
                        (Default = pos) (NOTE: Expecting tab delimited file
                        with a header line)
  --txt-gene-name txt gene name column
                        The name for the gene name/symbol column in the txt
                        file. (Default = gene_name) (NOTE: Expecting tab
                        delimited file with a header line)
  --consplice-col ConSplice Column Name
                        The name of the ConSplice score column in the
                        ConSplice file. (Default = ConSplice_Percentile)
  --out-consplice-col ConSplice Score Column
                        The name of the column to create the represents the
                        ConSplice score. (Default = 'ConSplice_score')

Required Arguments:
  --consplice-file ConSplice Score bed File
                        (Required) The path to the 0-based ConSplice score
                        file in bed format.
  --txt-file Variant txt file
                        (Required) The path to the 1-based variant file in txt
                        format.
  --score-type {by-gene,max}
                        (Required) How to add the score to the variant file.
                        Either by the gene name for the variant or the max
                        ConSplice score for that position. Choices = 'by-gene'
                        or 'max') (NOTE: If 'by-gene is chosen, then the
                        --txt-gene-name argument will be used to determine the
                        gene name in the txt file)
  --out-file Ouput File
                        (Required) The path and/or the name of the output file
                        to create

Required if using 'by-gene':
  --alt-gene-symbol Alternative Gene Symbol File
                        (Required if --score-type == 'by-gene') A file that
                        contains mappings between a canonical gene symbol to
                        alternative gene symbols. NOTE: The file needs to have
                        a header!. This script is set up to use the HGNC
                        protein-coding gene mapping file can be found in the
                        ConSplice GitHub repo:
                        https://github.com/mikecormier/ConSplice
```

## consplice_constraint_score-bed

### Tool Description
Add ConSplice scores to a bed variant file.

### Metadata
- **Docker Image**: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
- **Homepage**: https://github.com/mikecormier/ConSplice
- **Package**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikecormier/ConSplice
- **Stars**: N/A

### Original Help Text
```text
usage: ConSplice constraint score-bed [-h] --consplice-file ConSplice Score
                                      bed File --bed-file Variant bed file
                                      [--score-type {by-gene,max}] --out-file
                                      Ouput File [--out-type Output file type]
                                      [--bed-chrom bed chromosome column]
                                      [--bed-pos bed start position column]
                                      [--bed-gene-name bed gene name column]
                                      [--alt-gene-symbol Alternative Gene Symbol File]
                                      [--consplice-col ConSplice Column Name]
                                      [--out-consplice-col ConSplice Score Column]

	*************************
	* ConSplice - Score bed *
	*************************

	Score a 0-based variant file in bed format with ConSplice scores
	 - Expecting a tab delimited file with a header line that start with a #
	 - The last header line with a # will be treated as a column index based
	    on the tab separated names in that line.
	 - The variant position will be treated as 0-based genomic position
	 - The ConSplice score will be assigned by either a gene name or the 
	    max ConSplice score for that position based on input parameters.

optional arguments:
  -h, --help            show this help message and exit
  --out-type Output file type
                        The output file type. Whether the output file should
                        be a normal bed file or a bgzipped bed file. Choices =
                        ['bed', 'bedgz']. Default = 'bed'
  --bed-chrom bed chromosome column
                        The name of the chromosome column in the bed file.
                        (Default = chrom) (NOTE: Expecting tab delimited file
                        with a header line)
  --bed-pos bed start position column
                        The name of the start position column in the bed file.
                        (Default = start) (NOTE: Expecting tab delimited file
                        with a header line)
  --bed-gene-name bed gene name column
                        The name for the gene name/symbol column in the bed
                        file. (Default = gene_name) (NOTE: Expecting tab
                        delimited file with a header line)
  --consplice-col ConSplice Column Name
                        The name of the ConSplice score column in the
                        ConSplice file. (Default = ConSplice_Percentile)
  --out-consplice-col ConSplice Score Column
                        The name of the column to create the represents the
                        ConSplice score. (Default = 'ConSplice_score')

Required Arguments:
  --consplice-file ConSplice Score bed File
                        (Required) The path to the 0-based ConSplice score
                        file in bed format.
  --bed-file Variant bed file
                        (Required) The path to the 0-based variant file in bed
                        format.
  --score-type {by-gene,max}
                        (Required) How to add the score to the variant file.
                        Either by the gene name for the variant or the max
                        ConSplice score for that position. Choices = 'by-gene'
                        or 'max') (NOTE: If 'by-gene is chosen, then the
                        --bed-gene-name argument will be used to determine the
                        gene name in the bed file)
  --out-file Ouput File
                        (Required) The path and/or the name of the output file
                        to create

Required if using 'by-gene':
  --alt-gene-symbol Alternative Gene Symbol File
                        (Required if --score-type == 'by-gene') A file that
                        contains mappings between a canonical gene symbol to
                        alternative gene symbols. NOTE: The file needs to have
                        a header!. This script is set up to use the HGNC
                        protein-coding gene mapping file can be found in the
                        ConSplice GitHub repo:
                        https://github.com/mikecormier/ConSplice
```

## consplice_constraint_score-vcf

### Tool Description
Add ConSplice scores to a vcf file.

### Metadata
- **Docker Image**: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
- **Homepage**: https://github.com/mikecormier/ConSplice
- **Package**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikecormier/ConSplice
- **Stars**: N/A

### Original Help Text
```text
usage: ConSplice constraint score-vcf [-h] --consplice-file ConSplice Score
                                      bed File --vcf-file The VCF file
                                      --out-file Ouput File
                                      [--out-type Output file type]
                                      [--consplice-col ConSplice Column Name]

	*************************
	* ConSplice - Score vcf *
	*************************

	Score a valid vcf file with ConSplice scores
	 - Each variant is treated as an SNV using the
	   variant position rather the the genomic range

optional arguments:
  -h, --help            show this help message and exit
  --out-type Output file type
                        The output file type. Whether the output file should
                        be a normal vcf/bcf file or a bgzipped vcf/bcf file.
                        Choices = ['vcf','vcfgz','bcf','bcfgz']. vcfgz and
                        bcfgz are the compressed version of vcf or bcf files.
                        Default = 'vcf'
  --consplice-col ConSplice Column Name
                        The name of the ConSplice score column in the
                        ConSplice file. (Default = ConSplice_Percentile)

Required Arguments:
  --consplice-file ConSplice Score bed File
                        (Required) The path to the 0-based ConSplice score
                        file in bed format.
  --vcf-file The VCF file
                        (Required) The path to the valid vcf file to add
                        ConSplice scores to
  --out-file Ouput File
                        (Required) The path and/or the name of the output file
                        to create
```

## consplice_ML_train

### Tool Description
Train a Random Forest model using ConSplice.

### Metadata
- **Docker Image**: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
- **Homepage**: https://github.com/mikecormier/ConSplice
- **Package**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikecormier/ConSplice
- **Stars**: N/A

### Original Help Text
```text
usage: ConSplice ML train [-h] --patho-set Pathogenic Splicing set
                          --benign-set Benign Splicing set --consplice-col
                          ConSplice Column --spliceai-col SpliceAI Column
                          --squirls-col SQUIRLS Column
                          [--output-dir Output Directory]
                          [--random-state Random State]
                          [--n-dt N decision trees]

	****************************
	** ConSpliceML - Training **
	****************************

	Train a Random Forest using the regional ConSplice model,
	SpliceAI alternative splicing prediction scores, and
	SQUIRLS alternative splicing prediction scores.

optional arguments:
  -h, --help            show this help message and exit
  --output-dir Output Directory
                        (Optional) The path and name of the directory to crate
                        and store the final trained model in. The default
                        output dir will be created in the current working
                        directory under the name 'ConSpliceML_Model'
  --random-state Random State
                        (Optional) The random state to use when training the
                        model. (Default = 156498)
  --n-dt N decision trees
                        (Optional) The number of decision trees to use when
                        creating the random forest (Default = 1000)

Required Arguments:
  --patho-set Pathogenic Splicing set
                        (Required) The path and file name to the pathogenic
                        variants for training. ConSplice, SpliceAI, and SQUIRL
                        scores should be in this file. Requires a tab-
                        delimited file. NOTE: This file should be split into
                        the training set prior to using it here.
  --benign-set Benign Splicing set
                        (Required) The path and file name to the benign
                        variants for training. ConSplice, SpliceAI, and SQUIRL
                        scores should be in this file. Requires a tab-
                        delimited file. NOTE: This file should be split into
                        the training set prior to using it here.
  --consplice-col ConSplice Column
                        (Required) The name of the ConSplice column in the
                        pathogenic and benign training sets
  --spliceai-col SpliceAI Column
                        (Required) The name of the SpliceAI column in the
                        pathogenic and benign training sets
  --squirls-col SQUIRLS Column
                        (Required) The name of the SQUIRLS column in the
                        pathogenic and benign training sets
```

## consplice_ML_score-vcf

### Tool Description
Score variants using ConSpliceML.

### Metadata
- **Docker Image**: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
- **Homepage**: https://github.com/mikecormier/ConSplice
- **Package**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikecormier/ConSplice
- **Stars**: N/A

### Original Help Text
```text
usage: ConSplice ML score-vcf [-h] --vcf-file Input vcf File --output-file
                              Output File
                              [--alt-gene-symbol Alternative Gene Symbol File]
                              [--out-type Output file type]
                              [--n-cpu Number of CPUs]
                              [--ml-model ConSpliceML Model]

	*****************************
	** ConSpliceML - score-vcf **
	*****************************

	Score a vcf file using the trained ConSpliceML model
	NOTE: The vcf file needs to be annotated with the
	      required splicing scores: SpliceAI, SQUIRLS, and
	      ConSplice. This process will fail if these annotation
	      are missing from the INFO field of the vcf file.

optional arguments:
  -h, --help            show this help message and exit
  --out-type Output file type
                        The output file type. Whether the output file should
                        be a normal vcf/bcf file or a bgzipped vcf/bcf file.
                        Choices = ['vcf','vcfgz','bcf','bcfgz']. vcfgz and
                        bcfgz are the compressed version of vcf or bcf files.
                        Default = 'vcf'
  --n-cpu Number of CPUs
                        The number of CPUs to use for multi-threading during
                        vcf parsing. (Default = 3)
  --ml-model ConSpliceML Model
                        (Optional) The path to the directory that contains the
                        ConSpliceML Model. If not specified, the ConSpliceML
                        model from the config path will be used.

Required Arguments:
  --vcf-file Input vcf File
                        (Required) The input vcf file to score
  --output-file Output File
                        (Required) The output variant file to create
  --alt-gene-symbol Alternative Gene Symbol File
                        (Required) A file that contains mappings between a
                        canonical gene symbol to alternative gene symbols.
                        NOTE: The file needs to have a header!. This script is
                        set up to use the HGNC protein-coding gene mapping
                        file can be found in the ConSplice GitHub repo:
                        https://github.com/mikecormier/ConSplice
```

## Metadata
- **Skill**: generated

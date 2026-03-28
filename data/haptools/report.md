# haptools CWL Generation Report

## haptools_clump

### Tool Description
Performs clumping on datasets with SNPs, SNPs and STRs, and STRs. Clumping is the process of identifying SNPs or STRs that are highly correlated with one another and concatenating them all together into a single "clump" in order to not repeat the same effect size due to LD.

### Metadata
- **Docker Image**: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
- **Homepage**: https://github.com/cast-genomics/haptools
- **Package**: https://anaconda.org/channels/bioconda/packages/haptools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/haptools/overview
- **Total Downloads**: 15.1K
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/cast-genomics/haptools
- **Stars**: N/A
### Original Help Text
```text
Usage: haptools clump [OPTIONS]

  Performs clumping on datasets with SNPs, SNPs and STRs, and STRs. Clumping
  is the process of identifying SNPs or STRs that are highly correlated with
  one another and concatenating them all together into a single "clump" in
  order to not repeat the same effect size due to LD.

Options:
  --summstats-snps PATH           File to load snps summary statistics
  --summstats-strs PATH           File to load strs summary statistics
  --gts-snps PATH                 SNP genotypes (VCF or PGEN)
  --gts-strs PATH                 STR genotypes (VCF)
  --clump-p1 FLOAT                Max pval to start a new clump
  --clump-p2 FLOAT                Filter for pvalue less than
  --clump-id-field TEXT           Column header of the variant ID
  --clump-field TEXT              Column header of the p-values
  --clump-chrom-field TEXT        Column header of the chromosome
  --clump-pos-field TEXT          Column header of the position
  --clump-kb FLOAT                clump kb radius
  --clump-r2 FLOAT                r^2 threshold
  --ld [Exact|Pearson]            Calculation type to infer LD, Exact Solution
                                  or Pearson R. (Exact|Pearson). Note the
                                  Exact Solution works best when all three
                                  genotypes are present (0,1,2) in the
                                  variants being compared.  [default: Pearson]
  --out PATH                      Output filename  [required]
  -v, --verbosity [CRITICAL|ERROR|WARNING|INFO|DEBUG|NOTSET]
                                  The level of verbosity desired  [default:
                                  INFO]
  --help                          Show this message and exit.
```


## haptools_index

### Tool Description
Takes in an unsorted .hap file and outputs it as a .gz and a .tbi file

### Metadata
- **Docker Image**: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
- **Homepage**: https://github.com/cast-genomics/haptools
- **Package**: https://anaconda.org/channels/bioconda/packages/haptools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: haptools index [OPTIONS] HAPLOTYPES

  Takes in an unsorted .hap file and outputs it as a .gz and a .tbi file

Options:
  --sort / --no-sort              Sorting of the file will not be performed
                                  [default: sort]
  -o, --output PATH               A .hap file containing sorted and indexed
                                  haplotypes and variants  [default: (input
                                  file)]
  -v, --verbosity [CRITICAL|ERROR|WARNING|INFO|DEBUG|NOTSET]
                                  The level of verbosity desired  [default:
                                  INFO]
  --help                          Show this message and exit.
```


## haptools_karyogram

### Tool Description
Visualize a karyogram of local ancestry tracks

### Metadata
- **Docker Image**: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
- **Homepage**: https://github.com/cast-genomics/haptools
- **Package**: https://anaconda.org/channels/bioconda/packages/haptools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: haptools karyogram [OPTIONS]

  Visualize a karyogram of local ancestry tracks

Options:
  --bp TEXT                       Path to .bp file with breakpoints
                                  [required]
  --sample TEXT                   Sample ID to plot  [required]
  --out TEXT                      Name of output file  [required]
  --title TEXT                    Optional plot title
  --centromeres TEXT              Optional file with telomere/centromere cM
                                  positions
  --colors TEXT                   Optional color dictionary. Input can be from
                                  the matplotlib list of colors or in hexcode.
                                  Format is e.g. 'YRI:blue,CEU:green'
  -v, --verbosity [CRITICAL|ERROR|WARNING|INFO|DEBUG|NOTSET]
                                  The level of verbosity desired  [default:
                                  INFO]
  --help                          Show this message and exit.
```


## haptools_ld

### Tool Description
Compute the pair-wise LD (Pearson's correlation) between haplotypes (or variants) and a single TARGET haplotype (or variant)

### Metadata
- **Docker Image**: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
- **Homepage**: https://github.com/cast-genomics/haptools
- **Package**: https://anaconda.org/channels/bioconda/packages/haptools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: haptools ld [OPTIONS] TARGET GENOTYPES HAPLOTYPES

  Compute the pair-wise LD (Pearson's correlation) between haplotypes (or
  variants) and a single TARGET haplotype (or variant)

  GENOTYPES must be formatted as a VCF or PGEN and HAPLOTYPES must be
  formatted according to the .hap format spec

  TARGET refers to the ID of a variant or haplotype. LD is computed pair-wise
  between TARGET and all of the other haplotypes in the .hap (or genotype)
  file

  If TARGET is a variant ID, the ID must appear in GENOTYPES. Otherwise, it
  must be present in the .hap file

Options:
  --region TEXT                   The region from which to extract haplotypes;
                                  ex: 'chr1:1234-34566' or 'chr7'. For this to
                                  work, the VCF and .hap file must be indexed
                                  and the seqname provided must correspond
                                  with one in the files  [default: (all
                                  haplotypes)]
  -s, --sample TEXT               A list of the samples to subset from the
                                  genotypes file (ex: '-s sample1 -s sample2')
                                  [default: (all samples)]
  -S, --samples-file FILENAME     A single column txt file containing a list
                                  of the samples (one per line) to subset from
                                  the genotypes file  [default: (all samples)]
  -i, --id TEXT                   A list of the haplotype IDs to use from the
                                  .hap file (ex: '-i H1 -i H2'). Or, if
                                  --from-gts, a list of the variant IDs to use
                                  from the genotypes file. For this to work,
                                  the .hap file must be indexed  [default:
                                  (all haplotypes)]
  -I, --ids-file TEXT             A single column txt file containing a list
                                  of the haplotype (or variant) IDs (one per
                                  line) to subset from the .hap (or genotype)
                                  file  [default: (all haplotypes)]
  -c, --chunk-size INTEGER        If using a PGEN file, read genotypes in
                                  chunks of X variants; reduces memory
                                  [default: (all variants)]
  --discard-missing               Ignore any samples that are missing
                                  genotypes for the required variants
  --from-gts                      By default, LD is computed with the
                                  haplotypes in the .hap file. Use this switch
                                  to compute LD with the genotypes in the
                                  genotypes file, instead.
  -o, --output PATH               A .hap file containing haplotypes and their
                                  LD with TARGET  [default: (stdout)]
  -v, --verbosity [CRITICAL|ERROR|WARNING|INFO|DEBUG|NOTSET]
                                  The level of verbosity desired  [default:
                                  INFO]
  --help                          Show this message and exit.
```


## haptools_simgenotype

### Tool Description
Simulate admixed genomes under a pre-defined model.

### Metadata
- **Docker Image**: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
- **Homepage**: https://github.com/cast-genomics/haptools
- **Package**: https://anaconda.org/channels/bioconda/packages/haptools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: haptools simgenotype [OPTIONS]

  Simulate admixed genomes under a pre-defined model.

Options:
  --model TEXT                    Admixture model in .dat format. See File
                                  Formats under simgenotype in the docs for
                                  complete info.  [required]
  --mapdir DIRECTORY              Directory containing files with chr{1-22,X}
                                  and ending in .map in the file name with
                                  genetic map coords.  [required]
  --out TEXT                      Path to desired output file. E.g.
                                  /path/to/output.vcf.gz Possible outputs are
                                  vcf|bcf|vcf.gz|pgen and there will be an
                                  additional breakpoints output with extension
                                  bp e.g. /path/to/output.bp.  [required]
  --chroms TEXT                   Sorted and comma delimited list of
                                  chromosomes to simulate
  --seed INTEGER                  Random seed. Set to make simulations
                                  reproducible
  --ref_vcf TEXT                  VCF or PGEN file used as reference for
                                  creation of simulated samples respective
                                  genotypes.  [required]
  --sample_info TEXT              File that maps samples from the reference
                                  VCF (--invcf) to population codes describing
                                  the populations in the header of the model
                                  file.  [required]
  --region TEXT                   Subset the simulation to a specific region
                                  in a chromosome using the form chrom:start-
                                  end. Example 2:1000-2000
  --pop_field                     Flag for outputting the population field in
                                  your VCF output. NOTE this flag does not
                                  work when your output file is in PGEN
                                  format.
  --sample_field                  Flag for outputting the sample field in your
                                  VCF output. NOTE this flag does not work
                                  when your output file is in PGEN format.
  --no_replacement                Flag used to determine whether to sample
                                  reference haplotypes with or without
                                  replacement. (Default = Replacement)
  --only_breakpoint               Flag used to determine whether to only
                                  output breakpoints or continue to simulate a
                                  vcf file.
  -c, --chunk-size INTEGER        If requesting a PGEN output file, write
                                  genotypes in chunks of X variants; reduces
                                  memory  [default: (all variants)]
  -v, --verbosity [CRITICAL|ERROR|WARNING|INFO|DEBUG|NOTSET]
                                  The level of verbosity desired  [default:
                                  INFO]
  --help                          Show this message and exit.
```


## haptools_simphenotype

### Tool Description
Haplotype-aware phenotype simulation. Create a set of simulated phenotypes from a set of haplotypes.

### Metadata
- **Docker Image**: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
- **Homepage**: https://github.com/cast-genomics/haptools
- **Package**: https://anaconda.org/channels/bioconda/packages/haptools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: haptools simphenotype [OPTIONS] GENOTYPES HAPLOTYPES

  Haplotype-aware phenotype simulation. Create a set of simulated phenotypes
  from a set of haplotypes.

  GENOTYPES must be formatted as a VCF or PGEN file and HAPLOTYPES must be
  formatted according to the .hap format spec

  Note: GENOTYPES must be the output from the transform subcommand.

Options:
  -r, --replications INTEGER RANGE
                                  Number of rounds of simulation to perform
                                  [default: 1; x>=1]
  --environment FLOAT RANGE       Variance of environmental term; inferred if
                                  not specified  [x>=0]
  -h, --heritability FLOAT RANGE  Trait heritability  [default: (0.5);
                                  0<=x<=1]
  -p, --prevalence FLOAT RANGE    Disease prevalence if simulating a case-
                                  control trait  [default: (quantitative
                                  trait); 0<=x<1]
  --normalize / --no-normalize    Whether to normalize the genotypes before
                                  using them for simulation  [default:
                                  normalize]
  --region TEXT                   The region from which to extract haplotypes;
                                  ex: 'chr1:1234-34566' or 'chr7'. For this to
                                  work, the VCF and .hap file must be indexed
                                  and the seqname provided must correspond
                                  with one in the files  [default: (all
                                  haplotypes)]
  -s, --sample TEXT               A list of the samples to subset from the
                                  genotypes file (ex: '-s sample1 -s sample2')
                                  [default: (all samples)]
  -S, --samples-file FILENAME     A single column txt file containing a list
                                  of the samples (one per line) to subset from
                                  the genotypes file  [default: (all samples)]
  -i, --id TEXT                   A list of the haplotype IDs from the .hap
                                  file to use as causal variables (ex: '-i H1
                                  -i H2').  [default: (all haplotypes)]
  -I, --ids-file TEXT             A single column txt file containing a list
                                  of the haplotype IDs (one per line) to
                                  subset from the .hap file  [default: (all
                                  haplotypes)]
  -c, --chunk-size INTEGER        If using a PGEN file, read genotypes in
                                  chunks of X variants; reduces memory
                                  [default: (all variants)]
  --repeats PATH                  Path to a genotypes file containing tandem
                                  repeats. This is only necessary when
                                  simulating both haplotypes *and* repeats as
                                  causal effects
  --seed INTEGER                  Use this option across executions to make
                                  the output reproducible  [default: (chosen
                                  randomly)]
  -o, --output PATH               A TSV file containing simulated phenotypes
                                  [default: (stdout)]
  -v, --verbosity [CRITICAL|ERROR|WARNING|INFO|DEBUG|NOTSET]
                                  The level of verbosity desired  [default:
                                  INFO]
  --help                          Show this message and exit.
```


## haptools_transform

### Tool Description
Creates a VCF composed of haplotypes

### Metadata
- **Docker Image**: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
- **Homepage**: https://github.com/cast-genomics/haptools
- **Package**: https://anaconda.org/channels/bioconda/packages/haptools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: haptools transform [OPTIONS] GENOTYPES HAPLOTYPES

  Creates a VCF composed of haplotypes

  GENOTYPES must be formatted as a VCF or PGEN and HAPLOTYPES must be
  formatted according to the .hap format spec

Options:
  --region TEXT                   The region from which to extract haplotypes;
                                  ex: 'chr1:1234-34566' or 'chr7'. For this to
                                  work, the VCF and .hap file must be indexed
                                  and the seqname provided must correspond
                                  with one in the files  [default: (all
                                  haplotypes)]
  -s, --sample TEXT               A list of the samples to subset from the
                                  genotypes file (ex: '-s sample1 -s sample2')
                                  [default: (all samples)]
  -S, --samples-file FILENAME     A single column txt file containing a list
                                  of the samples (one per line) to subset from
                                  the genotypes file  [default: (all samples)]
  -i, --id TEXT                   A list of the haplotype IDs to use from the
                                  .hap file (ex: '-i H1 -i H2').  [default:
                                  (all haplotypes)]
  -I, --ids-file TEXT             A single column txt file containing a list
                                  of the haplotype IDs (one per line) to
                                  subset from the .hap file  [default: (all
                                  haplotypes)]
  -c, --chunk-size INTEGER        If using a PGEN file, read genotypes in
                                  chunks of X variants; reduces memory
                                  [default: (all variants)]
  --discard-missing               Ignore any samples that are missing
                                  genotypes for the required variants
  --ancestry                      Also transform using VCF 'POP' FORMAT field
                                  and 'ancestry' .hap extra field
  --maf FLOAT                     Do not output haplotypes with an MAF below
                                  this value  [default: (all haplotypes)]
  -o, --output PATH               A VCF file containing haplotype 'genotypes'
                                  [default: (stdout)]
  -v, --verbosity [CRITICAL|ERROR|WARNING|INFO|DEBUG|NOTSET]
                                  The level of verbosity desired  [default:
                                  INFO]
  --help                          Show this message and exit.
```


## Metadata
- **Skill**: generated

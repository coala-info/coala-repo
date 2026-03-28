# graphtyper CWL Generation Report

## graphtyper_bamshrink

### Tool Description
GraphTyper

### Metadata
- **Docker Image**: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
- **Homepage**: https://github.com/DecodeGenetics/graphtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Total Downloads**: 25.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/DecodeGenetics/graphtyper
- **Stars**: N/A
### Original Help Text
```text
[paw::Parser::MissingPositionalArgument] ERROR: Positional argument <bamPathIn> is missing.

NAME
   GraphTyper

USAGE
   graphtyper bamshrink <bamPathIn> [OPTIONS]

   <bamPathIn>
      Input BAM file path.

SUBCOMMANDS
   bamshrink       Run bamShrink.
   call            Call variants of a graph.
   check           Check a GraphTyper graph (useful for debugging).
   construct       Construct a graph.
   genotype        Run the SNP/indel genotyping pipeline.
   genotype_camou  (WIP) Run the camou SNP/indel genotyping pipeline.
   genotype_hla    (WIP) Run the HLA genotyping pipeline.
   genotype_lr     (WIP) Run the camou LR genotyping pipeline.
   genotype_sv     Run the structural variant (SV) genotyping pipeline.
   index           (deprecated) Index a graph.
   vcf_break_down  Break down/decompose a VCF file.
   vcf_concatenate Concatenate VCF files.
   vcf_merge       Merge VCF files.

OPTIONS
   --log=value or -lvalue
      Set path to log file.

   --verbose or -v
      Set to output verbose logging.

   --vverbose
      Set to output very verbose logging.

   --avg-cov-by-readlen=D or -aD [default: 0.3]
      Average coverage divided by read length.

   --index=value [default: <bamPathIn>.[bai,crai]]
      Input BAM bai/CRAM crai index file.

   --output=value or -ovalue [default: -]
      Output BAM file.

   --interval=value or -ivalue
      Interval/region to filter on in format chrA:N-M, where chrA is the contig 
      name, N is the begin position, and M is the end position of the interval.

   --interval-file=value or -Ivalue
      File with interval(s)/region(s) to filter on.

   --max-fragment-length=N or -fN [default: 1000]
      Maximum fragment length allowed.

   --min-num-matching=N or -mN [default: 55]
      Minumum number of matching bases in read.

   --help or -h
      Show this help.

VERSION
   2.7.7
```


## graphtyper_call

### Tool Description
Call variants of a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
- **Homepage**: https://github.com/DecodeGenetics/graphtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
   GraphTyper

USAGE
   graphtyper call [OPTIONS]

SUBCOMMANDS
   bamshrink       Run bamShrink.
   call            Call variants of a graph.
   check           Check a GraphTyper graph (useful for debugging).
   construct       Construct a graph.
   genotype        Run the SNP/indel genotyping pipeline.
   genotype_camou  (WIP) Run the camou SNP/indel genotyping pipeline.
   genotype_hla    (WIP) Run the HLA genotyping pipeline.
   genotype_lr     (WIP) Run the camou LR genotyping pipeline.
   genotype_sv     Run the structural variant (SV) genotyping pipeline.
   index           (deprecated) Index a graph.
   vcf_break_down  Break down/decompose a VCF file.
   vcf_concatenate Concatenate VCF files.
   vcf_merge       Merge VCF files.

OPTIONS
   --log=value or -lvalue
      Set path to log file.

   --verbose or -v
      Set to output verbose logging.

   --vverbose
      Set to output very verbose logging.

   --help or -h
      Show this help.

VERSION
   2.7.7
```


## graphtyper_check

### Tool Description
Check a GraphTyper graph (useful for debugging).

### Metadata
- **Docker Image**: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
- **Homepage**: https://github.com/DecodeGenetics/graphtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Validation**: PASS

### Original Help Text
```text
[paw::Parser::MissingPositionalArgument] ERROR: Positional argument <GRAPH> is missing.

NAME
   GraphTyper

USAGE
   graphtyper check <GRAPH> [OPTIONS]

   <GRAPH>
      Path to graph.

SUBCOMMANDS
   bamshrink       Run bamShrink.
   call            Call variants of a graph.
   check           Check a GraphTyper graph (useful for debugging).
   construct       Construct a graph.
   genotype        Run the SNP/indel genotyping pipeline.
   genotype_camou  (WIP) Run the camou SNP/indel genotyping pipeline.
   genotype_hla    (WIP) Run the HLA genotyping pipeline.
   genotype_lr     (WIP) Run the camou LR genotyping pipeline.
   genotype_sv     Run the structural variant (SV) genotyping pipeline.
   index           (deprecated) Index a graph.
   vcf_break_down  Break down/decompose a VCF file.
   vcf_concatenate Concatenate VCF files.
   vcf_merge       Merge VCF files.

OPTIONS
   --log=value or -lvalue
      Set path to log file.

   --verbose or -v
      Set to output verbose logging.

   --vverbose
      Set to output very verbose logging.

   --help or -h
      Show this help.

VERSION
   2.7.7
```


## graphtyper_construct

### Tool Description
Construct a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
- **Homepage**: https://github.com/DecodeGenetics/graphtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Validation**: PASS

### Original Help Text
```text
[paw::Parser::MissingPositionalArgument] ERROR: Positional argument <GRAPH> is missing.

NAME
   GraphTyper

USAGE
   graphtyper construct <GRAPH> <REF.FA> <REGION> [OPTIONS]

   <GRAPH>
      Path to graph.

   <REF.FA>
      Reference genome in FASTA format.

   <REGION>
      Genomic region to construct graph for.

SUBCOMMANDS
   bamshrink       Run bamShrink.
   call            Call variants of a graph.
   check           Check a GraphTyper graph (useful for debugging).
   construct       Construct a graph.
   genotype        Run the SNP/indel genotyping pipeline.
   genotype_camou  (WIP) Run the camou SNP/indel genotyping pipeline.
   genotype_hla    (WIP) Run the HLA genotyping pipeline.
   genotype_lr     (WIP) Run the camou LR genotyping pipeline.
   genotype_sv     Run the structural variant (SV) genotyping pipeline.
   index           (deprecated) Index a graph.
   vcf_break_down  Break down/decompose a VCF file.
   vcf_concatenate Concatenate VCF files.
   vcf_merge       Merge VCF files.

OPTIONS
   --log=value or -lvalue
      Set path to log file.

   --verbose or -v
      Set to output verbose logging.

   --vverbose
      Set to output very verbose logging.

   --sv_graph
      Set to construct an SV graph.

   --add_all_variants
      Set to create a graph with every possible haplotype on overlapping 
      variants.

   --use_tabix
      Set to use tabix index to extract variants of the given region.

   --vcf=value
      VCF variant input.

   --help or -h
      Show this help.

VERSION
   2.7.7
```


## graphtyper_genotype

### Tool Description
Run the SNP/indel genotyping pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
- **Homepage**: https://github.com/DecodeGenetics/graphtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Validation**: PASS

### Original Help Text
```text
[paw::Parser::MissingPositionalArgument] ERROR: Positional argument <REF.FA> is missing.

NAME
   GraphTyper

USAGE
   graphtyper genotype <REF.FA> [OPTIONS]

   <REF.FA>
      Reference genome in FASTA format.

SUBCOMMANDS
   bamshrink       Run bamShrink.
   call            Call variants of a graph.
   check           Check a GraphTyper graph (useful for debugging).
   construct       Construct a graph.
   genotype        Run the SNP/indel genotyping pipeline.
   genotype_camou  (WIP) Run the camou SNP/indel genotyping pipeline.
   genotype_hla    (WIP) Run the HLA genotyping pipeline.
   genotype_lr     (WIP) Run the camou LR genotyping pipeline.
   genotype_sv     Run the structural variant (SV) genotyping pipeline.
   index           (deprecated) Index a graph.
   vcf_break_down  Break down/decompose a VCF file.
   vcf_concatenate Concatenate VCF files.
   vcf_merge       Merge VCF files.

OPTIONS
   --log=value or -lvalue
      Set path to log file.

   --verbose or -v
      Set to output verbose logging.

   --vverbose
      Set to output very verbose logging.

   --advanced or -a
      Set to enable advanced options. See a list of all options (including 
      advanced) with 'graphtyper genotype --advanced --help'

   --avg_cov_by_readlen=value
      File with average coverage by read length (one value per line). The 
      values are used for subsampling regions with extremely high coverage and 
      should be in the same order as the BAM/CRAM list.

   --no_decompose
      Set to prohibit decomposing variants in VCF output, which means complex 
      variants wont be split/decomposed into smaller variants.

   --force_copy_reference
      Force copy of the reference FASTA to temporary folder.

   --force_no_copy_reference
      Force that the reference FASTA is NOT copied to temporary folder. Useful 
      if you have limit storage on your local disk or the reference is already 
      on your local disk.

   --output=value or -Ovalue [default: results]
      Output directory. Results will be written in 
      <output>/<contig>/<region>.vcf.gz

   --prior_vcf=value or -pvalue
      Input VCF file with prior variants sites. With this option set GraphTyper 
      will be run normally except the given input variant sites are used in 
      constructing the initial graph. We recommend only using common variants 
      as a prior (1% allele frequency or higher). Note that the final output 
      may not necessarily include every prior variant and GraphTyper may 
      discover other variants as well. If you rather want to call only a 
      specific set of variants then use the --vcf option instead.

   --region=value or -rvalue
      Genomic region to genotype. Use --region_file if you have more than one 
      region.

   --region_file=value or -Rvalue
      File with a list of genomic regions to genotype (one per line).

   --threads=value or -tvalue [default: 20]
      Max. number of threads to use. Note that it is not possible to utilize 
      more threads than input BAM/CRAMs.

   --sam=value or -svalue
      Input BAM/CRAM to analyze. If you have more than one file then create a 
      list and use --sams instead.

   --sams=value or -Svalue
      File with BAM/CRAMs paths to analyze (one per line).

   --sams_index=value or -ivalue
      File containing a list of BAM/CRAM indices to use when BAM/CRAM files are 
      queried (one per line). The index files must be given in the same order 
      as the BAMs/CRAMs.

   --vcf=value
      Input VCF file with variant sites. Use this option if you want GraphTyper 
      to only genotype variants from this VCF.

   --help or -h
      Show this help.

VERSION
   2.7.7
```


## graphtyper_genotype_camou

### Tool Description
GraphTyper

### Metadata
- **Docker Image**: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
- **Homepage**: https://github.com/DecodeGenetics/graphtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Validation**: PASS

### Original Help Text
```text
[paw::Parser::MissingPositionalArgument] ERROR: Positional argument <REF.FA> is missing.

NAME
   GraphTyper

USAGE
   graphtyper genotype_camou <REF.FA> <interval-file> [OPTIONS]

   <REF.FA>
      Reference genome in FASTA format.

   <interval-file>
      3-column BED type file with interval(s)/region(s) to filter on.

SUBCOMMANDS
   bamshrink       Run bamShrink.
   call            Call variants of a graph.
   check           Check a GraphTyper graph (useful for debugging).
   construct       Construct a graph.
   genotype        Run the SNP/indel genotyping pipeline.
   genotype_camou  (WIP) Run the camou SNP/indel genotyping pipeline.
   genotype_hla    (WIP) Run the HLA genotyping pipeline.
   genotype_lr     (WIP) Run the camou LR genotyping pipeline.
   genotype_sv     Run the structural variant (SV) genotyping pipeline.
   index           (deprecated) Index a graph.
   vcf_break_down  Break down/decompose a VCF file.
   vcf_concatenate Concatenate VCF files.
   vcf_merge       Merge VCF files.

OPTIONS
   --log=value or -lvalue
      Set path to log file.

   --verbose or -v
      Set to output verbose logging.

   --vverbose
      Set to output very verbose logging.

   --avg_cov_by_readlen=value
      File with average coverage by read length.

   --max_files_open=value [default: 864]
      Select how many files can be open at the same time.

   --no_bamshrink
      Set to skip bamShrink.

   --no_cleanup
      Set to skip removing temporary files. Useful for debugging.

   --output=value or -Ovalue [default: results]
      Output directory. Results will be written in 
      <output>/<contig>/<region>.vcf.gz

   --sam=value or -svalue
      SAM/BAM/CRAM to analyze.

   --sams=value or -Svalue
      File with SAM/BAM/CRAMs to analyze (one per line).

   --threads=value or -tvalue [default: 20]
      Max. number of threads to use.

   --vcf=value
      Input VCF file with variant sites. Use this option if you want GraphTyper 
      to only genotype variants from this VCF.

   --help or -h
      Show this help.

VERSION
   2.7.7
```


## graphtyper_genotype_hla

### Tool Description
Run the HLA genotyping pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
- **Homepage**: https://github.com/DecodeGenetics/graphtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Validation**: PASS

### Original Help Text
```text
[paw::Parser::MissingPositionalArgument] ERROR: Positional argument <REF.FA> is missing.

NAME
   GraphTyper

USAGE
   graphtyper genotype_hla <REF.FA> <vcf> [OPTIONS]

   <REF.FA>
      Reference genome in FASTA format.

   <vcf>
      Input VCF file with known HLA variants.

SUBCOMMANDS
   bamshrink       Run bamShrink.
   call            Call variants of a graph.
   check           Check a GraphTyper graph (useful for debugging).
   construct       Construct a graph.
   genotype        Run the SNP/indel genotyping pipeline.
   genotype_camou  (WIP) Run the camou SNP/indel genotyping pipeline.
   genotype_hla    (WIP) Run the HLA genotyping pipeline.
   genotype_lr     (WIP) Run the camou LR genotyping pipeline.
   genotype_sv     Run the structural variant (SV) genotyping pipeline.
   index           (deprecated) Index a graph.
   vcf_break_down  Break down/decompose a VCF file.
   vcf_concatenate Concatenate VCF files.
   vcf_merge       Merge VCF files.

OPTIONS
   --log=value or -lvalue
      Set path to log file.

   --verbose or -v
      Set to output verbose logging.

   --vverbose
      Set to output very verbose logging.

   --advanced or -a
      Set to enable advanced options. See a list of all options (including 
      advanced) with 'graphtyper genotype_hla --advanced --help'

   --avg_cov_by_readlen=value
      File with average coverage by read length (one value per line). The 
      values are used for subsampling regions with extremely high coverage and 
      should be in the same order as the BAM/CRAM list.

   --intervals=value or -ivalue
      BED file with intervals to gather reads from. If empty, reads in region 
      will be used.

   --output=value or -Ovalue [default: hla_results]
      Output directory.

   --region=value or -rvalue
      Genomic region to genotype.

   --region_file=value or -Rvalue
      File with genomic regions to genotype.

   --threads=value or -tvalue [default: 20]
      Max. number of threads to use.

   --sam=value or -svalue
      SAM/BAM/CRAM to analyze.

   --sams=value or -Svalue
      File with SAM/BAM/CRAMs to analyze (one per line).

   --sams_index=value or -ivalue
      File containing a list of BAM/CRAM indices to use when BAM/CRAM files are 
      queried (one per line). The index files must be given in the same order 
      as the BAMs/CRAMs.

   --help or -h
      Show this help.

VERSION
   2.7.7
```


## graphtyper_genotype_lr

### Tool Description
GraphTyper

### Metadata
- **Docker Image**: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
- **Homepage**: https://github.com/DecodeGenetics/graphtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Validation**: PASS

### Original Help Text
```text
[paw::Parser::MissingPositionalArgument] ERROR: Positional argument <REF.FA> is missing.

NAME
   GraphTyper

USAGE
   graphtyper genotype_lr <REF.FA> [OPTIONS]

   <REF.FA>
      Reference genome in FASTA format.

SUBCOMMANDS
   bamshrink       Run bamShrink.
   call            Call variants of a graph.
   check           Check a GraphTyper graph (useful for debugging).
   construct       Construct a graph.
   genotype        Run the SNP/indel genotyping pipeline.
   genotype_camou  (WIP) Run the camou SNP/indel genotyping pipeline.
   genotype_hla    (WIP) Run the HLA genotyping pipeline.
   genotype_lr     (WIP) Run the camou LR genotyping pipeline.
   genotype_sv     Run the structural variant (SV) genotyping pipeline.
   index           (deprecated) Index a graph.
   vcf_break_down  Break down/decompose a VCF file.
   vcf_concatenate Concatenate VCF files.
   vcf_merge       Merge VCF files.

OPTIONS
   --log=value or -lvalue
      Set path to log file.

   --verbose or -v
      Set to output verbose logging.

   --vverbose
      Set to output very verbose logging.

   --advanced or -a
      Set to enable advanced options. See a list of all options (including 
      advanced) with 'graphtyper genotype_sv --advanced --help'

   --output=value or -Ovalue [default: sv_results]
      Output directory.

   --region=value or -rvalue
      Genomic region to genotype.

   --region_file=value or -Rvalue
      File with genomic regions to genotype.

   --threads=value or -tvalue [default: 20]
      Max. number of threads to use.

   --sam=value or -svalue
      SAM/BAM/CRAM to analyze.

   --sams=value or -Svalue
      File with SAM/BAM/CRAMs to analyze (one per line).

   --help or -h
      Show this help.

VERSION
   2.7.7
```


## graphtyper_genotype_sv

### Tool Description
Run the structural variant (SV) genotyping pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
- **Homepage**: https://github.com/DecodeGenetics/graphtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Validation**: PASS

### Original Help Text
```text
[paw::Parser::MissingPositionalArgument] ERROR: Positional argument <REF.FA> is missing.

NAME
   GraphTyper

USAGE
   graphtyper genotype_sv <REF.FA> <vcf> [OPTIONS]

   <REF.FA>
      Reference genome in FASTA format.

   <vcf>
      Input VCF file with structural variant sites and optionally also 
      SNP/indel sites.

SUBCOMMANDS
   bamshrink       Run bamShrink.
   call            Call variants of a graph.
   check           Check a GraphTyper graph (useful for debugging).
   construct       Construct a graph.
   genotype        Run the SNP/indel genotyping pipeline.
   genotype_camou  (WIP) Run the camou SNP/indel genotyping pipeline.
   genotype_hla    (WIP) Run the HLA genotyping pipeline.
   genotype_lr     (WIP) Run the camou LR genotyping pipeline.
   genotype_sv     Run the structural variant (SV) genotyping pipeline.
   index           (deprecated) Index a graph.
   vcf_break_down  Break down/decompose a VCF file.
   vcf_concatenate Concatenate VCF files.
   vcf_merge       Merge VCF files.

OPTIONS
   --log=value or -lvalue
      Set path to log file.

   --verbose or -v
      Set to output verbose logging.

   --vverbose
      Set to output very verbose logging.

   --advanced or -a
      Set to enable advanced options. See a list of all options (including 
      advanced) with 'graphtyper genotype_sv --advanced --help'

   --avg_cov_by_readlen=value
      File with average coverage by read length (one value per line). The 
      values are used for subsampling regions with extremely high coverage and 
      should be in the same order as the BAM/CRAM list.

   --output=value or -Ovalue [default: sv_results]
      Output directory.

   --region=value or -rvalue
      Genomic region to genotype.

   --region_file=value or -Rvalue
      File with genomic regions to genotype.

   --threads=value or -tvalue [default: 20]
      Max. number of threads to use.

   --sam=value or -svalue
      SAM/BAM/CRAM to analyze.

   --sams=value or -Svalue
      File with SAM/BAM/CRAMs to analyze (one per line).

   --help or -h
      Show this help.

VERSION
   2.7.7
```


## graphtyper_index

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
- **Homepage**: https://github.com/DecodeGenetics/graphtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
GraphTyper's 'index' subcommand deprecated. Graph is now indexed automatically after construction.
```


## graphtyper_vcf_break_down

### Tool Description
Break down/decompose a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
- **Homepage**: https://github.com/DecodeGenetics/graphtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Validation**: PASS

### Original Help Text
```text
[paw::Parser::MissingPositionalArgument] ERROR: Positional argument <GRAPH> is missing.

NAME
   GraphTyper

USAGE
   graphtyper vcf_break_down <GRAPH> <VCF> [OPTIONS]

   <GRAPH>
      Path to graph.

   <VCF>
      Path to VCF file to break down.

SUBCOMMANDS
   bamshrink       Run bamShrink.
   call            Call variants of a graph.
   check           Check a GraphTyper graph (useful for debugging).
   construct       Construct a graph.
   genotype        Run the SNP/indel genotyping pipeline.
   genotype_camou  (WIP) Run the camou SNP/indel genotyping pipeline.
   genotype_hla    (WIP) Run the HLA genotyping pipeline.
   genotype_lr     (WIP) Run the camou LR genotyping pipeline.
   genotype_sv     Run the structural variant (SV) genotyping pipeline.
   index           (deprecated) Index a graph.
   vcf_break_down  Break down/decompose a VCF file.
   vcf_concatenate Concatenate VCF files.
   vcf_merge       Merge VCF files.

OPTIONS
   --log=value or -lvalue
      Set path to log file.

   --verbose or -v
      Set to output verbose logging.

   --vverbose
      Set to output very verbose logging.

   --output=value or -ovalue [default: -]
      Output VCF file name.

   --region=value or -rvalue
      Region to print variant in.

   --help or -h
      Show this help.

VERSION
   2.7.7
```


## graphtyper_vcf_concatenate

### Tool Description
Concatenates VCF files generated by Graphtyper.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
- **Homepage**: https://github.com/DecodeGenetics/graphtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Validation**: PASS

### Original Help Text
```text
##fileformat=VCFv4.2
##fileDate=20260225
##source=Graphtyper
##graphtyperVersion=2.7.7
##graphtyperGitBranch=HEAD
##graphtyperSHA1=a42025d7b901f5d104c60bf97f75bf0f3a7865ad
##INFO=<ID=AAScore,Number=A,Type=Float,Description="Alternative allele confidence score in range [0.0,1.0]. The score is determined by a logistic regression model which was trained on GIAB truth data using other INFOs metrics as covariates.">
##INFO=<ID=ABHet,Number=1,Type=Float,Description="Allele Balance for heterozygouscalls (read count of call2/(call1+call2)) where the called genotype is call1/call2. -1 if no heterozygous calls.">
##INFO=<ID=ABHom,Number=1,Type=Float,Description="Allele Balance for homozygous calls(read count of A/(A+O)) where A is the called allele and O is anything else. -1 if no homozygous calls.">
##INFO=<ID=ABHetMulti,Number=R,Type=Float,Description="List of Allele Balance values for heterozygous calls (alt/(ref+alt)). -1 if not available.">
##INFO=<ID=ABHomMulti,Number=R,Type=Float,Description="List of Allele Balance values for homozygous calls (A/(A+0)) where A is the called allele and O is anything else. -1 if not available.">
##INFO=<ID=AC,Number=A,Type=Integer,Description="Number of alternate alleles in called genotypes.">
##INFO=<ID=AF,Number=A,Type=Float,Description="Allele frequency.">
##INFO=<ID=AN,Number=1,Type=Integer,Description="Number of alleles in called genotypes.">
##INFO=<ID=CR,Number=1,Type=Integer,Description="Number of clipped reads in the graph alignment.">
##INFO=<ID=CRal,Number=.,Type=String,Description="Number of clipped bp per allele.">
##INFO=<ID=CRalt,Number=A,Type=Float,Description="Percent of clipped reads per allele.">
##INFO=<ID=END,Number=1,Type=Integer,Description="End position of an SV.">
##INFO=<ID=FEATURE,Number=1,Type=String,Description="Gene feature.">
##INFO=<ID=GT_ANTI_HAPLOTYPE,Number=.,Type=String,Description="Haplotype string with downstream variants  with no (or very low) evidence of being in the same haplotype. Used internally by Graphtyper.">
##INFO=<ID=GT_HAPLOTYPE,Number=.,Type=String,Description="Haplotype string with downstream variants  with high evidence of being always in the same haplotype. Used internally by Graphtyper.">
##INFO=<ID=GT_ID,Number=.,Type=String,Description="ID for variant. Used internally by Graphtyper.">
##INFO=<ID=HOMSEQ,Number=.,Type=String,Description="Sequence of base pair identical homology at event breakpoints.">
##INFO=<ID=INV3,Number=0,Type=Flag,Description="Inversion breakends open 3' of reported location">
##INFO=<ID=INV5,Number=0,Type=Flag,Description="Inversion breakends open 5' of reported location">
##INFO=<ID=LEFT_SVINSSEQ,Number=.,Type=String,Description="Known left side of insertion for an insertion of unknown length.">
##INFO=<ID=LOGF,Number=1,Type=Float,Description="Output from logistic regression model.">
##INFO=<ID=MaxAAS,Number=A,Type=Integer,Description="Maximum alternative allele support per alt. allele.">
##INFO=<ID=MaxAASR,Number=A,Type=Float,Description="Maximum alternative allele support ratio per alt. allele.">
##INFO=<ID=MaxAltPP,Number=1,Type=Integer,Description="Maximum number of proper pairs support the alternative allele.">
##INFO=<ID=MMal,Number=.,Type=String,Description="Scaled mismatch count per allele.">
##INFO=<ID=MMalt,Number=A,Type=Float,Description="Mismatch percent per alternative allele.">
##INFO=<ID=MQ,Number=1,Type=Integer,Description="Root-mean-square mapping quality.">
##INFO=<ID=MQalt,Number=A,Type=Integer,Description="Mapping qualities per alternative allele.">
##INFO=<ID=MQSal,Number=.,Type=String,Description="Sum of squared mapping qualities per allele.">
##INFO=<ID=MQsquared,Number=.,Type=String,Description="Sum of squared mapping qualities. Used to calculate MQ.">
##INFO=<ID=NCLUSTERS,Number=1,Type=Integer,Description="Number of SV candidates in cluster.">
##INFO=<ID=NGT,Number=3,Type=Integer,Description="Number of REF/REF, REF/ALT and ALT/ALTgenotypes, respectively.">
##INFO=<ID=NHet,Number=A,Type=Integer,Description="Number of heterozygous genotype calls.">
##INFO=<ID=NHomRef,Number=A,Type=Integer,Description="Number of homozygous reference genotype calls.">
##INFO=<ID=NHomAlt,Number=A,Type=Integer,Description="Number of homozygous alternative genotype calls.">
##INFO=<ID=NUM_MERGED_SVS,Number=1,Type=Integer,Description="Number of SVs merged.">
##INFO=<ID=OLD_VARIANT_ID,Number=1,Type=String,Description="Variant ID from a VCF (SVs only).">
##INFO=<ID=ORSTART,Number=1,Type=Integer,Description="Start coordinate of sequence origin.">
##INFO=<ID=OREND,Number=1,Type=Integer,Description="End coordinate of sequence origin.">
##INFO=<ID=QD,Number=1,Type=Float,Description="QUAL divided by NonReferenceSeqDepth.">
##INFO=<ID=QDalt,Number=A,Type=Float,Description="Simplified QD calculated separately for each allele against all other alleles.">
##INFO=<ID=PASS_AC,Number=A,Type=Integer,Description="Number of alternate alleles in called genotyped that have FT = PASS.">
##INFO=<ID=PASS_AN,Number=1,Type=Integer,Description="Number of genotype calls that haveFT = PASS.">
##INFO=<ID=PASS_ratio,Number=1,Type=Float,Description="Ratio of genotype calls that haveFT = PASS.">
##INFO=<ID=PexcessHet,Number=A,Type=Float,Description="Pval of excess heterozygous calls.">
##INFO=<ID=RefLen,Number=1,Type=Integer,Description="Length of the reference allele.">
##INFO=<ID=RELATED_SV_ID,Number=1,Type=Integer,Description="GraphTyper ID of a related SV.">
##INFO=<ID=RIGHT_SVINSSEQ,Number=.,Type=String,Description="Known right side of insertion for an insertion of unknown length.">
##INFO=<ID=SB,Number=1,Type=Float,Description="Strand bias (F/(F+R)) where F and R are forward and reverse strands, respectively. -1 if not available.">
##INFO=<ID=SBAlt,Number=1,Type=Float,Description="Strand bias of alternative alleles only. -1 if not available.">
##INFO=<ID=SBF,Number=R,Type=Integer,Description="Number of forward stranded reads per allele.">
##INFO=<ID=SBF1,Number=R,Type=Integer,Description="Number of first forward stranded reads per allele.">
##INFO=<ID=SBF2,Number=R,Type=Integer,Description="Number of second forward stranded reads per allele.">
##INFO=<ID=SBR,Number=R,Type=Integer,Description="Number of reverse stranded reads per allele.">
##INFO=<ID=SBR1,Number=R,Type=Integer,Description="Number of first reverse stranded reads per allele.">
##INFO=<ID=SBR2,Number=R,Type=Integer,Description="Number of second reverse stranded reads per allele.">
##INFO=<ID=SDal,Number=.,Type=String,Description="Score difference of AS and XS tags per allele.">
##INFO=<ID=SDalt,Number=A,Type=Float,Description="Avergae score difference of AS and XS tags per alternative allele.">
##INFO=<ID=SEQ,Number=1,Type=String,Description="Inserted sequence at variant site.">
##INFO=<ID=SeqDepth,Number=1,Type=Integer,Description="Total accumulated sequencing depth over all the samples.">
##INFO=<ID=SV_ID,Number=1,Type=Integer,Description="GraphTyper's ID on SV.">
##INFO=<ID=SVINSSEQ,Number=.,Type=String,Description="Sequence of insertion.">
##INFO=<ID=SVLEN,Number=1,Type=Integer,Description="Length of structural variant in bp. Negative lengths indicate a deletion.">
##INFO=<ID=SVMODEL,Number=1,Type=String,Description="Model used for SV genotyping.">
##INFO=<ID=SVSIZE,Number=1,Type=Integer,Description="Size of structural variant in bp. Always 50 or more.">
##INFO=<ID=SVTYPE,Number=1,Type=String,Description="Type of structural variant.">
##INFO=<ID=VarType,Number=1,Type=String,Description="First letter is program identifier,the second letter is variant type.">
##FORMAT=<ID=GT,Number=1,Type=String,Description="GenoType call. ./. is called if there is no coverage at the variant site.">
##FORMAT=<ID=FT,Number=1,Type=String,Description="Filter. PASS or FAILN where N is a number.">
##FORMAT=<ID=AD,Number=R,Type=Integer,Description="Allelic depths for the ref and alt alleles in the order listed.">
##FORMAT=<ID=MD,Number=1,Type=Integer,Description="Read depth of multiple alleles.">
##FORMAT=<ID=DP,Number=1,Type=Integer,Description="Approximate read depth.">
##FORMAT=<ID=RA,Number=2,Type=Integer,Description="Total read depth of the reference allele and all alternative alleles, including reads that support more than one allele.">
##FORMAT=<ID=PP,Number=1,Type=Integer,Description="Number of reads that support non-reference haplotype that are proper pairs.">
##FORMAT=<ID=GQ,Number=1,Type=Integer,Description="Genotype Quality.">
##FORMAT=<ID=PL,Number=G,Type=Integer,Description="PHRED-scaled genotype likelihoods.">
##FILTER=<ID=PASS,Description="All filters passed">
##FILTER=<ID=LowAAScore,Description="Alternative alleles have a low score.">
##FILTER=<ID=LowABHet,Description="Allele balance of heterozygous carriers is below 17.5%.">
##FILTER=<ID=LowABHom,Description="Allele balance of homozygous carriers is below 90%.">
##FILTER=<ID=LowQD,Description="QD (quality by depth) is below 6.0.">
##FILTER=<ID=LowQUAL,Description="QUAL score is less than 10.">
##FILTER=<ID=LowPratio,Description="Ratio of PASSed calls was too low.">
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO
```


## graphtyper_vcf_merge

### Tool Description
GraphTyper

### Metadata
- **Docker Image**: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
- **Homepage**: https://github.com/DecodeGenetics/graphtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/graphtyper/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
   GraphTyper

USAGE
   graphtyper vcf_merge <vcfs...> [OPTIONS]

   <vcfs...>
      VCFs to merge

SUBCOMMANDS
   bamshrink       Run bamShrink.
   call            Call variants of a graph.
   check           Check a GraphTyper graph (useful for debugging).
   construct       Construct a graph.
   genotype        Run the SNP/indel genotyping pipeline.
   genotype_camou  (WIP) Run the camou SNP/indel genotyping pipeline.
   genotype_hla    (WIP) Run the HLA genotyping pipeline.
   genotype_lr     (WIP) Run the camou LR genotyping pipeline.
   genotype_sv     Run the structural variant (SV) genotyping pipeline.
   index           (deprecated) Index a graph.
   vcf_break_down  Break down/decompose a VCF file.
   vcf_concatenate Concatenate VCF files.
   vcf_merge       Merge VCF files.

OPTIONS
   --log=value or -lvalue
      Set path to log file.

   --verbose or -v
      Set to output verbose logging.

   --vverbose
      Set to output very verbose logging.

   --output=value or -ovalue
      Output VCF file name.

   --file_list=value
      File containing VCFs to merge.

   --sv
      Set if the input VCFs were generated from genotype_sv.

   --encoding=value [default: vcf]
      Select output encoding. Available are: vcf, popvcf

   --help or -h
      Show this help.

VERSION
   2.7.7
```


## Metadata
- **Skill**: generated

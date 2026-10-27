# viewbs CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| viewbs_BisNonConvRate | PASS |  |
| viewbs_GlobalMethLev | PASS |  |
| viewbs_MethCoverage | PASS |  |
| viewbs_MethGeno | PASS |  |
| viewbs_MethHeatmap | PASS |  |
| viewbs_MethLevDist | PASS |  |
| viewbs_MethOneRegion | PASS |  |
| viewbs_MethOverRegion | PASS |  |

## viewbs_MethCoverage

### Tool Description
Generate coverage report for BS-seq data

### Metadata
- **Docker Image**: quay.io/biocontainers/viewbs:0.1.11--pl5321h7b50bb2_4
- **Homepage**: https://github.com/xie186/ViewBS
- **Package**: https://anaconda.org/channels/bioconda/packages/viewbs/overview
- **Validation**: PASS

### Original Help Text
```text
[help] ViewBS MethCoverage: ok via ViewBS MethCoverage --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Subcommand: MethCoverage
NAME
    ViewBS MethCoverage - Generate coverage report for BS-seq data

SYNOPSIS
    ViewBS MethCoverage --sample <meth,sample_name> [--sample
    <meth,sample_name> .......] --prefix <prefix for output>

DESCRIPTION
    MethCoverage will generate the coverage report for BS-seq data.

Required arguments
    -help | -h
             - Prints the help message and exists.

    --verbose
    --reference [required]
             - reference genome in fasta file.

    --sample [required]
             - Provide the sample information. [Format: methlationfile,samplename] 
               It is possible to specify more than one sample pair by using the options 
               --sample more than once. The methylation information can also be read from
               a TEXT file. Instead of giving an explicit sample information pairs, 
               you need to write "file:" followed by the name of the TEXT file.
               See details at: https://github.com/readbio/ViewBS

    --outdir [optional]
             - Provide the output directory. [default: ./]

    --prefix [optional]
             - Provide prefix for the output file. [default: MethCoverage]

    --height [optional]
             - Height of PDF figure. Unit is cm. [default: 10]

    --width [optional]
             - Width of PDF figure. Unit is cm. [default: 10]
```

## viewbs_BisNonConvRate

### Tool Description
Estimate non-conversion rate of BS-seq data

### Metadata
- **Docker Image**: quay.io/biocontainers/viewbs:0.1.11--pl5321h7b50bb2_4
- **Homepage**: https://github.com/xie186/ViewBS
- **Package**: https://anaconda.org/channels/bioconda/packages/viewbs/overview
- **Validation**: PASS

### Original Help Text
```text
[help] ViewBS BisNonConvRate: ok via ViewBS BisNonConvRate --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Subcommand: BisNonConvRate
Sample list: 
NAME
    ViewBS BisNonConvRate - Estimate non-conversion rate of BS-seq data

SYNOPSIS
    ViewBS BisNonConvRate --chrom <ChrC> --sample <meth,sample_name>
    [--sample <meth,sample_name> .......] --prefix <prefix for output>
    --outdir <output folder>

DESCRIPTION
    ViewBS BisNonConvRate will estimate non-conversion rate of BS-seq data
    based on the unmethlated Chromsome, like chloroplast genome in plant or
    PhiX genome.

Required arguments
    -help | -h
             - Prints the help message and exists.

    --verbose
    --sample [required]
             - Provide the sample information. [Format: methlationfile,samplename] 
               It is possible to specify more than one sample pair by using the options 
               --sample more than once. The methylation information can also be read from
               a TEXT file. Instead of giving an explicit sample information pairs, 
               you need to write "file:" followed by the name of the TEXT file.
               See details at: https://github.com/readbio/ViewBS

    --chrom [required]
             - Chromosome ID that the users want to use to estimate non-conversion rate.

    --minDepth [optional]
             - Minimum read depth for calculating methylation level. [default: 5]

    --context [optional]
             - Sequence context for calculating non-conversion rate. It is possible to specify 
               more than one sample pair by using the option --context more than once. [default: CXX]
               CXX means non-conversion rate will be calculated based on all the 3 sequence context.

    --maxDepth [optional]
             - Maximum read depth for calculating methylation level. [default: 10000]

    --outdir [optional]
             - Provide the output directory. [default: ./]

    --prefix [optional]
             - Provide prefix for the output file. [default: GlobalMethLev]

    --height [optional]
             - Height of PDF figure. Unit is cm. [default: 10]

    --width [optional]
             - Width of PDF figure. Unit is cm. [default: 10]
```

## viewbs_GlobalMethLev

### Tool Description
Generate global (bulk) methylation level report

### Metadata
- **Docker Image**: quay.io/biocontainers/viewbs:0.1.11--pl5321h7b50bb2_4
- **Homepage**: https://github.com/xie186/ViewBS
- **Package**: https://anaconda.org/channels/bioconda/packages/viewbs/overview
- **Validation**: PASS

### Original Help Text
```text
[help] ViewBS GlobalMethLev: ok via ViewBS GlobalMethLev --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Subcommand: GlobalMethLev

NAME
    ViewBS MethGlobalLevl - Generate global (bulk) methylation level report

SYNOPSIS
    ViewBS MethGlobalLevl --sample <meth,sample_name> [--sample
    <meth,sample_name> .......] --prefix <prefix for output> --outdir
    <output folder>

DESCRIPTION
    ViewBS MethGlobalLevl will generate global (bulk) methylation level
    report

Required arguments
    -help | -h
             - Prints the help message and exists.

    --verbose
    --sample [required]
             - Provide the sample information. [Format: methlationfile,samplename]
               It is possible to specify more than one sample pair by using the options
               --sample more than once. The methylation information can also be read from
               a TEXT file. Instead of giving an explicit sample information pairs,
               you need to write "file:" followed by the name of the TEXT file.
               See details at: https://github.com/readbio/ViewBS

    --minDepth [optional]
             - Minimum read depth for calculating methylation level. [default: 1]

    --maxDepth [optional]
             - Maximum read depth for calculating methylation level. [default: 10000]

    --outdir [optional]
             - Provide the output directory. [default: ./]

    --prefix [optional]
             - Provide prefix for the output file. [default: GlobalMethLev]

    --height [optional]
             - Height of PDF figure. Unit is cm. [default: 10]

    --width [optional]
             - Width of PDF figure. Unit is cm. [default: 10]
```

## viewbs_MethGeno

### Tool Description
Generate methylation information across chromosome

### Metadata
- **Docker Image**: quay.io/biocontainers/viewbs:0.1.11--pl5321h7b50bb2_4
- **Homepage**: https://github.com/xie186/ViewBS
- **Package**: https://anaconda.org/channels/bioconda/packages/viewbs/overview
- **Validation**: PASS

### Original Help Text
```text
[help] ViewBS MethGeno: ok via ViewBS MethGeno --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Subcommand: MethGeno

NAME
    ViewBS MethGeno - Generate methylation information across chromosome.

SYNOPSIS
    ViewBS MethGeno

DESCRIPTION
    Generate methylation information across chromosome.

Required arguments
    -help | -h
             - Prints the help message and exists.

    --genomeLength [required]
             - chromosome length information. Can be generated using 'samtools faidx
               ref.fa'

    --sample [required]
             - Provide the sample information. [Format: methlationfile,samplename]
               It is possible to specify more than one sample pair by using the options
               --sample more than once. The methylation information can also be read from
               a TEXT file. Instead of giving an explicit sample information pairs,
               you need to write "file:" followed by the name of the TEXT file.
               See details at: https://github.com/readbio/ViewBS

    --win [optional]
             - Window size. Default: 500000

    --step [optional]
             - Step size. Default: 500000

    --minLength [optional]
             - Minimum length for a chromosome to output. Default: 0

    --maxChromNumber [optional]
             - Maximum number of chromosome IDs with lenght > 'minLength'.
               Default: 60.

            maxChromNumber

    --outdir
             - Output directory. [Default: ./]

    --prefix
             - Prefix for the output  [Default: MethGeno]

    --height [optional]
             - Height of PDF figure. Unit is cm. [default: 10]

    --width [optional]
             - Width of PDF figure. Unit is cm. [default: 10]
```

## viewbs_MethLevDist

### Tool Description
Generate distribution of methylation levels genome wide or for a list of regions

### Metadata
- **Docker Image**: quay.io/biocontainers/viewbs:0.1.11--pl5321h7b50bb2_4
- **Homepage**: https://github.com/xie186/ViewBS
- **Package**: https://anaconda.org/channels/bioconda/packages/viewbs/overview
- **Validation**: PASS

### Original Help Text
```text
[help] ViewBS MethLevDist: ok via ViewBS MethLevDist --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Subcommand: MethLevDist

NAME
    ViewBS MethLevDist - Generate distribution of methylation levels genome
    wide or for a list of regions, like genes, promoters, etc.

SYNOPSIS
    ViewBS MethMethLevDist --sample <meth,sample_name> [--sample
    <meth,sample_name> .......]

DESCRIPTION
    Prifile the distribution of methylation level for a given list of region
    or for whole genome-wide.

Required arguments
    -help | -h
             - Prints the help message and exists.

    --verbose
    --sample [required]
             - Provide the sample information. [Format: methlationfile,samplename]
               It is possible to specify more than one sample pair by using the options
               --sample more than once. The methylation information can also be read from
               a TEXT file. Instead of giving an explicit sample information pairs,
               you need to write "file:" followed by the name of the TEXT file.
               See details at: https://github.com/readbio/ViewBS

    --region [optional]
             - Restrict the calculation to the regions provided only.

    --minDepth [optional]
             - Minimum read depth for calculating methylation level. [default: 5]

    --maxDepth [optional]
             - Maximum read depth for calculating methylation level. [default: 10000]

    --binMethLev [optional]
             - Bin size to calculate the distribution of methylation level. [default: 0.1]

    --outdir [optional]
             - Provide the output directory. [default: ./]

    --prefix [optional]
             - Provide prefix for the output file. [default: MethLevDist]

    --height [optional]
             - Height of PDF figure. Unit is cm. [default: 10]

    --width [optional]
             - Width of PDF figure. Unit is cm. [default: 10]
```

## viewbs_MethHeatmap

### Tool Description
Generate methylation for each region and each sample to make heatmap and violin-boxplot

### Metadata
- **Docker Image**: quay.io/biocontainers/viewbs:0.1.11--pl5321h7b50bb2_4
- **Homepage**: https://github.com/xie186/ViewBS
- **Package**: https://anaconda.org/channels/bioconda/packages/viewbs/overview
- **Validation**: PASS

### Original Help Text
```text
[help] ViewBS MethHeatmap: ok via ViewBS MethHeatmap --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Subcommand: MethHeatmap

NAME
    ViewBS MethHeatmap - Generate methylation for each region and each
    sample to make heatmap and violin-boxplot.

SYNOPSIS
    ViewBS MethHeatmap --region <region> --sample <methlation
    information,sample_name> [--sample <methlation information,sample_name>]
    ...

DESCRIPTION
    Generate methylation for each region and each sample to make heatmap and
    violin-boxplot.

Required arguments
    -help | -h
             - Prints the help message and exists.

    --verbose
             - Suppress extended information or not. [Default: TRUE]

    --region [required*]
             - regions you want to investigate.

    --sample [required]
             - Provide the sample information. [Format: methlationfile,samplename]

    --merge [optional]
             - If --merge is provided (True), methylation level for different context will be genrated in one file.

    --minDepth [optional]
             - Minimum read depth for calculating methylation level. [default: 5]

    --maxDepth [optional]
             - Maximum read depth for calculating methylation level. [default: 10000]

    --cluster_rows [optional]
             - boolean values determining if rows should be clustered or hclust object.

    --cluster_cols [optional]
             - boolean values determining if columns should be clustered or hclust object.

    --outdir [optional]
             - Output folder. [Default: ./]

    --prefix [required]
             - Provide prefix for the output file. [Default: MethHeatmap]

    --height [optional]
             - Height of PDF figure (Heatmap). Unit is cm. [Default: 10]

    --width [optional]
             - Width of PDF figure (Heatmap). Unit is cm. [Default: 10]

    --height2 [optional]
             - Height of PDF figure (Violin and boxplot). Unit is cm. [Default: 10]

    --width2 [optional]
             - Width of PDF figure (Violin and boxplot). Unit is cm. [Default: 10]

    --random_region [optional]
             - The number to select the regions randomly for the give list of regions.
               When the given regions are too many, it may cause "cannot allocate 
               vector of size" when generating the heatmap. Then we randomly select 
               part of the data to generate the heatmap. [Default: 2000] 
  
               If ViewBS still "cannot allocate vector of size", please select a smaller 
               number.
```

## viewbs_MethOneRegion

### Tool Description
Extract methylation information for one region of each sample

### Metadata
- **Docker Image**: quay.io/biocontainers/viewbs:0.1.11--pl5321h7b50bb2_4
- **Homepage**: https://github.com/xie186/ViewBS
- **Package**: https://anaconda.org/channels/bioconda/packages/viewbs/overview
- **Validation**: PASS

### Original Help Text
```text
[help] ViewBS MethOneRegion: ok via ViewBS MethOneRegion --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Subcommand: MethOneRegion

NAME
    ViewBS MethOneRegion - Extract methylation information for one region of
    each sample.

SYNOPSIS
    ViewBS MethHeatmap --region <region chr1:100-200> --sample <methlation
    information,sample_name> [--sample <methlation information,sample_name>]

DESCRIPTION
    ViewBS MethOneRegion - Extract methylation information for one region of
    each sample and plot the methylation information.

Required arguments
    -help | -h
             - Prints the help message and exists.

    verbose
             - Suppress extended information or not. [Default: TRUE]

    --region [required]
             - One target region. [chr1:100-200]

    --sample [required]
             - Provide the sample information. [Format: methlationFile,samplenName] 
               It is possible to specify more than one sample pair by using the options 
               --sample more than once. The methylation information can also be read from
               a TEXT file. Instead of giving an explicit sample information pairs, 
               you need to write file: followed by the name of the TEXT file.

    --sample [optional]
             -  Sequence context (CG, CHG or CHH) to plot. It is possible to specify more than 
                one sample pair by using the options --sample more than once. [Default: CG].

    --minDepth [optional]
             - Minimum read depth for calculating methylation level. [default: 5]

    --maxDepth [optional]
             - Maximum read depth for calculating methylation level. [default: 10000]

    --flank [optional]
             - Extend the provided reigons to the flanking regions. [default: 400]

    --outdir [optional]
             - Output folder. [Default: ./]

    --prefix [optional]
             - Provide prefix for the output file. [Default: MethOneRegion]
```

## viewbs_MethOverRegion

### Tool Description
Generate methylation information over a list of regions

### Metadata
- **Docker Image**: quay.io/biocontainers/viewbs:0.1.11--pl5321h7b50bb2_4
- **Homepage**: https://github.com/xie186/ViewBS
- **Package**: https://anaconda.org/channels/bioconda/packages/viewbs/overview
- **Validation**: PASS

### Original Help Text
```text
[help] ViewBS MethOverRegion: ok via ViewBS MethOverRegion --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Subcommand: MethOverRegion

NAME
    ViewBS MethOverRegion - Generate methylation information over a list of
    regions.

SYNOPSIS
    ViewBS MethOverRegion --region <region> --sample <meth,sample_name>
    [--sample <meth,sample_name> .......]

DESCRIPTION
    MethOverRegion will calculate DNA methylation information across the
    provide regions, genes, transposable elements, etc.

Required arguments
    -help | -h
             - Prints the help message and exists.

    --verbose
    --sample [required]
             - Provide the sample information. [Format: methlationfile,samplename] 
               It is possible to specify more than one sample pair by using the options 
               --sample more than once. The methylation information can also be read from
               a TEXT file. Instead of giving an explicit sample information pairs, 
               you need to write "file:" followed by the name of the TEXT file.
               See details at: https://github.com/readbio/ViewBS

    --region [required if "file:" not specified]
             - regions you want to investigate.

    --context [optional]
             -  Sequence context (CG, CHG or CHH) to plot. It is possible to specify more than
                one sample pair by using the options --sample more than once. [Default: CG].

    --binNumber [optional]
             - The number of bins for the given regions [default: 60].

    --flank [optional]
             - Flanking regions [default: 2000].

    --binLength [optional]
             - The length of bins for the flanking regions for the given regions [default: 100].

    --minDepth [optional]
             - Minimum read depth for calculating methylation level. [default: 5]

    --maxDepth [optional]
             - Maximum read depth for calculating methylation level. [default: 400]

    --outdir [optional]
             - Output directory. [./]

    --prefix [optional]
             - Provide prefix for the output file. [Default: MethOverRegion]

    --regionName [Optional]
             - The type of regions provided, like Gene, TE, DMR, etc. [Default: Gene]

    --height [optional]
             - Height of PDF figure. Unit is cm. [default: 10]

    --width [optional]
             - Width of PDF figure. Unit is cm. [default: 10]
```


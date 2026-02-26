# fegenie CWL Generation Report

## fegenie_FeGenie.py

### Tool Description
FeGenie: a pipeline for identifying iron-related genes in genomic and metagenomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/fegenie:1.2--py313r40hdfd78af_5
- **Homepage**: https://github.com/Arkadiy-Garber/FeGenie
- **Package**: https://anaconda.org/channels/bioconda/packages/fegenie/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fegenie/overview
- **Total Downloads**: 10.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Arkadiy-Garber/FeGenie
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/FeGenie.py:367: SyntaxWarning: invalid escape sequence '\.'
  description=textwrap.dedent('''
/usr/local/bin/FeGenie.py:442: SyntaxWarning: invalid escape sequence '\ '
  "For the third BAM file in the provided tab-delimited file, \'-which_bams 3\ should be specified'", default="average")
/usr/local/bin/FeGenie.py:638: SyntaxWarning: invalid escape sequence '\|'
  print("Looks like one of your fasta files has a header containing the character: \|")
/usr/local/bin/FeGenie.py:652: SyntaxWarning: invalid escape sequence '\|'
  "Looks like one of your fasta files has a header containing the character: \|")
/usr/local/bin/FeGenie.py:663: SyntaxWarning: invalid escape sequence '\|'
  print("Looks like one of your fasta files has a header containing the character: \|")
usage: FeGenie.py [-h] [-bin_dir BIN_DIR] [-bin_ext BIN_EXT] [-d D] [-ref REF]
                  [-out OUT] [-inflation INFLATION] [-t T] [-bams BAMS]
                  [-which_bams WHICH_BAMS] [-bam BAM]
                  [-contig_names CONTIG_NAMES] [-cat CAT] [--gbk [GBK]]
                  [--orfs [ORFS]] [--skip [SKIP]] [--meta [META]]
                  [--norm [NORM]] [--all_results [ALL_RESULTS]]
                  [--heme [HEME]] [--hematite [HEMATITE]]
                  [--makeplots [MAKEPLOTS]] [--nohup [NOHUP]]

*******************************************************

Developed by Arkadiy Garber and Nancy Merino;
University of Southern California, Earth Sciences
Please send comments and inquiries to arkadiyg@usc.edu

    )`-.--.  )\.---.     )\.-.    )\.---.   )\  )\  .'(   )\.---.  
    ) ,-._( (   ,-._(  ,' ,-,_)  (   ,-._( (  \, /  \  ) (   ,-._( 
    \ `-._   \  '-,   (  .   __   \  '-,    ) \ (   ) (   \  '-,   
     ) ,_(    ) ,-`    ) '._\ _)   ) ,-`   ( ( \ \  \  )   ) ,-`   
    (  \     (  ``-.  (  ,   (    (  ``-.   `.)/  )  ) \  (  ``-.  
     ).'      )..-.(   )/'._.'     )..-.(      '.(    )/   )..-.(                                                                                    
                          %(?/////////&//%                                                
      .,,.                   (%((&@@@#/*.                      .,,.        
      .,,.                     @(((/&@@@#///**                  ...        
                                 #&((///////////////*/@                                
                                                     #*@.                             
                              ()                   * )//*
                              <^^>             *     (/*   .
                             .-""-.                  *)
                  .---.    ."-....-"-._     _...---''`/. '
                 ( (`\ \ .'            ``-''    _.-"'`
                  \ \ \ : :.                 .-'
                   `\`.\: `:.             _.'
                   (  .'`.`            _.'
                    ``    `-..______.-'
                              ):.  (
                            ."-....-".
                          .':.        `.
                          "-..______..-"

Image design: Nancy Merino (2018);
ASCII art: https://manytools.org/hacker-tools/convert-images-to-ascii-art/
https://ascii.co.uk/text
*******************************************************

options:
  -h, --help            show this help message and exit
  -bin_dir BIN_DIR      directory of bins
  -bin_ext BIN_EXT      extension for bins (do not include the period)
  -d D                  maximum distance between genes to be considered in a
                        genomic 'cluster'.This number should be an integer and
                        should reflect the maximum number of genes in between
                        putative iron-related genes identified by the HMM
                        database (default=5)
  -ref REF              path to a reference protein database, which must be in
                        FASTA format
  -out OUT              name output directory (default=fegenie_out)
  -inflation INFLATION  inflation factor for final gene category counts
                        (default=1000)
  -t T                  number of threads to use for DIAMOND BLAST and
                        HMMSEARCH (default=1, max=16)
  -bams BAMS            a tab-delimited file with two columns: first column
                        has the genome or metagenome file names; second column
                        has the corresponding BAM file (provide full path to
                        the BAM file). Use this option if you have genomes
                        that each have different BAM files associated with
                        them. If you have a set of bins from a single
                        metagenome sample and, thus, have only one BAM file,
                        then use the '-bam' option. BAM files are only
                        required if you would like to create a heatmap that
                        summarizes the abundance of a certain gene that is
                        based on read coverage, rather than gene counts.
  -which_bams WHICH_BAMS
                        if you provided a tab-delimited file specifying
                        multiple BAM files for your metagenome assemblies or
                        bins/genomes, FeGenie will, by default, make the
                        heatmap CSV and dotplot based on the average depth
                        across all of BAM files. However, with this argument,
                        you can specify which bam in that file that you want
                        FeGenie to use for the generation of a
                        heatmap/dotplot. For example, if only coverage from
                        the first BAM file is desired, then you can specify
                        '-which_bams 1'. For the third BAM file in the
                        provided tab-delimited file, '-which_bams 3\ should be
                        specified'
  -bam BAM              BAM file. This option is only required if you would
                        like to create a heatmap that summarizes the abundance
                        of a certain gene that is based on read coverage,
                        rather than gene counts. If you have more than one BAM
                        filecorresponding to different genomes that you are
                        providing, please use the '-bams' argument to provide
                        a tab-delimited file that denotes which BAM file (or
                        files) belongs with which genome
  -contig_names CONTIG_NAMES
                        contig names in your provided FASTA files. Use this
                        optionif you are providing gene calls in amino acid
                        format (don't forgetto add the '--orfs' flag)
  -cat CAT              comma-separated list of iron gene categories you'd
                        like FeGenie to look for (default = all categories)
  --gbk [GBK]           include this flag if your bins are in Genbank format
  --orfs [ORFS]         include this flag if you are providing bins as open-
                        reading frames or genes in FASTA amino-acid format
  --skip [SKIP]         skip the main part of the algorithm (ORF prediction
                        and HMM searching) and re-summarize previously
                        produced results (for example, if you want to re-run
                        using the --norm flag, or providing a BAM file). All
                        other flags/arguments need to be provided (e.g.
                        -bin_dir, -bin_ext, -out, etc.)
  --meta [META]         include this flag if the provided contigs are from
                        metagenomic/metatranscriptomic assemblies
  --norm [NORM]         include this flag if you would like the gene counts
                        for each iron gene category to be normalized to the
                        number of predicted ORFs in each genome or metagenome.
                        Without normalization, FeGenie will create a heatmap-
                        compatible CSV output with raw gene counts. With
                        normalization, FeGenie will create a heatmap-
                        compatible with 'normalized gene abundances'
  --all_results [ALL_RESULTS]
                        report all results, regardless of clustering patterns
                        and operon structure
  --heme [HEME]         find all genes with heme-binding motifs (CXXCH), and
                        output them to a separate summary file
  --hematite [HEMATITE]
                        find all genes with hematite-binding motifs, and
                        output them to a separate summary file
  --makeplots [MAKEPLOTS]
                        include this flag if you would like FeGenie to make
                        some figures from your data?. To take advantage of
                        this part of the pipeline, you will need to have
                        Rscipt installed. It is a way for R to be called
                        directly from the command line. Please be sure to
                        install all the required R packages as instrcuted in
                        the FeGenie Wiki: https://github.com/Arkadiy-
                        Garber/FeGenie/wiki/Installation. If you see error or
                        warning messages associated with Rscript, you can
                        still expect to see the main output (CSV files) from
                        FeGenie.
  --nohup [NOHUP]       include this flag if you are running FeGenie under
                        'nohup', and would like to re-write a currently
                        existing directory.
```


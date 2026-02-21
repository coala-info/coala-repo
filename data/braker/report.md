# braker CWL Generation Report

## braker

### Tool Description
The provided text does not contain help information as the executable was not found in the environment.

### Metadata
- **Docker Image**: quay.io/biocontainers/braker:1.9--1
- **Homepage**: https://github.com/Gaius-Augustus/BRAKER
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/braker/overview
- **Total Downloads**: 10.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Gaius-Augustus/BRAKER
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/10 07:32:10  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "braker": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## braker_braker.pl

### Tool Description
Pipeline for predicting genes with GeneMark-ET and AUGUSTUS with RNA-Seq

### Metadata
- **Docker Image**: quay.io/biocontainers/braker:1.9--1
- **Homepage**: https://github.com/Gaius-Augustus/BRAKER
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
braker.pl     Pipeline for predicting genes with GeneMark-ET and AUGUSTUS with RNA-Seq

SYNOPSIS

braker.pl [OPTIONS] --genome=genome.fa --bam=rnaseq.bam


  --genome=genome.fa          fasta file with DNA sequences
  --bam=rnaseq.bam            bam file with spliced alignments from RNA-Seq


    
    
OPTIONS

    --help                               Print this help message
    --alternatives-from-evidence=true    Output alternative transcripts based on explicit evidence from 
                                         hints (default is true).
    --AUGUSTUS_CONFIG_PATH=/path/        Set path to AUGUSTUS (if not specified as environment variable).
      to/augustus/                       Has higher priority than environment variable.
    --BAMTOOLS_PATH=/path/to/            Set path to bamtools (if not specified as environment 
      bamtools/                          variable). Has higher priority than the environment variable.
    --cores                              Specifies the maximum number of cores that can be used during 
                                         computation
    --extrinsicCfgFile                   Optional. This file contains the list of used sources for the 
                                         hints and their boni and mali. If not specified the file "extrinsic.cfg" 
                                         in the config directory $AUGUSTUS_CONFIG_PATH is copied and adjusted.
    --fungus                             GeneMark-ET option: run algorithm with branch point model (most 
                                         useful for fungal genomes)
    --GENEMARK_PATH=/path/to/            Set path to GeneMark-ET (if not specified as environment 
      gmes_petap.pl/                     variable). Has higher priority than environment variable.
    --gff3                               Output in GFF3 format.
    --hints=hints.gff                    Alternatively to calling braker.pl with a bam file, it is 
                                         possible to call it with a file that contains introns extracted 
                                         from RNA-Seq data in gff format. This flag also allows the usage
                                         of hints from additional extrinsic sources for gene prediction 
                                         with AUGUSTUS. To consider such additional extrinsic information,
                                         you need to use the flag --optCfgFile to specify parameters for 
                                         all sources in the hints file
                                         (including the source "E" for intron hints from RNA-Seq).
    --optCfgFile=ppx.cfg                 Optional custom config file for AUGUSTUS (see --hints).
    --overwrite                          Overwrite existing files (except for species parameter files)
    --SAMTOOLS_PATH=/path/to/            Optionally set path to samtools (if not specified as environment 
      samtools/                          variable) to fix BAM files automatically, if necessary. Has higher     
                                         priority than environment variable.
    --skipGeneMark-ET                    Skip GeneMark-ET and use provided GeneMark-ET output (e.g. from a
                                         different source) 
    --skipOptimize                       Skip optimize parameter step (not recommended).
    --softmasking                        Softmasking option for soft masked genome files. Set to 'on' or '1'
    --species=sname                      Species name. Existing species will not be overwritten. 
                                         Uses Sp_1 etc., if no species is assigned                          
    --useexisting                        Use the present config and parameter files if they exist for 
                                         'species'
    --UTR                                Predict untranslated regions. Default is off.
    --workingdir=/path/to/wd/            Set path to working directory. In the working directory results
                                         and temporary files are stored
    --filterOutShort			 It may happen that a "good" training gene, i.e. one that has intron
					 support from RNA-Seq in all introns predicted by GeneMark, is in fact
					 too short. This flag will discard such genes that have supported introns
					 and a neighboring RNA-Seq supported intron upstream of the start codon within 
					 the range of the maximum CDS size of that gene and with a multiplicity that
					 is at least as high as 20% of the average intron multiplicity of that gene.
    --version                            print version number of braker.pl
                           

DESCRIPTION
      
  Example:

    braker.pl [OPTIONS] --genome=genome.fa  --species=speciesname --bam=accepted_hits.bam
```


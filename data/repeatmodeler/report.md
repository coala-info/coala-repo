# repeatmodeler CWL Generation Report

## repeatmodeler_BuildDatabase

### Tool Description
Format FASTA files for use with RepeatModeler

### Metadata
- **Docker Image**: quay.io/biocontainers/repeatmodeler:2.0.7--pl5321hdfd78af_0
- **Homepage**: https://www.repeatmasker.org/RepeatModeler
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatmodeler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/repeatmodeler/overview
- **Total Downloads**: 54.0K
- **Last updated**: 2025-07-03
- **GitHub**: https://github.com/Dfam-consortium/RepeatModeler
- **Stars**: N/A
### Original Help Text
```text
No query sequence file indicated

/usr/local/bin/BuildDatabase - 2.0.7
NAME
    BuildDatabase - Format FASTA files for use with RepeatModeler

SYNOPSIS
      BuildDatabase [-options] -name "mydb" <seqfile(s) in fasta format>
     or 
      BuildDatabase [-options] -name "mydb" 
                                  -dir <dir containing fasta files *.fa, *.fasta,
                                         *.fast, *.FA, *.FASTA, *.FAST, *.dna,
                                         and  *.DNA > 
     or
      BuildDatabase [-options] -name "mydb" 
                                  -batch <file containing a list of fasta files>

DESCRIPTION
      This is basically a wrapper around AB-Blast's and NCBI Blast's
      DB formating programs.  It assists in aggregating files for processing 
      into a single database.  Source files can be specified by:

          - Placing the names of the FASTA files on the command
            line.
          - Providing the name of a directory containing FASTA files 
            with the file suffixes *.fa or *.fasta.
          - Providing the name of a manifest file which contains the 
            names of FASTA files ( fully qualified ) one per line.

      NOTE: Sequence identifiers are not preserved in this database. Each
            sequence is assigned a new GI ( starting from 1 ).  The 
            translation back to the original sequence is preserved in the
            *.translation file.

    The options are:

    -h(elp)
        Detailed help

    -name <database name>
        The name of the database to create.

    -dir <directory>
        The name of a directory containing fasta files to be processed. The
        files are recognized by their suffix. Only *.fa and *.fasta files
        are processed.

    -batch <file>
        The name of a file which contains the names of fasta files to
        process. The files names are listed one per line and should be fully
        qualified.

SEE ALSO
        RepeatModeler, RMBlast

COPYRIGHT
    Copyright 2004-2019 Institute for Systems Biology

AUTHOR
    Robert Hubley <rhubley@systemsbiology.org>
```


## repeatmodeler_RepeatModeler

### Tool Description
Model repetitive DNA

### Metadata
- **Docker Image**: quay.io/biocontainers/repeatmodeler:2.0.7--pl5321hdfd78af_0
- **Homepage**: https://www.repeatmasker.org/RepeatModeler
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatmodeler/overview
- **Validation**: PASS

### Original Help Text
```text
No database indicated

/usr/local/bin/RepeatModeler - 2.0.7
NAME
    RepeatModeler - Model repetitive DNA

SYNOPSIS
      RepeatModeler [-options] -database <XDF Database>

DESCRIPTION
    The options are:

    -h(elp)
        Detailed help

    -database
        The name of the sequence database to run an analysis on. This is the
        name that was provided to the BuildDatabase script using the "-name"
        option.

    -threads #
        Specify the maximum number of threads which can be used by the
        program at any one time. Note that the '-pa' parameter in previous
        releases controlled the number of sequence batches compared in
        parallel using rmblastn (each running 4 threads). Therefore, if '-pa
        4' was used previously the new thread parameter should be set to
        '-threads 16'.

    -recoverDir <Previous Output Directory>
        If a run fails in the middle of processing, it may be possible
        recover some results and continue where the previous run left off.
        Simply supply the output directory where the results of the failed
        run were saved and the program will attempt to recover and continue
        the run.

    -srand #
        Optionally set the seed of the random number generator to a known
        value before the batches are randomly selected ( using Fisher Yates
        Shuffling ). This is only useful if you need to reproduce the sample
        choice between runs. This should be an integer number.

    -LTRStruct
        Run the LTR structural discovery pipeline ( LTR_Harvest and
        LTR_retreiver ) and combine results with the RepeatScout/RECON
        pipeline. [optional]

    -genomeSampleSizeMax #
        Optionally change the maximum sample size (bp). The sample sizes for
        RECON are increased until this number is reached (default: 270MB in
        5 rounds, or 243MB in 6 rounds for '-quick' option).

    -numAddlRounds #
        Optionally increase the number of rounds. The sample size for
        additional rounds will change by size multiplier (currently 3).

    -quick
        In RepeatModeler 2.0.4 due to improvements in masking and
        parallelization the sample sizes have increased improving
        sensitivity. Using the quick option reverts back to the original
        sample sizes (pre 2.0.4) allowing for similar sensitivity as before,
        at a faster rate.

CONFIGURATION OVERRIDES
    -repeatmasker_dir <string>
        The path to the installation of RepeatMasker (RM 4.1.5 or higher)

    -ninja_dir <string>
        The path to the installation of the Ninja phylogenetic analysis
        package.

    -repeatafterme_dir <string>
        The path to the installation of the RepeatAfterMe ( 0.0.6 or higher
        ) extension program.

    -recon_dir <string>
        The path to the installation of the RECON de-novo repeatfinding
        program.

    -ltr_retriever_dir <string>
        The path to the installation of the LTR_Retriever v2.9.0 structural
        LTR analysis package.

    -trf_dir <string>
        The full path to TRF program. TRF must be named "trf". ( 4.0.9 or
        higher )

    -rmblast_dir <string>
        The path to the installation of the RMBLAST (2.14.1 or higher)

    -cdhit_dir <string>
        The path to the installation of the CD-Hit sequence clustering
        package.

    -rscout_dir <string>
        The path to the installation of the RepeatScout ( 1.0.7 or higher )
        de-novo repeatfinding program.

    -ucsctools_dir <string>
        The path to the installation directory of the UCSC TwoBit Tools
        (twoBitToFa, faToTwoBit, twoBitInfo etc).

    -genometools_dir <string>
        The path to the installation of the GenomeTools package.

    -mafft_dir <string>
        The path to the installation of the MAFFT multiple alignment
        program.

SEE ALSO
        RepeatMasker, RMBlast

COPYRIGHT
     Copyright 2005-2025 Institute for Systems Biology

AUTHOR
     RepeatModeler:
       Robert Hubley <rhubley@systemsbiology.org>
       Arian Smit <asmit@systemsbiology.org>

     LTR Pipeline Extensions:
       Jullien Michelle Flynn <jmf422@cornell.edu>
```


## Metadata
- **Skill**: generated

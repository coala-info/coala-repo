# mirnature CWL Generation Report

## mirnature_miRNAture

### Tool Description
Seems that you did pass an empty flag, please refer to documentation.

### Metadata
- **Docker Image**: quay.io/biocontainers/mirnature:1.1--pl5321hdfd78af_2
- **Homepage**: https://github.com/Bierinformatik/miRNAture
- **Package**: https://anaconda.org/channels/bioconda/packages/mirnature/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mirnature/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Bierinformatik/miRNAture
- **Stars**: N/A
### Original Help Text
```text
Seems that you did pass an empty flag, please refer to documentation.
Usage:
    ./miRNAture [-options]

Options:
    -h/-help    Print this documentation.

    -man        Prints an extended help page and exits.

    -blstq/-blastQueriesFolder <PATH>
                Path of blast query sequences in FASTA format to be searched
                on the subject sequence.

    -dataF/-datadir <PATH>
                Path to pre-calculated data directory containing RFAM and
                miRBase covariance, hidden markov models, and necessary
                files to run MIRfix.

    -debug_mode/dbug <0|1>
                Activate the Perl DEBUGGER to run miRNAture.

    -mfx/-mirfix_path <PATH>
                Alternative path of the MIRfix.py program.

    -m/-mode <blast,hmm,rfam,mirbase,user,final>
                Homology search modes: blast, hmm, rfam, mirbase, infernal,
                user and/or final. It is possible to perform individual
                analysis, but it is always recommended to include the final
                option to merge multiple results.

    -ps/-parallel_slurm <0|1>
                Activate SLURM resource manager to submit parallel jobs (1)
                or not (0).

    -pe/-parallel <0|1>
                Activate parallel jobs processing (1) or not (0).

    -rep/-repetition_cutoff <relax,Number_Loci,Candidates_to_evaluate>
                Setup number of maximum loci number that will be evaluated
                by the mature's annotation stage. By default, miRNAture will
                detect miRNA families that report high number of loci (> 200
                loci). Then, it will select the top 100 candidates in terms
                of alignment scores, as candidates for the validation stage
                (default,200,100). The designed values could be modified by
                the following flag:
                'relax,Number_Loci,Candidates_to_evaluate'. This option
                allows to the user to select the threshold values to detect
                repetitive families. The first parameter is <relax>, which
                tells miRNAture to change the default configuration. The
                next one, <Number_Loci> is the threshold of loci number to
                classify a family as repetitive. The last one,
                <Candidates_to_evaluate>, is the number of candidates prone
                to be evaluated in the next evaluation section. The rest
                candidates are included as homology 'potential' candidates.

    -str/-strategy <1,2,3,4,5,6,7,8,9,10>
                This flag is blast mode specific. It corresponds to blast
                strategies that would be used to search miRNAs. It must be
                indicated along with -m Blast flag.

    -stg/-stage
    <'homology','no_homology','validation','evaluation','summarise','complet
    e'>
                Selects the stage to be run on miRNAture. The options are:
                'homology', 'no_homology', 'validation', 'evaluation',
                'summarise' or 'complete'.

    -speG/-species_genome <PATH>
                Path of target sequences to be analyzed in FASTA format.

    -speN/-species_name <Genera_species>
                Species or sequence source's scientific name. The format
                must be: Genera_species, separated by '_'.

    -speT/-species_tag <TAG_NAME>
                Experiment tag. Will help to identify the generated files
                along miRNA output files.

    -sublist/-subset_models <FILE_WITH_CM_NAMES>
                Target list of CMs to be searched on subject
                genome/sequences. If not indicated, miRNAture will run all
                RFAM v14.4 metazoan miRNA models.

    -usrM/-user_models <PATH>
                Directory with additional hidden Markov (HMMs) or covariance
                models (CMs) provided by the user. This must be contain a
                corresponding HMMs/ and CMs/ folders, which the user models
                will be identified.

    -w/-workdir <OUT_PATH>
                Working directory path to write all miRNAture results.
```


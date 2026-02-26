# ericscript CWL Generation Report

## ericscript_ericscript.pl

### Tool Description
EricScript.pl automatically runs a pipeline to detect chimeric transcripts in paired-end RNA-seq samples. It is also able to generate datasets with synthetic gene fusions.

### Metadata
- **Docker Image**: quay.io/biocontainers/ericscript:0.5.5--pl5.22.0r3.3.2_1
- **Homepage**: https://github.com/databio/ericscript
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ericscript/overview
- **Total Downloads**: 15.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/databio/ericscript
- **Stars**: N/A
### Original Help Text
```text
Usage:
     ericscript.pl [arguments] <reads_1.fq(.gz)> <reads_2.fq(.gz)>
 
            Optional arguments:
            -h, --help                      print help message
            -m, --man                       print complete documentation
            -v, --verbose                   use verbose output
            -name, --samplename <string>    what's the name of your sample?
            -o, --outputfolder <string>     where the results will be stored
            -db, --dbfolder <string>        where database is stored. Default is ERICSCRIPT_FOLDER/lib/
            -minr, --minreads <int>         minimum reads to consider discordant alignments [3]
            -p, --nthreads <int>            number of threads for the bwa aln process [4]
            -ntrim <int>                    trim PE reads from 1st base to $ntrim. Default is no trimming. Set ntrim=0 to don't trim reads.
            --MAPQ <int>                    minimum value of mapping quality to consider discordant reads. For MAPQ 0 use a negative value [20]
            --remove                        remove all temporary files.
            --demo                          Run a demonstration of EricScript on simulated reads.
            --refid                         Genome reference identification. Run ericscript.pl --printdb to see available refid [homo_sapiens].
            --bwa_aln                       Use BWA ALN instead of BWA MEM to search for discordant reads.

            Subcommands:
            --checkdb                       Check if your database is up-to-date, based on the latest Ensembl release.
            --downdb                        Download, build database. refid parameter need to be specified.
            --simulator                     Generate synthetic gene fusions with the same recipe of the ericscript's paper
            --calcstats                     Calculate the statistics that we used in our paper to evaluate the performance of the algorithms.
        
            --------
            arguments for databases subcommands (downdb, checkdb):

                    -db, --dbfolder <string>        where database is stored. Default is ERICSCRIPT_FOLDER/lib/
                    --refid                         Genome reference identification. Run ericscript.pl --printdb to see available refid [homo_sapiens].
                    --printdb                       Print a list of available genomes and exit.
                    --ensversion            Download data of a specific Ensembl version (>= 70). Default is the latest one.
 
            -------
            arguments for simulator:
                    -o, --outputfolder <string>     where synthetic datasets will be stored [HOME/ericscript_simulator]
                    -rl, --readlength <int>         length of synthetic reads [75]
                    --refid                         Genome reference identification. Run ericscript.pl --printdb to see available refid [homo_sapiens].
                    -v, --verbose                   use verbose output
                    --insize                        parameter of wgsym. Outer distance between the two ends [200]
                    --sd_insize                     parameter of wgsym. Standard deviation [50]
                    --ngenefusion                   The number of synthetic gene fusions per dataset? [50]
                    --min_cov                       Minimum coverage to simulate [1]
                    --max_cov                       Maximum coverage to simulate [50]
                    --nsims                         The number of synthetic datasets to simulate [10]
                    --be                            Use --be to generate Broken Exons (BE) data [no]
                    --ie                            Use --ie to generate Intact Exons (IE) data [yes]
                    -db, --dbfolder                 where database is stored. Default is ERICSCRIPT_FOLDER/lib/ 
                    --background_1                  Fastq file (forward)  for generating background reads. 
                    --background_2                  Fastq file (reverse) for generating background reads. 
                    --nreads_background             The number of reads to extract from background data [200e3].

            -------
            arguments for calcstats:
                    -o, --outputfolder <string>     where statistics file will be stored [HOME/ericscript_calcstats]
                    --resultsfolder <string>        path to folder containing algorithm results.
                    --datafolder <string>           path to folder containing synthetic data generated by ericscript simulator.
                    --algoname <string>             name of the algorithm that generated results. 
                    --dataset <string>              type of synthetic data to considered for calculating statistics. IE or BE? 
                    -rl, --readlength <int>         length of synthetic reads 
                    --normroc <int>                 factor to normalize the score given by the algorithm.
                        
     ericscript.pl automatically runs a pipeline to detect chimeric transcripts in
     paired-end RNA-seq samples. It is also able to generate datasets with synthetic gene fusions.
     More information about running EricScript Simulator and EricScript CalcStats can be 
     found at http://ericscript.sourceforge.net
 
     Version: 0.5.5b

Options:
    --help
             print a brief usage message and detailed explanation of options.

    --man
             print the complete manual of the program.

    --verbose
             use verbose output.

    --samplename
             Choose a name for your sample. Default is "MyEric"

    --outputfolder
             Folder that will contain all the results of the analysis. Default is YOUR_HOME/SAMPLENAME

    --dbfolder
             Folder that contains transcriptome sequences and information of the downloaded species. Default is
             ERICSCRIPT_FOLDER/lib

    --minreads
             Minimum reads to consider discordant alignments. Default is 3 reads with minimum MAPQ.

    -ntrim
             trim PE reads from 1st base to $ntrim. Trimmed reads will be used only for the first alignment (identification 
             of discordant reads). Setting ntrim to values lower than orginal read length allows EricScript to 
             increase its sensitivity, especially when the length of reads is 75nt or 100 nt. 
             Default is no trimming. Set ntrim=0 to don't trim reads.

    --nthreads
             Number of threads for the bwa aln process.

    --MAPQ
             minimum value of mapping quality to consider discordant reads. For MAPQ 0 use a negative value. Default is 20.

    --remove
             remove all temporary files. By default, all temporary files will be kept for 
             user inspection, but this will easily clutter the directory.

    --checkdb
             Check if your database is up-to-date, based on the latest Ensembl release.

    --downdb
             Download, build database. refid parameter need to be specified.

    --refid
             Genome reference identification. Run ericscript.pl --printdb to see available refid.[homo_sapiens]

    --ensversion
             Download data of a specific version of Ensembl. Default is downloading the latest version of Ensembl.
             Minimum supported version is 70.

    --printdb
             Print a list of available genomes and exit.

    --demo
             Run a demonstration of EricScript on simulated reads.
```


# resfinder CWL Generation Report

## resfinder_run_resfinder.py

### Tool Description
Run resfinder for acquired resistance genes

### Metadata
- **Docker Image**: quay.io/biocontainers/resfinder:4.7.2--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/resfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/resfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/resfinder/overview
- **Total Downloads**: 10.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: run_resfinder.py [-h] [-ifa INPUTFASTA]
                        [-ifq INPUTFASTQ [INPUTFASTQ ...]] [--nanopore]
                        -o OUTPUTPATH [-j OUT_JSON] [-b BLASTPATH]
                        [-k KMAPATH] [--kma_threads KMA_THREADS] [-s SPECIES]
                        [--ignore_missing_species] [--output_aln]
                        [-db_res DB_PATH_RES] [-db_res_kma DB_PATH_RES_KMA]
                        [-acq] [-ao ACQ_OVERLAP] [-l MIN_COV] [-t THRESHOLD]
                        [-d] [-db_disinf DB_PATH_DISINF]
                        [-db_disinf_kma DB_PATH_DISINF_KMA] [-c]
                        [-db_point DB_PATH_POINT]
                        [-db_point_kma DB_PATH_POINT_KMA]
                        [-g SPECIFIC_GENE [SPECIFIC_GENE ...]] [-u]
                        [-l_p MIN_COV_POINT] [-t_p THRESHOLD_POINT]
                        [--ignore_indels] [--ignore_stop_codons] [-v]
                        [--pickle]

options:
  -h, --help            show this help message and exit
  -ifa, --inputfasta INPUTFASTA
                        Input fasta file.
  -ifq, --inputfastq INPUTFASTQ [INPUTFASTQ ...]
                        Input fastq file(s). Assumed to be single-end fastq if
                        only one file is provided, and assumed to be paired-
                        end data if two files are provided.
  --nanopore            If nanopore data is used
  -o, --outputPath OUTPUTPATH
                        Output directory. If it doesn't exist, it will be
                        created.
  -j, --out_json OUT_JSON
                        Specify JSON filename and output directory. If the
                        directory doesn't exist, it will be created.
  -b, --blastPath BLASTPATH
                        Path to blastn
  -k, --kmaPath KMAPATH
                        Path to KMA
  --kma_threads KMA_THREADS
                        Number of threads to use with KMA
  -s, --species SPECIES
                        Species in the sample
  --ignore_missing_species
                        If set, species is provided and --point flag is set,
                        will not throw an error if no database is found for
                        the provided species. If species is not found. Point
                        mutations will silently be ignored.
  --output_aln          will add the alignments in the json output.
  -db_res, --db_path_res DB_PATH_RES
                        Path to the databases for ResFinder.
  -db_res_kma, --db_path_res_kma DB_PATH_RES_KMA
                        Path to the ResFinder databases indexed with KMA.
                        Defaults to the value of the --db_res flag.
  -acq, --acquired      Run resfinder for acquired resistance genes
  -ao, --acq_overlap ACQ_OVERLAP
                        Genes are allowed to overlap this number of
                        nucleotides. Default: 30.
  -l, --min_cov MIN_COV
                        Minimum (breadth-of) coverage of ResFinder within the
                        range 0-1.
  -t, --threshold THRESHOLD
                        Threshold for identity of ResFinder within the range
                        0-1.
  -d, --disinfectant    Run resfinder for disinfectant resistance genes
  -db_disinf, --db_path_disinf DB_PATH_DISINF
                        Path to the databases for DisinFinder.
  -db_disinf_kma, --db_path_disinf_kma DB_PATH_DISINF_KMA
                        Path to the DisinFinder databases indexed with KMA.
                        Defaults to the value of the --db_res flag.
  -c, --point           Run pointfinder for chromosomal mutations
  -db_point, --db_path_point DB_PATH_POINT
                        Path to the databases for PointFinder
  -db_point_kma, --db_path_point_kma DB_PATH_POINT_KMA
                        Path to the PointFinder databases indexed with KMA.
                        Defaults to the value of the --db_path_point flag.
  -g, --specific_gene SPECIFIC_GENE [SPECIFIC_GENE ...]
                        Specify genes existing in the database to search for -
                        if none is specified all genes are included in the
                        search.
  -u, --unknown_mut     Show all mutations found even if in unknown to the
                        resistance database
  -l_p, --min_cov_point MIN_COV_POINT
                        Minimum (breadth-of) coverage of Pointfinder within
                        the range 0-1. If None is selected, the minimum
                        coverage of ResFinder will be used.
  -t_p, --threshold_point THRESHOLD_POINT
                        Threshold for identity of Pointfinder within the range
                        0-1. If None is selected, the minimum coverage of
                        ResFinder will be used.
  --ignore_indels       Ignore frameshift-causing indels in Pointfinder.
  --ignore_stop_codons  Ignore premature stop codons in Pointfinder.
  -v, --version         Show program's version number and exit
  --pickle              Create a pickle dump of the Isolate object. Currently
                        needed in the CGE webserver. Dependency and this
                        option is being removed.
```


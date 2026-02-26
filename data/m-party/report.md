# m-party CWL Generation Report

## m-party

### Tool Description
PlastEDMA's main script

### Metadata
- **Docker Image**: quay.io/biocontainers/m-party:0.2.2--hdfd78af_0
- **Homepage**: https://github.com/ozefreitas/M-PARTY
- **Package**: https://anaconda.org/channels/bioconda/packages/m-party/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/m-party/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ozefreitas/M-PARTY
- **Stars**: N/A
### Original Help Text
```text
['/usr/local/share', '/usr/local/bin', '/usr/local/lib/python37.zip', '/usr/local/lib/python3.7', '/usr/local/lib/python3.7/lib-dynload', '/usr/local/lib/python3.7/site-packages', '/usr/local/bin/workflow/scripts']
usage: m-party [-h] [-i INPUT] [--input_seqs_db_const INPUT_SEQS_DB_CONST]
               [-db DATABASE] [--hmm_db_name HMM_DB_NAME] [-it INPUT_TYPE]
               [-o OUTPUT] [--output_type OUTPUT_TYPE] [-rt]
               [--hmms_output_type HMMS_OUTPUT_TYPE] [--validation] [-p]
               [--negative_db NEGATIVE_DB] [-s SNAKEFILE] [-t THREADS]
               [-hm HMM_MODELS] [--concat_hmm_models] [--unlock] [-w WORKFLOW]
               [-c CONFIG_FILE] [--display_config] [-v]

PlastEDMA's main script

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        input FASTA file containing a list of protein
                        sequences to be analysed
  --input_seqs_db_const INPUT_SEQS_DB_CONST
                        input a FASTA file with a set of sequences from which
                        the user wants to create the HMM database from scratch
  -db DATABASE, --database DATABASE
                        FASTA database to run against the also user inputted
                        sequences. DIAMOND is performed in order to expand the
                        data and build the models. PlastEDMA has no in-built
                        database for this matter. If flag is given, download
                        of the default database will start and model built
                        from that. Defaults to UniProt DataBase.
  --hmm_db_name HMM_DB_NAME
                        name to be assigned to the hmm database to be created.
                        Its recomended to give a name that that describes the
                        family or other characteristic of the given sequences
  -it INPUT_TYPE, --input_type INPUT_TYPE
                        specifies the nature of the sequences in the input
                        file between 'protein', 'nucleic' or 'metagenome'.
                        Defaults to 'protein'
  -o OUTPUT, --output OUTPUT
                        name for the output directory. Defaults to
                        'PlastEDMA_results'
  --output_type OUTPUT_TYPE
                        choose report table outpt format from 'tsv', 'csv' or
                        'excel'. Defaults to 'tsv'
  -rt, --report_text    decides whether to produce or not a friendly report in
                        txt format with easy to read information
  --hmms_output_type HMMS_OUTPUT_TYPE
                        chose output type of hmmsearch run from 'out', 'tsv'
                        or 'pfam' format. Defaults to 'tsv'
  --validation          decides whether to perform models validation and
                        filtration with the 'leave-one-out' cross validation
                        methods. Call to set to True. Defaults to False
  -p, --produce_inter_tables
                        call if user wants to save intermediate tables as
                        parseale .csv files (tables from hmmsearch results
                        processing)
  --negative_db NEGATIVE_DB
                        path to a user defined negative control database.
                        Default use of human gut microbiome
  -s SNAKEFILE, --snakefile SNAKEFILE
                        user defined snakemake workflow Snakefile. Defaults to
                        '/workflow/Snakefile
  -t THREADS, --threads THREADS
                        number of threads for Snakemake to use. Defaults to 1
  -hm HMM_MODELS, --hmm_models HMM_MODELS
                        path to a directory containing HMM models previously
                        created by the user. By default PlastEDMA uses the
                        built-in HMMs from database in
                        'resources/Data/HMMs/After_tcoffee_UPI/'
  --concat_hmm_models   concatenate HMM models into a single file
  --unlock              could be required after forced workflow termination
  -w WORKFLOW, --workflow WORKFLOW
                        defines the workflow to follow, between "annotation",
                        "database_construction" and "both". Latter keyword
                        makes the database construction first and posterior
                        annotation. Defaults to "annotation"
  -c CONFIG_FILE, --config_file CONFIG_FILE
                        user defined config file. Only recommended for
                        advanced users. Defaults to 'config.yaml'. If given,
                        overrides config file construction from input
  --display_config      declare to output the written config file together
                        with results. Useful in case of debug
  -v, --version         show program's version number and exit
```


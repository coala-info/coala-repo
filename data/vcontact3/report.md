# vcontact3 CWL Generation Report

## vcontact3_version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcontact3:3.1.6--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/MAVERICLab/vcontact3
- **Package**: https://anaconda.org/channels/bioconda/packages/vcontact3/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcontact3/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-10-23
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: vcontact3 version [-h]

options:
  -h, --help  show this help message and exit
```


## vcontact3_prepare_databases

### Tool Description
Prepare vContact2 databases

### Metadata
- **Docker Image**: quay.io/biocontainers/vcontact3:3.1.6--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/MAVERICLab/vcontact3
- **Package**: https://anaconda.org/channels/bioconda/packages/vcontact3/overview
- **Validation**: PASS

### Original Help Text
```text
[INFO] 2026-02-25 05:38:24 Downloading database 230 from https://zenodo.org/records/15598380/files/v230.tar.gz. This may take some time depending on your internet connection.
Traceback (most recent call last):
  File "/usr/local/bin/vcontact3", line 9, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.11/site-packages/vcontact3/cli.py", line 159, in main
    arguments.func(**args_dict)
  File "/usr/local/lib/python3.11/site-packages/vcontact3/cli.py", line 39, in prepare_databases_entry
    prepare_databases(**kwargs)
  File "/usr/local/lib/python3.11/site-packages/vcontact3/databases.py", line 218, in prepare_databases
    download_version(get_version, download_path, available_dbs)
  File "/usr/local/lib/python3.11/site-packages/vcontact3/databases.py", line 103, in download_version
    version_dl_res = utils.execute_stdout(['curl', '-s', '-o', str(dest_path), src_path])
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/vcontact3/utilities.py", line 113, in execute_stdout
    res = subprocess.run(command, shell=False, encoding='utf-8', stdout=subprocess.PIPE)
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/subprocess.py", line 548, in run
    with Popen(*popenargs, **kwargs) as process:
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/subprocess.py", line 1026, in __init__
    self._execute_child(args, executable, preexec_fn, close_fds,
  File "/usr/local/lib/python3.11/subprocess.py", line 1955, in _execute_child
    raise child_exception_type(errno_num, err_msg, err_filename)
FileNotFoundError: [Errno 2] No such file or directory: 'curl'
```


## vcontact3_run

### Tool Description
vcontact3 run

### Metadata
- **Docker Image**: quay.io/biocontainers/vcontact3:3.1.6--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/MAVERICLab/vcontact3
- **Package**: https://anaconda.org/channels/bioconda/packages/vcontact3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vcontact3 run [-h] [-n NUCLEOTIDES] [--pyrodigal-gv] [--virus-only]
                     [-p PROTEINS] [-g GENE2GENOME] [-l NUCL_LEN]
                     [-o OUTPUT_DIR]
                     [--db-domain {archaea,bacteria,prokaryotes,eukaryotes}]
                     [--db-version DB_VERSION] [-d DB_PATH]
                     [--default-realm {Monodnaviria,Duplodnaviria,Adnaviria,Varidnaviria}]
                     [--distance-metric {VirClust,SqRoot,Shorter,Jaccard}]
                     [-i ITER_PER_COMPONENT] [--mmseqs-bin MMSEQS_FP]
                     [--vclust-bin VCLUST_FP]
                     [-e {cytoscape,graphml,cosmograph,d3js,ani,newick,profiles,completeness,centroids} [{cytoscape,graphml,cosmograph,d3js,ani,newick,profiles,completeness,centroids} ...]]
                     [-r {order,family,subfamily,genus} [{order,family,subfamily,genus} ...]]
                     [-x TARGET_MEMBERS] [-c COMPLETENESS_MEMBERS]
                     [--calc-silhouette] [--keep-fna] [-b BREAKS]
                     [--export-all] [-t THREADS] [--reduce-memory] [-k]
                     [--no-progress] [-v] [--quiet] [-f]

options:
  -h, --help            show this help message and exit

Inputs/Outputs:
  -n NUCLEOTIDES, --nucleotide NUCLEOTIDES
                        FASTA-formatted nucleotide file. Enables gene-calling,
                        disables --proteins. (default: None)
  --pyrodigal-gv        Enable pyrodigal-gv models (giant viruses, alternative
                        codes). (default: False)
  --virus-only          Run only virus models in pyrodigal-gv. (default:
                        False)
  -p PROTEINS, --proteins PROTEINS
                        FASTA-formatted proteins file. Disables ANI export
                        (default: None)
  -g GENE2GENOME, --gene2genome GENE2GENOME
                        File linking gene names to genomes (required with
                        --proteins). (default: None)
  -l NUCL_LEN, --len-nucleotide NUCL_LEN
                        Genome length file for normalization. (default: None)
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        Output directory. (default: vConTACT3_results)

Databases:
  --db-domain {archaea,bacteria,prokaryotes,eukaryotes}
                        Database domain to use. (default: prokaryotes)
  --db-version DB_VERSION
                        Database version to use. (default: None)
  -d DB_PATH, --db-path DB_PATH
                        Path to database file or directory. (default: None)
  --default-realm {Monodnaviria,Duplodnaviria,Adnaviria,Varidnaviria}
                        Default realm fallback if no PC similarity found.
                        (default: Duplodnaviria)

Protein Cluster Creation Options:
  --distance-metric {VirClust,SqRoot,Shorter,Jaccard}
                        Distance metric between genomes. (default: SqRoot)
  -i ITER_PER_COMPONENT, --max-iterations ITER_PER_COMPONENT
                        Max number of iterations to run when resolving mixed-
                        realm components. Increase to to remove or reduce
                        large hetero-realm clusters (e.g.
                        Adnaviria|Duplornaviria) (default: 3)

Executables:
  --mmseqs-bin MMSEQS_FP
                        Path to MMSeqs2 executable. (default: None)
  --vclust-bin VCLUST_FP
                        Path to vclust executable. (default: None)

Exporting and Outputs:
  -e {cytoscape,graphml,cosmograph,d3js,ani,newick,profiles,completeness,centroids} [{cytoscape,graphml,cosmograph,d3js,ani,newick,profiles,completeness,centroids} ...], --exports {cytoscape,graphml,cosmograph,d3js,ani,newick,profiles,completeness,centroids} [{cytoscape,graphml,cosmograph,d3js,ani,newick,profiles,completeness,centroids} ...]
                        Export formats to generate. (default: [''])
  -r {order,family,subfamily,genus} [{order,family,subfamily,genus} ...], --target-rank {order,family,subfamily,genus} [{order,family,subfamily,genus} ...]
                        Target rank(s) for protein cluster profiles. (default:
                        [])
  -x TARGET_MEMBERS, --target-members TARGET_MEMBERS
                        Minimum members for profile rendering. (default: 5)
  -c COMPLETENESS_MEMBERS, --completeness-members COMPLETENESS_MEMBERS
                        Minimum members for completeness calculation.
                        Moderately increases processing time.Uses genus to
                        estimate completeness. (default: 5)
  --calc-silhouette     Calculate Silhouette scores for Newick. Slightly
                        increases processing time. (default: False)
  --keep-fna            Keep family-level nucleotide files when --export ani.
                        (default: False)
  -b BREAKS, --breaks BREAKS
                        Number of breaks for output chunking. (default: 1)
  --export-all          For "ani", "newick" and "profiles", include ALL
                        genomes, not just user-supplied. (default: False)

Miscellaneous Options:
  -t THREADS, --threads THREADS
                        Number of CPUs to use. (default: 20)
  --reduce-memory       Reduce memory usage with float16 arrays. (default:
                        False)
  -k, --keep-temp       Keep intermediate files. (default: False)
  --no-progress         Disable progress bars (useful for batch jobs).
                        (default: False)
  -v, --verbose         Increase verbosity: default=INFO, -v=DEBUG. Use
                        --quiet to show only warnings/errors. (default: 0)
  --quiet               Suppress progress messages; only show warnings and
                        errors. (default: False)
  -f, --force-overwrite
                        Overwrite existing files. (default: False)
```


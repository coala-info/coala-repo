# virmet CWL Generation Report

## virmet_fetch

### Tool Description
Fetch viral, human, bacterial, fungal, or bovine databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/virmet:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/medvir/VirMet
- **Package**: https://anaconda.org/channels/bioconda/packages/virmet/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/virmet/overview
- **Total Downloads**: 31.1K
- **Last updated**: 2026-01-23
- **GitHub**: https://github.com/medvir/VirMet
- **Stars**: N/A
### Original Help Text
```text
usage: virmet fetch [-h] [--viral {n,p}] [--human] [--bact_fungal] [--bovine]
                    [--no_db_compression] [--dbdir [DBDIR]]

options:
  -h, --help           show this help message and exit
  --viral {n,p}        viral [nucleic acids/proteins]
  --human              human
  --bact_fungal        bacterial and fungal(RefSeq)
  --bovine             bovine (Bos taurus)
  --no_db_compression  do not compress the viral database
  --dbdir [DBDIR]      path to store the new Virmet database
```


## virmet_update

### Tool Description
Update the Virmet database.

### Metadata
- **Docker Image**: quay.io/biocontainers/virmet:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/medvir/VirMet
- **Package**: https://anaconda.org/channels/bioconda/packages/virmet/overview
- **Validation**: PASS

### Original Help Text
```text
usage: virmet update [-h] [--viral {n,p}] [--picked PICKED]
                     [--update_min_date UPDATE_MIN_DATE] [--no_db_compression]
                     [--dbdir [DBDIR]]

options:
  -h, --help            show this help message and exit
  --viral {n,p}         update viral [n]ucleic/[p]rotein
  --picked PICKED       file with additional sequences, one GI per line
  --update_min_date UPDATE_MIN_DATE
                        update viral [n]ucleic/[p]rotein with sequences
                        produced after the date YYYY/MM/DD
  --no_db_compression   do not compress the viral database
  --dbdir [DBDIR]       path to store the updated Virmet database
```


## virmet_index

### Tool Description
Builds indexes for various databases used by Virmet.

### Metadata
- **Docker Image**: quay.io/biocontainers/virmet:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/medvir/VirMet
- **Package**: https://anaconda.org/channels/bioconda/packages/virmet/overview
- **Validation**: PASS

### Original Help Text
```text
usage: virmet index [-h] [--viral {n,p}] [--human] [--bact_fungal] [--bovine]
                    [--dbdir [DBDIR]]

options:
  -h, --help       show this help message and exit
  --viral {n,p}    make blast index of viral database
  --human          make bwa index of human database
  --bact_fungal    build kraken2 bacterial and fungal database
  --bovine         make bwa index of bovine database
  --dbdir [DBDIR]  path to store the indexed Virmet database
```


## virmet_wolfpack

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/virmet:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/medvir/VirMet
- **Package**: https://anaconda.org/channels/bioconda/packages/virmet/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/virmet", line 9, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.14/site-packages/virmet/cli.py", line 210, in main
    args.func(args)
    ~~~~~~~~~^^^^^^
  File "/usr/local/lib/python3.14/site-packages/virmet/cli.py", line 31, in wolfpack_run
    od = wolfpack.main(args)
  File "/usr/local/lib/python3.14/site-packages/virmet/wolfpack.py", line 672, in main
    out_dir_final = "virmet_output_%s" % run_name
                                         ^^^^^^^^
UnboundLocalError: cannot access local variable 'run_name' where it is not associated with a value
```


## virmet_covplot

### Tool Description
Generate coverage plots for viral genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/virmet:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/medvir/VirMet
- **Package**: https://anaconda.org/channels/bioconda/packages/virmet/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/virmet", line 9, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.14/site-packages/virmet/cli.py", line 210, in main
    args.func(args)
    ~~~~~~~~~^^^^^^
  File "/usr/local/lib/python3.14/site-packages/virmet/covplot.py", line 336, in main
    organism = os.path.expandvars(args.organism)
  File "<frozen posixpath>", line 294, in expandvars
TypeError: expected str, bytes or os.PathLike object, not NoneType
```


## Metadata
- **Skill**: generated

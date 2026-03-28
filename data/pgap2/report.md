# pgap2 CWL Generation Report

## pgap2_prep

### Tool Description
Prepares input data for pgap2.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bucongfan/PGAP2
- **Package**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Total Downloads**: 766
- **Last updated**: 2026-02-06
- **GitHub**: https://github.com/bucongfan/PGAP2
- **Stars**: N/A
### Original Help Text
```text
usage: pgap2 prep [-h] --indir INDIR [--outdir OUTDIR] [--dup_id DUP_ID]
                  [--orth_id ORTH_ID] [--para_id PARA_ID]
                  [--type-filter TYPE_FILTER] [--id-attr-key ID_ATTR_KEY]
                  [--min_falen MIN_FALEN] [--accurate]
                  [--max_targets MAX_TARGETS] [--LD LD] [--AS AS] [--AL AL]
                  [--evalue EVALUE] [--aligner {diamond,blast}]
                  [--clust_method {cdhit,mmseqs2}] [--marker MARKER]
                  [--ani_thre ANI_THRE] [--annot] [--retrieve] [--gcode GCODE]
                  [--nodraw] [--single_file] [--verbose] [--debug] [--disable]
                  [--threads THREADS]

options:
  -h, --help            show this help message and exit
  --indir INDIR, -i INDIR
                        Input file contained, same prefix seems as the same
                        strain. (default: None)
  --outdir OUTDIR, -o OUTDIR
                        Output directory (default: .)
  --dup_id DUP_ID       The maximum identity between the most recent
                        duplication envent. (default: 0.99)
  --orth_id ORTH_ID     The maximum identity between the most similar
                        panclusters, 0 means automatic selection. (default:
                        0.98)
  --para_id PARA_ID     Use this identity as the paralogous identity, 0 means
                        automatic selection. (default: 0.7)
  --type-filter TYPE_FILTER
                        Only for gff file as input, feature type (3rd column)
                        to include, Only lines matching these types will be
                        processed. (default: CDS)
  --id-attr-key ID_ATTR_KEY
                        Only for gff file as input, Attribute key to extract
                        from the 9th column as the record ID (e.g., 'ID',
                        'gene', 'locus_tag'). (default: ID)
  --min_falen MIN_FALEN, -l MIN_FALEN
                        protein length of throw_away_sequences, at least 11
                        (default: 20)
  --accurate, -a        Apply bidirection check for paralogous gene partition.
                        (default: False)
  --max_targets MAX_TARGETS, -k MAX_TARGETS
                        The maximum targets for each query in alignment.
                        Improves accuracy for large-scale analyses, but
                        increases runtime and memory usage. (default: 2000)
  --LD LD               Minimum gene length difference proportion between two
                        genes. (default: 0.6)
  --AS AS               Coverage for the shorter sequence. (default: 0.6)
  --AL AL               Coverage for the longer sequence. (default: 0.6)
  --evalue EVALUE       The evalue of aligner. (default: 1e-05)
  --aligner {diamond,blast}
                        The aligner used to pairwise alignment. (default:
                        diamond)
  --clust_method {cdhit,mmseqs2}
                        The method used to cluster the genes. (default: cdhit)
  --marker MARKER       Assigned darb or outlier strain used to filter the
                        input. See detail in marker.cfg in the main path
                        (default: None)
  --ani_thre ANI_THRE   Expect ani threshold (default: 95)
  --annot               Discard original annotation, and re-annote the genome
                        privately using prodigal (default: False)
  --retrieve            Retrieving gene that may lost with annotations
                        (default: False)
  --gcode GCODE         The genetic code of your species. Default is [11]
                        (bacteria). (default: 11)
  --nodraw              Only output flat file, but no drawing plot (default:
                        False)
  --single_file, -s     Output each vector plot as a single file (default:
                        False)
  --verbose, -V         Verbose output (default: False)
  --debug, -D           Debug mode. Note: very verbose (default: False)
  --disable             Disable progress bar (default: False)
  --threads THREADS, -t THREADS
                        threads used in parallel (default: 1)
```


## pgap2_main

### Tool Description
Main entry point for pgap2.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bucongfan/PGAP2
- **Package**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgap2 main [-h] --indir INDIR [--outdir OUTDIR] [--dup_id DUP_ID]
                  [--orth_id ORTH_ID] [--para_id PARA_ID]
                  [--type-filter TYPE_FILTER] [--id-attr-key ID_ATTR_KEY]
                  [--hconf_thre HCONF_THRE] [--exhaust_orth]
                  [--sensitivity {soft,moderate,strict}] [--ins] [--fast]
                  [--accurate] [--retrieve] [--threads THREADS]
                  [--max_targets MAX_TARGETS] [--LD LD] [--AS AS] [--AL AL]
                  [--evalue EVALUE] [--aligner {diamond,blastp}]
                  [--clust_method {cdhit,mmseqs2}] [--radius RADIUS]
                  [--min_falen MIN_FALEN] [--gcode GCODE] [--annot]
                  [--verbose] [--debug] [--disable]

options:
  -h, --help            show this help message and exit
  --indir INDIR, -i INDIR
                        Input file contained, same prefix seems as the same
                        strain. (default: None)
  --outdir OUTDIR, -o OUTDIR
                        Output directory (default: .)
  --dup_id DUP_ID       The maximum identity between the most recent
                        duplication envent. (default: 0.99)
  --orth_id ORTH_ID     The maximum identity between the most similar
                        panclusters. (default: 0.98)
  --para_id PARA_ID     Use this identity as the paralogous identity.
                        (default: 0.7)
  --type-filter TYPE_FILTER
                        Only for gff file as input, feature type (3rd column)
                        to include, Only lines matching these types will be
                        processed. (default: CDS)
  --id-attr-key ID_ATTR_KEY
                        Only for gff file as input, Attribute key to extract
                        from the 9th column as the record ID (e.g., 'ID',
                        'gene', 'locus_tag'). (default: ID)
  --hconf_thre HCONF_THRE
                        The threshold to define high confidence cluster which
                        is used to evaluate the cluster diversity. Loose this
                        value when your input is too large or too diverse,
                        such as 0.95. (default: 1)
  --exhaust_orth, -e    Try to split every paralogs gene exhausted (default:
                        False)
  --sensitivity {soft,moderate,strict}, -s {soft,moderate,strict}
                        The degree of connectedness between each node of
                        clust. (default: strict)
  --ins, -n             Ignore the influence of insertion sequence. (default:
                        False)
  --fast, -f            Do not apply fine feature analysis just partition
                        according to the gene identity and synteny. (default:
                        False)
  --accurate, -a        Apply bidirection check for paralogous gene partition
                        (useless if exhaust_orth asigned). (default: False)
  --retrieve, -r        Retrieve gene that may lost with annotations (default:
                        False)
  --threads THREADS, -t THREADS
                        threads used in parallel (default: 1)
  --max_targets MAX_TARGETS, -k MAX_TARGETS
                        The maximum targets for each query in alignment.
                        Improves accuracy for large-scale analyses, but
                        increases runtime and memory usage. (default: 2000)
  --LD LD               Minimum gene length difference proportion between two
                        genes. (default: 0.6)
  --AS AS               Coverage for the shorter sequence. (default: 0.6)
  --AL AL               Coverage for the longer sequence. (default: 0.6)
  --evalue EVALUE       The evalue of aligner. (default: 1e-05)
  --aligner {diamond,blastp}
                        The aligner used to pairwise alignment. (default:
                        diamond)
  --clust_method {cdhit,mmseqs2}
                        The method used to cluster the genes. (default:
                        mmseqs2)
  --radius RADIUS       The radius of search region. (default: 3)
  --min_falen MIN_FALEN, -m MIN_FALEN
                        protein length of throw_away_sequences, at least 11
                        (default: 20)
  --gcode GCODE         The genetic code of your species. (default: 11)
  --annot               Discard original annotation, and re-annote the genome
                        privately using prodigal (default: False)
  --verbose, -v         Verbose output (default: False)
  --debug, -D           Debug mode. Note: very verbose (default: False)
  --disable             Disable progress bar (default: False)
```


## pgap2_add

### Tool Description
Add new sequences to an existing PGAP2 analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bucongfan/PGAP2
- **Package**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgap2 add [-h] --indir INDIR [--outdir OUTDIR] [--previous PREVIOUS]
                 [--aligner {diamond,blastp}] [--clust_method {cdhit,mmseqs2}]
                 [--type-filter TYPE_FILTER] [--id-attr-key ID_ATTR_KEY]
                 [--retrieve] [--threads THREADS] [--min_falen MIN_FALEN]
                 [--gcode GCODE] [--annot] [--verbose] [--debug] [--disable]

options:
  -h, --help            show this help message and exit
  --indir INDIR, -i INDIR
                        Input file contained, same prefix seems as the same
                        strain. (default: None)
  --outdir OUTDIR, -o OUTDIR
                        Output directory (default: .)
  --previous PREVIOUS, -p PREVIOUS
                        The previous PGAP2 result directory, used to resume
                        the partition step quickly. (default: None)
  --aligner {diamond,blastp}
                        The aligner used to pairwise alignment. (default:
                        diamond)
  --clust_method {cdhit,mmseqs2}
                        The method used to cluster the genes. (default:
                        mmseqs2)
  --type-filter TYPE_FILTER
                        Only for gff file as input, feature type (3rd column)
                        to include, Only lines matching these types will be
                        processed. (default: CDS)
  --id-attr-key ID_ATTR_KEY
                        Only for gff file as input, Attribute key to extract
                        from the 9th column as the record ID (e.g., 'ID',
                        'gene', 'locus_tag'). (default: ID)
  --retrieve, -r        Retrieve gene that may lost with annotations (default:
                        False)
  --threads THREADS, -t THREADS
                        threads used in parallel (default: 1)
  --min_falen MIN_FALEN, -m MIN_FALEN
                        protein length of throw_away_sequences, at least 11
                        (default: 20)
  --gcode GCODE         The genetic code of your species. (default: 11)
  --annot               Discard original annotation, and re-annote the genome
                        privately using prodigal (default: False)
  --verbose, -v         Verbose output (default: False)
  --debug, -D           Debug mode. Note: very verbose (default: False)
  --disable             Disable progress bar (default: False)
```


## pgap2_post

### Tool Description
Performs post-processing analysis on pangenome data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bucongfan/PGAP2
- **Package**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgap2 post [-h] {stat,profile,singletree,baps,tajimas_d} ...

positional arguments:
  {stat,profile,singletree,baps,tajimas_d}
    stat                Statistical analysis
    profile             To generate the pangenome profile using PAV matrix, it
                        is the subset of [stat] module
    singletree          Workflow for bayesian analysis of population structure
    baps                Workflow for bayesian analysis of population structure
    tajimas_d           Workflow for Tajima's D test

options:
  -h, --help            show this help message and exit
```


## Metadata
- **Skill**: generated

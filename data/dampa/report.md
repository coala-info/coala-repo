# dampa CWL Generation Report

## dampa_design

### Tool Description
Design probes for pangenomes

### Metadata
- **Docker Image**: quay.io/biocontainers/dampa:0.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/MultipathogenGenomics/dampa
- **Package**: https://anaconda.org/channels/bioconda/packages/dampa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dampa/overview
- **Total Downloads**: 35.9K
- **Last updated**: 2025-11-14
- **GitHub**: https://github.com/MultipathogenGenomics/dampa
- **Stars**: N/A
### Original Help Text
```text
usage: dampa design [-h] -g INPUT [-c CLUSTERASSIGN]
                    [--clustertype {cdhit,tabular}]
                    [--maxnonspandard MAXNONSPANDARD] [-o OUTPUTFOLDER]
                    [-p OUTPUTPREFIX] [-l PROBELEN] [-s PROBESTEP]
                    [--skipsubambig] [--shannonthresh SHANNONTHRESH]
                    [--pangraphident {5,10,20}]
                    [--pangraphalpha PANGRAPHALPHA]
                    [--pangraphbeta PANGRAPHBETA] [--pangraphlen PANGRAPHLEN]
                    [--pangraphstrict] [--pangraphdepth PANGRAPHDEPTH]
                    [--probetoolsidentity PROBETOOLSIDENTITY]
                    [--probetoolsalignmin PROBETOOLSALIGNMIN]
                    [--probetools0covnmin PROBETOOLS0COVNMIN]
                    [--maxambig MAXAMBIG] [--nodust]
                    [--clustering_inputno_trigger CLUSTERING_INPUTNO_TRIGGER]
                    [--clusterident CLUSTERIDENT] [--clustercov CLUSTERCOV]
                    [--remove_outliers] [--outliersizelimit OUTLIERSIZELIMIT]
                    [--outlierclusterident OUTLIERCLUSTERIDENT]
                    [--outlierclustercov OUTLIERCLUSTERCOV] [--skip_padding]
                    [--padding_nuc {A,T,C,G}]
                    [--minlenforpadding MINLENFORPADDING]
                    [--skip_probetoolsfinal] [--unioncov] [-t THREADS]
                    [--keeplogs] [--keeptmp] [--skip_summaries]
                    [--maxdepth_describe MAXDEPTH_DESCRIBE]
                    [--report0covperc REPORT0COVPERC] [--version] [--maxdiv]

options:
  -h, --help            show this help message and exit

Input/Output options:
  -g, --input INPUT     Either folder containing individual genome fasta files
                        OR a single fasta file containing all genomes (files
                        must end in .fna, .fa or .fasta) (default: None)
  -c, --clusterassign CLUSTERASSIGN
                        clstr file from cd-hit (default: None)
  --clustertype {cdhit,tabular}
                        type of cluster file input cdhit (produced by cdhit)
                        or tabular (genome and cluster tab delimited)
                        (default: tabular)
  --maxnonspandard MAXNONSPANDARD
                        maximum proportion of genome that can be non ATGC
                        (0-1) (default: 0.01)
  -o, --outputfolder OUTPUTFOLDER
                        path to output folder (default: //)
  -p, --outputprefix OUTPUTPREFIX
                        prefix for all output files and folders (default:
                        probebench_run)

General settings:
  -l, --probelen PROBELEN
                        length of output probes (default: 120)
  -s, --probestep PROBESTEP
                        step of probes (for no overlap set to same as
                        probelen) (default: 120)
  --skipsubambig        do NOT substitute ambiguous nucleotides (by default N
                        or other ambiguous nucleotides are substituted for
                        ATGC in a random selection weighted by proportions in
                        input genomes (default: False)
  --shannonthresh SHANNONTHRESH
                        minimum shannon entropy of probes and reported
                        coverage regions (filters out low complexity
                        probes/regions) (default: 1.5)

Pangraph settings:
  These settings control the pangenome graph generation step

  --pangraphident {5,10,20}
                        Pangenome percentage identity setting allowable values
                        are 5,10 or 20 (default: 20)
  --pangraphalpha PANGRAPHALPHA
                        Energy cost for splitting a block during alignment
                        merger. Controls graph fragmentation (default: 0)
  --pangraphbeta PANGRAPHBETA
                        Energy cost for diversity in the alignment. A high
                        value prevents merging of distantly-related sequences
                        in the same block (default: 6.666)
  --pangraphlen PANGRAPHLEN
                        Minimum length of a node to allow in pangenome graph
                        (default: 90)
  --pangraphstrict      enable the -S strict identity option which limits
                        merges to 1/pangraphbeta divergence (default: False)
  --pangraphdepth PANGRAPHDEPTH
                        Minimum depth of a node to allow in pangenome graph.
                        Nodes with depth below this will be removed from the
                        graph. Set to 0 to not remove any nodes based on depth
                        (default: 0)

Probetools settings:
  Used to retrieve sequences that may be missed in the graph based design
  step

  --probetoolsidentity PROBETOOLSIDENTITY
                        Minimum identity in probe match to target to call
                        probe binding (default: 80)
  --probetoolsalignmin PROBETOOLSALIGNMIN
                        Minimum length (bp) of probe-target binding to allow
                        call of binding (default: 90)
  --probetools0covnmin PROBETOOLS0COVNMIN
                        Minimum length (bp) of 0 coverage region in input
                        genomes to trigger design of additional probes
                        (default: 20)
  --maxambig MAXAMBIG   The maximum number of ambiguous bases allowed in a
                        probe (default: 10)
  --nodust              Do not run low complexity filter in BLAST (within
                        probetools). If sample has very low GC or is very
                        repetitive this option can be enabled to prevent low
                        complexity regions from being removed (default: False)

cdhit preclustering settings:
  This step reduces redundancy in input genomes to speed up pangraph

  --clustering_inputno_trigger CLUSTERING_INPUTNO_TRIGGER
                        if number of input sequences exceeds this number then
                        cdhit will be used to deduplcate genomes above 99.9
                        percent identity Set to 0 to always cluster (default:
                        5000)
  --clusterident CLUSTERIDENT
                        Minimum identity to cluster genomes (default: 0.999)
  --clustercov CLUSTERCOV
                        Minimum coverage of genomes over which clusterident
                        must apply (0-1) (default: 1)
  --outlierclustercov OUTLIERCLUSTERCOV
                        Minimum coverage of genomes over which clusterident
                        must apply (0-1) (default: 1)

outlier removal settings:
  This step removes clusters smaller than outliersizelimit that are distinct
  at outlierclusterident identity threshold from all other sequences in the
  input set. Uses ch-hit for clustering

  --remove_outliers     perform initial high threshold clustering followed by
                        low threshold clustering of representatives, remove
                        low level clusters composed of one high level cluster
                        with <= outliersizelimit members (default: False)
  --outliersizelimit OUTLIERSIZELIMIT
                        In two step clustering if a cluster is
                        <=outliersizelimit at both high and low identity then
                        it is treated as an outlier (default: 1)
  --outlierclusterident OUTLIERCLUSTERIDENT
                        outlier identity threshold, i.e. if a cluster is
                        <outlierclusterident and <=outliersizelimit members it
                        is treated as an outlier (default: 0.85)

Additional settings:
  --skip_padding        do not generate additional probes for pangenome nodes
                        between pangraphlen and probelen in length. i.e. if
                        padding is run 30*T would be added to the end of a
                        90bp pancontig (default: False)
  --padding_nuc {A,T,C,G}
                        nucleotide to use for padding probes to args.probelen
                        (default: T)
  --minlenforpadding MINLENFORPADDING
                        minimum length for a pancontig for it to be padded
                        (WARNING setting this below ~80 may result in probes
                        that do not effectively bind, leave these small
                        sequences for final probetools step) (default: 90)
  --skip_probetoolsfinal
                        do NOT run final probe design step. i.e. this step
                        uses probetools to design probes to regions that are
                        not represented in the pangenome (default: False)
  --unioncov            minimise pangenome graph size by removing nodes
                        represented elsewhere in sections (default: False)
  -t, --threads THREADS
                        number of threads (default: 1)
  --keeplogs            keep logs containing output from pangraph and
                        probetools (default: False)
  --keeptmp             keep intermediate files from pangraph and probetools
                        (default: False)
  --skip_summaries      do NOT run visualisation generaton of dampa probes
                        relative to input genomes (default: False)
  --maxdepth_describe MAXDEPTH_DESCRIBE
                        Maximum depth of probe coverage to describe
                        separately. i.e. if 1 there will be 0,1 and >1 depth
                        categories (default: 1)
  --report0covperc REPORT0COVPERC
                        threshold above which genomes are reported as having
                        too much of their genome not covered by any probes
                        (default: 1)
  --version             print version and exit (default: False)
  --maxdiv              use new maxdiv pangraph version (default: False)
```


## dampa_eval

### Tool Description
Check probe coverage against genomes or capture files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dampa:0.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/MultipathogenGenomics/dampa
- **Package**: https://anaconda.org/channels/bioconda/packages/dampa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dampa eval [-h] -g INPUT [--inputtype {genomes,capture}] -q PROBES
                  [-c CLUSTERASSIGN] [--clustertype {cdhit,tabular}]
                  [--filtnonstandard] [-o OUTPUTFOLDER] [-p OUTPUTPREFIX]
                  [--probetoolsidentity PROBETOOLSIDENTITY]
                  [--probetoolsalignmin PROBETOOLSALIGNMIN]
                  [--probetools0covnmin PROBETOOLS0COVNMIN] [--nodust]
                  [-l PROBELEN] [--shannonthresh SHANNONTHRESH] [-t THREADS]
                  [--keeplogs] [--maxdepth_describe MAXDEPTH_DESCRIBE]
                  [--report0covperc REPORT0COVPERC] [--version] [--keeptmp]

options:
  -h, --help            show this help message and exit

Input/Output options:
  -g, --input INPUT     Genomes to check probe coverage. If genomes either
                        folder containing individual genome fasta files OR a
                        single fasta file containing all genomes (files must
                        end in .fna, .fa or .fasta) If capture file then a pt
                        file from a previous pangraph design or pangraph eval
                        run (default: None)
  --inputtype {genomes,capture}
                        type of cluster file input cdhit (produced by cdhit)
                        or tabular (genome and cluster tab delimited)
                        (default: genomes)
  -q, --probes PROBES   Fasta file containing probes to evaluate (files must
                        end in .fna, .fa or .fasta) (default: None)
  -c, --clusterassign CLUSTERASSIGN
                        clstr file from cd-hit (default: None)
  --clustertype {cdhit,tabular}
                        type of cluster file input cdhit (produced by cdhit)
                        or tabular (genome and cluster tab delimited)
                        (default: tabular)
  --filtnonstandard     remove genomes with non standard nucleotides i.e. not
                        A,T,G,C or N (default: False)
  -o, --outputfolder OUTPUTFOLDER
                        path to output folder (default: //)
  -p, --outputprefix OUTPUTPREFIX
                        prefix for all output files and folders (default:
                        probebench_run)

Probetools settings:
  --probetoolsidentity PROBETOOLSIDENTITY
                        Minimum identity in probe match to target to call
                        probe binding (default: 85)
  --probetoolsalignmin PROBETOOLSALIGNMIN
                        Minimum length (bp) of probe-target binding to allow
                        call of binding (default: 90)
  --probetools0covnmin PROBETOOLS0COVNMIN
                        Minimum length (bp) of 0 coverage region in input
                        genomes to trigger design of additional probes
                        (default: 20)
  --nodust              Do not run low complexity filter in BLAST (within
                        probetools). If sample has very low GC or is very
                        repetitive this option can be enabled to prevent low
                        complexity regions from being removed (default: False)
  -l, --probelen PROBELEN
                        length of output probes (default: 120)
  --shannonthresh SHANNONTHRESH
                        minimum shannon entropy of probes and reported
                        coverage regions (filters out low complexity
                        probes/regions) (default: 1.5)

Additional settings:
  -t, --threads THREADS
                        number of threads (default: 1)
  --keeplogs            keep logs containing output from pangraph and
                        probetools (default: False)
  --maxdepth_describe MAXDEPTH_DESCRIBE
                        Maximum depth of probe coverage to describe
                        separately. i.e. if 1 there will be 0,1 and >1 depth
                        categories (default: 1)
  --report0covperc REPORT0COVPERC
                        threshold above which genomes are reported as having
                        too much of their genome not covered by any probes
                        (default: 1)
  --version             print version and exit (default: False)
  --keeptmp             keep intermediate files from pangraph and probetools
                        (default: False)
```


## dampa_targets

### Tool Description
Generates target sequences based on a dampa design JSON file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dampa:0.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/MultipathogenGenomics/dampa
- **Package**: https://anaconda.org/channels/bioconda/packages/dampa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dampa targets [-h] -j INPUTJSON [-o OUTPUTFOLDER] [-p OUTPUTPREFIX]
                     [-l PROBELEN] [--nthresh NTHRESH] [--keeplogs]
                     [-t THREADS]

options:
  -h, --help            show this help message and exit

General settings:
  -j, --inputjson INPUTJSON
                        path to dampa design json arguments file (default:
                        None)
  -o, --outputfolder OUTPUTFOLDER
                        path to output folder (default: //)
  -p, --outputprefix OUTPUTPREFIX
                        prefix for all output files and folders (default:
                        probebench_run)
  -l, --probelen PROBELEN
                        length of output probes (default: 120)
  --nthresh NTHRESH     proportion of Ns allowed in any given graph node to be
                        included in targets (default: 0.1)
  --keeplogs            keep logs containing output from pangraph and
                        probetools (default: False)
  -t, --threads THREADS
                        number of threads (default: 1)
```


## Metadata
- **Skill**: generated

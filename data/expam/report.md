# expam CWL Generation Report

## expam_create

### Tool Description
Initialise database.

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Total Downloads**: 29.8K
- **Last updated**: 2025-09-18
- **GitHub**: https://github.com/seansolari/expam
- **Stars**: N/A
### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_build

### Tool Description
Start building database.

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_print

### Tool Description
Print current database parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_run

### Tool Description
Run reads against database.

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_add

### Tool Description
Add sequence to the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_remove

### Tool Description
Remove sequence from database (only impacts future db builds).

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_set

### Tool Description
Set database build parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_to_taxonomy

### Tool Description
Convert results to taxonomic setting.

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_phylotree

### Tool Description
Draw results on phylotree.

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_draw_tree

### Tool Description
Draw the reference tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_download_taxonomy

### Tool Description
Download taxonomic information for reference sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_cutoff

### Tool Description
Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_mashtree

### Tool Description
Create mashtree from current sequences and add to database.

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_quickrun

### Tool Description
Initialise, set parameters and start building db (assumes sequences all lie in the same folder).

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## expam_make_reads

### Tool Description
Uniformly sample reads of length l from some input sequence. This is for testing purposes only, and is not a replacement for actual read generating software.

### Metadata
- **Docker Image**: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
- **Homepage**: https://github.com/seansolari/expam
- **Package**: https://anaconda.org/channels/bioconda/packages/expam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: expam [-h] [--version] [-db [database name]] [-k [k value int)]]
             [-n [n (int)]] [-s [sketch size (int]] [-p [phylogeny URL]]
             [-d [directory]] [-l [read length]] [-o [out URL]]
             [-y [pile size]] [-e [error rate]] [-t TRUTH_DIR] [--plot]
             [--first FIRST_N] [--cpm CPM] [--taxonomy] [--rank RANK]
             [--keep-zeros] [--ignore-names] [--group GROUPS [GROUPS ...]]
             [--colour-list COLOUR_LIST [COLOUR_LIST ...]] [--sourmash]
             [--rapidnj] [--quicktree] [--paired] [--alpha ALPHA]
             [--log-scores] [--itol] [--flat-colour] [--debug]
             [command]

  expam CLI
--------------

positional arguments:
  [command]             
                        Command to execute. Valid commands include:
                        -------------------------------------------
                        create:-	Initialise database.
                        build:-		Start building database.
                        print:-		Print current database parameters.
                        run:-		Run reads against database.
                        add:-		Add sequence to the database.
                        remove:-	Remove sequence from database (only impacts future db builds).
                        set:-		Set database build parameters.
                        to_taxonomy:-		Convert results to taxonomic setting.
                        phylotree:-		Draw results on phylotree.
                        draw_tree:-		Draw the reference tree.
                        download_taxonomy:-		Download taxonomic information for reference seqeunces.
                        cutoff:-		Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!
                        mashtree:-	Create mashtree from current sequences and add to database.
                        quickrun:-	Initialise, set parameters and start building db (assumes
                        			sequences all lie in the same folder).
                        make_reads:-	Uniformly sample reads of length l from some input sequence.
                        		This is for testing purposes only, and is not a replacement
                        		for actual read generating software.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -db [database name], --db_name [database name]
                        Name of database.
  -k [k value (int)], --kmer [k value (int)]
                        Length of mer used for analysis.
  -n [n (int)], --n-processes [n (int)]
                        Number of CPUs to use for processing.
  -s [sketch size (int)], --sketch [sketch size (int)]
                        Sketch size for mash.
  -p [phylogeny URL], --phylogeny [phylogeny URL]
                        URL of Newick file containing phylogeny.
  -d [directory], --directory [directory]
                        File URL, context depending on command supplied.
  -l [read length], --length [read length]
                        Length of simulated reads.
  -o [out URL], --out [out URL]
                        Where to save classification results.
  -y [pile size], --pile [pile size]
                        Number of genomes to pile at a time (or inf).
  -e [error rate], --error-rate [error rate]
                        Generate error in reads (error ~ reads with errors / reads).
  -t TRUTH_DIR, --truth TRUTH_DIR
                        Location of truth dataset.
  --plot                Plot timing data of database build.
  --first FIRST_N       Add first n genomes in folder.
  --cpm CPM             Counts/million cutoff for read-count to be non-negligible.
  --taxonomy            Convert phylogenetic results to taxonomic results.
  --rank RANK           Rank at which to sort results.
  --keep-zeros          Keep nodes of output where no reads have been assigned.
  --ignore-names
  --group GROUPS [GROUPS ...]
                        Space-separated list of sample files to be treated as a single group in phylotree.
  --colour-list COLOUR_LIST [COLOUR_LIST ...]
                        List of colours to use when plotting groups in phylotree.
  --sourmash            Use sourmash for distance estimation.
  --rapidnj             Use RapidNJ for Neighbour-Joining algorithm.
  --quicktree           Use QuickTree for Neighbour-Joining algorithm.
  --paired              Treat reads as paired-end.
  --alpha ALPHA         Percentage requirement for classification subtrees (see Tutorials 1 & 2).
  --log-scores          Log transformation to opacity scores on phylotree (think uneven distributions).
  --itol                Output plotting data in ITOL format.
  --flat-colour         Do not use abundance to make phylotree colours opaque.
  --debug               Set logging level to DEBUG (as opposed to INFO).
```


## Metadata
- **Skill**: generated

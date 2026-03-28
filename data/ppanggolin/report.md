# ppanggolin CWL Generation Report

## ppanggolin_ppanggolin

### Tool Description
ppanggolin: error: argument : invalid choice: 'ppanggolin' (choose from 'annotate', 'cluster', 'graph', 'partition', 'rarefaction', 'workflow', 'panrgp', 'panmodule', 'all', 'draw', 'write_pangenome', 'write_genomes', 'write_metadata', 'fasta', 'msa', 'metrics', 'align', 'rgp', 'spot', 'module', 'context', 'projection', 'rgp_cluster', 'metadata', 'info', 'utils')

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Total Downloads**: 100.1K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/labgem/PPanGGOLiN
- **Stars**: N/A
### Original Help Text
```text
usage: ppanggolin [-h] [-v]  ...
ppanggolin: error: argument : invalid choice: 'ppanggolin' (choose from 'annotate', 'cluster', 'graph', 'partition', 'rarefaction', 'workflow', 'panrgp', 'panmodule', 'all', 'draw', 'write_pangenome', 'write_genomes', 'write_metadata', 'fasta', 'msa', 'metrics', 'align', 'rgp', 'spot', 'module', 'context', 'projection', 'rgp_cluster', 'metadata', 'info', 'utils')
```


## ppanggolin_all

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin all [-h] [--fasta FASTA] [--anno ANNO] [--clusters CLUSTERS]
                      [-o OUTPUT] [--basename BASENAME] [--rarefaction]
                      [-c CPU] [--translation_table TRANSLATION_TABLE]
                      [--kingdom {bacteria,archaea}] [--mode {0,1,2,3}]
                      [--coverage COVERAGE] [--identity IDENTITY]
                      [--infer_singletons] [--use_pseudo]
                      [-K NB_OF_PARTITIONS] [--no_defrag] [--no_flat_files]
                      [--tmpdir TMPDIR] [--verbose {0,1,2}] [--log LOG] [-d]
                      [-f] [--config CONFIG]

Input arguments:
  The possible input arguments :

  --fasta FASTA         A tab-separated file listing the genome names, and the fasta filepath of its genomic sequence(s) (the fastas can be compressed). One line per genome. This option can be used alone.
  --anno ANNO           A tab-separated file listing the genome names, and the gff filepath of its annotations (the gffs can be compressed). One line per genome. This option can be used alone IF the fasta sequences are in the gff files, otherwise --fasta needs to be used.
  --clusters CLUSTERS   a tab-separated file listing the cluster names, the gene IDs, and optionally whether they are a fragment or not.

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Output directory
  --basename BASENAME   basename for the output file
  --rarefaction         Use to compute the rarefaction curves (WARNING: can be time consuming)
  -c CPU, --cpu CPU     Number of available cpus
  --translation_table TRANSLATION_TABLE
                        Translation table (genetic code) to use.
  --kingdom {bacteria,archaea}
                        Kingdom to which the prokaryota belongs to, to know which models to use for rRNA annotation.
  --mode {0,1,2,3}      the cluster mode of MMseqs2. 0: Setcover, 1: single linkage (or connected component), 2: CD-HIT-like, 3: CD-HIT-like (lowmem)
  --coverage COVERAGE   Minimal coverage of the alignment for two proteins to be in the same cluster
  --identity IDENTITY   Minimal identity percent for two proteins to be in the same cluster
  --infer_singletons    Use this option together with --clusters. If a gene is not present in the provided clustering result file, it will be assigned to its own unique cluster as a singleton.
  --use_pseudo          In the context of provided annotation, use this option to read pseudogenes. (Default behavior is to ignore them)
  -K NB_OF_PARTITIONS, --nb_of_partitions NB_OF_PARTITIONS
                        Number of partitions to use. Must be at least 2. If under 2, it will be detected automatically.
  --no_defrag           DO NOT Realign gene families to link fragments with their non-fragmented gene family.
  --no_flat_files       Generate only the HDF5 pangenome file.
  --tmpdir TMPDIR       directory for storing temporary files

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_workflow

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin workflow [-h] [--fasta FASTA] [--anno ANNO]
                           [--clusters CLUSTERS] [-o OUTPUT]
                           [--basename BASENAME] [--rarefaction] [-c CPU]
                           [--translation_table TRANSLATION_TABLE]
                           [--kingdom {bacteria,archaea}] [--mode {0,1,2,3}]
                           [--coverage COVERAGE] [--identity IDENTITY]
                           [--infer_singletons] [--use_pseudo]
                           [-K NB_OF_PARTITIONS] [--no_defrag]
                           [--no_flat_files] [--tmpdir TMPDIR]
                           [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                           [--config CONFIG]

Input arguments:
  The possible input arguments :

  --fasta FASTA         A tab-separated file listing the genome names, and the fasta filepath of its genomic sequence(s) (the fastas can be compressed). One line per genome. This option can be used alone.
  --anno ANNO           A tab-separated file listing the genome names, and the gff filepath of its annotations (the gffs can be compressed). One line per genome. This option can be used alone IF the fasta sequences are in the gff files, otherwise --fasta needs to be used.
  --clusters CLUSTERS   a tab-separated file listing the cluster names, the gene IDs, and optionally whether they are a fragment or not.

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Output directory
  --basename BASENAME   basename for the output file
  --rarefaction         Use to compute the rarefaction curves (WARNING: can be time consuming)
  -c CPU, --cpu CPU     Number of available cpus
  --translation_table TRANSLATION_TABLE
                        Translation table (genetic code) to use.
  --kingdom {bacteria,archaea}
                        Kingdom to which the prokaryota belongs to, to know which models to use for rRNA annotation.
  --mode {0,1,2,3}      the cluster mode of MMseqs2. 0: Setcover, 1: single linkage (or connected component), 2: CD-HIT-like, 3: CD-HIT-like (lowmem)
  --coverage COVERAGE   Minimal coverage of the alignment for two proteins to be in the same cluster
  --identity IDENTITY   Minimal identity percent for two proteins to be in the same cluster
  --infer_singletons    Use this option together with --clusters. If a gene is not present in the provided clustering result file, it will be assigned to its own unique cluster as a singleton.
  --use_pseudo          In the context of provided annotation, use this option to read pseudogenes. (Default behavior is to ignore them)
  -K NB_OF_PARTITIONS, --nb_of_partitions NB_OF_PARTITIONS
                        Number of partitions to use. Must be at least 2. If under 2, it will be detected automatically.
  --no_defrag           DO NOT Realign gene families to link fragments with their non-fragmented gene family.
  --no_flat_files       Generate only the HDF5 pangenome file.
  --tmpdir TMPDIR       directory for storing temporary files

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732
```


## ppanggolin_panrgp

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin panrgp [-h] [--fasta FASTA] [--anno ANNO]
                         [--clusters CLUSTERS] [-o OUTPUT]
                         [--basename BASENAME] [--rarefaction] [-c CPU]
                         [--translation_table TRANSLATION_TABLE]
                         [--kingdom {bacteria,archaea}] [--mode {0,1,2,3}]
                         [--coverage COVERAGE] [--identity IDENTITY]
                         [--infer_singletons] [--use_pseudo]
                         [-K NB_OF_PARTITIONS] [--no_defrag] [--no_flat_files]
                         [--tmpdir TMPDIR] [--verbose {0,1,2}] [--log LOG]
                         [-d] [-f] [--config CONFIG]

Input arguments:
  The possible input arguments :

  --fasta FASTA         A tab-separated file listing the genome names, and the fasta filepath of its genomic sequence(s) (the fastas can be compressed). One line per genome. This option can be used alone.
  --anno ANNO           A tab-separated file listing the genome names, and the gff filepath of its annotations (the gffs can be compressed). One line per genome. This option can be used alone IF the fasta sequences are in the gff files, otherwise --fasta needs to be used.
  --clusters CLUSTERS   a tab-separated file listing the cluster names, the gene IDs, and optionally whether they are a fragment or not.

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Output directory
  --basename BASENAME   basename for the output file
  --rarefaction         Use to compute the rarefaction curves (WARNING: can be time consuming)
  -c CPU, --cpu CPU     Number of available cpus
  --translation_table TRANSLATION_TABLE
                        Translation table (genetic code) to use.
  --kingdom {bacteria,archaea}
                        Kingdom to which the prokaryota belongs to, to know which models to use for rRNA annotation.
  --mode {0,1,2,3}      the cluster mode of MMseqs2. 0: Setcover, 1: single linkage (or connected component), 2: CD-HIT-like, 3: CD-HIT-like (lowmem)
  --coverage COVERAGE   Minimal coverage of the alignment for two proteins to be in the same cluster
  --identity IDENTITY   Minimal identity percent for two proteins to be in the same cluster
  --infer_singletons    Use this option together with --clusters. If a gene is not present in the provided clustering result file, it will be assigned to its own unique cluster as a singleton.
  --use_pseudo          In the context of provided annotation, use this option to read pseudogenes. (Default behavior is to ignore them)
  -K NB_OF_PARTITIONS, --nb_of_partitions NB_OF_PARTITIONS
                        Number of partitions to use. Must be at least 2. If under 2, it will be detected automatically.
  --no_defrag           DO NOT Realign gene families to link fragments with their non-fragmented gene family.
  --no_flat_files       Generate only the HDF5 pangenome file.
  --tmpdir TMPDIR       directory for storing temporary files

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792
```


## ppanggolin_panmodule

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin panmodule [-h] [--fasta FASTA] [--anno ANNO]
                            [--clusters CLUSTERS] [-o OUTPUT]
                            [--basename BASENAME] [--rarefaction] [-c CPU]
                            [--translation_table TRANSLATION_TABLE]
                            [--kingdom {bacteria,archaea}] [--mode {0,1,2,3}]
                            [--coverage COVERAGE] [--identity IDENTITY]
                            [--infer_singletons] [--use_pseudo]
                            [-K NB_OF_PARTITIONS] [--no_defrag]
                            [--no_flat_files] [--tmpdir TMPDIR]
                            [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                            [--config CONFIG]

Input arguments:
  The possible input arguments :

  --fasta FASTA         A tab-separated file listing the genome names, and the fasta filepath of its genomic sequence(s) (the fastas can be compressed). One line per genome. This option can be used alone.
  --anno ANNO           A tab-separated file listing the genome names, and the gff filepath of its annotations (the gffs can be compressed). One line per genome. This option can be used alone IF the fasta sequences are in the gff files, otherwise --fasta needs to be used.
  --clusters CLUSTERS   a tab-separated file listing the cluster names, the gene IDs, and optionally whether they are a fragment or not.

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Output directory
  --basename BASENAME   basename for the output file
  --rarefaction         Use to compute the rarefaction curves (WARNING: can be time consuming)
  -c CPU, --cpu CPU     Number of available cpus
  --translation_table TRANSLATION_TABLE
                        Translation table (genetic code) to use.
  --kingdom {bacteria,archaea}
                        Kingdom to which the prokaryota belongs to, to know which models to use for rRNA annotation.
  --mode {0,1,2,3}      the cluster mode of MMseqs2. 0: Setcover, 1: single linkage (or connected component), 2: CD-HIT-like, 3: CD-HIT-like (lowmem)
  --coverage COVERAGE   Minimal coverage of the alignment for two proteins to be in the same cluster
  --identity IDENTITY   Minimal identity percent for two proteins to be in the same cluster
  --infer_singletons    Use this option together with --clusters. If a gene is not present in the provided clustering result file, it will be assigned to its own unique cluster as a singleton.
  --use_pseudo          In the context of provided annotation, use this option to read pseudogenes. (Default behavior is to ignore them)
  -K NB_OF_PARTITIONS, --nb_of_partitions NB_OF_PARTITIONS
                        Number of partitions to use. Must be at least 2. If under 2, it will be detected automatically.
  --no_defrag           DO NOT Realign gene families to link fragments with their non-fragmented gene family.
  --no_flat_files       Generate only the HDF5 pangenome file.
  --tmpdir TMPDIR       directory for storing temporary files

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_annotate

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin annotate [-h] [--fasta FASTA] [--anno ANNO] [-o OUTPUT]
                           [--allow_overlap] [--norna]
                           [--kingdom {bacteria,archaea}]
                           [--translation_table TRANSLATION_TABLE]
                           [--basename BASENAME] [--use_pseudo]
                           [-p {single,meta}] [-c CPU] [--tmpdir TMPDIR]
                           [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                           [--config CONFIG]

Required arguments:
  One of the following arguments is required :

  --fasta FASTA         A tab-separated file listing the genome names, and the fasta filepath of its genomic sequence(s) (the fastas can be compressed with gzip). One line per genome.
  --anno ANNO           A tab-separated file listing the genome names, and the gff/gbff filepath of its annotations (the files can be compressed with gzip). One line per genome. If this is provided, those annotations will be used.

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Output directory
  --allow_overlap       Use to not remove genes overlapping with RNA features.
  --norna               Use to avoid annotating RNA features.
  --kingdom {bacteria,archaea}
                        Kingdom to which the prokaryota belongs to, to know which models to use for rRNA annotation.
  --translation_table TRANSLATION_TABLE
                        Translation table (genetic code) to use.
  --basename BASENAME   basename for the output file
  --use_pseudo          In the context of provided annotation, use this option to read pseudogenes. (Default behavior is to ignore them)
  -p {single,meta}, --prodigal_procedure {single,meta}
                        Allow to force the prodigal procedure. If nothing given, PPanGGOLiN will decide in function of contig length
  -c CPU, --cpu CPU     Number of available cpus
  --tmpdir TMPDIR       directory for storing temporary files

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732
```


## ppanggolin_cluster

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin cluster [-h] [-p PANGENOME] [--identity IDENTITY]
                          [--coverage COVERAGE] [--mode {0,1,2,3}]
                          [--no_defrag] [--clusters CLUSTERS]
                          [--infer_singletons]
                          [--translation_table TRANSLATION_TABLE] [-c CPU]
                          [--tmpdir TMPDIR] [--keep_tmp] [--verbose {0,1,2}]
                          [--log LOG] [-d] [-f] [--config CONFIG]

Required arguments:
  One of the following arguments is required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file

Clustering arguments:
  --identity IDENTITY   Minimal identity percent for two proteins to be in the same cluster
  --coverage COVERAGE   Minimal coverage of the alignment for two proteins to be in the same cluster
  --mode {0,1,2,3}      the cluster mode of MMseqs2. 0: Setcover, 1: single linkage (or connected component), 2: CD-HIT-like, 3: CD-HIT-like (lowmem)
  --no_defrag           DO NOT Use the defragmentation strategy to link potential fragments with their original gene family.

Read clustering arguments:
  --clusters CLUSTERS   A tab-separated list containing the result of a clustering. One line per gene. First column is cluster ID, and second is gene ID
  --infer_singletons    When reading a clustering result with --clusters, if a gene is not in the provided file it will be placed in a cluster where the gene is the only member.

Optional arguments:
  --translation_table TRANSLATION_TABLE
                        Translation table (genetic code) to use.
  -c CPU, --cpu CPU     Number of available cpus
  --tmpdir TMPDIR       directory for storing temporary files
  --keep_tmp            Keeping temporary files (useful for debugging).

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732
```


## ppanggolin_graph

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin graph [-h] [-p PANGENOME] [-r REMOVE_HIGH_COPY_NUMBER]
                        [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                        [--config CONFIG]

Required arguments:
  Following arguments is required:

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file

Optional arguments:
  -r REMOVE_HIGH_COPY_NUMBER, --remove_high_copy_number REMOVE_HIGH_COPY_NUMBER
                        Positive Number: Remove families having a number of copy of gene in a single genome above or equal to this threshold in at least one genome (0 or negative values are ignored).

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732
```


## ppanggolin_partition

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin partition [-h] [-p PANGENOME] [-b BETA]
                            [-ms MAX_DEGREE_SMOOTHING] [-o OUTPUT] [-fd]
                            [-ck CHUNK_SIZE] [-K NB_OF_PARTITIONS]
                            [-Kmm KRANGE KRANGE] [-im ICL_MARGIN] [--draw_ICL]
                            [--keep_tmp_files] [-se SEED] [-c CPU]
                            [--tmpdir TMPDIR] [--verbose {0,1,2}] [--log LOG]
                            [-d] [-f] [--config CONFIG]

Required arguments:
  One of the following arguments is required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome.h5 file

Optional arguments:
  -b BETA, --beta BETA  beta is the strength of the smoothing using the graph topology during partitioning. 0 will deactivate spatial smoothing.
  -ms MAX_DEGREE_SMOOTHING, --max_degree_smoothing MAX_DEGREE_SMOOTHING
                        max. degree of the nodes to be included in the smoothing process.
  -o OUTPUT, --output OUTPUT
                        Output directory
  -fd, --free_dispersion
                        use if the dispersion around the centroid vector of each partition during must be free. It will be the same for all genomes by default.
  -ck CHUNK_SIZE, --chunk_size CHUNK_SIZE
                        Size of the chunks when performing partitioning using chunks of genomes. Chunk partitioning will be used automatically if the number of genomes is above this number.
  -K NB_OF_PARTITIONS, --nb_of_partitions NB_OF_PARTITIONS
                        Number of partitions to use. Must be at least 2. If under 2, it will be detected automatically.
  -Kmm KRANGE KRANGE, --krange KRANGE KRANGE
                        Range of K values to test when detecting K automatically.
  -im ICL_MARGIN, --ICL_margin ICL_MARGIN
                        K is detected automatically by maximizing ICL. However at some point the ICL reaches a plateau. Therefore we are looking for the minimal value of K without significant gain from the larger values of K measured by ICL. For that we take the lowest K that is found within a given 'margin' of the maximal ICL value. Basically, change this option only if you truly understand it, otherwise just leave it be.
  --draw_ICL            Use if you want to draw the ICL curve for all the tested K values. Will not be done if K is given.
  --keep_tmp_files      Use if you want to keep the temporary NEM files
  -se SEED, --seed SEED
                        seed used to generate random numbers
  -c CPU, --cpu CPU     Number of available cpus
  --tmpdir TMPDIR       directory for storing temporary files

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732
```


## ppanggolin_rarefaction

### Tool Description
Compute the rarefaction curve of the pangenome

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin rarefaction [-h] [-p PANGENOME] [-b BETA] [--depth DEPTH]
                              [--min MIN] [--max MAX]
                              [-ms MAX_DEGREE_SMOOTHING] [-o OUTPUT] [-fd]
                              [-ck CHUNK_SIZE] [-K NB_OF_PARTITIONS]
                              [--reestimate_K] [-Kmm KRANGE KRANGE]
                              [--soft_core SOFT_CORE] [-se SEED] [-c CPU]
                              [--tmpdir TMPDIR] [--verbose {0,1,2}]
                              [--log LOG] [-d] [-f] [--config CONFIG]

Compute the rarefaction curve of the pangenome

Required arguments:
  One of the following arguments is required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file

Optional arguments:
  -b BETA, --beta BETA  beta is the strength of the smoothing using the graph topology during  partitioning. 0 will deactivate spatial smoothing.
  --depth DEPTH         Number of samplings at each sampling point
  --min MIN             Minimum number of genomes in a sample
  --max MAX             Maximum number of genomes in a sample (if above the number of provided genomes, the provided genomes will be the maximum)
  -ms MAX_DEGREE_SMOOTHING, --max_degree_smoothing MAX_DEGREE_SMOOTHING
                        max. degree of the nodes to be included in the smoothing process.
  -o OUTPUT, --output OUTPUT
                        Output directory
  -fd, --free_dispersion
                        use if the dispersion around the centroid vector of each partition during must be free. It will be the same for all genomes by default.
  -ck CHUNK_SIZE, --chunk_size CHUNK_SIZE
                        Size of the chunks when performing partitioning using chunks of genomes. Chunk partitioning will be used automatically if the number of genomes is above this number.
  -K NB_OF_PARTITIONS, --nb_of_partitions NB_OF_PARTITIONS
                        Number of partitions to use. Must be at least 2. By default reuse K if it exists else compute it.
  --reestimate_K         Will recompute the number of partitions for each sample (between the values provided by --krange) (VERY intensive. Can take a long time.)
  -Kmm KRANGE KRANGE, --krange KRANGE KRANGE
                        Range of K values to test when detecting K automatically. Default between 3 and the K previously computed if there is one, or 20 if there are none.
  --soft_core SOFT_CORE
                        Soft core threshold
  -se SEED, --seed SEED
                        seed used to generate random numbers
  -c CPU, --cpu CPU     Number of available cpus
  --tmpdir TMPDIR       directory for storing temporary files

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732
```


## ppanggolin_metadata

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin metadata [-h] [-p PANGENOME] [-m [METADATA]] [-s [SOURCE]]
                           [-a [{families,genomes,contigs,genes,RGPs,spots,modules}]]
                           [--omit] [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                           [--config CONFIG]

Required arguments:
  All of the following arguments are required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file
  -m [METADATA], --metadata [METADATA]
                        Metadata in TSV file. See our github for more detail about format
  -s [SOURCE], --source [SOURCE]
                        Name of the metadata source
  -a [{families,genomes,contigs,genes,RGPs,spots,modules}], --assign [{families,genomes,contigs,genes,RGPs,spots,modules}]
                        Select to which pangenome element metadata will be assigned

Optional arguments:
  --omit                Allow to pass if a key in metadata is not find in pangenome

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_draw

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin draw [-h] [-p PANGENOME] [-o OUTPUT] [--tile_plot]
                       [--soft_core SOFT_CORE] [--ucurve] [--draw_spots]
                       [--spots SPOTS [SPOTS ...]] [--nocloud]
                       [--add_dendrogram] [--add_metadata]
                       [--metadata_sources METADATA_SOURCES [METADATA_SOURCES ...]]
                       [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                       [--config CONFIG]

Required arguments:
  One of the following arguments is required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome.h5 file

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Output directory
  --tile_plot           draw the tile plot of the pangenome
  --soft_core SOFT_CORE
                        Soft core threshold to use
  --ucurve              draw the U-curve of the pangenome
  --draw_spots          draw plots for spots of the pangenome
  --spots SPOTS [SPOTS ...]
                        a comma-separated list of spots to draw (or 'all' to draw all spots, or 'synteny' to draw spots with different RGP syntenies).
  --nocloud             Do not draw the cloud genes in the tile plot
  --add_dendrogram      Include a dendrogram for genomes in the tile plot based on the presence/absence of gene families.
  --add_metadata        Display gene metadata as hover text for each cell in the tile plot.
  --metadata_sources METADATA_SOURCES [METADATA_SOURCES ...]
                        Which source of metadata should be written in the tile plot. By default all metadata sources are included.

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_write_pangenome

### Tool Description
Write pangenome data to various formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin write_pangenome [-h] [-p PANGENOME] -o OUTPUT
                                  [--soft_core SOFT_CORE]
                                  [--dup_margin DUP_MARGIN] [--gexf]
                                  [--light_gexf] [--json] [--csv] [--Rtab]
                                  [--stats] [--partitions] [--families_tsv]
                                  [--regions] [--regions_families] [--spots]
                                  [--borders] [--modules] [--spot_modules]
                                  [--compress] [-c CPU] [--verbose {0,1,2}]
                                  [--log LOG] [-d] [-f] [--config CONFIG]

Required arguments:
  One of the following arguments is required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file
  -o OUTPUT, --output OUTPUT
                        Output directory where the file(s) will be written

Optional arguments:
  --soft_core SOFT_CORE
                        Soft core threshold to use
  --dup_margin DUP_MARGIN
                        Minimum ratio of genomes in which the family must have multiple genes for it to be considered 'duplicated'
  --gexf                Generate a detailed GEXF file with all genes and annotations for each family
  --light_gexf          Generate a simplified GEXF file with basic gene family information
  --json                Export the graph in JSON file format
  --csv                 Export gene presence/absence in CSV format (compatible with Roary). Uses partitions as alternative gene IDs if available.
  --Rtab                Export gene presence/absence as a tabular binary matrix
  --stats               Generate genome statistics ('genome_statistics.tsv') and duplication summary of persistent families ('mean_persistent_duplication.tsv')
  --partitions          Generate one file per partition listing the gene families it contains
  --families_tsv        Write a TSV file mapping genes to their corresponding gene families
  --regions             Write predicted RGPs (Regions of Genomic Plasticity) and metrics to 'plastic_regions.tsv'
  --regions_families    Write a TSV file mapping each RGP to its gene family content in 'rgp_families.tsv'
  --spots               Write spot summary and list all RGPs (Regions of Genomic Plasticity) per spot
  --borders             List all borders of each spot
  --modules             Write a TSV file listing functional modules and their associated gene families
  --spot_modules        Generate two files comparing module presence across spots
  --compress            Compress output files using gzip (.gz)
  -c CPU, --cpu CPU     Number of available cpus

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_write_genomes

### Tool Description
Write genomes from a pangenome analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin write_genomes [-h] [-p PANGENOME] -o OUTPUT [--table]
                                [--gff] [--proksee] [--compress]
                                [--genomes GENOMES] [--add_metadata]
                                [--metadata_sources METADATA_SOURCES [METADATA_SOURCES ...]]
                                [--metadata_sep METADATA_SEP] [-c CPU]
                                [--fasta FASTA] [--anno ANNO]
                                [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                                [--config CONFIG]

Required arguments:
  One of the following arguments is required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file
  -o OUTPUT, --output OUTPUT
                        Output directory where the file(s) will be written

Optional arguments:
  --table               Generate a tsv file for each genome with pangenome annotations.
  --gff                 Generate a gff file for each genome containing pangenome annotations.
  --proksee             Generate JSON map files for PROKSEE for each genome containing pangenome annotations to be used in proksee.
  --compress            Compress the files in .gz
  --genomes GENOMES     Specify the genomes for which to generate output. You can provide a list of genome names either directly in the command line separated by commas, or by referencing a file containing the list of genome names, with one name per line.
  --add_metadata        Include metadata information in the output files if any have been added to pangenome elements (see ppanggolin metadata command).
  --metadata_sources METADATA_SOURCES [METADATA_SOURCES ...]
                        Which source of metadata should be written. By default all metadata sources are included.
  --metadata_sep METADATA_SEP
                        The separator used to join multiple metadata values for elements with multiple metadata values from the same source. This character should not appear in metadata values.
  -c CPU, --cpu CPU     Number of available cpus

Contextually required arguments:
  With --proksee and --gff, the following arguments can be used to add sequence information to the output file:

  --fasta FASTA         A tab-separated file listing the genome names, and the fasta filepath of its genomic sequence(s) (the fastas can be compressed with gzip). One line per genome.
  --anno ANNO           A tab-separated file listing the genome names, and the gff/gbff filepath of its annotations (the files can be compressed with gzip). One line per genome. If this is provided, those annotations will be used.

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_write_metadata

### Tool Description
Write metadata for pangenome elements.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin write_metadata [-h] [-p PANGENOME] -o OUTPUT [--compress]
                                 [-e {spots,modules,families,genomes,RGPs,contigs,genes} [{spots,modules,families,genomes,RGPs,contigs,genes} ...]]
                                 [-s METADATA_SOURCES [METADATA_SOURCES ...]]
                                 [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                                 [--config CONFIG]

Required arguments:
  One of the following arguments is required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file
  -o OUTPUT, --output OUTPUT
                        Output directory where the file(s) will be written

Optional arguments:
  --compress            Compress the files in .gz
  -e {spots,modules,families,genomes,RGPs,contigs,genes} [{spots,modules,families,genomes,RGPs,contigs,genes} ...], --pangenome_elements {spots,modules,families,genomes,RGPs,contigs,genes} [{spots,modules,families,genomes,RGPs,contigs,genes} ...]
                        Specify pangenome elements for which to write metadata. default is all element with metadata. 
  -s METADATA_SOURCES [METADATA_SOURCES ...], --metadata_sources METADATA_SOURCES [METADATA_SOURCES ...]
                        Which source of metadata should be written. By default all metadata sources are included.

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_fasta

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin fasta [-h] [-p PANGENOME] -o OUTPUT [--fasta FASTA]
                        [--anno ANNO] [--genes GENES] [--proteins PROTEINS]
                        [--prot_families PROT_FAMILIES]
                        [--gene_families GENE_FAMILIES]
                        [--regions {all,complete}] [--soft_core SOFT_CORE]
                        [--compress] [--translation_table TRANSLATION_TABLE]
                        [--cpu CPU] [--tmpdir TMPDIR] [--keep_tmp]
                        [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                        [--config CONFIG]

Required arguments:
  One of the following arguments is required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file
  -o OUTPUT, --output OUTPUT
                        Output directory where the file(s) will be written

Contextually required arguments:
  With --regions, the following arguments are required:

  --fasta FASTA         A tab-separated file listing the genome names, and the fasta filepath of its genomic sequence(s) (the fastas can be compressed with gzip). One line per genome.
  --anno ANNO           A tab-separated file listing the genome names, and the gff/gbff filepath of its annotations (the files can be compressed with gzip). One line per genome. If this is provided, those annotations will be used.

Output file:
  At least one of the following argument is required. Indicating 'all' writes all elements. Writing a partition ('persistent', 'shell' or 'cloud') write the elements associated to said partition. Writing 'rgp' writes elements associated to RGPs

  --genes GENES         Write all nucleotide CDS sequences. Possible values are all, persistent, shell, cloud, rgp, softcore, core, module_X with X being a module id.
  --proteins PROTEINS   Write representative amino acid sequences of genes. Possible values are all, persistent, shell, cloud, rgp, softcore, core, module_X with X being a module id.
  --prot_families PROT_FAMILIES
                        Write representative amino acid sequences of gene families. Possible values are all, persistent, shell, cloud, rgp, softcore, core, module_X with X being a module id.
  --gene_families GENE_FAMILIES
                        Write representative nucleotide sequences of gene families. Possible values are all, persistent, shell, cloud, rgp, softcore, core, module_X with X being a module id.

Optional arguments:
  --regions {all,complete}
                        Write the RGP nucleotide sequences (requires --anno or --fasta used to compute the pangenome to be given)
  --soft_core SOFT_CORE
                        Soft core threshold to use if 'softcore' partition is chosen
  --compress            Compress the files in .gz
  --translation_table TRANSLATION_TABLE
                        Translation table (genetic code) to use.
  --cpu CPU             Number of available threads
  --tmpdir TMPDIR       directory for storing temporary files
  --keep_tmp            Keeping temporary files (useful for debugging).

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_info

### Tool Description
Show information about a pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin info [-h] -p PANGENOME [-a] [-c] [-s] [-m]

options:
  -h, --help            show this help message and exit

Required arguments:
  Specify the following required argument:

  -p PANGENOME, --pangenome PANGENOME
                        Path to the pangenome .h5 file

Information Display Options (default: all):
  -a, --parameters      Display the parameters used or computed for each step of pangenome generation
  -c, --content         Display detailed information about the pangenome's content
  -s, --status          Display information about the statuses of different elements in the pangenome, indicating what has been computed or not
  -m, --metadata        Display a summary of the metadata saved in the pangenome
```


## ppanggolin_metrics

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin metrics [-h] [-p PANGENOME] [--genome_fluidity]
                          [--no_print_info] [--recompute_metrics]
                          [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                          [--config CONFIG]

Required arguments:
  Specify the required argument:

  -p PANGENOME, --pangenome PANGENOME
                        Path to the pangenome .h5 file

Input file:
  Choose one of the following arguments:

  --genome_fluidity     Compute the pangenome genomic fluidity.

Optional arguments:
  Specify optional arguments with default values:

  --no_print_info       Suppress printing the metrics result. Metrics are saved in the pangenome and viewable using 'ppanggolin info'.
  --recompute_metrics   Force re-computation of metrics if already computed.

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_rgp

### Tool Description
For genomic islands and spots of insertion detection, please cite: Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity. Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin rgp [-h] [-p PANGENOME]
                      [--persistent_penalty PERSISTENT_PENALTY]
                      [--variable_gain VARIABLE_GAIN] [--min_score MIN_SCORE]
                      [--min_length MIN_LENGTH] [--dup_margin DUP_MARGIN]
                      [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                      [--config CONFIG]

Required arguments:
  One of the following arguments is required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file

Optional arguments:
  --persistent_penalty PERSISTENT_PENALTY
                        Penalty score to apply to persistent genes
  --variable_gain VARIABLE_GAIN
                        Gain score to apply to variable genes
  --min_score MIN_SCORE
                        Minimal score wanted for considering a region as being a RGP
  --min_length MIN_LENGTH
                        Minimum length (bp) of a region to be considered a RGP
  --dup_margin DUP_MARGIN
                        Minimum ratio of genomes where the family is present in which the family must have multiple genes for it to be considered 'duplicated'

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792
```


## ppanggolin_spot

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin spot [-h] [-p PANGENOME] [-o OUTPUT] [--spot_graph]
                       [--overlapping_match OVERLAPPING_MATCH]
                       [--set_size SET_SIZE]
                       [--exact_match_size EXACT_MATCH_SIZE]
                       [--graph_formats {gexf,graphml} [{gexf,graphml} ...]]
                       [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                       [--config CONFIG]

Required arguments:
  One of the following arguments is required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Output directory
  --spot_graph          Writes a graph of pairs of blocks of single copy markers flanking RGPs, supposedly belonging to the same hotspot
  --overlapping_match OVERLAPPING_MATCH
                        The number of 'missing' persistent genes allowed when comparing flanking genes during hotspot computations
  --set_size SET_SIZE   Number of single copy markers to use as flanking genes for a RGP during hotspot computation
  --exact_match_size EXACT_MATCH_SIZE
                        Number of perfectly matching flanking single copy markers required to associate RGPs during hotspot computation (Ex: If set to 1, two RGPs are in the same hotspot if both their 1st flanking genes are the same)
  --graph_formats {gexf,graphml} [{gexf,graphml} ...]
                        Format of the output graph.

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792
```


## ppanggolin_module

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin module [-h] [-p PANGENOME] [--size SIZE]
                         [--dup_margin DUP_MARGIN] [-m MIN_PRESENCE]
                         [-t TRANSITIVE] [-s JACCARD] [-c CPU]
                         [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                         [--config CONFIG]

Required arguments:
  One of the following arguments is required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file

Optional arguments:
  --size SIZE           Minimal number of gene family in a module
  --dup_margin DUP_MARGIN
                        minimum ratio of genomes in which the family must have multiple genes for it to be considered 'duplicated'
  -m MIN_PRESENCE, --min_presence MIN_PRESENCE
                        Minimum number of times the module needs to be present in the pangenome to be reported. Increasing it will improve precision but lower sensitivity.
  -t TRANSITIVE, --transitive TRANSITIVE
                        Size of the transitive closure used to build the graph. This indicates the number of non related genes allowed in-between two related genes. Increasing it will improve precision but lower sensitivity a little.
  -s JACCARD, --jaccard JACCARD
                        minimum jaccard similarity used to filter edges between gene families. Increasing it will improve precision but lower sensitivity a lot.
  -c CPU, --cpu CPU     Number of available cpus

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_rgp_cluster

### Tool Description
Cluster RGPs based on gene repertoire relatedness.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin rgp_cluster [-h] -p PANGENOME [--grr_cutoff GRR_CUTOFF]
                              [--grr_metric {incomplete_aware_grr,min_grr,max_grr}]
                              [--ignore_incomplete_rgp]
                              [--no_identical_rgp_merging]
                              [--basename BASENAME] [-o OUTPUT]
                              [--graph_formats {gexf,graphml} [{gexf,graphml} ...]]
                              [--add_metadata]
                              [--metadata_sources METADATA_SOURCES [METADATA_SOURCES ...]]
                              [--metadata_sep METADATA_SEP]
                              [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                              [--config CONFIG]

Required arguments:
  One of the following arguments is required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file

Optional arguments:
  --grr_cutoff GRR_CUTOFF
                        Min gene repertoire relatedness metric used in the rgp clustering
  --grr_metric {incomplete_aware_grr,min_grr,max_grr}
                        The grr (Gene Repertoire Relatedness) is used to assess the similarity between two RGPs based on their gene families.There are three different modes for calculating the grr value: 'min_grr', 'max_grr' or  'incomplete_aware_grr'.'min_grr': Computes the number of gene families shared between the two RGPs and divides it by the smaller number of gene families among the two RGPs.'max_grr': Calculates the number of gene families shared between the two RGPs and divides it by the larger number of gene families among the two RGPs.'incomplete_aware_grr' (default): If at least one RGP is considered incomplete, which occurs when it is located at the border of a contig,the 'min_grr' mode is used. Otherwise, the 'max_grr' mode is applied.
  --ignore_incomplete_rgp
                        Do not cluster RGPs located on a contig border which are likely incomplete.
  --no_identical_rgp_merging
                        Do not merge in one node identical RGP (i.e. having the same family content) before clustering.
  --basename BASENAME   basename for the output file
  -o OUTPUT, --output OUTPUT
                        Output directory
  --graph_formats {gexf,graphml} [{gexf,graphml} ...]
                        Format of the output graph.
  --add_metadata        Include metadata information in the output files if any have been added to pangenome elements (see ppanggolin metadata command).
  --metadata_sources METADATA_SOURCES [METADATA_SOURCES ...]
                        Which source of metadata should be written. By default all metadata sources are included.
  --metadata_sep METADATA_SEP
                        The separator used to join multiple metadata values for elements with multiple metadata values from the same source. This character should not appear in metadata values.

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792
```


## ppanggolin_msa

### Tool Description
compute Multiple Sequence Alignment of the gene families in the given partition

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin msa [-h] [-p PANGENOME] -o OUTPUT [--soft_core SOFT_CORE]
                      [--dup_margin DUP_MARGIN] [--single_copy]
                      [--partition {all,persistent,shell,cloud,core,accessory,softcore}]
                      [--source {dna,protein}] [--phylo] [--use_gene_id]
                      [--translation_table TRANSLATION_TABLE] [-c CPU]
                      [--tmpdir TMPDIR] [--verbose {0,1,2}] [--log LOG] [-d]
                      [-f] [--config CONFIG]

Required arguments:
  The following arguments are required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file
  -o OUTPUT, --output OUTPUT
                        Output directory where the file(s) will be written

Optional arguments. Indicating 'all' writes all elements. Writing a partition ('persistent', 'shell', 'cloud', 'core' or 'accessory') write the elements associated to said partition.:
  --soft_core SOFT_CORE
                        Soft core threshold to use if 'softcore' partition is chosen
  --dup_margin DUP_MARGIN
                        minimum ratio of genomes in which the family must have multiple genes for it to be considered 'duplicated'
  --single_copy         Use report gene families that are considered 'single copy', for details see option --dup_margin
  --partition {all,persistent,shell,cloud,core,accessory,softcore}
                        compute Multiple Sequence Alignment of the gene families in the given partition
  --source {dna,protein}
                        indicates whether to use protein or dna sequences to compute the msa
  --phylo               Writes a whole genome msa file for additional phylogenetic analysis
  --use_gene_id         Use gene identifiers rather than genome names for sequences in the family MSA (genome names are used by default)
  --translation_table TRANSLATION_TABLE
                        Translation table (genetic code) to use.
  -c CPU, --cpu CPU     Number of available cpus
  --tmpdir TMPDIR       directory for storing temporary files

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_align

### Tool Description
Align sequences (nucleotides or amino acids) on the pangenome gene families.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin align [-h] [-S SEQUENCES] [-p PANGENOME] -o OUTPUT
                        [--no_defrag] [--identity IDENTITY]
                        [--coverage COVERAGE] [--fast]
                        [--translation_table TRANSLATION_TABLE] [--getinfo]
                        [--draw_related] [--use_pseudo] [-c CPU]
                        [--tmpdir TMPDIR] [--keep_tmp] [--verbose {0,1,2}]
                        [--log LOG] [-d] [-f] [--config CONFIG]

Required arguments:
  All of the following arguments are required :

  -S SEQUENCES, --sequences SEQUENCES
                        sequences (nucleotides or amino acids) to align on the pangenome gene families
  -p PANGENOME, --pangenome PANGENOME
                        The pangenome .h5 file
  -o OUTPUT, --output OUTPUT
                        Output directory where the file(s) will be written

Optional arguments:
  --no_defrag           DO NOT Realign gene families to link fragments withtheir non-fragmented gene family. (default: False)
  --identity IDENTITY   min identity percentage threshold
  --coverage COVERAGE   min coverage percentage threshold
  --fast                Use representative sequences of gene families for input gene alignment. This option is faster but may be less sensitive. By default, all pangenome genes are used.
  --translation_table TRANSLATION_TABLE
                        Translation table (genetic code) to use.
  --getinfo             Use this option to extract info related to the best hit of each query, such as the RGP it is in, or the spots.
  --draw_related        Draw figures and provide graphs in a gexf format of the eventual spots associated to the input sequences
  --use_pseudo          In the context of provided annotation, use this option to read pseudogenes. (Default behavior is to ignore them)
  -c CPU, --cpu CPU     Number of available cpus
  --tmpdir TMPDIR       directory for storing temporary files
  --keep_tmp            Keeping temporary files (useful for debugging).

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_context

### Tool Description
PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin context [-h] [-p PANGENOME] [-o OUTPUT] [-S SEQUENCES]
                          [-F FAMILY] [-t TRANSITIVE] [-w WINDOW_SIZE]
                          [-s JACCARD] [--graph_format {gexf,graphml}]
                          [--no_defrag] [--fast] [--identity IDENTITY]
                          [--coverage COVERAGE]
                          [--translation_table TRANSLATION_TABLE]
                          [--tmpdir TMPDIR] [--keep_tmp] [-c CPU]
                          [--verbose {0,1,2}] [--log LOG] [-d] [-f]
                          [--config CONFIG]

Required arguments:
  All of the following arguments are required :

  -p PANGENOME, --pangenome PANGENOME
                        The pangenome.h5 file
  -o OUTPUT, --output OUTPUT
                        Output directory where the file(s) will be written

Input file:
  One of the following argument is required :

  -S SEQUENCES, --sequences SEQUENCES
                        Fasta file with the sequences of interest
  -F FAMILY, --family FAMILY
                        List of family IDs of interest from the pangenome

Optional arguments:
  -t TRANSITIVE, --transitive TRANSITIVE
                        Size of the transitive closure used to build the graph. This indicates the number of non related genes allowed in-between two related genes. Increasing it will improve precision but lower sensitivity a little.
  -w WINDOW_SIZE, --window_size WINDOW_SIZE
                        Number of neighboring genes that are considered on each side of a gene of interest when searching for conserved genomic contexts.
  -s JACCARD, --jaccard JACCARD
                        minimum jaccard similarity used to filter edges between gene families. Increasing it will improve precision but lower sensitivity a lot.
  --graph_format {gexf,graphml}
                        Format of the context graph. Can be gexf or graphml.

Alignment arguments:
  This argument makes sense only when --sequence is provided.

  --no_defrag           DO NOT Realign gene families to link fragments withtheir non-fragmented gene family.
  --fast                Use representative sequences of gene families for input gene alignment. This option is recommended for faster processing but may be less sensitive. By default, all pangenome genes are used for alignment.
  --identity IDENTITY   min identity percentage threshold
  --coverage COVERAGE   min coverage percentage threshold
  --translation_table TRANSLATION_TABLE
                        The translation table to use when the input sequences are nucleotide sequences. 
  --tmpdir TMPDIR       directory for storing temporary files
  --keep_tmp            Keeping temporary files (useful for debugging).
  -c CPU, --cpu CPU     Number of available cpus

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_projection

### Tool Description
Project pangenome annotations onto input genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin projection [-h] [-p PANGENOME] [--fasta FASTA] [--anno ANNO]
                             [-n GENOME_NAME]
                             [--circular_contigs CIRCULAR_CONTIGS [CIRCULAR_CONTIGS ...]]
                             [-o OUTPUT] [--no_defrag] [--fast]
                             [--identity IDENTITY] [--coverage COVERAGE]
                             [--use_pseudo] [--dup_margin DUP_MARGIN]
                             [--soft_core SOFT_CORE] [--spot_graph]
                             [--graph_formats {gexf,graphml} [{gexf,graphml} ...]]
                             [--gff] [--proksee] [--table] [--compress]
                             [--add_sequences] [-c CPU] [--tmpdir TMPDIR]
                             [--keep_tmp] [--add_metadata]
                             [--metadata_sources METADATA_SOURCES [METADATA_SOURCES ...]]
                             [--metadata_sep METADATA_SEP] [--verbose {0,1,2}]
                             [--log LOG] [-d] [-f] [--config CONFIG]

Required arguments:
  -p PANGENOME, --pangenome PANGENOME
                        The pangenome.h5 file
  --fasta FASTA         Specify a FASTA file containing the genomic sequences of the genome(s) you wish to annotate, or provide a tab-separated file listing genome names alongside their respective FASTA filepaths, with one line per genome.
  --anno ANNO           Specify an annotation file in GFF/GBFF format for the genome you wish to annotate. Alternatively, you can provide a tab-separated file listing genome names alongside their respective annotation filepaths, with one line per genome. If both an annotation file and a FASTA file are provided, the annotation file will take precedence.

Single Genome Arguments:
  Use these options when providing a single FASTA or annotation file:

  -n GENOME_NAME, --genome_name GENOME_NAME
                        Specify the name of the genome whose genome you want to annotate when providing a single FASTA or annotation file.
  --circular_contigs CIRCULAR_CONTIGS [CIRCULAR_CONTIGS ...]
                        Specify the contigs of the input genome that should be treated as circular when providing a single FASTA or annotation file.

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Output directory
  --no_defrag           DO NOT Realign gene families to link fragments with their non-fragmented gene family. (default: False)
  --fast                Use representative sequences of gene families for input gene alignment. This option is faster but may be less sensitive. By default, all pangenome genes are used.
  --identity IDENTITY   min identity percentage threshold
  --coverage COVERAGE   min coverage percentage threshold
  --use_pseudo          In the context of provided annotation, use this option to read pseudogenes. (Default behavior is to ignore them)
  --dup_margin DUP_MARGIN
                        minimum ratio of genomes in which the family must have multiple genes for it to be considered 'duplicated'. This metric is used to compute completeness and duplication of the input genomes
  --soft_core SOFT_CORE
                        Soft core threshold used when generating general statistics on the projected genome. This threshold does not influence PPanGGOLiN's partitioning. The value determines the minimum fraction of genomes that must possess a gene family for it to be considered part of the soft core.
  --spot_graph          Write the spot graph to a file, with pairs of blocks of single copy markers flanking RGPs as nodes. This graph can be used to visualize nodes that have RGPs from the input genome.
  --graph_formats {gexf,graphml} [{gexf,graphml} ...]
                        Format of the output graph.
  --gff                 Generate GFF files with projected pangenome annotations for each input genome.
  --proksee             Generate JSON map files for PROKSEE with projected pangenome annotations for each input genome.
  --table               Generate a tsv file for each input genome with pangenome annotations.
  --compress            Compress the files in .gz
  --add_sequences       Include input genome DNA sequences in GFF and Proksee output.
  -c CPU, --cpu CPU     Number of available cpus
  --tmpdir TMPDIR       directory for storing temporary files
  --keep_tmp            Keeping temporary files (useful for debugging).
  --add_metadata        Include metadata information in the output files if any have been added to pangenome elements (see ppanggolin metadata command).
  --metadata_sources METADATA_SOURCES [METADATA_SOURCES ...]
                        Which source of metadata should be written. By default all metadata sources are included.
  --metadata_sep METADATA_SEP
                        The separator used to join multiple metadata values for elements with multiple metadata values from the same source. This character should not appear in metadata values.

Common arguments:
  -h, --help            show this help message and exit
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -d, --disable_prog_bar
                        disables the progress bars
  -f, --force           Force writing in output directory and in pangenome output file.
  --config CONFIG       Specify command arguments through a YAML configuration file.

PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement.

For pangenome analyses, please cite:
Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732

For genomic islands and spots of insertion detection, please cite:
Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity.
Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792

For module prediction, please cite:
Bazin A et al. (2021) panModule: detecting conserved modules in the variable regions of a pangenome graph.
bioRxiv. https://doi.org/10.1101/2021.12.06.471380
```


## ppanggolin_utils

### Tool Description
Generate a config file with default values for the given subcommand.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
- **Homepage**: https://github.com/labgem/PPanGGOLiN
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanggolin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanggolin utils [-h]
                        [--default_config {annotate,cluster,graph,partition,rarefaction,workflow,panrgp,panmodule,all,draw,write_pangenome,write_genomes,write_metadata,fasta,msa,metrics,align,rgp,spot,module,context,projection,rgp_cluster,metadata}]
                        [-o OUTPUT] [--verbose {0,1,2}] [--log LOG] [-f]

options:
  -h, --help            show this help message and exit

Required arguments:
  All of the following arguments are required :

  --default_config {annotate,cluster,graph,partition,rarefaction,workflow,panrgp,panmodule,all,draw,write_pangenome,write_genomes,write_metadata,fasta,msa,metrics,align,rgp,spot,module,context,projection,rgp_cluster,metadata}
                        Generate a config file with default values for the given subcommand.

Config arguments:
  -o OUTPUT, --output OUTPUT
                        name and path of the config file with default parameters written in yaml.
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only, 1 for info, 2 for debug)
  --log LOG             log output file
  -f, --force           Overwrite the given output file if it exists.
```


## Metadata
- **Skill**: generated

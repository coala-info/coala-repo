# panorama CWL Generation Report

## panorama_panorama

### Tool Description
Panorama tool for various bioinformatics tasks.

### Metadata
- **Docker Image**: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/panorama
- **Package**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Total Downloads**: 153
- **Last updated**: 2026-01-21
- **GitHub**: https://github.com/labgem/panorama
- **Stars**: N/A
### Original Help Text
```text
usage: panorama [-h] [-v]  ...
panorama: error: argument : invalid choice: 'panorama' (choose from info, annotation, systems, align, cluster, compare_context, compare_systems, compare_spots, write, write_systems, pansystems, utils)
```


## panorama_annotation

### Tool Description
Perform annotation of pangenomes using various sources like tables or HMM profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/panorama
- **Package**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panorama annotation [-h] -p [PANGENOMES] -s [SOURCE]
                           (--table TABLE | --hmm [HMM])
                           [--mode {fast,profile,sensitive}]
                           [--k_best_hit K_BEST_HIT] [-b] [--msa MSA]
                           [--save_hits [{tblout,domtblout,pfamtblout} ...]]
                           [-Z [Z]] [-o [OUTPUT]] [--keep_tmp] [--tmp [TMP]]
                           [--threads [THREADS]] [--verbose {0,1,2}]
                           [--log LOG] [-d] [--force]

    ____     ___     _   __   ____     ____     ___     __  ___    ___ 
   / __ \   /   |   / | / /  / __ \   / __ \   /   |   /  |/  /   /   |
  / /_/ /  / /| |  /  |/ /  / / / /  / /_/ /  / /| |  / /|_/ /   / /| |
 / ____/  / ___ | / /|  /  / /_/ /  / _, _/  / ___ | / /  / /   / ___ |
/_/      /_/  |_|/_/ |_/   \____/  /_/ |_|  /_/  |_|/_/  /_/   /_/  |_|

options:
  -h, --help            show this help message and exit

Required arguments:
  All of the following arguments are required :

  -p [PANGENOMES], --pangenomes [PANGENOMES]
                        A list of pangenome.h5 files in .tsv file (default:
                        None)
  -s [SOURCE], --source [SOURCE]
                        Name of the annotation source. (default: None)
  --table TABLE         A list of tab-separated file, containing annotation of
                        gene families.Expected format is pangenome name in
                        first column and path to the TSV with annotation in
                        second column. (default: None)
  --hmm [HMM]           A tab-separated file with HMM information and
                        path.Note: Use panorama utils --hmm to create the HMM
                        list file (default: None)

HMM arguments:
  All of the following arguments are required, if you're using HMM mode :

  --mode {fast,profile,sensitive}
                        Choose the mode use to align HMM database and gene
                        families. Fast will align the reference sequence of
                        gene family against HMM.Profile will create an HMM
                        profile for each gene family and this profile will be
                        aligned.Sensitive will align HMM to all genes in
                        families. (default: None)
  --k_best_hit K_BEST_HIT
                        Keep the k best annotation hit per gene family.If not
                        specified, all hit will be kept. (default: None)
  -b, --only_best_hit   alias to keep only the best hit for each gene family.
                        (default: False)
  --msa MSA             To create a HMM profile for families, you can give a
                        msa of each gene in families.This msa could be gotten
                        from ppanggolin (See ppanggolin msa). If no msa
                        provide Panorama will launch one. (default: None)
  --save_hits [{tblout,domtblout,pfamtblout} ...]
                        Save HMM alignment results in tabular format. Option
                        are the same than in HMMSearch. (default: None)
  -Z [Z], --Z [Z]       From HMMER: Assert that the total number of targets in
                        your searches is <x>, for the purposes of per-sequence
                        E-value calculations, rather than the actual number of
                        targets seen. (default: None)
  -o [OUTPUT], --output [OUTPUT]
                        Output directory to write HMM results (default: None)
  --keep_tmp            Keep the temporary files. Useful for debugging in
                        sensitive or profile mode. (default: False)
  --tmp [TMP]           Path to temporary directory, defaults path is
                        /tmp/panorama (default: /tmp)

Optional arguments:
  --threads [THREADS]   Number of available threads. (default: 1)
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only,
                        1 for info, 2 for debug) (default: 1)
  --log LOG             log output file (default: stdout)
  -d, --disable_prog_bar
                        disables the progress bars (default: False)
  --force               Force writing in output directory and in pangenome
                        output file. (default: False)

By Jérôme Arnoux <arnoux.jeromepj@gmail.com>
PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT
LABGeM
```


## panorama_systems

### Tool Description
PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT

### Metadata
- **Docker Image**: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/panorama
- **Package**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panorama systems [-h] -p [PANGENOMES] -m [MODELS] -s [SOURCE]
                        [--annotation_sources ANNOTATION_SOURCES [ANNOTATION_SOURCES ...]]
                        [--jaccard JACCARD] [--threads [THREADS]]
                        [--verbose {0,1,2}] [--log LOG] [-d] [--force]

    ____     ___     _   __   ____     ____     ___     __  ___    ___ 
   / __ \   /   |   / | / /  / __ \   / __ \   /   |   /  |/  /   /   |
  / /_/ /  / /| |  /  |/ /  / / / /  / /_/ /  / /| |  / /|_/ /   / /| |
 / ____/  / ___ | / /|  /  / /_/ /  / _, _/  / ___ | / /  / /   / ___ |
/_/      /_/  |_|/_/ |_/   \____/  /_/ |_|  /_/  |_|/_/  /_/   /_/  |_|

options:
  -h, --help            show this help message and exit

Required arguments:
  All of the following arguments are required:

  -p [PANGENOMES], --pangenomes [PANGENOMES]
                        A list of pangenome .h5 files in a .tsv file.
                        (default: None)
  -m [MODELS], --models [MODELS]
                        Path to model list file. Note: Use 'panorama utils
                        --models' to create the models list file. (default:
                        None)
  -s [SOURCE], --source [SOURCE]
                        Name of the annotation source to select in pangenomes.
                        (default: None)

Optional arguments:
  --annotation_sources ANNOTATION_SOURCES [ANNOTATION_SOURCES ...]
                        Name of the annotation sources to load if different
                        from the system source. Can specify more than one,
                        separated by space. (default: None)
  --jaccard JACCARD     Minimum Jaccard similarity used to filter edges
                        between gene families. Increasing this value improves
                        precision but significantly lowers sensitivity.
                        (default: 0.8)
  --threads [THREADS]   Number of available threads. (default: 1)
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only,
                        1 for info, 2 for debug) (default: 1)
  --log LOG             log output file (default: stdout)
  -d, --disable_prog_bar
                        disables the progress bars (default: False)
  --force               Force writing in output directory and in pangenome
                        output file. (default: False)

By Jérôme Arnoux <arnoux.jeromepj@gmail.com>
PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT
LABGeM
```


## panorama_write

### Tool Description
Write annotation/metadata assigned to gene families in pangenomes

### Metadata
- **Docker Image**: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/panorama
- **Package**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panorama write [-h] -p [PANGENOMES] -o [OUTPUT] [--annotations]
                      [--sources SOURCES [SOURCES ...]] [--hmm] [--msa MSA]
                      [--msa_format {stockholm,pfam,a2m,psiblast,selex,afa,clustal,clustallike,phylip,phylips}]
                      [--threads THREADS] [--verbose {0,1,2}] [--log LOG] [-d]
                      [--force]

    ____     ___     _   __   ____     ____     ___     __  ___    ___ 
   / __ \   /   |   / | / /  / __ \   / __ \   /   |   /  |/  /   /   |
  / /_/ /  / /| |  /  |/ /  / / / /  / /_/ /  / /| |  / /|_/ /   / /| |
 / ____/  / ___ | / /|  /  / /_/ /  / _, _/  / ___ | / /  / /   / ___ |
/_/      /_/  |_|/_/ |_/   \____/  /_/ |_|  /_/  |_|/_/  /_/   /_/  |_|

options:
  -h, --help            show this help message and exit

Required arguments:
  All of the following arguments are required :

  -p [PANGENOMES], --pangenomes [PANGENOMES]
                        A list of pangenome .h5 files in .tsv file (default:
                        None)
  -o [OUTPUT], --output [OUTPUT]
                        Output directory (default: None)

Write annotation:
  Arguments for writing annotation/metadata assigned to gene families in pangenomes

  --annotations         Write all the annotations from families for the given
                        sources (default: False)
  --sources SOURCES [SOURCES ...]
                        Name of the annotation source where panorama as to
                        select in pangenomes (default: None)

Write HMM:
  Arguments for writing gene families HMM

  --hmm                 Write an hmm for each gene families in pangenomes
                        (default: False)
  --msa MSA             To create a HMM profile for families, you can give a
                        msa of each gene in families.This msa could be get
                        from ppanggolin (See ppanggolin msa). Should be a 2
                        column tsv file with pangenome name in first and path
                        to MSA in second (default: None)
  --msa_format {stockholm,pfam,a2m,psiblast,selex,afa,clustal,clustallike,phylip,phylips}
                        Format of the input MSA. (default: afa)

Optional arguments:
  --threads THREADS
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only,
                        1 for info, 2 for debug) (default: 1)
  --log LOG             log output file (default: stdout)
  -d, --disable_prog_bar
                        disables the progress bars (default: False)
  --force               Force writing in output directory and in pangenome
                        output file. (default: False)

By Jérôme Arnoux <arnoux.jeromepj@gmail.com>
PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT
LABGeM
```


## panorama_utility

### Tool Description
Panorama utility for various bioinformatics tasks.

### Metadata
- **Docker Image**: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/panorama
- **Package**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panorama [-h] [-v]  ...
panorama: error: argument : invalid choice: 'utility' (choose from info, annotation, systems, align, cluster, compare_context, compare_systems, compare_spots, write, write_systems, pansystems, utils)
```


## panorama_write_systems

### Tool Description
Write systems from pangenomes

### Metadata
- **Docker Image**: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/panorama
- **Package**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panorama write_systems [-h] -p [PANGENOMES] -o [OUTPUT] -m MODELS
                              [MODELS ...] -s SOURCES [SOURCES ...]
                              [--projection] [--partition]
                              [--association {all,modules,RGPs,spots} [{all,modules,RGPs,spots} ...]]
                              [--proksee {all,base,modules,RGP,spots,annotations} [{all,base,modules,RGP,spots,annotations} ...]]
                              [--canonical]
                              [--organisms ORGANISMS [ORGANISMS ...]]
                              [--output_formats {html,png} [{html,png} ...]]
                              [--threads THREADS] [--verbose {0,1,2}]
                              [--log LOG] [-d] [--force]

    ____     ___     _   __   ____     ____     ___     __  ___    ___ 
   / __ \   /   |   / | / /  / __ \   / __ \   /   |   /  |/  /   /   |
  / /_/ /  / /| |  /  |/ /  / / / /  / /_/ /  / /| |  / /|_/ /   / /| |
 / ____/  / ___ | / /|  /  / /_/ /  / _, _/  / ___ | / /  / /   / ___ |
/_/      /_/  |_|/_/ |_/   \____/  /_/ |_|  /_/  |_|/_/  /_/   /_/  |_|

options:
  -h, --help            show this help message and exit

Required arguments:
  All of the following arguments are required :

  -p [PANGENOMES], --pangenomes [PANGENOMES]
                        A list of pangenome .h5 files in .tsv file (default:
                        None)
  -o [OUTPUT], --output [OUTPUT]
                        Output directory (default: None)
  -m MODELS [MODELS ...], --models MODELS [MODELS ...]
                        Path to model list file. You can specify multiple
                        models from different source. For that separate the
                        model list files by a space and make sure you give
                        them in the same order as the sources. (default: None)
  -s SOURCES [SOURCES ...], --sources SOURCES [SOURCES ...]
                        Name of the systems sources. You can specify multiple
                        sources. For that separate names by a space and make
                        sure you give them in the same order as the sources.
                        (default: None)

Optional arguments:
  --projection          Project the systems on organisms. If organisms are
                        specified, projection will be done only for them.
                        (default: False)
  --partition           Write a heatmap file with for each organism, partition
                        of the systems. If organisms are specified, heatmap
                        will be write only for them. (default: False)
  --association {all,modules,RGPs,spots} [{all,modules,RGPs,spots} ...]
                        Write association between systems and others
                        pangenomes elements (default: [])
  --proksee {all,base,modules,RGP,spots,annotations} [{all,base,modules,RGP,spots,annotations} ...]
                        Write a proksee file with systems. If you only want
                        the systems with genes, gene families and partition,
                        use base value.Write RGPs, spots or modules -split by
                        `,'- if you want them. (default: None)
  --canonical           Write the canonical version of systems too. (default:
                        False)
  --organisms ORGANISMS [ORGANISMS ...]
                        List of organisms to write. If not specified, all
                        organisms will be written. (default: None)
  --output_formats {html,png} [{html,png} ...]
                        Visualization output format customization. (default:
                        ['html'])
  --threads THREADS
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only,
                        1 for info, 2 for debug) (default: 1)
  --log LOG             log output file (default: stdout)
  -d, --disable_prog_bar
                        disables the progress bars (default: False)
  --force               Force writing in output directory and in pangenome
                        output file. (default: False)

By Jérôme Arnoux <arnoux.jeromepj@gmail.com>
PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT
LABGeM
```


## panorama_pansystems

### Tool Description
PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT

### Metadata
- **Docker Image**: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/panorama
- **Package**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panorama pansystems [-h] -p [PANGENOMES] -s [SOURCE] -o [OUTPUT]
                           (--table TABLE | --hmm [HMM])
                           [--mode {fast,profile,sensitive}]
                           [--k_best_hit K_BEST_HIT] [-b] [--msa MSA]
                           [--save_hits [{tblout,domtblout,pfamtblout} ...]]
                           [-Z [Z]] -m [MODELS] [--jaccard JACCARD]
                           [--projection] [--partition]
                           [--association {all,modules,RGPs,spots} [{all,modules,RGPs,spots} ...]]
                           [--proksee {all,base,modules,RGP,spots,annotate} [{all,base,modules,RGP,spots,annotate} ...]]
                           [--threads [THREADS]] [--keep_tmp] [--tmp [TMP]]
                           [--verbose {0,1,2}] [--log LOG] [-d] [--force]

    ____     ___     _   __   ____     ____     ___     __  ___    ___ 
   / __ \   /   |   / | / /  / __ \   / __ \   /   |   /  |/  /   /   |
  / /_/ /  / /| |  /  |/ /  / / / /  / /_/ /  / /| |  / /|_/ /   / /| |
 / ____/  / ___ | / /|  /  / /_/ /  / _, _/  / ___ | / /  / /   / ___ |
/_/      /_/  |_|/_/ |_/   \____/  /_/ |_|  /_/  |_|/_/  /_/   /_/  |_|

options:
  -h, --help            show this help message and exit

Required arguments:
  All of the following arguments are required:

  -p [PANGENOMES], --pangenomes [PANGENOMES]
                        A list of pangenome .h5 files in .tsv file (default:
                        None)
  -s [SOURCE], --source [SOURCE]
                        Name of the annotation source where panorama as to
                        select in pangenomes (default: None)
  -o [OUTPUT], --output [OUTPUT]
                        Output directory (default: None)

Annotation arguments:
  All of the following arguments are used for annotation step:

  --table TABLE         A list of tab-separated file, containing annotation of
                        gene families.Expected format is pangenome name in
                        first column and path to the TSV with annotation in
                        second column. (default: None)
  --hmm [HMM]           A tab-separated file with HMM information and
                        path.Note: Use panorama utils --hmm to create the HMM
                        list file (default: None)

Systems detection arguments:
  All of the following arguments are used for systems detection step:

  -m [MODELS], --models [MODELS]
                        Path to model list file.Note: Use panorama utils
                        --models to create the models list file (default:
                        None)
  --jaccard JACCARD     minimum jaccard similarity used to filter edges
                        between gene families. Increasing it will improve
                        precision but lower sensitivity a lot. (default: 0.8)

Optional arguments:
  --threads [THREADS]   Number of available threads (default: 1)
  --keep_tmp            Keep the temporary files. Useful for debugging in
                        sensitive or profile mode. (default: False)
  --tmp [TMP]           Path to temporary directory, defaults path is
                        /tmp/panorama (default: None)

Optional arguments:
  --projection          Project the systems on organisms. If organisms are
                        specified, projection will be done only for them.
                        (default: False)
  --partition           Write a heatmap file with for each organism, partition
                        of the systems. If organisms are specified, heatmap
                        will be write only for them. (default: False)
  --association {all,modules,RGPs,spots} [{all,modules,RGPs,spots} ...]
                        Write association between systems and others
                        pangenomes elements (default: [])
  --proksee {all,base,modules,RGP,spots,annotate} [{all,base,modules,RGP,spots,annotate} ...]
                        Write a proksee file with systems. If you only want
                        the systems with genes, gene families and partition,
                        use base value.Write RGPs, spots or modules -split by
                        `,'- if you want them. (default: None)
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only,
                        1 for info, 2 for debug) (default: 1)
  --log LOG             log output file (default: stdout)
  -d, --disable_prog_bar
                        disables the progress bars (default: False)
  --force               Force writing in output directory and in pangenome
                        output file. (default: False)

By Jérôme Arnoux <arnoux.jeromepj@gmail.com>
PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT
LABGeM
```


## panorama_align

### Tool Description
Perform sequence alignment between pangenome gene families using MMseqs2 with support for both inter-pangenome and all-against-all alignment modes.

### Metadata
- **Docker Image**: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/panorama
- **Package**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panorama align [-h] -p FILE -o DIR
                      (--inter_pangenomes | --all_against_all)
                      [--align_identity FLOAT] [--align_coverage FLOAT]
                      [--align_cov_mode INT] [--tmpdir DIR] [--keep_tmp]
                      [--threads INT] [--verbose {0,1,2}] [--log LOG] [-d]
                      [--force]

    ____     ___     _   __   ____     ____     ___     __  ___    ___ 
   / __ \   /   |   / | / /  / __ \   / __ \   /   |   /  |/  /   /   |
  / /_/ /  / /| |  /  |/ /  / / / /  / /_/ /  / /| |  / /|_/ /   / /| |
 / ____/  / ___ | / /|  /  / /_/ /  / _, _/  / ___ | / /  / /   / ___ |
/_/      /_/  |_|/_/ |_/   \____/  /_/ |_|  /_/  |_|/_/  /_/   /_/  |_|

Perform sequence alignment between pangenome gene families using MMseqs2 with support for both inter-pangenome and all-against-all alignment modes.

options:
  -h, --help            show this help message and exit

Required arguments:
  All of the following arguments are required:

  -p FILE, --pangenomes FILE
                        Path to TSV file containing list of pangenome .h5
                        files to process (default: None)
  -o DIR, --output DIR  Output directory where alignment results will be
                        written (default: None)
  --inter_pangenomes    Perform inter-pangenome alignment only (exclude intra-
                        pangenome comparisons). Cannot be used with
                        --all_against_all (default: False)
  --all_against_all     Perform all-against-all alignment including intra-
                        pangenome comparisons. Cannot be used with
                        --inter_pangenomes (default: False)

MMseqs2 alignment parameters:
  Configure MMseqs2 alignment behavior. See MMseqs2 documentation for detailed parameter descriptions.

  --align_identity FLOAT
                        Minimum identity percentage threshold (0.0-1.0).
                        Default: 0.8 (default: 0.8)
  --align_coverage FLOAT
                        Minimum coverage percentage threshold (0.0-1.0).
                        Default: 0.8 (default: 0.8)
  --align_cov_mode INT  Coverage mode: 0=query, 1=target, 2=shorter seq,
                        3=longer seq, 4=query and target, 5=shorter and longer
                        seq. Default: 0 (default: 0)

Optional arguments:
  --tmpdir DIR          Directory for temporary files. Default: /tmp (default:
                        /tmp)
  --keep_tmp            Keep temporary files after completion (useful for
                        debugging) (default: False)
  --threads INT         Number of threads for parallel processing. Default: 1
                        (default: 1)
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only,
                        1 for info, 2 for debug) (default: 1)
  --log LOG             log output file (default: stdout)
  -d, --disable_prog_bar
                        disables the progress bars (default: False)
  --force               Force writing in output directory and in pangenome
                        output file. (default: False)

By Jérôme Arnoux <arnoux.jeromepj@gmail.com>
PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT
LABGeM
```


## panorama_cluster

### Tool Description
Perform gene family clustering across multiple pangenomes using MMseqs2 with support for both fast (linclust) and sensitive (cluster) clustering methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/panorama
- **Package**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panorama cluster [-h] -p FILE -o DIR -m METHOD
                        [--cluster_identity FLOAT] [--cluster_coverage FLOAT]
                        [--cluster_cov_mode INT] [--cluster_eval FLOAT]
                        [--cluster_sensitivity FLOAT] [--cluster_max_seqs INT]
                        [--cluster_comp_bias_corr INT]
                        [--cluster_kmer_per_seq INT]
                        [--cluster_align_mode INT] [--cluster_max_seq_len INT]
                        [--cluster_max_reject INT] [--cluster_mode INT]
                        [--cluster_min_ungapped INT] [--tmpdir DIR]
                        [--keep_tmp] [--threads INT] [--verbose {0,1,2}]
                        [--log LOG] [-d] [--force]

    ____     ___     _   __   ____     ____     ___     __  ___    ___ 
   / __ \   /   |   / | / /  / __ \   / __ \   /   |   /  |/  /   /   |
  / /_/ /  / /| |  /  |/ /  / / / /  / /_/ /  / /| |  / /|_/ /   / /| |
 / ____/  / ___ | / /|  /  / /_/ /  / _, _/  / ___ | / /  / /   / ___ |
/_/      /_/  |_|/_/ |_/   \____/  /_/ |_|  /_/  |_|/_/  /_/   /_/  |_|

Perform gene family clustering across multiple pangenomes using MMseqs2 with support for both fast (linclust) and sensitive (cluster) clustering methods.

options:
  -h, --help            show this help message and exit

Required arguments:
  All of the following arguments are required:

  -p FILE, --pangenomes FILE
                        Path to TSV file containing list of pangenome .h5
                        files to process (default: None)
  -o DIR, --output DIR  Output directory where clustering results will be
                        written (default: None)
  -m METHOD, --method METHOD
                        Clustering method: linclust (fast) or cluster
                        (sensitive) (default: None)

MMseqs2 clustering parameters:
  Configure MMseqs2 clustering behavior. See MMseqs2 documentation for detailed parameter descriptions.

  --cluster_identity FLOAT
                        Minimum sequence identity threshold (0.0-1.0).
                        Default: 0.5 (default: 0.5)
  --cluster_coverage FLOAT
                        Minimum coverage threshold (0.0-1.0). Default: 0.8
                        (default: 0.8)
  --cluster_cov_mode INT
                        Coverage mode: 0=query, 1=target, 2=shorter seq,
                        3=longer seq, 4=query and target, 5=shorter and longer
                        seq. Default: 0 (default: 0)
  --cluster_eval FLOAT  E-value threshold. Default: 0.001 (default: 0.001)
  --cluster_sensitivity FLOAT
                        Search sensitivity (cluster method only). Higher
                        values = more sensitive but slower (default: None)
  --cluster_max_seqs INT
                        Maximum number of sequences per cluster representative
                        (cluster method only) (default: None)
  --cluster_comp_bias_corr INT
                        Compositional bias correction: 0=disabled, 1=enabled
                        (default: None)
  --cluster_kmer_per_seq INT
                        Number of k-mers per sequence (default: None)
  --cluster_align_mode INT
                        Alignment mode: 0=automatic, 1=only score, 2=only
                        extended, 3=score+extended, 4=fast+extended (default:
                        None)
  --cluster_max_seq_len INT
                        Maximum sequence length (default: None)
  --cluster_max_reject INT
                        Maximum number of rejected sequences (default: None)
  --cluster_mode INT    Clustering mode: 0=Set Cover, 1=Connected Component,
                        2=Greedy, 3=Greedy Low Memory (default: None)
  --cluster_min_ungapped INT
                        Minimum ungapped alignment score (cluster method only)
                        (default: None)

Optional arguments:
  --tmpdir DIR          Directory for temporary files. Default: /tmp (default:
                        /tmp)
  --keep_tmp            Keep temporary files after completion (useful for
                        debugging) (default: False)
  --threads INT         Number of threads for parallel processing. Default: 1
                        (default: 1)
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only,
                        1 for info, 2 for debug) (default: 1)
  --log LOG             log output file (default: stdout)
  -d, --disable_prog_bar
                        disables the progress bars (default: False)
  --force               Force writing in output directory and in pangenome
                        output file. (default: False)

By Jérôme Arnoux <arnoux.jeromepj@gmail.com>
PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT
LABGeM
```


## panorama_compare_systems

### Tool Description
Compare genomic systems among pangenomes using GFRR metrics

### Metadata
- **Docker Image**: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/panorama
- **Package**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panorama compare_systems [-h] -p PANGENOMES -o OUTPUT
                                [--cluster CLUSTER]
                                [--gfrr_cutoff MIN_FRR MAX_FRR]
                                [--cluster_identity FLOAT]
                                [--cluster_coverage FLOAT]
                                [--cluster_cov_mode INT]
                                [--cluster_eval FLOAT]
                                [--cluster_sensitivity FLOAT]
                                [--cluster_max_seqs INT]
                                [--cluster_comp_bias_corr INT]
                                [--cluster_kmer_per_seq INT]
                                [--cluster_align_mode INT]
                                [--cluster_max_seq_len INT]
                                [--cluster_max_reject INT]
                                [--cluster_mode INT]
                                [--cluster_min_ungapped INT]
                                [--method {linclust,cluster}] [--seed SEED]
                                [--graph_formats {gexf,graphml} [{gexf,graphml} ...]]
                                [--tmpdir TMPDIR] [--keep_tmp] [-c CPUS] -m
                                MODELS [MODELS ...] -s SOURCES [SOURCES ...]
                                [--heatmap]
                                [--gfrr_metrics {min_gfrr_models,max_gfrr_models,min_gfrr,max_gfrr}]
                                [--gfrr_models_cutoff GFRR_MODELS_CUTOFF GFRR_MODELS_CUTOFF]
                                [--canonical] [--verbose {0,1,2}] [--log LOG]
                                [-d] [--force]

    ____     ___     _   __   ____     ____     ___     __  ___    ___ 
   / __ \   /   |   / | / /  / __ \   / __ \   /   |   /  |/  /   /   |
  / /_/ /  / /| |  /  |/ /  / / / /  / /_/ /  / /| |  / /|_/ /   / /| |
 / ____/  / ___ | / /|  /  / /_/ /  / _, _/  / ___ | / /  / /   / ___ |
/_/      /_/  |_|/_/ |_/   \____/  /_/ |_|  /_/  |_|/_/  /_/   /_/  |_|

Compare genomic systems among pangenomes using GFRR metrics

options:
  -h, --help            show this help message and exit

Required arguments:
  All of the following arguments are required:

  -p PANGENOMES, --pangenomes PANGENOMES
                        Path to TSV file containing list of pangenome .h5
                        files to compare (default: None)
  -o OUTPUT, --output OUTPUT
                        Output directory where result files will be written
                        (default: None)
  -m MODELS [MODELS ...], --models MODELS [MODELS ...]
                        Path(s) to model list files. Multiple models can be
                        specified corresponding to different sources. Order
                        must match --sources. (default: None)
  -s SOURCES [SOURCES ...], --sources SOURCES [SOURCES ...]
                        Name(s) of the systems sources. Multiple sources can
                        be specified. Order must match --models argument.
                        (default: None)

Comparison optional arguments:
  --cluster CLUSTER     Path to tab-separated file with pre-computed
                        clustering results (cluster_name\tfamily_id format).
                        If not provided, clustering will be performed.
                        (default: None)
  --gfrr_cutoff MIN_FRR MAX_FRR
                        FRR (Family Relatedness Relationship) cutoff values
                        for similarity assessment. min_gfrr = shared_families
                        / min(families1, families2), max_gfrr =
                        shared_families / max(families1, families2)Default:
                        0.5 0.8 (default: (0.5, 0.8))
  --heatmap             Generate heatmaps showing normalized system presence
                        distribution across pangenomes (default: False)
  --gfrr_metrics {min_gfrr_models,max_gfrr_models,min_gfrr,max_gfrr}
                        Similarity metric for clustering conserved systems.
                        Models metrics use only model gene families, while
                        regular metrics use all families. (default: None)
  --gfrr_models_cutoff GFRR_MODELS_CUTOFF GFRR_MODELS_CUTOFF
                        GFRR cutoff thresholds for model gene families
                        comparison. min_gfrr = shared_families /
                        min(families1, families2), max_gfrr = shared_families
                        / max(families1, families2). Default: 0.2 0.2
                        (default: [0.4, 0.6])

MMseqs2 clustering parameters:
  MMSeqs2 clustering arguments (used only if --cluster is not provided)

  --cluster_identity FLOAT
                        Minimum sequence identity threshold (0.0-1.0).
                        Default: 0.5 (default: 0.5)
  --cluster_coverage FLOAT
                        Minimum coverage threshold (0.0-1.0). Default: 0.8
                        (default: 0.8)
  --cluster_cov_mode INT
                        Coverage mode: 0=query, 1=target, 2=shorter seq,
                        3=longer seq, 4=query and target, 5=shorter and longer
                        seq. Default: 0 (default: 0)
  --cluster_eval FLOAT  E-value threshold. Default: 0.001 (default: 0.001)
  --cluster_sensitivity FLOAT
                        Search sensitivity (cluster method only). Higher
                        values = more sensitive but slower (default: None)
  --cluster_max_seqs INT
                        Maximum number of sequences per cluster representative
                        (cluster method only) (default: None)
  --cluster_comp_bias_corr INT
                        Compositional bias correction: 0=disabled, 1=enabled
                        (default: None)
  --cluster_kmer_per_seq INT
                        Number of k-mers per sequence (default: None)
  --cluster_align_mode INT
                        Alignment mode: 0=automatic, 1=only score, 2=only
                        extended, 3=score+extended, 4=fast+extended (default:
                        None)
  --cluster_max_seq_len INT
                        Maximum sequence length (default: None)
  --cluster_max_reject INT
                        Maximum number of rejected sequences (default: None)
  --cluster_mode INT    Clustering mode: 0=Set Cover, 1=Connected Component,
                        2=Greedy, 3=Greedy Low Memory (default: None)
  --cluster_min_ungapped INT
                        Minimum ungapped alignment score (cluster method only)
                        (default: None)
  --method {linclust,cluster}
                        MMSeqs2 clustering method selection: 'linclust' - fast
                        linear-time clustering (less sensitive), 'cluster' -
                        slower but more sensitive clustering. Default:
                        linclust (default: linclust)

Optional arguments:
  --seed SEED           Random seed for reproducibility. Default: 42 (default:
                        42)
  --graph_formats {gexf,graphml} [{gexf,graphml} ...]
                        Output format(s) for graph files. Multiple formats can
                        be specified. Supported: gexf (Gephi Exchange Format),
                        graphml (Graph Markup Language) (default: None)
  --tmpdir TMPDIR       Directory for temporary files. Default: /tmp (default:
                        /tmp)
  --keep_tmp            Keep temporary files after completion (useful for
                        debugging and inspection) (default: False)
  -c CPUS, --cpus CPUS  Number of CPU threads to use for parallel processing.
                        Default: 1 (default: 1)
  --canonical           Include canonical system versions in the analysis
                        output. (default: False)
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only,
                        1 for info, 2 for debug) (default: 1)
  --log LOG             log output file (default: stdout)
  -d, --disable_prog_bar
                        disables the progress bars (default: False)
  --force               Force writing in output directory and in pangenome
                        output file. (default: False)

By Jérôme Arnoux <arnoux.jeromepj@gmail.com>
PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT
LABGeM
```


## panorama_compare_spots

### Tool Description
Compare and identify conserved spots across multiple pangenomes. This analysis identifies genomic regions that are conserved across different pangenomes based on gene family similarity and optionally analyzes systems relationships within these regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/panorama
- **Package**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panorama compare_spots [-h] -p PANGENOMES -o OUTPUT [--cluster CLUSTER]
                              [--gfrr_cutoff MIN_FRR MAX_FRR]
                              [--cluster_identity FLOAT]
                              [--cluster_coverage FLOAT]
                              [--cluster_cov_mode INT] [--cluster_eval FLOAT]
                              [--cluster_sensitivity FLOAT]
                              [--cluster_max_seqs INT]
                              [--cluster_comp_bias_corr INT]
                              [--cluster_kmer_per_seq INT]
                              [--cluster_align_mode INT]
                              [--cluster_max_seq_len INT]
                              [--cluster_max_reject INT] [--cluster_mode INT]
                              [--cluster_min_ungapped INT]
                              [--method {linclust,cluster}] [--seed SEED]
                              [--graph_formats {gexf,graphml} [{gexf,graphml} ...]]
                              [--tmpdir TMPDIR] [--keep_tmp] [-c CPUS]
                              [--gfrr_metrics {min_gfrr,max_gfrr}]
                              [--dup_margin DUP_MARGIN] [--systems]
                              [-m MODEL_FILE [MODEL_FILE ...]]
                              [-s SOURCE_NAME [SOURCE_NAME ...]] [--canonical]
                              [--verbose {0,1,2}] [--log LOG] [-d] [--force]

    ____     ___     _   __   ____     ____     ___     __  ___    ___ 
   / __ \   /   |   / | / /  / __ \   / __ \   /   |   /  |/  /   /   |
  / /_/ /  / /| |  /  |/ /  / / / /  / /_/ /  / /| |  / /|_/ /   / /| |
 / ____/  / ___ | / /|  /  / /_/ /  / _, _/  / ___ | / /  / /   / ___ |
/_/      /_/  |_|/_/ |_/   \____/  /_/ |_|  /_/  |_|/_/  /_/   /_/  |_|

Compare and identify conserved spots across multiple pangenomes. This analysis identifies genomic regions that are conserved across different pangenomes based on gene family similarity and optionally analyzes systems relationships within these regions.

options:
  -h, --help            show this help message and exit

Required arguments:
  All of the following arguments are required:

  -p PANGENOMES, --pangenomes PANGENOMES
                        Path to TSV file containing list of pangenome .h5
                        files to compare (default: None)
  -o OUTPUT, --output OUTPUT
                        Output directory where result files will be written
                        (default: None)

Comparison optional arguments:
  --cluster CLUSTER     Path to tab-separated file with pre-computed
                        clustering results (cluster_name\tfamily_id format).
                        If not provided, clustering will be performed.
                        (default: None)
  --gfrr_cutoff MIN_FRR MAX_FRR
                        FRR (Family Relatedness Relationship) cutoff values
                        for similarity assessment. min_gfrr = shared_families
                        / min(families1, families2), max_gfrr =
                        shared_families / max(families1, families2)Default:
                        0.5 0.8 (default: (0.5, 0.8))
  --gfrr_metrics {min_gfrr,max_gfrr}
                        GFRR metric used for spots clustering. 'min_gfrr':
                        conservative metric (shared/smaller_set), 'max_gfrr':
                        liberal metric (shared/larger_set). Default: min_gfrr
                        (default: min_gfrr)

MMseqs2 clustering parameters:
  MMSeqs2 clustering arguments (used only if --cluster is not provided)

  --cluster_identity FLOAT
                        Minimum sequence identity threshold (0.0-1.0).
                        Default: 0.5 (default: 0.5)
  --cluster_coverage FLOAT
                        Minimum coverage threshold (0.0-1.0). Default: 0.8
                        (default: 0.8)
  --cluster_cov_mode INT
                        Coverage mode: 0=query, 1=target, 2=shorter seq,
                        3=longer seq, 4=query and target, 5=shorter and longer
                        seq. Default: 0 (default: 0)
  --cluster_eval FLOAT  E-value threshold. Default: 0.001 (default: 0.001)
  --cluster_sensitivity FLOAT
                        Search sensitivity (cluster method only). Higher
                        values = more sensitive but slower (default: None)
  --cluster_max_seqs INT
                        Maximum number of sequences per cluster representative
                        (cluster method only) (default: None)
  --cluster_comp_bias_corr INT
                        Compositional bias correction: 0=disabled, 1=enabled
                        (default: None)
  --cluster_kmer_per_seq INT
                        Number of k-mers per sequence (default: None)
  --cluster_align_mode INT
                        Alignment mode: 0=automatic, 1=only score, 2=only
                        extended, 3=score+extended, 4=fast+extended (default:
                        None)
  --cluster_max_seq_len INT
                        Maximum sequence length (default: None)
  --cluster_max_reject INT
                        Maximum number of rejected sequences (default: None)
  --cluster_mode INT    Clustering mode: 0=Set Cover, 1=Connected Component,
                        2=Greedy, 3=Greedy Low Memory (default: None)
  --cluster_min_ungapped INT
                        Minimum ungapped alignment score (cluster method only)
                        (default: None)
  --method {linclust,cluster}
                        MMSeqs2 clustering method selection: 'linclust' - fast
                        linear-time clustering (less sensitive), 'cluster' -
                        slower but more sensitive clustering. Default:
                        linclust (default: linclust)

Systems analysis options:
  Optional analysis of systems relationships within conserved spots

  --systems             Enable systems analysis to examine relationships
                        between conserved spots and detected biological
                        systems. This adds systems linkage graphs and enriched
                        annotations to the output. (default: False)
  -m MODEL_FILE [MODEL_FILE ...], --models MODEL_FILE [MODEL_FILE ...]
                        Path(s) to system model files. Multiple model files
                        can be specified (space-separated) for different
                        system sources. Must be provided in the same order as
                        --sources. Required if --systems is used. (default:
                        None)
  -s SOURCE_NAME [SOURCE_NAME ...], --sources SOURCE_NAME [SOURCE_NAME ...]
                        Name(s) of systems sources corresponding to model
                        files. Multiple sources can be specified (space-
                        separated). Must be provided in the same order as
                        --models. Required if --systems is used. (default:
                        None)
  --canonical           Include canonical versions of systems in the analysis.
                        This provides additional system representations that
                        may be useful for comprehensive systems analysis.
                        (default: False)

Optional arguments:
  --seed SEED           Random seed for reproducibility. Default: 42 (default:
                        42)
  --graph_formats {gexf,graphml} [{gexf,graphml} ...]
                        Output format(s) for graph files. Multiple formats can
                        be specified. Supported: gexf (Gephi Exchange Format),
                        graphml (Graph Markup Language) (default: None)
  --tmpdir TMPDIR       Directory for temporary files. Default: /tmp (default:
                        /tmp)
  --keep_tmp            Keep temporary files after completion (useful for
                        debugging and inspection) (default: False)
  -c CPUS, --cpus CPUS  Number of CPU threads to use for parallel processing.
                        Default: 1 (default: 1)
  --dup_margin DUP_MARGIN
                        Minimum ratio of genomes in which a gene family must
                        have multiple copies to be considered 'duplicated'.
                        This affects multigenic family detection for spot
                        border analysis. Range: 0.0-1.0. Default: 0.05 (5%)
                        (default: 0.05)
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only,
                        1 for info, 2 for debug) (default: 1)
  --log LOG             log output file (default: stdout)
  -d, --disable_prog_bar
                        disables the progress bars (default: False)
  --force               Force writing in output directory and in pangenome
                        output file. (default: False)

By Jérôme Arnoux <arnoux.jeromepj@gmail.com>
PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT
LABGeM
```


## panorama_info

### Tool Description
Extract status, content, parameters, and metadata information from pangenome HDF5 files and export as interactive HTML reports.

### Metadata
- **Docker Image**: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/panorama
- **Package**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panorama info [-h] -p PANGENOMES -o OUTPUT [-s] [-c]
                     [--verbose {0,1,2}] [--log LOG] [-d] [--force]

    ____     ___     _   __   ____     ____     ___     __  ___    ___ 
   / __ \   /   |   / | / /  / __ \   / __ \   /   |   /  |/  /   /   |
  / /_/ /  / /| |  /  |/ /  / / / /  / /_/ /  / /| |  / /|_/ /   / /| |
 / ____/  / ___ | / /|  /  / /_/ /  / _, _/  / ___ | / /  / /   / ___ |
/_/      /_/  |_|/_/ |_/   \____/  /_/ |_|  /_/  |_|/_/  /_/   /_/  |_|

Extract status, content, parameters, and metadata information from pangenome HDF5 files and export as interactive HTML reports.

options:
  -h, --help            show this help message and exit

Required arguments:
  All of the following arguments are required:

  -p PANGENOMES, --pangenomes PANGENOMES
                        Path to a TSV file listing pangenome .h5 files with
                        their names and paths (default: None)
  -o OUTPUT, --output OUTPUT
                        Output directory where HTML reports will be saved
                        (default: None)

Information Display Options:
  Select which types of information to extract (default: all types)

  -s, --status          Extract and export status information showing
                        completion status of different analysis steps for each
                        pangenome (default: False)
  -c, --content         Extract and export content information including gene
                        family statistics, core/accessory genome metrics, and
                        module information (default: False)

Optional arguments:
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only,
                        1 for info, 2 for debug) (default: 1)
  --log LOG             log output file (default: stdout)
  -d, --disable_prog_bar
                        disables the progress bars (default: False)
  --force               Force writing in output directory and in pangenome
                        output file. (default: False)

Optional arguments:
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only,
                        1 for info, 2 for debug) (default: 1)
  --log LOG             log output file (default: stdout)
  -d, --disable_prog_bar
                        disables the progress bars (default: False)
  --force               Force writing in output directory and in pangenome
                        output file. (default: False)

By Jérôme Arnoux <arnoux.jeromepj@gmail.com>
PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT
LABGeM
```


## panorama_utils

### Tool Description
Create input files used by PANORAMA

### Metadata
- **Docker Image**: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/panorama
- **Package**: https://anaconda.org/channels/bioconda/packages/panorama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panorama utils [-h] [--models MODELS [MODELS ...]]
                      [--hmm HMM [HMM ...]] [--meta [META]] [--binary]
                      [-c COVERAGE COVERAGE] [--hmm_coverage [HMM_COVERAGE]]
                      [--target_coverage [TARGET_COVERAGE]]
                      [--translate TRANSLATE]
                      [--source [{padloc,defense-finder,CONJScan,TXSScan,TFFscan}]]
                      [-o [OUTPUT]] [--recursive] [--verbose {0,1,2}]
                      [--log LOG] [-d] [--force]

    ____     ___     _   __   ____     ____     ___     __  ___    ___ 
   / __ \   /   |   / | / /  / __ \   / __ \   /   |   /  |/  /   /   |
  / /_/ /  / /| |  /  |/ /  / / / /  / /_/ /  / /| |  / /|_/ /   / /| |
 / ____/  / ___ | / /|  /  / /_/ /  / _, _/  / ___ | / /  / /   / ___ |
/_/      /_/  |_|/_/ |_/   \____/  /_/ |_|  /_/  |_|/_/  /_/   /_/  |_|

options:
  -h, --help            show this help message and exit

Create input files arguments:
  Create some input files used by PANORAMA

  --models MODELS [MODELS ...]
                        Create a models_list.tsv file from the given models
                        and check them. (default: None)

HMM utils arguments:
  Arguments to create an HMM list. Arguments are common with translate arguments.

  --hmm HMM [HMM ...]   Path to HMM files or directory containing HMM
                        (default: None)
  --meta [META]         Path to metadata file to add some to list file
                        (default: None)
  --binary              Flag to rewrite the HMM in binary mode. Useful to
                        speed up annotation (default: False)
  -c COVERAGE COVERAGE, --coverage COVERAGE COVERAGE
                        Set the coverage threshold for the hmm and the target.
                        The same threshold will be used for all HMM and
                        target. It's Not recommended for PADLOC. For defense
                        finder and macsy finder see --hmm_coverage. (default:
                        (None, None))
  --hmm_coverage [HMM_COVERAGE]
                        Set the coverage threshold on the hmm. The same
                        threshold will be used for all HMM. It's Not
                        recommended for PADLOC. For defense finders it's
                        correspond to --coverage arguments.For macsyfinder
                        it's correspond to --coverage-profile. (default: None)
  --target_coverage [TARGET_COVERAGE]
                        Set the coverage threshold on the target. The same
                        threshold will be used for all target. It's Not
                        recommended for PADLOC, defensefinder or macsyfinder.
                        (default: None)

Translate arguments:
  Arguments to translate systems models from different sources

  --translate TRANSLATE
                        Path to models to be translated. Give the directory
                        with models, hmms and other files.PANORAMA will take
                        care of everything it needs to translate. (default:
                        None)
  --source [{padloc,defense-finder,CONJScan,TXSScan,TFFscan}]
                        Available sources that we know how to translate.The
                        directory will be read recursively to catch all
                        models. (default: None)

Optional arguments:
  -o [OUTPUT], --output [OUTPUT]
                        Path to output directory. (default: None)
  --recursive           Flag to indicate if directories should be read
                        recursively (default: False)
  --verbose {0,1,2}     Indicate verbose level (0 for warning and errors only,
                        1 for info, 2 for debug) (default: 1)
  --log LOG             log output file (default: stdout)
  -d, --disable_prog_bar
                        disables the progress bars (default: False)
  --force               Force writing in output directory and in pangenome
                        output file. (default: False)

By Jérôme Arnoux <arnoux.jeromepj@gmail.com>
PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT
LABGeM
```


## Metadata
- **Skill**: generated

# read2tree CWL Generation Report

## read2tree

### Tool Description
read2tree is a pipeline allowing to use read data in combination with an OMA standalone output run to produce high quality trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/read2tree:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/DessimozLab/read2tree
- **Package**: https://anaconda.org/channels/bioconda/packages/read2tree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/read2tree/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/DessimozLab/read2tree
- **Stars**: N/A
### Original Help Text
```text
usage: read2tree [-h] [--version] [--output_path OUTPUT_PATH]
                 --standalone_path STANDALONE_PATH [--reads READS [READS ...]]
                 [--read_type READ_TYPE] [--threads THREADS] [--sample_reads]
                 [--genome_len GENOME_LEN] [--coverage COVERAGE]
                 [--min_cons_coverage MIN_CONS_COVERAGE]
                 [--dna_reference DNA_REFERENCE] [--sc_threshold SC_THRESHOLD]
                 [--debug] [--sequence_selection_mode SEQUENCE_SELECTION_MODE]
                 [-s SPECIES_NAME] [--tree] [--step STEP]
                 [--min_species MIN_SPECIES]
                 [--remove_species_mapping REMOVE_SPECIES_MAPPING]
                 [--remove_species_ogs REMOVE_SPECIES_OGS] [--keep_all_ogs]
                 [--ignore_species IGNORE_SPECIES]

read2tree is a pipeline allowing to use read data in combination with an OMA
standalone output run to produce high quality trees.

options:
  -h, --help            show this help message and exit
  --version             Show programme's version number and exit.
  --output_path OUTPUT_PATH
                        [Default is current directory] Path to output
                        directory.
  --standalone_path STANDALONE_PATH
                        [Default is current directory] Path to oma standalone
                        directory.
  --reads READS [READS ...]
                        [Default is none] Reads to be mapped to reference. If
                        paired end add separated by space.
  --read_type READ_TYPE
                        [Default is -ax sr] Minimap2 command-line options for
                        mapping reads to reference. Examples: -ax sr , -ax
                        map-hifi , -ax map-pb or -ax map-ont
  --threads THREADS     [Default is 1] Number of threads for gene marker
                        alignment (mafft) and read mapping (minimap2) and tree
                        inference (iqtree)
  --sample_reads        [Default is off] Splits reads as defined by split_len
                        (200) and split_overlap (0) parameters.
  --genome_len GENOME_LEN
                        [Default is 2000000] Genome size in bp.
  --coverage COVERAGE   [Default is 10] coverage in X. Only considered if
                        --sample reads is selected.
  --min_cons_coverage MIN_CONS_COVERAGE
                        [Default is 1] Minimum number of nucleotides at
                        column.
  --dna_reference DNA_REFERENCE
                        [Default is None] Reference file that contains
                        nucleotide sequences (fasta, hdf5). If not given it
                        will usethe RESTapi and retrieve sequences from
                        http://omabrowser.org directly. NOTE: internet
                        connection required!
  --sc_threshold SC_THRESHOLD
                        [Default is 0.25; Range 0-1] Parameter for selection
                        of sequences from mapping by completeness compared to
                        its reference sequence (number of ACGT basepairs vs
                        length of sequence). By default, all sequences are
                        selected.
  --debug               [Default is false] Changes to debug mode: * bam files
                        are saved!* reads are saved by mapping to OG
  --sequence_selection_mode SEQUENCE_SELECTION_MODE
                        [Default is sc] Possibilities are cov and cov_sc for
                        mapped sequence.
  -s, --species_name SPECIES_NAME
                        [Default is name of read 1st file] Name of species for
                        mapped sequence.
  --tree                [Default is false] Compute tree, otherwise just output
                        concatenated alignment!
  --step STEP           [Default is all 1marker 2map 3combine
  --min_species MIN_SPECIES
                        Min number of species in selected orthologous groups.
                        If not selected it will be estimated such that around
                        1000 OGs are available.
  --remove_species_mapping REMOVE_SPECIES_MAPPING
                        [Default is none] Remove species present in data set
                        after mapping step completed and only do analysis on
                        subset. Input is comma separated list without spaces,
                        e.g. XXX,YYY,AAA.
  --remove_species_ogs REMOVE_SPECIES_OGS
                        [Default is none] Remove species present in data set
                        after mapping step completed to build OGs. Input is
                        comma separated list without spaces, e.g. XXX,YYY,AAA.
  --keep_all_ogs        [Default is on] Keep all orthologs after addition of
                        mapped seq, which means also the OGs that have no
                        mapped sequence. Otherwise only OGs are used that have
                        the mapped sequence for alignment and tree inference.
  --ignore_species IGNORE_SPECIES
                        [Default is none] Ignores species part of the OMA
                        standalone pipeline. Input is comma separated list
                        without spaces, e.g. XXX,YYY,AAA.

read2tree (C) 2017-2026 David Dylus, Adrian M. Altenhoff, Sina Majidian
```


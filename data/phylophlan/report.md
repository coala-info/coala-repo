# phylophlan CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phylophlan | PASS | ran on six real poxvirus proteomes with a small custom marker database (4 markers built with phylophlan_setup_database), not the standard database |
| phylophlan_assign_sgbs | Not completed | needs the large SGB Mash database and genomes to classify |
| phylophlan_assign_sgbs_legacy | Not completed | needs the large SGB Mash database and genomes to classify |
| phylophlan_draw_metagenomic | Not completed | needs the output table of an SGB assignment and a bin-to-metagenome map; no small real example exists |
| phylophlan_get_reference | Not completed | downloads the GenBank assembly summary and reference genomes from the network (large); not run |
| phylophlan_patristic_distances | Failed | image problem: IndexError on every tree; the script shares globals with a multiprocessing pool, which breaks under the Python 3.14 default start method |
| phylophlan_setup_database | PASS | ran on four real poxvirus marker sequences, not on a downloaded database |
| phylophlan_strain_finder | PASS | ran on the tree and mutation rates from the small poxvirus run |
| phylophlan_write_config_file | PASS |  |

## phylophlan

### Tool Description
PhyloPhlAn is an accurate, rapid, and easy-to-use method for large-scale microbial genome characterization and phylogenetic analysis at multiple levels of resolution. PhyloPhlAn can assign finished, draft, or metagenome-assembled genomes (MAGs) to species-level genome bins (SGBs). For individual clades of interest (e.g. newly sequenced genome sets), PhyloPhlAn reconstructs strain-level phylogenies from among the closest species using clade-specific maximally informative markers. At the other extreme of resolution, PhyloPhlAn scales to very-large phylogenies comprising >17,000 microbial species

### Metadata
- **Docker Image**: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/biobakery/phylophlan
- **Package**: https://anaconda.org/channels/bioconda/packages/phylophlan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phylophlan/overview
- **Total Downloads**: 57.0K
- **Last updated**: 2026-02-17
- **GitHub**: https://github.com/biobakery/phylophlan
- **Stars**: N/A
### Original Help Text
```text
usage: phylophlan [-h] [-i INPUT | -c CLEAN] [-o OUTPUT] [-d DATABASE]
                  [-t {n,a}] [-f CONFIG_FILE] --diversity {low,medium,high}
                  [--strainphlan] [--accurate | --fast] [--clean_all]
                  [--database_list] [-s SUBMAT] [--submat_list]
                  [--submod_list] [--nproc NPROC]
                  [--min_num_proteins MIN_NUM_PROTEINS]
                  [--min_len_protein MIN_LEN_PROTEIN]
                  [--min_num_markers MIN_NUM_MARKERS]
                  [--trim {gap_trim,gap_perc,not_variant,greedy}]
                  [--gap_perc_threshold GAP_PERC_THRESHOLD]
                  [--not_variant_threshold NOT_VARIANT_THRESHOLD]
                  [--subsample {phylophlan,onethousand,sevenhundred,fivehundred,threehundred,onehundred,fifty,twentyfive,tenpercent,twentyfivepercent,fiftypercent,full}]
                  [--unknown_fraction UNKNOWN_FRACTION]
                  [--scoring_function {trident,muscle,random}] [--sort]
                  [--remove_fragmentary_entries]
                  [--fragmentary_threshold FRAGMENTARY_THRESHOLD]
                  [--min_num_entries MIN_NUM_ENTRIES] [--maas MAAS]
                  [--remove_only_gaps_entries] [--mutation_rates]
                  [--force_nucleotides] [--convert_N2gap]
                  [--input_folder INPUT_FOLDER] [--data_folder DATA_FOLDER]
                  [--databases_folder DATABASES_FOLDER]
                  [--submat_folder SUBMAT_FOLDER]
                  [--submod_folder SUBMOD_FOLDER]
                  [--configs_folder CONFIGS_FOLDER]
                  [--output_folder OUTPUT_FOLDER]
                  [--genome_extension GENOME_EXTENSION]
                  [--proteome_extension PROTEOME_EXTENSION] [--update]
                  [--citation] [--verbose] [-v]

PhyloPhlAn is an accurate, rapid, and easy-to-use method for large-scale
microbial genome characterization and phylogenetic analysis at multiple levels
of resolution. PhyloPhlAn can assign finished, draft, or metagenome-assembled
genomes (MAGs) to species-level genome bins (SGBs). For individual clades of
interest (e.g. newly sequenced genome sets), PhyloPhlAn reconstructs strain-
level phylogenies from among the closest species using clade-specific
maximally informative markers. At the other extreme of resolution, PhyloPhlAn
scales to very-large phylogenies comprising >17,000 microbial species

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     Folder containing your input genomes and/or proteomes
                        (default: None)
  -c, --clean CLEAN     Clean the output and partial data produced for the
                        specified project (default: None)
  -o, --output OUTPUT   Output folder name, otherwise it will be the name of
                        the input folder concatenated with the name of the
                        database used (default: None)
  -d, --database DATABASE
                        The name of the database of markers to use (default:
                        None)
  -t, --db_type {n,a}   Specify the type of the database of markers, where "n"
                        stands for nucleotides and "a" for amino acids. If not
                        specified, PhyloPhlAn will automatically detect the
                        type of database (default: None)
  -f, --config_file CONFIG_FILE
                        The configuration file to use. Four ready-to-use
                        configuration files can be generated using the
                        "phylophlan_write_default_configs.sh" script (default:
                        None)
  --diversity {low,medium,high}
                        Specify the expected diversity of the phylogeny,
                        automatically adjust some parameters: "low": for
                        genus-/species-/strain-level phylogenies; "medium":
                        for class-/order-level phylogenies; "high": for
                        phylum-/tree-of-life size phylogenies
  --strainphlan         The inputs are aligned markers from StrainPhlAn
                        (default: False)
  --accurate            Use more phylogenetic signal which can result in more
                        accurate phylogeny; affected parameters depend on the
                        "--diversity" level (default: False)
  --fast                Perform more a faster phylogeny reconstruction by
                        reducing the phylogenetic positions to use; affected
                        parameters depend on the "--diversity" level (default:
                        False)
  --clean_all           Remove all installation and database files
                        automatically generated (default: False)
  --database_list       List of all the available databases that can be
                        specified with the -d/--database option (default:
                        False)
  -s, --submat SUBMAT   Specify the substitution matrix to use, available
                        substitution matrices can be listed with "--
                        submat_list" (default: None)
  --submat_list         List of all the available substitution matrices that
                        can be specified with the -s/--submat option (default:
                        False)
  --submod_list         List of all the available substitution models that can
                        be specified with the --maas option (default: False)
  --nproc NPROC         The number of cores to use (default: 1)
  --min_num_proteins MIN_NUM_PROTEINS
                        Proteomes with less than this number of proteins will
                        be discarded (default: 1)
  --min_len_protein MIN_LEN_PROTEIN
                        Proteins in proteomes shorter than this value will be
                        discarded (default: 50)
  --min_num_markers MIN_NUM_MARKERS
                        Input genomes or proteomes that map to less than the
                        specified number of markers will be discarded
                        (default: 1)
  --trim {gap_trim,gap_perc,not_variant,greedy}
                        Specify which type of trimming to perform: "gap_trim":
                        execute what specified in the "trim" section of the
                        configuration file; "gap_perc": remove columns with a
                        percentage of gaps above a certain threshold (see "--
                        gap_perc_threshold" parameter)"not_variant": remove
                        columns with at least one nucleotide/amino acid
                        appearing above a certain threshold (see "--
                        not_variant_threshold" parameter); "greedy": performs
                        all the above trimming steps; If not specified, no
                        trimming will be performed (default: None)
  --gap_perc_threshold GAP_PERC_THRESHOLD
                        Fraction of gaps above which to discard a column when
                        "--trim gap_perc" is specified. [0-1] (default: 0.8)
  --not_variant_threshold NOT_VARIANT_THRESHOLD
                        Conservation value used above which to discard a
                        column as not variant when "--trim not_variant" is
                        specified. [0-1] (default: 0.99)
  --subsample {phylophlan,onethousand,sevenhundred,fivehundred,threehundred,onehundred,fifty,twentyfive,tenpercent,twentyfivepercent,fiftypercent,full}
                        The number of positions to retain from each single
                        marker, available option are: "phylophlan": specific
                        number of positions for each PhyloPhlAn marker (only
                        when "--database phylophlan"); "onethousand": return
                        the top 1000 positions; "sevenhundred": return the top
                        700; "fivehundred": return the top 500; "threehundred"
                        return the top 300; "onehundred": return the top 100
                        positions; "fifty": return the top 50 positions;
                        "twentyfive": return the top 25 positions;
                        "fiftypercent": return the top 50 percent positions;
                        "twentyfivepercent": return the top 25% positions;
                        "tenpercent": return the top 10% positions; "full":
                        full alignment. (default: full)
  --unknown_fraction UNKNOWN_FRACTION
                        Define the amount of unknowns ("X" and "-") allowed in
                        each column of the MSA of the markers (default: 0.3)
  --scoring_function {trident,muscle,random}
                        Specify which scoring function to use to evaluate
                        columns in the MSA results (default: None)
  --sort                If specified, the markers will be ordered, when using
                        the PhyloPhlAn database, it will be automatically set
                        to "True" (default: False)
  --remove_fragmentary_entries
                        If specified the MSAs will be checked and cleaned from
                        fragmentary entries. See --fragmentary_threshold for
                        the threshold values above which an entry will be
                        considered fragmentary (default: False)
  --fragmentary_threshold FRAGMENTARY_THRESHOLD
                        The fraction of gaps in the MSA for the sample to be
                        considered fragmentary and hence discarded when
                        --remove_fragmentary_entries is set. [0-1] (default:
                        0.85)
  --min_num_entries MIN_NUM_ENTRIES
                        The minimum number of entries to be present for each
                        of the markers in the database (default: 4)
  --maas MAAS           Select a mapping file that specifies the substitution
                        model of amino acid to use for each of the markers for
                        the gene tree reconstruction. File must be tab-
                        separated (default: None)
  --remove_only_gaps_entries
                        If specified, entries in the MSAs composed only of
                        gaps ("-") will be removed. This is equivalent to
                        specify "--remove_fragmentary_entries
                        --fragmentary_threshold 1" (default: False)
  --mutation_rates      If specified will produced a mutation rates table for
                        each of the aligned markers and a summary table for
                        the concatenated MSA. This operation can take a long
                        time to finish (default: False)
  --force_nucleotides   If specified force PhyloPhlAn to use nucleotide
                        sequences for the phylogenetic analysis, even in the
                        case of a database of amino acids (default: False)
  --convert_N2gap       If specified Ns will be forced to gaps (-) after the
                        MSAs and only whit nucleotides MSAs (default: False)
  --update              Update the databases file (default: False)
  --citation            Show citation
  --verbose             Makes PhyloPhlAn verbose (default: False)
  -v, --version         Prints the current PhyloPhlAn version and exit

Folder paths:
  Parameters for setting the folder locations

  --input_folder INPUT_FOLDER
                        Path to the folder containing the input data (default:
                        input/)
  --data_folder DATA_FOLDER
                        Path to the folder where to store the intermediate
                        files, default is "tmp" inside the project's output
                        folder (default: None)
  --databases_folder DATABASES_FOLDER
                        Path to the folder containing the database files
                        (default: phylophlan_databases/)
  --submat_folder SUBMAT_FOLDER
                        Path to the folder containing the substitution
                        matrices to use to compute the column score for the
                        subsampling step (default:
                        phylophlan_substitution_matrices/)
  --submod_folder SUBMOD_FOLDER
                        Path to the folder containing the mapping file with
                        substitution models for each marker for the gene tree
                        building (default: phylophlan_substitution_models/)
  --configs_folder CONFIGS_FOLDER
                        Path to the folder containing the configuration files
                        (default: phylophlan_configs/)
  --output_folder OUTPUT_FOLDER
                        Path to the output folder where to save the results
                        (default: )

Filename extensions:
  Parameters for setting the extensions of the input files

  --genome_extension GENOME_EXTENSION
                        Extension for input genomes (default: .fna)
  --proteome_extension PROTEOME_EXTENSION
                        Extension for input proteomes (default: .faa)
```

## phylophlan_setup_database

### Tool Description
Formats an input folder or multi-fasta file of marker sequences to be used as a database in phylophlan, or downloads a pre-identified set of core UniRef90 proteins for the species of a given taxonomic

### Metadata
- **Docker Image**: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/biobakery/phylophlan
- **Package**: https://anaconda.org/channels/bioconda/packages/phylophlan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phylophlan_setup_database [-h] [-i INPUT | -g GET_CORE_PROTEINS]
                                 [--database_update] [-o OUTPUT] [-d DB_NAME]
                                 [-e INPUT_EXTENSION] [-t {n,a}]
                                 [-x OUTPUT_EXTENSION] [--overwrite]
                                 [--citation] [--verbose] [-v]

The phylophlan_setup_database.py script can be used to either format an input
folder or multi-fasta file to be used as database in phylophlan.py, or
automatically download a pre-identified set of core UniRef90 proteins for the
taxonomic label of a given species

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     Specify the path to either the folder containing the
                        marker files or the file of markers, in (multi-)fasta
                        format (default: None)
  -g, --get_core_proteins GET_CORE_PROTEINS
                        Specify the taxonomic label for which download the set
                        of core proteins. The label must represent a species:
                        "--get_core_proteins s__Escherichia_coli" (default:
                        None)
  --database_update     Update the databases file (default: False)
  -o, --output OUTPUT   Specify path to the output folder where to save the
                        database (default: None)
  -d, --db_name DB_NAME
                        Specify the name of the output database (default:
                        None)
  -e, --input_extension INPUT_EXTENSION
                        Specify the extension of the input file(s) specified
                        via -i/--input (default: None)
  -t, --db_type {n,a}   Specify the type of the database, where "n" stands for
                        nucleotides and "a" for amino acids (default: None)
  -x, --output_extension OUTPUT_EXTENSION
                        Set the database output extension (default: None)
  --overwrite           If specified and the output file exists it will be
                        overwritten (default: False)
  --citation            Show citation
  --verbose             Prints more stuff (default: False)
  -v, --version         Prints the current phylophlan_setup_database.py
                        version and exit
```

## phylophlan_write_config_file

### Tool Description
Generates a configuration file to be used with the phylophlan script, with standard parameters for the selected software.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/biobakery/phylophlan
- **Package**: https://anaconda.org/channels/bioconda/packages/phylophlan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phylophlan_write_config_file [-h] -o OUTPUT -d {n,a}
                                    (--db_dna {makeblastdb} |
                                    --db_aa {usearch,diamond})
                                    [--map_dna {blastn,tblastn,diamond}]
                                    [--map_aa {usearch,diamond}]
                                    --msa {muscle,mafft,opal,upp}
                                    [--trim {trimal}]
                                    [--gene_tree1 {fasttree,raxml,iqtree}]
                                    [--gene_tree2 {raxml}]
                                    --tree1 {fasttree,raxml,iqtree,astral,astrid}
                                    [--tree2 {raxml}] [-a]
                                    [--force_nucleotides] [--overwrite]
                                    [--citation] [--verbose] [-v]

The phylophlan_write_config_file.py script generates a configuration file to
be used with the phylophlan.py script. It implements some standard parameters
for the software integrated, but if needed, the parameters of the selected
software can be added/modified/removed by editing the generated configuration
file using a text editor

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Specify the output file where to write the
                        configurations
  -d, --db_type {n,a}   Specify the type of the database, where "n" stands for
                        nucleotides and "a" for amino acids
  --db_dna {makeblastdb}
                        Add the "db_dna" section of the selected software that
                        will be used for building the indexed database
                        (default: None)
  --db_aa {usearch,diamond}
                        Add the "db_aa" section of the selected software that
                        will be used for building the indexed database
                        (default: None)
  --map_dna {blastn,tblastn,diamond}
                        Add the "map_dna" section of the selected software
                        that will be used for mapping the database against the
                        input genomes (default: None)
  --map_aa {usearch,diamond}
                        Add the "map_aa" section of the selected software that
                        will be used for mapping the database against the
                        input proteomes (default: None)
  --msa {muscle,mafft,opal,upp}
                        Add the "msa" section of the selected software that
                        will be used for producing the MSAs
  --trim {trimal}       Add the "trim" section of the selected software that
                        will be used for the gappy regions removal of the MSAs
                        (default: None)
  --gene_tree1 {fasttree,raxml,iqtree}
                        Add the "gene_tree1" section of the selected software
                        that will be used for building the phylogenies for the
                        markers in the database (default: None)
  --gene_tree2 {raxml}  Add the "gene_tree2" section of the selected software
                        that will be used for refining the phylogenies
                        previously built with what specified in the
                        "gene_tree1" section (default: None)
  --tree1 {fasttree,raxml,iqtree,astral,astrid}
                        Add the "tree1" section of the selected software that
                        will be used for building the first phylogeny
  --tree2 {raxml}       Add the "tree2" section of the selected software that
                        will be used for refining the phylogeny previously
                        built with what specified in the "tree1" section
                        (default: None)
  -a, --absolute_path   Write the absolute path to the executable instead of
                        the executable name as found in the system path
                        environment (default: False)
  --force_nucleotides   If specified sets parameters for phylogenetic analysis
                        software so that they use nucleotide sequences, even
                        in the case of a database of amino acids (default:
                        None)
  --overwrite           Overwrite output file if it exists (default: False)
  --citation            Show citation
  --verbose             Prints more stuff (default: False)
  -v, --version         Prints the current phylophlan_write_config_file.py
                        version and exit
```

## phylophlan_patristic_distances

### Tool Description
Calculates the pairwise patristic (leaf-to-leaf) distance matrix from a phylogenetic tree. It runs efficiently in O^2 time and space and can be parallelized.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/biobakery/phylophlan
- **Package**: https://anaconda.org/channels/bioconda/packages/phylophlan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phylophlan_patristic_distances [-h] -i INPUT_TREE -o OUTPUT_FILE
                                      [-f {tsv,parquet,npy,tri}]
                                      [--nproc NPROC] [-v]

A script to calculate the pairwise patristic (leaf-to-leaft) distance matrix
from a phylogenetic tree. It runs efficiently in O^2 time and space and can be
parallelized.

options:
  -h, --help            show this help message and exit
  -i, --input_tree INPUT_TREE
                        Path to the tree file in Newick format
  -o, --output_file OUTPUT_FILE
                        Output file to write the distance matrix to
  -f, --output_format {tsv,parquet,npy,tri}
                        Output format, if not specified will be determined
                        from the output_file extension. - tsv: tab-separated
                        values. A full matrix will be generated, gzip or bzip2
                        compression is supported and is inferred from the
                        output_file extension - parquet: apache parquet file.
                        A full matrix will be generated, export is handled by
                        pandas. - npy: The condensed distance matrix will be
                        written as npy file and the index will be written to
                        the [output_file].index file - tri: The condensed
                        matrix will be written as a lower triangular matrix
                        file, gzip or bzip2 compression is supported (default:
                        None)
  --nproc NPROC         Number of processes (default: 1)
  -v, --version         Print the version and exit
```

## phylophlan_strain_finder

### Tool Description
Analyzes the phylogeny and the mutation rates table generated by phylophlan and returns sub-trees representing the same strain, according to a phylogenetic threshold and a mutation rate threshold.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/biobakery/phylophlan
- **Package**: https://anaconda.org/channels/bioconda/packages/phylophlan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phylophlan_strain_finder [-h] -i INPUT -m MUTATION_RATES
                                [--phylo_thr PHYLO_THR]
                                [--mutrate_thr MUTRATE_THR]
                                [--tree_format {newick,nexus,phyloxml,cdao,nexml}]
                                [-o OUTPUT] [--overwrite] [-s {;,,,	}]
                                [--citation] [--verbose] [-v]

The phylophlan_strain_finder.py script analyzes the phylogeny and the mutation
rates table generated from the phylophlan.py script and returns sub-trees
representing the same strain, according to both a phylogenetic threshold
(computed on the normalized pairwise phylogenetic distances) and a mutation
rate threshold (computed on the aligned sequences of the markers used in the
phylogenetic analysis)

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     Specify the file of the phylogenetic tree as generated
                        from phylophlan.py
  -m, --mutation_rates MUTATION_RATES
                        Specify the file of the mutation rates as generated
                        from phylophlan.py
  --phylo_thr PHYLO_THR
                        Maximum phylogenetic distance threshold for every pair
                        of nodes in the same subtree (inclusive) (default:
                        0.05)
  --mutrate_thr MUTRATE_THR
                        Maximum mutation rate ratio for every pair of nodes in
                        the same subtree (inclusive) (default: 0.05)
  --tree_format {newick,nexus,phyloxml,cdao,nexml}
                        Specify the format of the input tree (default: newick)
  -o, --output OUTPUT   Specify the output filename, if not specified will be
                        stdout (default: None)
  --overwrite           Overwrite the output file if exists (default: False)
  -s, --separator {;,,,	}
                        Specify the separator to use in the output (default: )
  --citation            Show citation
  --verbose             Write more stuff (default: False)
  -v, --version         Prints the current phylophlan_strain_finder.py version
                        and exit
```

## phylophlan_get_reference

### Tool Description
Downloads a specified number of reference genomes from the Genbank repository for a taxonomic label (or all species), or lists the available clades.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/biobakery/phylophlan
- **Package**: https://anaconda.org/channels/bioconda/packages/phylophlan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phylophlan_get_reference [-h] [-g GET | -l] [--database_update]
                                [-e OUTPUT_FILE_EXTENSION] [-o OUTPUT]
                                [-n HOW_MANY] [-m GENBANK_MAPPING]
                                [--citation] [--verbose] [-v]

The phylophlan_get_reference.py script allows to download a specified number
(-n/--how_many) of reference genomes from the Genbank repository. Special case
"all" allows to download a specified number of reference genomes for all
available taxonomic species. With the -l/--list_clades params the
phylophlan_get_reference.py scripts returns the list of all species in the
database

options:
  -h, --help            show this help message and exit
  -g, --get GET         Specify the taxonomic label for which download the set
                        of reference genomes. The label must represent a valid
                        taxonomic level or the special case "all" (default:
                        None)
  -l, --list_clades     Print for all taxa the total number of species and
                        reference genomes available (default: False)
  --database_update     Update the databases file (default: False)
  -e, --output_file_extension OUTPUT_FILE_EXTENSION
                        Specify path to the extension of the output files
                        (default: .fna.gz)
  -o, --output OUTPUT   Specify path to the output folder where to save the
                        files, required when -g/--get is specified (default:
                        None)
  -n, --how_many HOW_MANY
                        Specify how many reference genomes to download, where
                        -1 stands for "all available" (default: 4)
  -m, --genbank_mapping GENBANK_MAPPING
                        The local GenBank mapping file, if not found it will
                        be automatically downloaded (default:
                        assembly_summary_genbank.txt)
  --citation            Show citation
  --verbose             Prints more stuff (default: False)
  -v, --version         Prints the current phylophlan_get_reference.py version
                        and exit
```

## phylophlan_assign_sgbs

### Tool Description
Assigns the SGB and taxonomy to a given set of input genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/biobakery/phylophlan
- **Package**: https://anaconda.org/channels/bioconda/packages/phylophlan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phylophlan_assign_sgbs [-h] [-i INPUT_DIRECTORY] [-e INPUT_EXTENSION]
                              [-o OUTPUT_DIRECTORY]
                              [--database_folder DATABASE_FOLDER]
                              [-d DATABASE] [--list_databases]
                              [--nproc_cpu NPROC_CPU] [--nproc_io NPROC_IO]
                              [--clean] [--citation] [-v]

The phylophlan_assign_sgbs script assigns the SGB and taxonomy to a given set
of input genomes.

options:
  -h, --help            show this help message and exit
  -i, --input_directory INPUT_DIRECTORY
                        Input folder containing genomes to be indexed
                        (default: None)
  -e, --input_extension INPUT_EXTENSION
                        Specify the extension of the input file(s) specified
                        via -i/--input. If not specified will use all files in
                        the directory (default: None)
  -o, --output_directory OUTPUT_DIRECTORY
                        Output directory (default: None)
  --database_folder DATABASE_FOLDER
                        Path to the folder that contains the database file
                        (default: phylophlan_databases/)
  -d, --database DATABASE
                        Database name, available options can be listed using
                        the --database_list parameter (default: None)
  --list_databases      List of all the available databases that can be
                        specified with the -d/--database option (default:
                        False)
  --nproc_cpu NPROC_CPU
                        The number of threads to use for CPU intensive jobs
                        (default: 1)
  --nproc_io NPROC_IO   The number of CPUs to use for I/O intensive jobs
                        (default: 1)
  --clean               Whether to clean the temporary directory (don't reuse
                        intermediate results) (default: False)
  --citation            Print citation and exit
  -v, --version         Print the version and exit
```

## phylophlan_assign_sgbs_legacy

### Tool Description
Assigns SGB and taxonomy to a given set of input genomes (older Mash-based version): the closest SGBs sorted by average Mash distance, the closest SGB, GGB, FGB and reference genomes, or an all-vs-all

### Metadata
- **Docker Image**: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/biobakery/phylophlan
- **Package**: https://anaconda.org/channels/bioconda/packages/phylophlan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phylophlan_assign_sgbs_legacy [-h] [-i INPUT] [-o OUTPUT_PREFIX]
                                     [-d DATABASE] [--database_list]
                                     [--database_update] [-e INPUT_EXTENSION]
                                     [-n HOW_MANY] [--nproc NPROC]
                                     [--database_folder DATABASE_FOLDER]
                                     [--only_input] [--add_ggb] [--add_fgb]
                                     [--overwrite] [--citation] [--verbose]
                                     [-v]

The phylophlan_metagenomic.py script assign SGB and taxonomy to a given set of
input genomes. Outputs can be of three types: (1) for each input genomes
returns the list of the closest -n/--how_many SGBs sorted by average Mash
distance; (2) for each input genomes returns the closest SGB, GGB, FGB, and
reference genomes; (3) returns a all vs. all matrix with all the pairwise mash
distances

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     Input folder containing the metagenomic bins to be
                        indexed (default: None)
  -o, --output_prefix OUTPUT_PREFIX
                        Prefix used for the output folders: indexed bins,
                        distance estimations. If not specified, the input
                        folder will be used (default: None)
  -d, --database DATABASE
                        Database name, available options can be listed using
                        the --database_list parameter (default: None)
  --database_list       List of all the available databases that can be
                        specified with the -d/--database option (default:
                        False)
  --database_update     Update the databases file (default: False)
  -e, --input_extension INPUT_EXTENSION
                        Specify the extension of the input file(s) specified
                        via -i/--input. If not specified will try to infer it
                        from the input files (default: None)
  -n, --how_many HOW_MANY
                        Specify the number of SGBs to report in the output;
                        "all" is a special value to report all the SGBs; this
                        param is not used when "--only_input" is specified
                        (default: 10)
  --nproc NPROC         The number of CPUs to use (default: 1)
  --database_folder DATABASE_FOLDER
                        Path to the folder that contains the database file
                        (default: phylophlan_databases/)
  --only_input          If specified provides a distance matrix between only
                        the input genomes provided (default: False)
  --add_ggb             If specified adds GGB assignments. If specified with
                        --add_fgb, then -n/--how_many will be set to 1 and
                        will be adding a column that reports the closest
                        reference genome (default: False)
  --add_fgb             If specified adds FGB assignments. If specified with
                        --add_ggb, then -n/--how_many will be set to 1 and
                        will be adding a column that reports the closest
                        reference genome (default: False)
  --overwrite           If specified overwrite the output file if exists
                        (default: False)
  --citation            Show citation
  --verbose             Prints more stuff (default: False)
  -v, --version         Prints the current phylophlan_metagenomic.py version
                        and exit
```

## phylophlan_draw_metagenomic

### Tool Description
Takes the output table of the phylophlan metagenomic assignment and produces two heatmap figures: presence/absence of the SGBs in the metagenomic samples, and the amount of kSGB, uSGB and unassigned f

### Metadata
- **Docker Image**: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/biobakery/phylophlan
- **Package**: https://anaconda.org/channels/bioconda/packages/phylophlan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phylophlan_draw_metagenomic [-h] -i INPUT -m MAP [--top TOP]
                                   [-o OUTPUT] [-s SEPARATOR] [--dpi DPI]
                                   [-f F] [--citation] [--verbose] [-v]

The phylophlan_draw_metagenomic.py script takes as input the output table
generated form the phylophlan_metagenomic.py script and produces two heatmap
figures: (1) presence/absence heatmap of the SGBs and the metagenomic samples
of the recontructed input genomes; and (2) heatmap showing the amount of kSGB,
uSGB, and unassigned for each metagenome

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     The input file generated from
                        phylophlan_metagenomic.py
  -m, --map MAP         A mapping file that maps each bin to its metagenome
  --top TOP             The number of SGBs to display in the figure (default:
                        20)
  -o, --output OUTPUT   Prefix output files (default: output_heatmap)
  -s, --separator SEPARATOR
                        The separator used in the mapping file (default: )
  --dpi DPI             Dpi resolution of the images (default: 200)
  -f F                  Images output format (default: svg)
  --citation            Show citation
  --verbose             Prints more stuff (default: False)
  -v, --version         Prints the current phylophlan_draw_metagenomic.py
                        version and exit
```


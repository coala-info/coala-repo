# gtdbtk CWL Generation Report

## gtdbtk_classify_wf

### Tool Description
Classify genomes using GTDB-Tk

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Total Downloads**: 194.1K
- **Last updated**: 2026-01-13
- **GitHub**: https://github.com/Ecogenomics/GTDBTk
- **Stars**: N/A
### Original Help Text
```text
usage: gtdbtk classify_wf (--genome_dir GENOME_DIR | --batchfile BATCHFILE)
                          --out_dir OUT_DIR
                          [--skani_sketch_dir SKANI_SKETCH_DIR]
                          [--skip_ani_screen] [-f] [-x EXTENSION]
                          [--min_perc_aa MIN_PERC_AA] [--prefix PREFIX]
                          [--genes] [--cpus CPUS]
                          [--pplacer_cpus PPLACER_CPUS] [--force]
                          [--scratch_dir SCRATCH_DIR]
                          [--write_single_copy_genes] [--keep_intermediates]
                          [--min_af MIN_AF] [--tmpdir TMPDIR] [--debug] [-h]

mutually exclusive required arguments:
  --genome_dir GENOME_DIR
                        directory containing genome files in FASTA format
  --batchfile BATCHFILE
                        path to file describing genomes - tab separated in 2
                        or 3 columns (FASTA file, genome ID, translation table
                        [optional])

required named arguments:
  --out_dir OUT_DIR     directory to output files

optional skani arguments:
  --skani_sketch_dir SKANI_SKETCH_DIR
                        directory to store skani sketch db for reference
                        genomes to reuse across runs.If not provided, a
                        temporary directory will be used. If provided for the
                        first time, the sketch db will be created in this
                        directory.

optional arguments:
  --skip_ani_screen     Skip the skani ANI screening step to classify genomes.
                        (default: False)
  -f, --full_tree       use the unsplit bacterial tree for the classify step;
                        this is the original GTDB-Tk approach (version < 2)
                        and requires more than 320 GB of RAM to load the
                        reference tree (default: False)
  -x, --extension EXTENSION
                        extension of files to process, gz = gzipped (default:
                        fna)
  --min_perc_aa MIN_PERC_AA
                        exclude genomes that do not have at least this
                        percentage of AA in the MSA (inclusive bound)
                        (default: 10)
  --prefix PREFIX       prefix for all output files (default: gtdbtk)
  --genes               indicates input files contain predicted proteins as
                        amino acids (skip gene calling).Warning: This flag
                        will skip the ANI comparison steps (ANI screen and
                        classification). (default: False)
  --cpus CPUS           number of CPUs to use (default: 1)
  --pplacer_cpus PPLACER_CPUS
                        number of CPUs to use during pplacer placement
  --force               continue processing if an error occurs on a single
                        genome (default: False)
  --scratch_dir SCRATCH_DIR
                        reduce pplacer memory usage by writing to disk
                        (slower).
  --write_single_copy_genes
                        output unaligned single-copy marker genes (default:
                        False)
  --keep_intermediates  keep intermediate files in the final directory
                        (default: False)
  --min_af MIN_AF       minimum alignment fraction to assign genome to a
                        species cluster (default: 0.5)
  --tmpdir TMPDIR       specify alternative directory for temporary files
                        (default: /tmp)
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message
```


## gtdbtk_de_novo_wf

### Tool Description
De novo workflow for GTDB-Tk

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk de_novo_wf (--genome_dir GENOME_DIR | --batchfile BATCHFILE)
                         (--bacteria | --archaea)
                         --outgroup_taxon OUTGROUP_TAXON --out_dir OUT_DIR
                         [-x EXTENSION] [--skip_gtdb_refs]
                         [--taxa_filter TAXA_FILTER]
                         [--min_perc_aa MIN_PERC_AA] [--custom_msa_filters]
                         [--cols_per_gene COLS_PER_GENE]
                         [--min_consensus MIN_CONSENSUS]
                         [--max_consensus MAX_CONSENSUS]
                         [--min_perc_taxa MIN_PERC_TAXA] [--rnd_seed RND_SEED]
                         [--prot_model {JTT,WAG,LG}] [--no_support] [--gamma]
                         [--gtdbtk_classification_file GTDBTK_CLASSIFICATION_FILE]
                         [--custom_taxonomy_file CUSTOM_TAXONOMY_FILE]
                         [--write_single_copy_genes] [--prefix PREFIX]
                         [--genes] [--cpus CPUS] [--force] [--tmpdir TMPDIR]
                         [--keep_intermediates] [--debug] [-h]

mutually exclusive required arguments:
  --genome_dir GENOME_DIR
                        directory containing genome files in FASTA format
  --batchfile BATCHFILE
                        path to file describing genomes - tab separated in 2
                        or 3 columns (FASTA file, genome ID, translation table
                        [optional])

mutually exclusive required arguments:
  --bacteria            process bacterial genomes (default: False)
  --archaea             process archaeal genomes (default: False)

required named arguments:
  --outgroup_taxon OUTGROUP_TAXON
                        taxon to use as outgroup (e.g., p__Patescibacteriota
                        or p__Altiarchaeota)
  --out_dir OUT_DIR     directory to output files

optional arguments:
  -x, --extension EXTENSION
                        extension of files to process, gz = gzipped (default:
                        fna)
  --skip_gtdb_refs      do not include GTDB reference genomes in multiple
                        sequence alignment. (default: False)
  --taxa_filter TAXA_FILTER
                        filter GTDB genomes to taxa (comma separated) within
                        specific taxonomic groups (e.g.: d__Bacteria or
                        p__Proteobacteria,p__Actinobacteria)
  --min_perc_aa MIN_PERC_AA
                        exclude genomes that do not have at least this
                        percentage of AA in the MSA (inclusive bound)
                        (default: 10)
  --custom_msa_filters  perform custom filtering of MSA with cols_per_gene,
                        min_consensus max_consensus, and min_perc_taxa
                        parameters instead of using canonical mask (default:
                        False)
  --cols_per_gene COLS_PER_GENE
                        maximum number of columns to retain per gene when
                        generating the MSA (default: 42)
  --min_consensus MIN_CONSENSUS
                        minimum percentage of the same amino acid required to
                        retain column (inclusive bound) (default: 25)
  --max_consensus MAX_CONSENSUS
                        maximum percentage of the same amino acid required to
                        retain column (exclusive bound) (default: 95)
  --min_perc_taxa MIN_PERC_TAXA
                        minimum percentage of taxa required to retain column
                        (inclusive bound) (default: 50)
  --rnd_seed RND_SEED   random seed to use for selecting columns, e.g. 42
  --prot_model {JTT,WAG,LG}
                        protein substitution model for tree inference
                        (default: WAG)
  --no_support          do not compute local support values using the
                        Shimodaira-Hasegawa test (default: False)
  --gamma               rescale branch lengths to optimize the Gamma20
                        likelihood (default: False)
  --gtdbtk_classification_file GTDBTK_CLASSIFICATION_FILE
                        file with GTDB-Tk classifications produced by the
                        `classify` command
  --custom_taxonomy_file CUSTOM_TAXONOMY_FILE
                        file indicating custom taxonomy strings for user
                        genomes, that should contain any genomes belonging to
                        the outgroup. Format:
                        GENOME_ID<TAB>d__;p__;c__;o__;f__;g__;s__
  --write_single_copy_genes
                        output unaligned single-copy marker genes (default:
                        False)
  --prefix PREFIX       prefix for all output files (default: gtdbtk)
  --genes               indicates input files contain predicted proteins as
                        amino acids (skip gene calling).Warning: This flag
                        will skip the ANI comparison steps (ANI screen and
                        classification). (default: False)
  --cpus CPUS           number of CPUs to use (default: 1)
  --force               continue processing if an error occurs on a single
                        genome (default: False)
  --tmpdir TMPDIR       specify alternative directory for temporary files
                        (default: /tmp)
  --keep_intermediates  keep intermediate files in the final directory
                        (default: False)
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message
```


## gtdbtk_identify

### Tool Description
Identify GTDB-Tk classifications for genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk identify (--genome_dir GENOME_DIR | --batchfile BATCHFILE)
                       --out_dir OUT_DIR [-x EXTENSION] [--prefix PREFIX]
                       [--genes] [--cpus CPUS] [--force]
                       [--write_single_copy_genes] [--tmpdir TMPDIR] [--debug]
                       [-h]

mutually exclusive required arguments:
  --genome_dir GENOME_DIR
                        directory containing genome files in FASTA format
  --batchfile BATCHFILE
                        path to file describing genomes - tab separated in 2
                        or 3 columns (FASTA file, genome ID, translation table
                        [optional])

required named arguments:
  --out_dir OUT_DIR     directory to output files

optional arguments:
  -x, --extension EXTENSION
                        extension of files to process, gz = gzipped (default:
                        fna)
  --prefix PREFIX       prefix for all output files (default: gtdbtk)
  --genes               indicates input files contain predicted proteins as
                        amino acids (skip gene calling).Warning: This flag
                        will skip the ANI comparison steps (ANI screen and
                        classification). (default: False)
  --cpus CPUS           number of CPUs to use (default: 1)
  --force               continue processing if an error occurs on a single
                        genome (default: False)
  --write_single_copy_genes
                        output unaligned single-copy marker genes (default:
                        False)
  --tmpdir TMPDIR       specify alternative directory for temporary files
                        (default: /tmp)
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message
```


## gtdbtk_align

### Tool Description
Aligns genomes to create a multiple sequence alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk align --identify_dir IDENTIFY_DIR --out_dir OUT_DIR
                    [--skip_gtdb_refs] [--taxa_filter TAXA_FILTER]
                    [--min_perc_aa MIN_PERC_AA]
                    [--cols_per_gene COLS_PER_GENE]
                    [--min_consensus MIN_CONSENSUS]
                    [--max_consensus MAX_CONSENSUS]
                    [--min_perc_taxa MIN_PERC_TAXA] [--rnd_seed RND_SEED]
                    [--prefix PREFIX] [--cpus CPUS] [--tmpdir TMPDIR]
                    [--debug] [-h] [--custom_msa_filters | --skip_trimming]

required named arguments:
  --identify_dir IDENTIFY_DIR
                        output directory of 'identify' command
  --out_dir OUT_DIR     directory to output files

optional arguments:
  --skip_gtdb_refs      do not include GTDB reference genomes in multiple
                        sequence alignment. (default: False)
  --taxa_filter TAXA_FILTER
                        filter GTDB genomes to taxa (comma separated) within
                        specific taxonomic groups (e.g.: d__Bacteria or
                        p__Proteobacteria,p__Actinobacteria)
  --min_perc_aa MIN_PERC_AA
                        exclude genomes that do not have at least this
                        percentage of AA in the MSA (inclusive bound)
                        (default: 10)
  --cols_per_gene COLS_PER_GENE
                        maximum number of columns to retain per gene when
                        generating the MSA (default: 42)
  --min_consensus MIN_CONSENSUS
                        minimum percentage of the same amino acid required to
                        retain column (inclusive bound) (default: 25)
  --max_consensus MAX_CONSENSUS
                        maximum percentage of the same amino acid required to
                        retain column (exclusive bound) (default: 95)
  --min_perc_taxa MIN_PERC_TAXA
                        minimum percentage of taxa required to retain column
                        (inclusive bound) (default: 50)
  --rnd_seed RND_SEED   random seed to use for selecting columns, e.g. 42
  --prefix PREFIX       prefix for all output files (default: gtdbtk)
  --cpus CPUS           number of CPUs to use (default: 1)
  --tmpdir TMPDIR       specify alternative directory for temporary files
                        (default: /tmp)
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message

mutually exclusive optional arguments:
  --custom_msa_filters  perform custom filtering of MSA with cols_per_gene,
                        min_consensus max_consensus, and min_perc_taxa
                        parameters instead of using canonical mask (default:
                        False)
  --skip_trimming       skip the trimming step and return the full MSAs
                        (default: False)
```


## gtdbtk_classify

### Tool Description
Classify genomes using GTDB-Tk

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk classify (--genome_dir GENOME_DIR | --batchfile BATCHFILE)
                       --align_dir ALIGN_DIR --out_dir OUT_DIR
                       [--skip_ani_screen] [-x EXTENSION] [--prefix PREFIX]
                       [--cpus CPUS] [--pplacer_cpus PPLACER_CPUS]
                       [--scratch_dir SCRATCH_DIR] [--genes] [-f]
                       [--min_af MIN_AF] [--tmpdir TMPDIR] [--debug] [-h]

mutually exclusive required arguments:
  --genome_dir GENOME_DIR
                        directory containing genome files in FASTA format
  --batchfile BATCHFILE
                        path to file describing genomes - tab separated in 2
                        or 3 columns (FASTA file, genome ID, translation table
                        [optional])

required named arguments:
  --align_dir ALIGN_DIR
                        output directory of 'align' command
  --out_dir OUT_DIR     directory to output files

optional arguments:
  --skip_ani_screen     Skip the skani ANI screening step to classify genomes.
                        (default: False)
  -x, --extension EXTENSION
                        extension of files to process, gz = gzipped (default:
                        fna)
  --prefix PREFIX       prefix for all output files (default: gtdbtk)
  --cpus CPUS           number of CPUs to use (default: 1)
  --pplacer_cpus PPLACER_CPUS
                        number of CPUs to use during pplacer placement
  --scratch_dir SCRATCH_DIR
                        reduce pplacer memory usage by writing to disk
                        (slower).
  --genes               indicates input files contain predicted proteins as
                        amino acids (skip gene calling).Warning: This flag
                        will skip the ANI comparison steps (ANI screen and
                        classification). (default: False)
  -f, --full_tree       use the unsplit bacterial tree for the classify step;
                        this is the original GTDB-Tk approach (version < 2)
                        and requires more than 320 GB of RAM to load the
                        reference tree (default: False)
  --min_af MIN_AF       minimum alignment fraction to assign genome to a
                        species cluster (default: 0.5)
  --tmpdir TMPDIR       specify alternative directory for temporary files
                        (default: /tmp)
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message
```


## gtdbtk_infer

### Tool Description
Infer phylogenetic trees for GTDB-Tk

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk infer --msa_file MSA_FILE --out_dir OUT_DIR
                    [--prot_model {JTT,WAG,LG}] [--no_support] [--gamma]
                    [--prefix PREFIX] [--cpus CPUS] [--tmpdir TMPDIR]
                    [--debug] [-h]

required named arguments:
  --msa_file MSA_FILE   multiple sequence alignment in FASTA format
  --out_dir OUT_DIR     directory to output files

optional arguments:
  --prot_model {JTT,WAG,LG}
                        protein substitution model for tree inference
                        (default: WAG)
  --no_support          do not compute local support values using the
                        Shimodaira-Hasegawa test (default: False)
  --gamma               rescale branch lengths to optimize the Gamma20
                        likelihood (default: False)
  --prefix PREFIX       prefix for all output files (default: gtdbtk)
  --cpus CPUS           number of CPUs to use (default: 1)
  --tmpdir TMPDIR       specify alternative directory for temporary files
                        (default: /tmp)
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message
```


## gtdbtk_root

### Tool Description
Root a tree using a specified outgroup taxon.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk root --input_tree INPUT_TREE --outgroup_taxon OUTGROUP_TAXON
                   --output_tree OUTPUT_TREE
                   [--gtdbtk_classification_file GTDBTK_CLASSIFICATION_FILE]
                   [--custom_taxonomy_file CUSTOM_TAXONOMY_FILE]
                   [--tmpdir TMPDIR] [--debug] [-h]

required named arguments:
  --input_tree INPUT_TREE
                        path to the unrooted tree in Newick format
  --outgroup_taxon OUTGROUP_TAXON
                        taxon to use as outgroup (e.g., p__Patescibacteriota
                        or p__Altiarchaeota)
  --output_tree OUTPUT_TREE
                        path to output the tree

optional arguments:
  --gtdbtk_classification_file GTDBTK_CLASSIFICATION_FILE
                        file with GTDB-Tk classifications produced by the
                        `classify` command
  --custom_taxonomy_file CUSTOM_TAXONOMY_FILE
                        file indicating custom taxonomy strings for user
                        genomes, that should contain any genomes belonging to
                        the outgroup. Format:
                        GENOME_ID<TAB>d__;p__;c__;o__;f__;g__;s__
  --tmpdir TMPDIR       specify alternative directory for temporary files
                        (default: /tmp)
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message
```


## gtdbtk_decorate

### Tool Description
Decorate a tree with GTDB-Tk classifications and custom taxonomy.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk decorate --input_tree INPUT_TREE --output_tree OUTPUT_TREE
                       [--gtdbtk_classification_file GTDBTK_CLASSIFICATION_FILE]
                       [--custom_taxonomy_file CUSTOM_TAXONOMY_FILE]
                       [--tmpdir TMPDIR] [--debug] [-h]

required named arguments:
  --input_tree INPUT_TREE
                        path to the unrooted tree in Newick format
  --output_tree OUTPUT_TREE
                        path to output the tree

optional arguments:
  --gtdbtk_classification_file GTDBTK_CLASSIFICATION_FILE
                        file with GTDB-Tk classifications produced by the
                        `classify` command
  --custom_taxonomy_file CUSTOM_TAXONOMY_FILE
                        file indicating custom taxonomy strings for user
                        genomes, that should contain any genomes belonging to
                        the outgroup. Format:
                        GENOME_ID<TAB>d__;p__;c__;o__;f__;g__;s__
  --tmpdir TMPDIR       specify alternative directory for temporary files
                        (default: /tmp)
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message
```


## gtdbtk_infer_ranks

### Tool Description
Root the input tree at the specified ingroup taxon and output the rooted tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk infer_ranks --input_tree INPUT_TREE
                          --ingroup_taxon INGROUP_TAXON
                          --output_tree OUTPUT_TREE [--tmpdir TMPDIR]
                          [--debug] [-h]

required named arguments:
  --input_tree INPUT_TREE
                        rooted input tree with labelled ingroup taxon
  --ingroup_taxon INGROUP_TAXON
                        labelled ingroup taxon to use as root for establishing
                        RED values (e.g., c__Bacilli or f__Lactobacillaceae
  --output_tree OUTPUT_TREE
                        path to output the tree

optional arguments:
  --tmpdir TMPDIR       specify alternative directory for temporary files
                        (default: /tmp)
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message
```


## gtdbtk_ani_rep

### Tool Description
Calculate ANI scores between genomes and assign them to species clusters.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk ani_rep (--genome_dir GENOME_DIR | --batchfile BATCHFILE)
                      --out_dir OUT_DIR [--min_af MIN_AF]
                      [--skani_sketch_dir SKANI_SKETCH_DIR] [-x EXTENSION]
                      [--prefix PREFIX] [--cpus CPUS] [--tmpdir TMPDIR]
                      [--debug] [-h]

mutually exclusive required arguments:
  --genome_dir GENOME_DIR
                        directory containing genome files in FASTA format
  --batchfile BATCHFILE
                        path to file describing genomes - tab separated in 2
                        or 3 columns (FASTA file, genome ID, translation table
                        [optional])

required named arguments:
  --out_dir OUT_DIR     directory to output files

optional clustering arguments:
  --min_af MIN_AF       minimum alignment fraction to assign genome to a
                        species cluster (default: 0.5)
  --skani_sketch_dir SKANI_SKETCH_DIR
                        directory to store skani sketch db for reference
                        genomes to reuse across runs.If not provided, a
                        temporary directory will be used. If provided for the
                        first time, the sketch db will be created in this
                        directory.

optional arguments:
  -x, --extension EXTENSION
                        extension of files to process, gz = gzipped (default:
                        fna)
  --prefix PREFIX       prefix for all output files (default: gtdbtk)
  --cpus CPUS           number of CPUs to use (default: 1)
  --tmpdir TMPDIR       specify alternative directory for temporary files
                        (default: /tmp)
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message
```


## gtdbtk_trim_msa

### Tool Description
Trims an MSA based on a mask file or reference mask.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk trim_msa --untrimmed_msa UNTRIMMED_MSA --output OUTPUT
                       (--mask_file MASK_FILE | --reference_mask {arc,bac})
                       [--debug] [-h]

required named arguments:
  --untrimmed_msa UNTRIMMED_MSA
                        path to the untrimmed MSA file
  --output OUTPUT       output file

mutually exclusive required arguments:
  --mask_file MASK_FILE
                        path to a custom mask file for trimming the MSA
  --reference_mask {arc,bac}
                        reference mask already present in GTDB-Tk

optional arguments:
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message
```


## gtdbtk_export_msa

### Tool Description
Export MSA from GTDB-Tk

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk export_msa --domain {arc,bac} --output OUTPUT [--debug] [-h]

required named arguments:
  --domain {arc,bac}  domain to export
  --output OUTPUT     output file

optional arguments:
  --debug             create intermediate files for debugging purposes
                      (default: False)
  -h, --help          show help message
```


## gtdbtk_remove_labels

### Tool Description
Removes labels from a GTDB-Tk tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk remove_labels --input_tree INPUT_TREE --output_tree OUTPUT_TREE
                            [--debug] [-h]

required named arguments:
  --input_tree INPUT_TREE
                        path to the unrooted tree in Newick format
  --output_tree OUTPUT_TREE
                        path to output the tree

optional arguments:
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message
```


## gtdbtk_convert_to_itol

### Tool Description
Convert GTDB-Tk trees to iTOL format

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk convert_to_itol --input_tree INPUT_TREE
                              --output_tree OUTPUT_TREE [--debug] [-h]

required named arguments:
  --input_tree INPUT_TREE
                        path to the unrooted tree in Newick format
  --output_tree OUTPUT_TREE
                        path to output the tree

optional arguments:
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message
```


## gtdbtk_convert_to_species

### Tool Description
Convert a tree to a species-resolved tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdbtk convert_to_species --input_tree INPUT_TREE
                                 --output_tree OUTPUT_TREE
                                 [--custom_taxonomy_file CUSTOM_TAXONOMY_FILE]
                                 [--all_ranks] [--debug] [-h]

required named arguments:
  --input_tree INPUT_TREE
                        path to the unrooted tree in Newick format
  --output_tree OUTPUT_TREE
                        path to output the tree

optional arguments:
  --custom_taxonomy_file CUSTOM_TAXONOMY_FILE
                        file indicating custom taxonomy strings for user
                        genomes, that should contain any genomes belonging to
                        the outgroup. Format:
                        GENOME_ID<TAB>d__;p__;c__;o__;f__;g__;s__
  --all_ranks           add all missing ranks to the leaf nodes if they are
                        present in the reference tree. (default: False)
  --debug               create intermediate files for debugging purposes
                        (default: False)
  -h, --help            show help message
```


## gtdbtk_test

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[2026-02-25 21:58:32] INFO: GTDB-Tk v2.6.1
[2026-02-25 21:58:32] INFO: gtdbtk test

================================================================================
                                     ERROR                                      
________________________________________________________________________________

          The 'GTDBTK_DATA_PATH' environment variable is not defined.           

            Please set this variable to your reference data package.            
           https://ecogenomics.github.io/GTDBTk/installing/index.html           
================================================================================
[2026-02-25 21:58:32] ERROR: Controlled exit resulting from early termination.
```


## gtdbtk_check_install

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
- **Homepage**: http://pypi.python.org/pypi/gtdbtk/
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdbtk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[2026-02-25 21:58:59] INFO: GTDB-Tk v2.6.1
[2026-02-25 21:58:59] INFO: gtdbtk check_install

================================================================================
                                     ERROR                                      
________________________________________________________________________________

          The 'GTDBTK_DATA_PATH' environment variable is not defined.           

            Please set this variable to your reference data package.            
           https://ecogenomics.github.io/GTDBTk/installing/index.html           
================================================================================
[2026-02-25 21:58:59] ERROR: Controlled exit resulting from early termination.
```


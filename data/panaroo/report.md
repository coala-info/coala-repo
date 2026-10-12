# panaroo CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| panaroo | PASS |  |
| panaroo_extract_gene | PASS |  |
| panaroo_filter_pa | PASS |  |
| panaroo_fmg | Not completed | with 4 genomes and a substitution-rate tree (no dated tree) the likelihood is NaN and the estimates are at the lower bound, so the result cannot be confirmed |
| panaroo_gene_neighbourhood | PASS |  |
| panaroo_generate_gffs | PASS |  |
| panaroo_img | PASS |  |
| panaroo_integrate | Failed | tool bug: the new genome is named x in the presence/absence tables (only final_graph.gml gets the real name) |
| panaroo_merge | PASS |  |
| panaroo_msa | PASS |  |
| panaroo_plot_abundance | PASS |  |
| panaroo_qc | PASS |  |
| panaroo_run_prokka | PASS |  |
| panaroo_spydrpick | PASS |  |

## panaroo

### Tool Description
an updated pipeline for pangenome investigation

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Total Downloads**: 53.9K
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/gtonkinhill/panaroo
- **Stars**: N/A
### Original Help Text
```text
usage: panaroo [-h] -i INPUT_FILES [INPUT_FILES ...] -o OUTPUT_DIR
               --clean-mode {strict,moderate,sensitive}
               [--remove-invalid-genes] [-c ID] [-f FAMILY_THRESHOLD]
               [--len_dif_percent LEN_DIF_PERCENT]
               [--family_len_dif_percent FAMILY_LEN_DIF_PERCENT]
               [--merge_paralogs] [--search_radius SEARCH_RADIUS]
               [--refind_prop_match REFIND_PROP_MATCH]
               [--refind-mode {default,strict,off}]
               [--min_trailing_support MIN_TRAILING_SUPPORT]
               [--trailing_recursive TRAILING_RECURSIVE]
               [--edge_support_threshold EDGE_SUPPORT_THRESHOLD]
               [--length_outlier_support_proportion LENGTH_OUTLIER_SUPPORT_PROPORTION]
               [--remove_by_consensus {True,False}]
               [--high_var_flag CYCLE_THRESHOLD_MIN]
               [--min_edge_support_sv MIN_EDGE_SUPPORT_SV]
               [--all_seq_in_graph] [--no_clean_edges] [-a {core,pan}]
               [--aligner {prank,clustal,mafft,none}] [--codons]
               [--core_threshold CORE] [--core_subset SUBSET]
               [--core_entropy_filter HC_THRESHOLD] [-t N_CPU]
               [--codon-table TABLE] [--quiet] [--version]

panaroo: an updated pipeline for pangenome investigation

options:
  -h, --help            show this help message and exit
  -t N_CPU, --threads N_CPU
                        number of threads to use (default=1)
  --codon-table TABLE   the codon table to use for translation (default=11)
  --quiet               suppress additional output
  --version             show program's version number and exit

Input/output:
  -i INPUT_FILES [INPUT_FILES ...], --input INPUT_FILES [INPUT_FILES ...]
                        input GFF3 files (usually output from running Prokka).
                        Can also take a file listing each gff file line by
                        line.
  -o OUTPUT_DIR, --out_dir OUTPUT_DIR
                        location of an output directory

Mode:
  --clean-mode {strict,moderate,sensitive}
                        The stringency mode at which to run panaroo. Must be
                        one of 'strict','moderate' or 'sensitive'. Each of
                        these modes can be fine tuned using the additional
                        parameters in the 'Graph correction' section.
                        
                        strict:
                        Requires fairly strong evidence (present in  at least
                        5% of genomes) to keep likely contaminant genes. Will
                        remove genes that are refound more often than they were
                        called originally.
                        
                        moderate:
                        Requires moderate evidence (present in  at least 1% of
                        genomes) to keep likely contaminant genes. Keeps genes
                        that are refound more often than they were called
                        originally.
                        
                        sensitive:
                        Does not delete any genes and only performes merge and
                        refinding operations. Useful if rare plasmids are of
                        interest as these are often hard to disguish from
                        contamination. Results will likely include  higher
                        number of spurious annotations.
  --remove-invalid-genes
                        removes annotations that do not conform to the
                        expected Prokka format such as those including
                        premature stop codons.

Matching:
  -c ID, --threshold ID
                        sequence identity threshold (default=0.98)
  -f FAMILY_THRESHOLD, --family_threshold FAMILY_THRESHOLD
                        protein family sequence identity threshold
                        (default=0.7)
  --len_dif_percent LEN_DIF_PERCENT
                        length difference cutoff (default=0.98)
  --family_len_dif_percent FAMILY_LEN_DIF_PERCENT
                        length difference cutoff at the gene family level
                        (default=0.0)
  --merge_paralogs      don't split paralogs

Refind:
  --search_radius SEARCH_RADIUS
                        the distance in nucleotides surronding the neighbour
                        of an accessory gene in which to search for it
  --refind_prop_match REFIND_PROP_MATCH
                        the proportion of an accessory gene that must be found
                        in order to consider it a match
  --refind-mode {default,strict,off}
                        The stringency mode at which to re-find genes.
                        
                        default:
                        Will re-find similar gene sequences. Allows for
                        premature stop codons and incorrect lengths to account
                        for misassemblies.
                        
                        strict:
                        Prevents fragmented, misassembled, or potential
                        pseudogene sequences from being re-found.
                        
                        off:
                        Turns off all re-finding steps.

Graph correction:
  --min_trailing_support MIN_TRAILING_SUPPORT
                        minimum cluster size to keep a gene called at the end
                        of a contig
  --trailing_recursive TRAILING_RECURSIVE
                        number of times to perform recursive trimming of low
                        support nodes near the end of contigs
  --edge_support_threshold EDGE_SUPPORT_THRESHOLD
                        minimum support required to keep an edge that has been
                        flagged as a possible mis-assembly
  --length_outlier_support_proportion LENGTH_OUTLIER_SUPPORT_PROPORTION
                        proportion of genomes supporting a gene with a length
                        more than 1.5x outside the interquatile range for
                        genes in the same cluster (default=0.01). Genes
                        failing this test will be re-annotated at the shorter
                        length
  --remove_by_consensus {True,False}
                        if a gene is called in the same region with similar
                        sequence a minority of the time, remove it. One of
                        'True' or 'False'
  --high_var_flag CYCLE_THRESHOLD_MIN
                        minimum number of nested cycles to call a highly
                        variable gene region (default = 5).
  --min_edge_support_sv MIN_EDGE_SUPPORT_SV
                        minimum edge support required to call structural
                        variants in the presence/absence sv file
  --all_seq_in_graph    Retains all DNA sequence for each gene cluster in the
                        graph output. Off by default as it uses a large amount
                        of space.
  --no_clean_edges      Turn off edge filtering in the final output graph.

Gene alignment:
  -a {core,pan}, --alignment {core,pan}
                        Output alignments of core genes or all genes. Options
                        are 'core' and 'pan'. Default: 'None'
  --aligner {prank,clustal,mafft,none}
                        Specify an aligner. Options:'prank', 'clustal', and
                        default: 'mafft'
  --codons              Generate codon alignments by aligning sequences at the
                        protein level
  --core_threshold CORE
                        Core-genome sample threshold (default=0.95)
  --core_subset SUBSET  Randomly subset the core genome to these many genes
                        (default=all)
  --core_entropy_filter HC_THRESHOLD
                        Manually set the Block Mapping and Gathering with
                        Entropy (BMGE) filter. Can be between 0.0 and 1.0. By
                        default this is set using the Tukey outlier method.
```

## panaroo_qc

### Tool Description
Generate quality control plots and tables (contamination, number of contigs and genes, MDS) before a Panaroo run.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: plot_panaroo_qc [-h] -i INPUT_FILES [INPUT_FILES ...] -o OUTPUT_DIR
                       [-t N_CPU]
                       [--graph_type {all,contam,ncontigs,ngenes,mds}]
                       [--no_plot] [--random_seed RANDOM_SEED]
                       [--ref_db REF_DB] [--version]

Generate quality control plots prior to a Panaroo run

options:
  -h, --help            show this help message and exit
  -t N_CPU, --threads N_CPU
                        number of threads to use (default=1)
  --graph_type {all,contam,ncontigs,ngenes,mds}
                        the type of graph to generate (default='all')
  --no_plot             don't generate the plots. Will only create the data
                        tables
  --random_seed RANDOM_SEED
                        random seed for reproducibility (default=1)
  --ref_db REF_DB       reference mash database for contamination
                        quantification.
  --version             show program's version number and exit

Input/output:
  -i INPUT_FILES [INPUT_FILES ...], --input INPUT_FILES [INPUT_FILES ...]
                        input GFF3 files (usually output from running Prokka)
  -o OUTPUT_DIR, --out_dir OUTPUT_DIR
                        location of an output directory
```

## panaroo_merge

### Tool Description
Merge independent runs of Panaroo into one pangenome graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panaroo_merge_graphs [-h] -d DIRECTORIES [DIRECTORIES ...] -o
                            OUTPUT_DIR [-c ID] [-f FAMILY_THRESHOLD]
                            [--len_dif_percent LEN_DIF_PERCENT]
                            [--family_len_dif_percent FAMILY_LEN_DIF_PERCENT]
                            [--merge_paralogs]
                            [--length_outlier_support_proportion LENGTH_OUTLIER_SUPPORT_PROPORTION]
                            [--min_edge_support_sv MIN_EDGE_SUPPORT_SV]
                            [-a {core,pan}] [--aligner {prank,clustal,mafft}]
                            [--codons] [--core_threshold CORE]
                            [--core_subset SUBSET]
                            [--core_entropy_filter HC_THRESHOLD] [-t N_CPU]
                            [--quiet] [--version]

Merge independent runs of Panaroo

options:
  -h, --help            show this help message and exit
  --min_edge_support_sv MIN_EDGE_SUPPORT_SV
                        minimum edge support required to call structural
                        variants in the presence/absence sv file
                        (default=max(2, 0.01*n_samples))
  -t N_CPU, --threads N_CPU
                        number of threads to use (default=1)
  --quiet               suppress additional output
  --version             show program's version number and exit

Input/output:
  -d DIRECTORIES [DIRECTORIES ...], --directories DIRECTORIES [DIRECTORIES ...]
                        Location of separate Panaroo output directories
  -o OUTPUT_DIR, --out_dir OUTPUT_DIR
                        location of a new output directory

Matching:
  -c ID, --threshold ID
                        sequence identity threshold (default=0.95)
  -f FAMILY_THRESHOLD, --family_threshold FAMILY_THRESHOLD
                        protein family sequence identity threshold
                        (default=0.7)
  --len_dif_percent LEN_DIF_PERCENT
                        length difference cut-off (default=0.95)
  --family_len_dif_percent FAMILY_LEN_DIF_PERCENT
                        length difference cutoff at the gene family level
                        (default=0.0)
  --merge_paralogs      don't split paralogs
  --length_outlier_support_proportion LENGTH_OUTLIER_SUPPORT_PROPORTION
                        proportion of genomes supporting a gene with a length
                        more than 1.5x outside the interquartile range for
                        genes in the same cluster (default=0.01). Genes
                        failing this test will be re-annotated at the shorter
                        length

Gene alignment:
  -a {core,pan}, --alignment {core,pan}
                        Output alignments of core genes or all genes. Options
                        are 'core' and 'pan'. Default: 'None'
  --aligner {prank,clustal,mafft}
                        Specify an aligner. Options:'prank', 'clustal', and
                        default: 'mafft'
  --codons              Generate codon alignments by aligning sequences at the
                        protein level
  --core_threshold CORE
                        Core-genome sample threshold (default=0.95)
  --core_subset SUBSET  Randomly subset the core genome to these many genes
                        (default=all)
  --core_entropy_filter HC_THRESHOLD
                        Manually set the Block Mapping and Gathering with
                        Entropy (BMGE) filter. Can be between 0.0 and 1.0. By
                        default this is set using the Tukey outlier method.
```

## panaroo_integrate

### Tool Description
Integrate a new GFF file into a pre-existing Panaroo graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panaroo_integrate [-h] -d INPUT_DIR -i INPUT_GFF -o OUTPUT_DIR
                         [--remove-invalid-genes] [-c ID]
                         [-f FAMILY_THRESHOLD]
                         [--len_dif_percent LEN_DIF_PERCENT]
                         [--merge_paralogs]
                         [--length_outlier_support_proportion LENGTH_OUTLIER_SUPPORT_PROPORTION]
                         [--family_len_dif_percent FAMILY_LEN_DIF_PERCENT]
                         [--min_edge_support_sv MIN_EDGE_SUPPORT_SV]
                         [-a {core,pan}] [--aligner {prank,clustal,mafft}]
                         [--codons] [--core_threshold CORE]
                         [--core_subset SUBSET]
                         [--core_entropy_filter HC_THRESHOLD]
                         [--all_seq_in_graph] [-t N_CPU] [--codon-table TABLE]
                         [--quiet] [--dirty] [--version']

Integrate new gff file into pre-existing graph

options:
  -h, --help            show this help message and exit
  --min_edge_support_sv MIN_EDGE_SUPPORT_SV
                        minimum edge support required to call structural
                        variants in the presence/absence csv file
                        (default=max(2, 0.01*n_samples))
  -t N_CPU, --threads N_CPU
                        number of threads to use (default=1)
  --codon-table TABLE   the codon table to use for translation (default=11)
  --quiet               suppress additional output
  --dirty               keep temporary directory containing cluster files and
                        cdhit output
  --version'            show program's version number and exit

Input/output:
  -d INPUT_DIR, --input_dir INPUT_DIR
                        input directory for gml of pre-existing panaroo output
  -i INPUT_GFF, --input_gff INPUT_GFF
                        input gff file of new genome to be integrated
  -o OUTPUT_DIR, --out_dir OUTPUT_DIR
                        location of a new output directory
  --remove-invalid-genes
                        removes annotations that do not conform to the
                        expected Prokka format such as those including
                        premature stop codons.

Matching:
  -c ID, --threshold ID
                        sequence identity threshold (default=0.95)
  -f FAMILY_THRESHOLD, --family_threshold FAMILY_THRESHOLD
                        protein family sequence identity threshold
                        (default=0.7)
  --len_dif_percent LEN_DIF_PERCENT
                        length difference cutoff (default=0.95)
  --merge_paralogs      don't split paralogs
  --length_outlier_support_proportion LENGTH_OUTLIER_SUPPORT_PROPORTION
                        proportion of genomes supporting a gene with a length
                        more than 1.5x outside the interquatile range for
                        genes in the same cluster (default=0.01). Genes
                        failing this test will be re-annotated at the shorter
                        length
  --family_len_dif_percent FAMILY_LEN_DIF_PERCENT
                        length difference cutoff at the gene family level
                        (default=0.0)

Gene alignment:
  -a {core,pan}, --alignment {core,pan}
                        Output alignments of core genes or all genes. Options
                        are 'core' and 'pan'. Default: 'None'
  --aligner {prank,clustal,mafft}
                        Specify an aligner. Options:'prank', 'clustal', and
                        default: 'mafft'
  --codons              Generate codon alignments by aligning sequences at the
                        protein level
  --core_threshold CORE
                        Core-genome sample threshold (default=0.95)
  --core_subset SUBSET  Randomly subset the core genome to these many genes
                        (default=all)
  --core_entropy_filter HC_THRESHOLD
                        Manually set the Block Mapping and Gathering with
                        Entropy (BMGE) filter. Can be between 0.0 and 1.0. By
                        default this is set using the Tukey outlier method.

Graph correction:
  --all_seq_in_graph    Retains all DNA sequence for each gene cluster in the
                        graph output. Off by default as it uses a large amount
                        of space.
```

## panaroo_msa

### Tool Description
Generate multiple sequence alignments of core or pan genes after a Panaroo run. The Panaroo output directory is updated in place.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: generate_panaroo_msa [-h] -o OUTPUT_DIR [-a {core,pan}]
                            [--aligner {prank,clustal,mafft,none}] [--codons]
                            [--core_threshold CORE] [--core_subset SUBSET]
                            [--core_entropy_filter HC_THRESHOLD] [-t N_CPU]
                            [--verbose] [--version]

Generate multiple sequence alignments after running Panaroo

options:
  -h, --help            show this help message and exit
  -t N_CPU, --threads N_CPU
                        number of threads to use (default=1)
  --verbose             print additional output
  --version             show program's version number and exit

Input/output:
  -o OUTPUT_DIR, --out_dir OUTPUT_DIR
                        location of the Panaroo output directory

Gene alignment:
  -a {core,pan}, --alignment {core,pan}
                        Output alignments of core genes or all genes. Options
                        are 'core' and 'pan'. Default: 'None'
  --aligner {prank,clustal,mafft,none}
                        Specify an aligner. Options:'prank', 'clustal', and
                        default: 'mafft'
  --codons              Generate codon alignments by aligning sequences at the
                        protein level
  --core_threshold CORE
                        Core-genome sample threshold (default=0.95)
  --core_subset SUBSET  Subset the core genome to these many random genes
                        (default=all)
  --core_entropy_filter HC_THRESHOLD
                        Manually set the Block Mapping and Gathering with
                        Entropy (BMGE) filter. Can be between 0.0 and 1.0. By
                        default this is set using the Tukey outlier method.
```

## panaroo_spydrpick

### Tool Description
Identify associations between genes with the Spydrpick algorithm from a Panaroo gene presence/absence file.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panaroo-spydrpick [-h] -i PA_FILE -o OUTPUT_DIR [--tree TREE_FILE]
                         [--clusters CLUSTER_FILE] [--quantile QUANTILE]
                         [--aracne] [--version]

Identify associations between genes using the Spydrpick algorithm

options:
  -h, --help            show this help message and exit
  --quantile QUANTILE   the quantile used to determine a threshold for keeping
                        MI values (default=0.9).
  --aracne              turn on the Aracne stage of the algorithm (see the
                        Spydrpick paper for details).
  --version             show program's version number and exit

Input/output:
  -i PA_FILE, --input PA_FILE
                        gene presence absence file (.Rtab) generated by
                        Panaroo
  -o OUTPUT_DIR, --out_dir OUTPUT_DIR
                        location of an output directory
  --tree TREE_FILE      phylogeny in newick format for weigting samples to
                        control for population structure
  --clusters CLUSTER_FILE
                        sample clusters for weigting to control for population
                        structure. format: 'sample_name,cluster_id'
```

## panaroo_img

### Tool Description
Estimate parameters of the Infinitely Many Genes model from Panaroo gene frequencies or core/pangenome sizes.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panaroo_img_est [-h] [--tree TREE] --pa PRESENCE_ABSENCE -o OUTPUT_DIR
                       -D {1,2} [--no_essential] [--no_constraint]
                       [--model {coalescent,fixed}] [--fit {cp,gf}]
                       [--init_u1 U1] [--init_u2 U2] [--init_v1 V1]
                       [--init_v2 V2] [--init_ess GESS] [--verbose]
                       [--version]

Estimate model parameters for either the Infinitely Many Genes Model using
gene frequencies

options:
  -h, --help            show this help message and exit
  --tree TREE           A dated phylogeny.
  --pa PRESENCE_ABSENCE
                        A presence/absence produced by Panaroo.
  -o OUTPUT_DIR, --out_dir OUTPUT_DIR
                        location of an output directory
  -D {1,2}              Number of separate rate classes to use for the
                        dispensable genome. Can be either 1 or 2.
  --no_essential        Removes essential gene class from model
  --no_constraint       Removes constraint that u/v must equal the genome
                        size.
  --model {coalescent,fixed}
                        Model to fit. Can be one of 'coalescent' or 'fixed'.
  --fit {cp,gf}         Whether to use the gene frequency spectrum or the
                        core/pangenome size for fitting (default=gf)
  --init_u1 U1          Initial value for u1 (default=0.01).
  --init_u2 U2          Initial value for u2 (default=0.01).
  --init_v1 V1          Initial value for v1 (default=0.01).
  --init_v2 V2          Initial value for v2 (default=0.01).
  --init_ess GESS       Initial value for the number of essential genes
                        (default=2000).
  --verbose             print additional output
  --version             show program's version number and exit
```

## panaroo_fmg

### Tool Description
Estimate parameters of the Finitely Many Genes model from a dated phylogeny and a Panaroo presence/absence file.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panaroo_fmg_est [-h] --tree TREE --pa PRESENCE_ABSENCE -o OUTPUTFILE
                       [--nboot NBOOT] [-t N_CPU] [--verbose] [--version]

Estimate model parameters for either the Finitely Many Genes Model

options:
  -h, --help            show this help message and exit
  --tree TREE           A dated phylogeny.
  --pa PRESENCE_ABSENCE
                        A presence/absence produced by Panaroo.
  -o OUTPUTFILE, --outfile OUTPUTFILE
                        Name of outputfile.
  --nboot NBOOT         The number of sub-sampling bootstrap iterations to
                        perform.
  -t N_CPU, --threads N_CPU
                        number of threads to use (default=1)
  --verbose             print additional output
  --version             show program's version number and exit
```

## panaroo_plot_abundance

### Tool Description
Generate gene abundance and pangenome size estimation plots from a Panaroo gene presence/absence file.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: plot_panaroo_summary [-h] -i PA_FILE -o OUTPUT_DIR
                            [--graph_type {jack2,acc,ICE,jack1,chao2,all}]
                            [--nboot NBOOT] [--version]

Generate summary plots from Panaroo run

options:
  -h, --help            show this help message and exit
  --graph_type {jack2,acc,ICE,jack1,chao2,all}
                        the type of graph to generate
  --nboot NBOOT         the number of bootstrap replicates (default=100)
  --version             show program's version number and exit

Input/output:
  -i PA_FILE, --input PA_FILE
                        gene presence absence file generated by Panaroo
  -o OUTPUT_DIR, --out_dir OUTPUT_DIR
                        location of an output directory
```

## panaroo_gene_neighbourhood

### Tool Description
Explore the neighbourhood of a gene in a Panaroo pangenome graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panaroo-gene-neighbourhood [-h] --gene GENE [--genome_id GENOME_ID]
                                  --graph GRAPH [--expand_no EXPAND_NO]
                                  [--out OUT]

Explore gene neighbourhood

options:
  -h, --help            show this help message and exit
  --gene GENE           gene of interest
  --genome_id GENOME_ID
                        genome ID of interest (default=ALL)
  --graph GRAPH         genome graph gml ('final_graph.gml')
  --expand_no EXPAND_NO
                        lengths of the path that will be expanded on in a
                        radius the target gene (default=5)
  --out OUT             output file
```

## panaroo_extract_gene

### Tool Description
Extract fasta files for given gene names from a Panaroo pangenome graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panaroo_extract_fasta [-h] -q QUERIES [QUERIES ...] --pa PA_FILE --gene
                             GENE_DATA -o OUTPUT_DIR [--dna]
                             [--idtype {gene,isolate,both}] [--version]

Extracts fasta files for a given gene name from a Panaroo pangenome graph.

options:
  -h, --help            show this help message and exit
  -q QUERIES [QUERIES ...], --queries QUERIES [QUERIES ...]
                        A list of gene names to extract
  --pa PA_FILE          The 'gene_presence_absence.csv' file output by Panaroo
  --gene GENE_DATA      The 'gene_data.csv' file output by Panaroo
  -o OUTPUT_DIR, --out_dir OUTPUT_DIR
                        location of an output directory
  --dna                 toggles the output of nucleotide sequence instead of
                        protein sequence
  --idtype {gene,isolate,both}
                        toggles the id type to use in the output multifasta.
                        Can be one of 'gene' (default), 'isolate' or 'both'
  --version             show program's version number and exit
```

## panaroo_filter_pa

### Tool Description
Filter the Panaroo gene_presence_absence.csv file to exclude sequences classed as length outliers, pseudogenes or fragmented. The tool builds the output names from the input path, so the input file is staged in the working directory and given by its file name.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panaroo_filter_pa [-h] -i INPUT_FILE -o OUTPUT_DIR [--type TYPE]
                         [--version]

Filters the Panaroo gene_presence_absence.csv file to exclude sequences
classed as length outliers, pseudogenes or fragmented.

options:
  -h, --help            show this help message and exit
  --type TYPE           any combination of 'pseudo', 'length' or 'frag'
                        separated by commas
  --version             show program's version number and exit

Input/output:
  -i INPUT_FILE, --input INPUT_FILE
                        input 'gene_presence_absence.csv' file generated by
                        Panaroo
  -o OUTPUT_DIR, --out_dir OUTPUT_DIR
                        location of an output directory
```

## panaroo_generate_gffs

### Tool Description
Generate GFF annotation files for each isolate from the Panaroo pangenome graph. The Panaroo output directory is updated in place.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: generate_gff_files [-h] -o OUTPUT_DIR -i INPUT_FILES [INPUT_FILES ...]
                          [-f {prokka,gff3}] [-t N_CPU] [--verbose]

Generate GFF annotation files for each isolate from the pan-genome graph

options:
  -h, --help            show this help message and exit
  -t N_CPU, --threads N_CPU
                        number of threads to use (default=1)
  --verbose             print additional output

Input/output:
  -o OUTPUT_DIR, --out_dir OUTPUT_DIR
                        location of the Panaroo output directory
  -i INPUT_FILES [INPUT_FILES ...], --input INPUT_FILES [INPUT_FILES ...]
                        input GFF3 files used to run panaroo. These are
                        required Can also take a file listing each gff file
                        line by line.

GFFs:
  -f {prokka,gff3}, --f {prokka,gff3}
                        Output format for the GFF files. 'prokka' with
                        included FASTA, or strict 'gff3'. Default: 'prokka'
```

## panaroo_run_prokka

### Tool Description
Re-run gene finding and annotation (Prokka) on genome fasta files so that they can be used as Panaroo input.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: run_prokka [-h] -i INPUT_FILES [INPUT_FILES ...] -o OUTPUT_DIR
                  [--force] [--add_prokka_cmds ADD_PROKKA_CMDS]
                  [--num_training NUM_TRAINING] [-t N_CPU] [--verbose]
                  [--version]

Re-run gene finding and annotation

options:
  -h, --help            show this help message and exit
  -t N_CPU, --threads N_CPU
                        number of threads to use (default=1)
  --verbose             print additional output
  --version             show program's version number and exit

Input/output:
  -i INPUT_FILES [INPUT_FILES ...], --input INPUT_FILES [INPUT_FILES ...]
                        input fasta files
  -o OUTPUT_DIR, --out_dir OUTPUT_DIR
                        location of an output directory
  --force               overwrite old commands

Prokka/prodigal command:
  --add_prokka_cmds ADD_PROKKA_CMDS
                        additional commands to supply to Prokka (these are not
                        checked!)
  --num_training NUM_TRAINING
                        number of genomes to use in training prodigal
                        (default=10)
```

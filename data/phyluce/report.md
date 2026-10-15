# phyluce CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phyluce_phyluce_align_add_missing_data_designators | PASS |  |
| phyluce_phyluce_align_convert_degen_bases | PASS | tested with FASTA output; --output-format nexus (the default) crashes in this image with a Biopython alphabet error |
| phyluce_phyluce_align_convert_one_align_to_another | PASS |  |
| phyluce_phyluce_align_explode_alignments | PASS |  |
| phyluce_phyluce_align_extract_taxa_from_alignments | PASS |  |
| phyluce_phyluce_align_extract_taxon_fasta_from_alignments | PASS |  |
| phyluce_phyluce_align_filter_alignments | PASS |  |
| phyluce_phyluce_align_filter_characters_from_alignments | PASS |  |
| phyluce_phyluce_align_format_concatenated_phylip_for_paml | PASS |  |
| phyluce_phyluce_align_format_nexus_files_for_mrbayes | PASS |  |
| phyluce_phyluce_align_format_nexus_files_for_raxml | PASS |  |
| phyluce_phyluce_align_get_align_summary_data | PASS |  |
| phyluce_phyluce_align_get_aligns_partitioned_by_cluster | PASS | synthetic data: cluster CSV built from invariant and variable sites of real alignments; tested with FASTA output, NEXUS output crashes in this image with a Biopython alphabet error |
| phyluce_phyluce_align_get_bed_from_lastz | PASS |  |
| phyluce_phyluce_align_get_gblocks_trimmed_alignments_from_untrimmed | PASS |  |
| phyluce_phyluce_align_get_incomplete_matrix_estimates | PASS |  |
| phyluce_phyluce_align_get_indels_from_alignments | PASS |  |
| phyluce_phyluce_align_get_informative_sites | PASS |  |
| phyluce_phyluce_align_get_only_loci_with_min_taxa | PASS |  |
| phyluce_phyluce_align_get_ry_recoded_alignments | PASS |  |
| phyluce_phyluce_align_get_smilogram_from_alignments | PASS |  |
| phyluce_phyluce_align_get_taxon_locus_counts_in_alignments | PASS |  |
| phyluce_phyluce_align_get_trimal_trimmed_alignments_from_untrimmed | PASS |  |
| phyluce_phyluce_align_get_trimmed_alignments_from_untrimmed | PASS |  |
| phyluce_phyluce_align_move_align_by_conf_file | PASS |  |
| phyluce_phyluce_align_output_list_of_taxon_counts | PASS |  |
| phyluce_phyluce_align_parallel_sate | Failed | image problem: run_sate.py (SATe) is not installed in the image, so the tool crashes with OSError |
| phyluce_phyluce_align_randomly_sample_and_concatenate | PASS |  |
| phyluce_phyluce_align_reduce_alignments_with_raxml | PASS | synthetic data: real alignments with 5 gap-only columns inserted; RAxML removed them |
| phyluce_phyluce_align_remove_empty_taxa | PASS |  |
| phyluce_phyluce_align_remove_locus_name_from_nexus_lines | PASS |  |
| phyluce_phyluce_align_screen_alignments_for_problems | PASS |  |
| phyluce_phyluce_align_seqcap_align | PASS |  |
| phyluce_phyluce_align_split_concat_nexus_to_loci | Failed | image problem: Biopython in the image cannot parse the charpartition line of NEXUS files written by phyluce itself (NexusError) |
| phyluce_phyluce_assembly_assemblo_abyss | PASS | 24 contigs and 7282 bp, same as the expected test set (run with --abyss-se) |
| phyluce_phyluce_assembly_assemblo_spades | PASS |  |
| phyluce_phyluce_assembly_assemblo_trinity | Failed | image problem: Trinity in the image stops with 'jellyfish: not found' |
| phyluce_phyluce_assembly_assemblo_velvet | PASS | 24 contigs, 18616 bp (expected 18635 bp); 12 contigs identical to the expected set |
| phyluce_phyluce_assembly_copy_trinity_symlinks | PASS | synthetic data: symlink folder planted from the real Trinity test contigs; wrapper copies the link targets so the output can be collected |
| phyluce_phyluce_assembly_explode_get_fastas_file | PASS | 4 per-taxon files with the same sequences as the expected test files |
| phyluce_phyluce_assembly_extract_contigs_to_barcodes | PASS | extracted the named contig from the real barcode test contigs |
| phyluce_phyluce_assembly_filter_seqs_from_fastas | PASS | short sequences removed by median-length cut-off (11 removed), checked by hand |
| phyluce_phyluce_assembly_get_bed_for_genome_enabled_taxon | PASS | synthetic data: sliced-contig headers planted from real probe hits; BED has the 20 expected loci |
| phyluce_phyluce_assembly_get_fasta_lengths | PASS | 24 contigs and 20187 bp, same as counted with Biopython |
| phyluce_phyluce_assembly_get_fastas_from_match_counts | PASS |  |
| phyluce_phyluce_assembly_get_fastq_lengths | PASS | 7404 reads and 677024 bp, same as the expected value in the phyluce tests |
| phyluce_phyluce_assembly_get_match_counts | PASS |  |
| phyluce_phyluce_assembly_get_trinity_coverage | Failed | image problem: the GATK jar is not in the image (GenomeAnalysisTK asks for gatk3-register), so no coverage file is made |
| phyluce_phyluce_assembly_get_trinity_coverage_for_uce_loci | Not completed | needs the coverage files of get_trinity_coverage, which cannot run in this image (GATK jar missing) |
| phyluce_phyluce_assembly_match_contigs_to_barcodes | Failed | image problem: python module requests is missing in the image |
| phyluce_phyluce_assembly_match_contigs_to_probes | PASS | match counts 24/24, 20/20, 16/21 and 6/6 contigs, same as the expected probe_match_results.csv |
| phyluce_phyluce_assembly_parse_trinity_coverage_for_uce_loci_log | PASS | synthetic data: log lines written in the format the coverage tool prints; the --output option crashes in the tool (use standard output) |
| phyluce_phyluce_assembly_parse_trinity_coverage_log | PASS | synthetic data: log lines written in the format the coverage tool prints |
| phyluce_phyluce_assembly_screen_probes_for_dupes | PASS | listed the duplicate probes found in a real probe self-to-self lastz file |
| phyluce_phyluce_genetrees_generate_multilocus_bootstrap_count | PASS |  |
| phyluce_phyluce_genetrees_get_mean_bootrep_support | PASS |  |
| phyluce_phyluce_genetrees_get_tree_counts | PASS |  |
| phyluce_phyluce_genetrees_locus_stats | Failed | tool bug: the script leaves a pdb.set_trace() in its last loop, so it always stops with BdbQuit and writes no result. |
| phyluce_phyluce_genetrees_order_gene_tree_file | Failed | image problem: the python module ete2 is missing in the image (ImportError). |
| phyluce_phyluce_genetrees_phybase | Failed | image problem: the python module rpy2 is missing in the image (ImportError). |
| phyluce_phyluce_genetrees_reformat_raxml_output | PASS |  |
| phyluce_phyluce_genetrees_reformat_trees | PASS |  |
| phyluce_phyluce_genetrees_rename_tree_leaves | PASS |  |
| phyluce_phyluce_genetrees_run_raxml_bootstraps | PASS |  |
| phyluce_phyluce_genetrees_run_raxml_genetrees | PASS |  |
| phyluce_phyluce_genetrees_run_raxml_multilocus_bootstraps | PASS |  |
| phyluce_phyluce_genetrees_sort_multilocus_bootstraps | PASS |  |
| phyluce_phyluce_genetrees_split_models_from_genetrees | PASS | synthetic data: a two-line CloudForest-style genetree file was planted because no real one exists; the locus and model table came out correctly. |
| phyluce_phyluce_ncbi_chunk_fasta_for_ncbi | PASS | 24 records split into chunks of 10, 10 and 4 |
| phyluce_phyluce_ncbi_prep_uce_align_files_for_ncbi | PASS |  |
| phyluce_phyluce_ncbi_prep_uce_align_files_for_ncbi_targeted_locus_db | PASS |  |
| phyluce_phyluce_ncbi_prep_uce_fasta_files_for_ncbi | Failed | image problem: python module seqtools is missing in the image |
| phyluce_phyluce_probe_easy_lastz | PASS |  |
| phyluce_phyluce_probe_get_clusters_from_bed | PASS | Probe BED names were rewritten to the probes-id\|probes-locus form from real lastz probe hits; the JSON clusters are correct. |
| phyluce_phyluce_probe_get_clusters_from_taxa | Failed | tool bug: add_new_locus_numbers_to_rest starts at mx instead of mx+1, so the first unclustered probe (id 3) gets locus 0 and joins the real cluster of probes 697-699 (probes table built from the probe headers). |
| phyluce_phyluce_probe_get_genome_sequences_from_bed | PASS |  |
| phyluce_phyluce_probe_get_locus_bed_from_lastz_files | PASS |  |
| phyluce_phyluce_probe_get_multi_fasta_table | PASS |  |
| phyluce_phyluce_probe_get_multi_merge_table | PASS |  |
| phyluce_phyluce_probe_get_probe_bed_from_lastz_files | PASS |  |
| phyluce_phyluce_probe_get_screened_loci_by_proximity | PASS |  |
| phyluce_phyluce_probe_get_subsets_of_tiled_probes | PASS |  |
| phyluce_phyluce_probe_get_tiled_probe_from_multiple_inputs | PASS |  |
| phyluce_phyluce_probe_get_tiled_probes | PASS |  |
| phyluce_phyluce_probe_query_multi_fasta_table | PASS |  |
| phyluce_phyluce_probe_query_multi_merge_table | PASS |  |
| phyluce_phyluce_probe_reconstruct_uce_from_probe | PASS |  |
| phyluce_phyluce_probe_remove_duplicate_hits_from_probes_using_lastz | PASS |  |
| phyluce_phyluce_probe_remove_overlapping_probes_given_config | PASS |  |
| phyluce_phyluce_probe_run_multiple_lastzs_sqlite | PASS |  |
| phyluce_phyluce_probe_slice_sequence_from_genomes | PASS |  |
| phyluce_phyluce_probe_strip_masked_loci_from_set | PASS |  |
| phyluce_phyluce_snp_bwa_align | PASS |  |
| phyluce_phyluce_snp_bwa_multiple_align | PASS |  |
| phyluce_phyluce_snp_convert_vcf_to_snapp | PASS |  |
| phyluce_phyluce_snp_convert_vcf_to_structure | PASS |  |
| phyluce_phyluce_snp_find_snps_in_bed_interval | PASS |  |
| phyluce_phyluce_snp_get_dbsnp_freq_stats | Failed | image problem: phyluce.helpers.get_xml_data uses etree without importing it (NameError), and lxml is not installed in the image. |
| phyluce_phyluce_snp_get_dbsnp_variability_for_all_uces | Failed | image problem: phyluce.helpers.get_xml_data uses etree without importing it (NameError), and lxml is not installed in the image. |
| phyluce_phyluce_snp_get_from_uce_alignments | Failed | image problem: the python module cogent is missing in the image (ImportError). |
| phyluce_phyluce_snp_phase_uces | PASS |  |
| phyluce_phyluce_snp_prep_interval_list_file_for_picard | PASS |  |
| phyluce_phyluce_snp_screen_phased_alignments | PASS |  |
| phyluce_phyluce_snp_screen_vcf_files | PASS |  |
| phyluce_phyluce_snp_summarize_vcf_file | PASS |  |
| phyluce_phyluce_utilities_cleanup_trinity | PASS | synthetic data: Trinity folder layout planted; only Trinity.fasta and trinity.log are kept |
| phyluce_phyluce_utilities_combine_reads | PASS | two read folders merged; read count doubled as expected |
| phyluce_phyluce_utilities_filter_bed_by_fasta | PASS | kept the 6 BED loci that are in the FASTA, plus the track line (standard output mode) |
| phyluce_phyluce_utilities_get_bed_from_fasta | PASS | synthetic data: sliced-contig FASTA headers planted; 20 BED rows with the locus prefix |
| phyluce_phyluce_utilities_merge_multiple_gzip_files | PASS | two gz read files merged into one with twice the reads |
| phyluce_phyluce_utilities_merge_next_seq_gzip_files | PASS | two lanes merged per read; twice the reads in each output |
| phyluce_phyluce_utilities_replace_many_links | PASS | synthetic data: symlink planted; new target path used and copied by the wrapper |
| phyluce_phyluce_utilities_sample_reads_from_files | PASS | 200 reads sampled as set in the config (100 UCE, 30 mtDNA, 70 genome) |
| phyluce_phyluce_utilities_unmix_fasta_reads | PASS | 100 R1, 100 R2 and 5 singleton reads from reads in new-style format; the tool only runs with --new-style |

## phyluce_phyluce_assembly_assemblo_spades

### Tool Description
Assemble raw reads using SPAdes

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Total Downloads**: 36.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/faircloth-lab/phyluce
- **Stars**: N/A
### Original Help Text
```text
usage: phyluce_assembly_assemblo_spades [-h] --output OUTPUT [--cores CORES]
                                        [--subfolder SUBFOLDER]
                                        [--verbosity {INFO,WARN,CRITICAL}]
                                        [--log-path LOG_PATH] [--do-not-clean]
                                        (--config CONFIG | --dir DIR)

Assemble raw reads using SPAdes

optional arguments:
  -h, --help            show this help message and exit
  --output OUTPUT       The directory in which to store the assembly data
  --cores CORES         The number of compute cores/threads to run with SPAdes
  --subfolder SUBFOLDER
                        A subdirectory, below the level of the group,
                        containing the reads
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use
  --log-path LOG_PATH   The path to a directory to hold logs.
  --do-not-clean        Do not cleanup intermediate SPAdes files
  --config CONFIG       A configuration file containing reads to assemble
  --dir DIR             A directory of reads to assemble
```


## phyluce_phyluce_assembly_get_match_counts

### Tool Description
Given an SQL database of UCE loci and a taxon-set file, output those taxa and those loci in complete and incomplete data matrices.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_get_match_counts [-h] --locus-db LOCUS_DB
                                         --taxon-list-config TAXON_LIST_CONFIG
                                         --taxon-group TAXON_GROUP --output
                                         OUTPUT [--incomplete-matrix]
                                         [--verbosity {INFO,WARN,CRITICAL}]
                                         [--log-path LOG_PATH] [--optimize]
                                         [--random] [--samples SAMPLES]
                                         [--sample-size SAMPLE_SIZE]
                                         [--extend-locus-db EXTEND_LOCUS_DB]
                                         [--silent] [--keep-counts]

Given an SQL database of UCE loci and a taxon-set file, output those taxa and
those loci in complete and incomplete data matrices.

optional arguments:
  -h, --help            show this help message and exit
  --locus-db LOCUS_DB   The SQL database file holding probe matches to
                        targeted loci (usually "lastz/probe.matches.sqlite".)
  --taxon-list-config TAXON_LIST_CONFIG
                        The config file containing lists of the taxa you want
                        to include in matrices.
  --taxon-group TAXON_GROUP
                        The [group] in the config file whose specific data
                        matrix you want to create.
  --output OUTPUT       The path to the output file you want to create.
  --incomplete-matrix   Generate an incomplete matrix of data.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --optimize            Return optimum groups of probes by enumeration
                        (default) or sampling.
  --random              Optimize by sampling.
  --samples SAMPLES     The number of samples to take.
  --sample-size SAMPLE_SIZE
                        The group size of samples.
  --extend-locus-db EXTEND_LOCUS_DB
                        An SQLlite database file holding probe matches to
                        other targeted loci
  --silent              Don't print probe names.
  --keep-counts
```


## phyluce_phyluce_assembly_get_fastas_from_match_counts

### Tool Description
Given an input SQL database of UCE locus matches, a config file containing the loci in your data matrix, and the contigs you have assembled, extract the fastas for each locus for each taxon in the assembled contigs, and rename those to the appropriate UCE loci, outputting the results as a single monolithic FASTA file containing all records. Can also incorporate data from genome-enabled taxa or other studies using the --extend-db and --extend- contigs parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_get_fastas_from_match_counts [-h] --contigs CONTIGS
                                                     --locus-db LOCUS_DB
                                                     --match-count-output
                                                     MATCH_COUNT_OUTPUT
                                                     [--incomplete-matrix INCOMPLETE_MATRIX]
                                                     --output OUTPUT
                                                     [--verbosity {INFO,WARN,CRITICAL}]
                                                     [--log-path LOG_PATH]
                                                     [--extend-locus-db EXTEND_LOCUS_DB]
                                                     [--extend-locus-contigs EXTEND_LOCUS_CONTIGS]

Given an input SQL database of UCE locus matches, a config file containing the
loci in your data matrix, and the contigs you have assembled, extract the
fastas for each locus for each taxon in the assembled contigs, and rename
those to the appropriate UCE loci, outputting the results as a single
monolithic FASTA file containing all records. Can also incorporate data from
genome-enabled taxa or other studies using the --extend-db and --extend-
contigs parameters.

optional arguments:
  -h, --help            show this help message and exit
  --contigs CONTIGS     The directory containing the assembled contigs in
                        which you searched for UCE loci. (default: None)
  --locus-db LOCUS_DB   The SQL database file holding probe matches to
                        targeted loci (usually "lastz/probe.matches.sqlite").
                        (default: None)
  --match-count-output MATCH_COUNT_OUTPUT
                        The output file containing taxa and loci in
                        complete/incomplete matrices generated by
                        get_match_counts.py. (default: None)
  --incomplete-matrix INCOMPLETE_MATRIX
                        The path to the outfile for incomplete-matrix records.
                        Required when processing an incomplete data matrix.
                        (default: False)
  --output OUTPUT       The path to the output FASTA file you want to create.
                        (default: None)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --extend-locus-db EXTEND_LOCUS_DB
                        An SQLlite database file holding probe matches to
                        other targeted loci. (default: None)
  --extend-locus-contigs EXTEND_LOCUS_CONTIGS
                        A directory holding the assembled contigs (from
                        genomes or another study) referenced by --extend-
                        locus-db. (default: None)
```


## phyluce_phyluce_align_seqcap_align

### Tool Description
Align and possibly trim records in a monolithic UCE FASTA file with MAFFT or MUSCLE

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_seqcap_align [-h] --fasta FASTA --output OUTPUT --taxa
                                  TAXA [--aligner {muscle,mafft}]
                                  [--output-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                  [--verbosity {INFO,WARN,CRITICAL}]
                                  [--log-path LOG_PATH] [--incomplete-matrix]
                                  [--no-trim] [--window WINDOW]
                                  [--proportion PROPORTION]
                                  [--threshold THRESHOLD]
                                  [--max-divergence MAX_DIVERGENCE]
                                  [--min-length MIN_LENGTH] [--ambiguous]
                                  [--cores CORES]

Align and possibly trim records in a monolithic UCE FASTA file with MAFFT or
MUSCLE

optional arguments:
  -h, --help            show this help message and exit
  --fasta FASTA         The file containing FASTA reads associated with
                        targted loci from get_fastas_from_match_counts.py
                        (default: None)
  --output OUTPUT       The directory in which to store the resulting
                        alignments. (default: None)
  --taxa TAXA           Number of taxa expected in each alignment. (default:
                        None)
  --aligner {muscle,mafft}
                        The alignment engine to use. (default: mafft)
  --output-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The output alignment format. (default: nexus)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --incomplete-matrix   Allow alignments that do not contain all --taxa.
                        (default: False)
  --no-trim             Align, but DO NOT trim alignments. (default: False)
  --window WINDOW       Sliding window size for trimming. (default: 20)
  --proportion PROPORTION
                        The proportion of taxa required to have sequence at
                        alignment ends. (default: 0.65)
  --threshold THRESHOLD
                        The proportion of residues required across the window
                        in proportion of taxa. (default: 0.65)
  --max-divergence MAX_DIVERGENCE
                        The max proportion of sequence divergence allowed
                        between any row of the alignment and the alignment
                        consensus. (default: 0.2)
  --min-length MIN_LENGTH
                        The minimum length of alignments to keep. (default:
                        100)
  --ambiguous           Allow reads in alignments containing N-bases.
                        (default: False)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
```


## phyluce_phyluce_align_get_only_loci_with_min_taxa

### Tool Description
Screen a directory of alignments, only returning those containing >= --percent of taxa

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_only_loci_with_min_taxa [-h] --alignments ALIGNMENTS
                                                 --taxa TAXA --output OUTPUT
                                                 [--percent PERCENT]
                                                 [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                                 [--verbosity {INFO,WARN,CRITICAL}]
                                                 [--log-path LOG_PATH]
                                                 [--cores CORES]

Screen a directory of alignments, only returning those containing >= --percent
of taxa

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments to screen.
                        (default: None)
  --taxa TAXA           The total number of taxa in all alignments. (default:
                        None)
  --output OUTPUT       The output dir in which to store copies of the
                        alignments (default: None)
  --percent PERCENT     The percent of taxa to require (default: 0.75)
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format. (default: nexus)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
```


## phyluce_phyluce_align_get_trimmed_alignments_from_untrimmed

### Tool Description
Use the PHYLUCE trimming algorithm to trim existing alignments in parallel

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_trimmed_alignments_from_untrimmed [-h] --alignments
                                                           ALIGNMENTS --output
                                                           OUTPUT
                                                           [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                                           [--output-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                                           [--verbosity {INFO,WARN,CRITICAL}]
                                                           [--log-path LOG_PATH]
                                                           [--window WINDOW]
                                                           [--proportion PROPORTION]
                                                           [--threshold THRESHOLD]
                                                           [--max_divergence MAX_DIVERGENCE]
                                                           [--min-length MIN_LENGTH]
                                                           [--cores CORES]

Use the PHYLUCE trimming algorithm to trim existing alignments in parallel

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments to be trimmed.
                        (default: None)
  --output OUTPUT       The directory in which to store the resulting
                        alignments. (default: None)
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format. (default: fasta)
  --output-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The output alignment format. (default: nexus)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --window WINDOW       Sliding window size for trimming. (default: 20)
  --proportion PROPORTION
                        The proportion of taxa required to have sequence at
                        alignment ends. (default: 0.65)
  --threshold THRESHOLD
                        The proportion of residues required across the window
                        in proportion of taxa. (default: 0.65)
  --max_divergence MAX_DIVERGENCE
                        The max proportion of sequence divergence allowed
                        between any row of the alignment and the alignment
                        consensus. (default: 0.2)
  --min-length MIN_LENGTH
                        The minimum length of alignments to keep. (default:
                        100)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
```


## phyluce_phyluce_align_get_align_summary_data

### Tool Description
Compute summary statistics for alignments in parallel

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_align_summary_data [-h] --alignments ALIGNMENTS
                                            [--input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}]
                                            [--show-taxon-counts]
                                            [--verbosity {INFO,WARN,CRITICAL}]
                                            [--log-path LOG_PATH]
                                            [--cores CORES]
                                            [--output-stats OUTPUT]

Compute summary statistics for alignments in parallel

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments to be summarized.
                        (default: None)
  --input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}
                        The input alignment format. (default: nexus)
  --show-taxon-counts   Show the count of loci with X taxa. (default: False)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
  --output-stats OUTPUT
                        Output a CSV-formatted file of stats, by locus
                        (default: None)
```


## phyluce_phyluce_probe_easy_lastz

### Tool Description
Run lastz in an easy way

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_easy_lastz [-h] --target TARGET --query QUERY --output
                                OUTPUT [--identity IDENTITY]
                                [--coverage COVERAGE | --min_match MIN_MATCH]

Run lastz in an easy way

optional arguments:
  -h, --help            show this help message and exit
  --target TARGET       The path to the target file (2bit/fasta)
  --query QUERY         The path to the query file (2bit/fasta)
  --output OUTPUT       The path to the output file
  --identity IDENTITY   The minimum percent identity to require for a match
  --coverage COVERAGE   The minimum coverage (%) required for a match
  --min_match MIN_MATCH
                        The minimum number of base pairs required for a match
```

## phyluce_phyluce_probe_get_clusters_from_bed

### Tool Description
Program description

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_get_clusters_from_bed [-h] --bed BED --outdir OUTDIR
                                           [--files FILES [FILES ...]]

Program description

optional arguments:
  -h, --help            show this help message and exit
  --bed BED             The BED directory you want to search for clusters
  --outdir OUTDIR       The output directory to store results
  --files FILES [FILES ...]
                        Specific files in the directory you want to process
```

## phyluce_phyluce_probe_get_clusters_from_taxa

### Tool Description
Program description

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_get_clusters_from_taxa [-h] --clusters CLUSTERS --db DB
                                            [--taxa TAXA [TAXA ...]]

Program description

optional arguments:
  -h, --help            show this help message and exit
  --clusters CLUSTERS   The directory containing cluster files
  --db DB               The database to update
  --taxa TAXA [TAXA ...]
                        The taxon overlaps to use
```

## phyluce_phyluce_probe_get_genome_sequences_from_bed

### Tool Description
Given an input BED file for one taxon, slice out genomic sequence given coordinates

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_get_genome_sequences_from_bed [-h] --bed BED --twobit
                                                   TWOBIT --output OUTPUT
                                                   [--filter-mask MASK]
                                                   [--max-n MAX_N]
                                                   [--buffer-to BUFFER_TO]

Given an input BED file for one taxon, slice out genomic sequence given
coordinates

optional arguments:
  -h, --help            show this help message and exit
  --bed BED             The input BED file
  --twobit TWOBIT       The input genome to slice in UCSC 2bit format
  --output OUTPUT       The output fasta file
  --filter-mask MASK    Filter strings with > X frequency of masked bases
  --max-n MAX_N         The maximum number of ambiguous bases ('N') to accept
  --buffer-to BUFFER_TO
                        The length to which to buffer the extracted sequences
```

## phyluce_phyluce_probe_get_locus_bed_from_lastz_files

### Tool Description
get_locus_bed_from_lastz

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_get_locus_bed_from_lastz_files [-h] --input INPUT
                                                    --output OUTPUT
                                                    [--regex REGEX]

get_locus_bed_from_lastz

optional arguments:
  -h, --help       show this help message and exit
  --input INPUT    The input directory containing lastz files
  --output OUTPUT  The output directory to hold BED-formatted files
  --regex REGEX    A regular expression to apply to the probe sequences for
                   replacement
```

## phyluce_phyluce_probe_get_multi_fasta_table

### Tool Description
Make a table of BED file matches

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_get_multi_fasta_table [-h] --fastas FASTAS --output
                                           OUTPUT --base-taxon BASE_TAXON

Make a table of BED file matches

optional arguments:
  -h, --help            show this help message and exit
  --fastas FASTAS       A folder of fasta files.
  --output OUTPUT       A SQLite database to create during integration.
  --base-taxon BASE_TAXON
                        The base taxon to use.
```

## phyluce_phyluce_probe_get_multi_merge_table

### Tool Description
Make a table of BED file matches

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_get_multi_merge_table [-h] --conf CONF --output OUTPUT
                                           --base-taxon BASE_TAXON
                                           [--filter FILTER]

Make a table of BED file matches

optional arguments:
  -h, --help            show this help message and exit
  --conf CONF           A config file mapping names to BED files.
  --output OUTPUT       A SQLite database to create during integration.
  --base-taxon BASE_TAXON
                        The base taxon to use.
  --filter FILTER       A file-type filter to apply to the BED directory of
                        files
```

## phyluce_phyluce_probe_get_probe_bed_from_lastz_files

### Tool Description
get_locus_bed_from_lastz

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_get_probe_bed_from_lastz_files [-h] --input INPUT
                                                    --output OUTPUT

get_locus_bed_from_lastz

optional arguments:
  -h, --help       show this help message and exit
  --input INPUT    The input directory containing lastz files
  --output OUTPUT  The output directory to hold BED-formatted files
```

## phyluce_phyluce_probe_get_screened_loci_by_proximity

### Tool Description
Given a FASTA file of properly formatted sequences (and header), screen for distance

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_get_screened_loci_by_proximity [-h] --input INPUT
                                                    --output OUTPUT
                                                    [--distance DISTANCE]
                                                    [--length LENGTH]

Given a FASTA file of properly formatted sequences (and header), screen for
distance

optional arguments:
  -h, --help           show this help message and exit
  --input INPUT        The FASTA file of input sequences
  --output OUTPUT      The output FASTA file of filtered sequences
  --distance DISTANCE  The minimum distance on which to filter
  --length LENGTH      The minimum length of sequences to filter
```

## phyluce_phyluce_probe_get_subsets_of_tiled_probes

### Tool Description
Given an input file of probes, filter the list for certain taxa

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_get_subsets_of_tiled_probes [-h] --probes PROBES --taxa
                                                 TAXA [TAXA ...] --output
                                                 OUTPUT [--regex REGEX]

Given an input file of probes, filter the list for certain taxa

optional arguments:
  -h, --help            show this help message and exit
  --probes PROBES       The probe file to filter.
  --taxa TAXA [TAXA ...]
                        The taxa for which to filter probes.
  --output OUTPUT       The file in which to store the output.
  --regex REGEX         A regular expression to apply to the probe names for
                        replacement [default='^(uce-\d+)(?:_p\d+.*)'].
```

## phyluce_phyluce_probe_get_tiled_probe_from_multiple_inputs

### Tool Description
Given a folder of FASTA reads of appropriate format and length (e.g. output by slice_sequence_from_genomes2.py), design probes from the multiple fasta output files

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_get_tiled_probe_from_multiple_inputs [-h] --fastas FASTAS
                                                          --multi-fasta-output
                                                          MULTI_FASTA_OUTPUT
                                                          --output OUTPUT
                                                          --probe-prefix
                                                          PROBE_PREFIX
                                                          --designer DESIGNER
                                                          --design DESIGN
                                                          [--probe-length LENGTH]
                                                          [--tiling-density DENSITY]
                                                          [--overlap {middle,flush-left}]
                                                          [--probe-bed PROBE_BED]
                                                          [--locus-bed LOCUS_BED]
                                                          [--masking MASK]
                                                          [--do-not-remove-ambiguous]
                                                          [--remove-gc]
                                                          [--start-index START_INDEX]
                                                          [--two-probes]

Given a folder of FASTA reads of appropriate format and length (e.g. output by
slice_sequence_from_genomes2.py), design probes from the multiple fasta output
files

optional arguments:
  -h, --help            show this help message and exit
  --fastas FASTAS       The folder of fasta files from which to design probes
  --multi-fasta-output MULTI_FASTA_OUTPUT
                        The output config file from query_multi_fasta_table.py
  --output OUTPUT       The file in which to store the output
  --probe-prefix PROBE_PREFIX
                        The prefix (e.g. "uce-") to add to all probes designed
  --designer DESIGNER   Your last name (to indicate who designed the probes)
  --design DESIGN       The design name.
  --probe-length LENGTH
                        The length of the probes sequence to design
  --tiling-density DENSITY
                        The tiling density
  --overlap {middle,flush-left}
                        The method of tiling
  --probe-bed PROBE_BED
                        The path to an output file for outputting the probe
                        coordinates in BED format
  --locus-bed LOCUS_BED
                        The path to an output file for outputting the locus
                        coordinates in BED format
  --masking MASK        The maximum frequency of per-probe masking allowed
                        containing the sequence
  --do-not-remove-ambiguous
                        Do not remove loci with probes containing ambiguous
                        bases
  --remove-gc           Remove loci with GC content outside 30 <= GC <= 70
  --start-index START_INDEX
                        The starting UCE index number to use.
  --two-probes          Design only two probes for a given locus.
```

## phyluce_phyluce_probe_get_tiled_probes

### Tool Description
Tile sequence capture probes across fastas.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_get_tiled_probes [-h] --input INPUT --output OUTPUT
                                      --probe-prefix PROBE_PREFIX --designer
                                      DESIGNER --design DESIGN
                                      [--probe-length LENGTH]
                                      [--tiling-density DENSITY]
                                      [--overlap {middle,flush-left}]
                                      [--probe-bed PROBE_BED]
                                      [--locus-bed LOCUS_BED] [--masking MASK]
                                      [--do-not-remove-ambiguous]
                                      [--remove-gc]
                                      [--start-index START_INDEX]
                                      [--two-probes]

Tile sequence capture probes across fastas.

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The path to the input file
  --output OUTPUT       The path to the output file
  --probe-prefix PROBE_PREFIX
                        The prefix (e.g. "uce-") to add to all probes designed
  --designer DESIGNER   Your last name (to indicate who designed the probes)
  --design DESIGN       The design name.
  --probe-length LENGTH
                        The length of the probes sequence to design
  --tiling-density DENSITY
                        The tiling density
  --overlap {middle,flush-left}
                        The method of tiling
  --probe-bed PROBE_BED
                        The path to an output file for outputting the probe
                        coordinates in BED format
  --locus-bed LOCUS_BED
                        The path to an output file for outputting the locus
                        coordinates in BED format
  --masking MASK        The maximum frequency of per-probe masking allowed
                        containing the sequence
  --do-not-remove-ambiguous
                        Do not remove loci with probes containing ambiguous
                        bases
  --remove-gc           Remove loci with GC content outside 30 <= GC <= 70
  --start-index START_INDEX
                        The starting UCE index number to use.
  --two-probes          Design only two probes for a given locus.
```

## phyluce_phyluce_probe_query_multi_fasta_table

### Tool Description
Query the multimerge taxa to output matching loci

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_query_multi_fasta_table [-h] --db DB [--output OUTPUT]
                                             --base-taxon BASE_TAXON
                                             [--specific-counts SPECIFIC_COUNTS]

Query the multimerge taxa to output matching loci

optional arguments:
  -h, --help            show this help message and exit
  --db DB               The database to query
  --output OUTPUT       When using --specific-counts, output a BED file of
                        those loci
  --base-taxon BASE_TAXON
                        The base taxon to use.
  --specific-counts SPECIFIC_COUNTS
                        Return data for a specific minimum number of taxa.
```

## phyluce_phyluce_probe_query_multi_merge_table

### Tool Description
Query the multimerge taxa to output matching loci

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_query_multi_merge_table [-h] --db DB [--output OUTPUT]
                                             --base-taxon BASE_TAXON
                                             [--specific-counts SPECIFIC_COUNTS]

Query the multimerge taxa to output matching loci

optional arguments:
  -h, --help            show this help message and exit
  --db DB               The database to query
  --output OUTPUT       When using --specific-counts, output a BED file of
                        those loci
  --base-taxon BASE_TAXON
                        The base taxon to use.
  --specific-counts SPECIFIC_COUNTS
                        Return data for a specific minimum number of taxa.
```

## phyluce_phyluce_probe_reconstruct_uce_from_probe

### Tool Description
From a UCE probe set, reconstruct the UCE sequence used for design

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_reconstruct_uce_from_probe [-h] --input INPUT --output
                                                OUTPUT
                                                [--verbosity {INFO,WARN,CRITICAL}]
                                                [--log-path LOG_PATH]

From a UCE probe set, reconstruct the UCE sequence used for design

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The input probe set
  --output OUTPUT       The output FASTA file
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_probe_remove_duplicate_hits_from_probes_using_lastz

### Tool Description
Remove duplicate loci from a fasta given self-to-self lastz

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_remove_duplicate_hits_from_probes_using_lastz
       [-h] --fasta FASTA --lastz LASTZ --probe-prefix PROBE_PREFIX
       [--probe-regex PROBE_REGEX] [--probe-bed PROBE_BED]
       [--locus-bed LOCUS_BED] [--long]

Remove duplicate loci from a fasta given self-to-self lastz

optional arguments:
  -h, --help            show this help message and exit
  --fasta FASTA         The fasta file to screen
  --lastz LASTZ         The lastz file to use
  --probe-prefix PROBE_PREFIX
                        The prefix (e.g. "uce-") added to all probes designed
  --probe-regex PROBE_REGEX
                        The regular expression to use for matching probes
  --probe-bed PROBE_BED
                        The path to a file contaning the probe coordinates in
                        BED format
  --locus-bed LOCUS_BED
                        The path to a file contaning the locus coordinates in
                        BED format
  --long                If the lastz output is the longfield format
```

## phyluce_phyluce_probe_remove_overlapping_probes_given_config

### Tool Description
Program description

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_remove_overlapping_probes_given_config
       [-h] --probes PROBES --config CONFIG --output OUTPUT

Program description

optional arguments:
  -h, --help       show this help message and exit
  --probes PROBES  The input probe file
  --config CONFIG  The input conf file of probes names to remove
  --output OUTPUT  The output probe file to write
```

## phyluce_phyluce_probe_run_multiple_lastzs_sqlite

### Tool Description
Align a set of probes against genome sequence(s) in scaffolds or chromosomes

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_run_multiple_lastzs_sqlite [-h] --db DB --output OUTPUT
                                                --probefile PROBEFILE
                                                [--chromolist CHROMOLIST [CHROMOLIST ...]]
                                                [--scaffoldlist SCAFFOLDLIST [SCAFFOLDLIST ...]]
                                                [--append] [--no-dir]
                                                [--cores CORES]
                                                [--genome-base-path BASE_PATH]
                                                [--coverage COVERAGE]
                                                [--identity IDENTITY]

Align a set of probes against genome sequence(s) in scaffolds or chromosomes

optional arguments:
  -h, --help            show this help message and exit
  --db DB               The database in which to store results (also use
                        --append if adding results to an existing database)
  --output OUTPUT       The directory in which to store the LASTZ files
  --probefile PROBEFILE
                        The probe file to align against the sequences
  --chromolist CHROMOLIST [CHROMOLIST ...]
                        The list of organisms with genome sequences in
                        chromosomes
  --scaffoldlist SCAFFOLDLIST [SCAFFOLDLIST ...]
                        The list of organisms with genome sequences in
                        scaffolds/contigs
  --append              Insert results to an existing database
  --no-dir              If genome sequences are not in their own abbr.
                        directory
  --cores CORES         The number of compute cores to use
  --genome-base-path BASE_PATH
                        The base path to a directory containing genomes
                        sequences
  --coverage COVERAGE   The default coverage to search for using lastz
  --identity IDENTITY   The default percent identity to search for using lastz
```

## phyluce_phyluce_probe_slice_sequence_from_genomes

### Tool Description
Given a LASTZ input directory, find matches, add flank, and return a FASTA file of sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_slice_sequence_from_genomes [-h] --conf CONF --lastz
                                                 LASTZ --output OUTPUT
                                                 [--name-pattern PATTERN]
                                                 [--probe-prefix PROBE_PREFIX]
                                                 [--probe-regex PROBE_REGEX]
                                                 [--exclude EXCLUDE [EXCLUDE ...]]
                                                 [--verbosity {INFO,WARN,CRITICAL}]
                                                 [--contig_orient]
                                                 (--flank FLANK | --probes PROBES)

Given a LASTZ input directory, find matches, add flank, and return a FASTA
file of sequences

optional arguments:
  -h, --help            show this help message and exit
  --conf CONF           Path to the configuration file
  --lastz LASTZ         Path to the directory containing LASTZ results
  --output OUTPUT       Path to the output directory for storing FASTA files
  --name-pattern PATTERN
                        An alternate name pattern to transform the conf entry
                        into
  --probe-prefix PROBE_PREFIX
                        The prefix (e.g. "uce-") added to all probes designed
  --probe-regex PROBE_REGEX
                        The regular expression to use for matching probes
  --exclude EXCLUDE [EXCLUDE ...]
                        Species to exclude from genome slicing
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use
  --contig_orient       Check orientation by contigs versus probes - useful
                        for multi-species probe sets
  --flank FLANK         The amount of flanking sequence to add to each match
  --probes PROBES       The probe length to use
```

## phyluce_phyluce_probe_strip_masked_loci_from_set

### Tool Description
Given an input BED file for one taxon, remove repetitive BED entried by base taxon

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_probe_strip_masked_loci_from_set [-h] --bed BED --twobit TWOBIT
                                                --output OUTPUT
                                                [--filter-mask MASK]
                                                [--max-n MAX_N]
                                                [--min-length MIN_LENGTH]

Given an input BED file for one taxon, remove repetitive BED entried by base
taxon

optional arguments:
  -h, --help            show this help message and exit
  --bed BED             The input BED file
  --twobit TWOBIT       The input genome to slice in UCSC 2bit format
  --output OUTPUT       The output BED file
  --filter-mask MASK    Filter strings with > X frequency of masked bases
  --max-n MAX_N         The maximum number of ambiguous bases ('N') to accept
  --min-length MIN_LENGTH
                        The minimum length loci to keep
```

## phyluce_phyluce_assembly_assemblo_abyss

### Tool Description
Assemble raw reads using ABySS

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_assemblo_abyss [-h] --output OUTPUT [--kmer KMER]
                                       [--cores CORES] [--subfolder SUBFOLDER]
                                       [--verbosity {INFO,WARN,CRITICAL}]
                                       [--log-path LOG_PATH] [--clean]
                                       [--abyss-se]
                                       (--config CONFIG | --dir DIR)

Assemble raw reads using ABySS

optional arguments:
  -h, --help            show this help message and exit
  --output OUTPUT       The directory in which to store the assembly data
  --kmer KMER           The kmer value to use
  --cores CORES         The number of compute cores/threads to run with
                        Trinity
  --subfolder SUBFOLDER
                        A subdirectory, below the level of the group,
                        containing the reads
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use
  --log-path LOG_PATH   The path to a directory to hold logs.
  --clean               Cleanup all intermediate Trinity files
  --abyss-se            Only use abyss-se
  --config CONFIG       A configuration file containing reads to assemble
  --dir DIR             A directory of reads to assemble
```

## phyluce_phyluce_assembly_assemblo_trinity

### Tool Description
Assemble raw reads using trinity

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_assemblo_trinity [-h] --output OUTPUT [--cores CORES]
                                         [--subfolder SUBFOLDER]
                                         [--verbosity {INFO,WARN,CRITICAL}]
                                         [--log-path LOG_PATH] [--clean]
                                         [--min-kmer-coverage MIN_KMER_COVERAGE]
                                         (--config CONFIG | --dir DIR)

Assemble raw reads using trinity

optional arguments:
  -h, --help            show this help message and exit
  --output OUTPUT       The directory in which to store the assembly data
  --cores CORES         The number of compute cores/threads to run with
                        Trinity
  --subfolder SUBFOLDER
                        A subdirectory, below the level of the group,
                        containing the reads
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use
  --log-path LOG_PATH   The path to a directory to hold logs.
  --clean               Cleanup all intermediate Trinity files
  --min-kmer-coverage MIN_KMER_COVERAGE
                        The min_kmer_coverage for trinity
  --config CONFIG       A configuration file containing reads to assemble
  --dir DIR             A directory of reads to assemble
```

## phyluce_phyluce_assembly_assemblo_velvet

### Tool Description
Assemble raw reads using velvet

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_assemblo_velvet [-h] --output OUTPUT [--kmer KMER]
                                        [--cores CORES]
                                        [--subfolder SUBFOLDER]
                                        [--verbosity {INFO,WARN,CRITICAL}]
                                        [--log-path LOG_PATH] [--clean]
                                        (--config CONFIG | --dir DIR)

Assemble raw reads using velvet

optional arguments:
  -h, --help            show this help message and exit
  --output OUTPUT       The directory in which to store the assembly data
  --kmer KMER           The kmer value to use
  --cores CORES         The number of compute cores/threads to run with Velvet
  --subfolder SUBFOLDER
                        A subdirectory, below the level of the group,
                        containing the reads
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use
  --log-path LOG_PATH   The path to a directory to hold logs.
  --clean               Cleanup all intermediate Trinity files
  --config CONFIG       A configuration file containing reads to assemble
  --dir DIR             A directory of reads to assemble
```

## phyluce_phyluce_assembly_copy_trinity_symlinks

### Tool Description
Copy symlinks from trinity assemblies to a new folder

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_copy_trinity_symlinks [-h] --assembly-symlinks
                                              SYMLINKS [--conf CONF]
                                              [--output OUTPUT]

Copy symlinks from trinity assemblies to a new folder

optional arguments:
  -h, --help            show this help message and exit
  --assembly-symlinks SYMLINKS
                        The location of the trinity symlinks (trinity-
                        assemblies/contigs)
  --conf CONF           The configuration file to use
  --output OUTPUT       The output folder
```

## phyluce_phyluce_assembly_explode_get_fastas_file

### Tool Description
Explode the fasta file produced by get_fastas_from_match_counts into single files

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_explode_get_fastas_file [-h] --input INPUT --output
                                                OUTPUT [--by-taxon]
                                                [--split-char SPLIT_CHAR]

Explode the fasta file produced by get_fastas_from_match_counts into single
files

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The input fasta file to explode
  --output OUTPUT       The output directory to create and in which to store
                        the fastas
  --by-taxon            Split file by taxon and not by locus
  --split-char SPLIT_CHAR
                        The character to split on
```

## phyluce_phyluce_assembly_extract_contigs_to_barcodes

### Tool Description
Parse the log file from match_contigs_to_barcodes to output a table of results

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_extract_contigs_to_barcodes [-h] --contigs CONTIGS
                                                    --config CONFIG --output
                                                    OUTPUT
                                                    [--verbosity {INFO,WARN,CRITICAL}]
                                                    [--log-path LOG_PATH]

Parse the log file from match_contigs_to_barcodes to output a table of results

optional arguments:
  -h, --help            show this help message and exit
  --contigs CONTIGS     The directory containing the assembled contigs.
  --config CONFIG       A config file containing the contigs to extract.
  --output OUTPUT       The output FASTA file to create
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_assembly_filter_seqs_from_fastas

### Tool Description
Removes sequences that are shorter than a specified proportion of the median length of sequences in an alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_filter_seqs_from_fastas [-h] --input INPUT --output
                                                OUTPUT
                                                --filtered-sequences-file
                                                SHORT_SEQUENCES_FILE
                                                [--cores CORES]
                                                [--verbosity {INFO,WARN,CRITICAL}]
                                                [--log-path LOG_PATH]
                                                (--trim-length | --trim-count)
                                                [--proportion PROPORTION]
                                                [--count COUNT]

Removes sequences that are shorter than a specified proportion of the median
length of sequences in an alignment.

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The directory containing the FASTA sequences to
                        filter.
  --output OUTPUT       An output directory to hold the converted alignments.
  --filtered-sequences-file SHORT_SEQUENCES_FILE
                        The file that will contain names of sequences (and
                        loci) removed
  --cores CORES         The number of compute cores to use
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --trim-length
  --trim-count
  --proportion PROPORTION
                        Proportion of the median length that will serve as cut
                        off (default=0.5)
  --count COUNT         Number of sequences per locus that will serve as cut
                        off (default=4).
```

## phyluce_phyluce_assembly_get_bed_for_genome_enabled_taxon

### Tool Description
Get a BED file for the given taxon using the probe.matches.sqlite database, the lastz file, and a taxon name

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_get_bed_for_genome_enabled_taxon [-h] --locus-db
                                                         LOCUS_DB --lastz-file
                                                         LASTZ_FILE
                                                         --taxon-name
                                                         TAXON_NAME --output
                                                         OUTPUT
                                                         [--verbosity {INFO,WARN,CRITICAL}]
                                                         [--log-path LOG_PATH]
                                                         [--regex REGEX]

Get a BED file for the given taxon using the probe.matches.sqlite database,
the lastz file, and a taxon name

optional arguments:
  -h, --help            show this help message and exit
  --locus-db LOCUS_DB   The probe.matches.sqlite database
  --lastz-file LASTZ_FILE
                        The lastz file to use
  --taxon-name TAXON_NAME
                        The taxon name to search for in probe.matches.sqlite
  --output OUTPUT       The output BED file to create
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --regex REGEX         A regular expression to apply to the probe names for
                        replacement [default='^(uce-\d+)(?:_p\d+.*)'].
```

## phyluce_phyluce_assembly_get_fasta_lengths

### Tool Description
Get summary (length) data for a directory of FASTA files

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_get_fasta_lengths [-h] --input INPUT [--csv]

Get summary (length) data for a directory of FASTA files

optional arguments:
  -h, --help     show this help message and exit
  --input INPUT  The fasta file to summarize
  --csv          Give output in CSV
```

## phyluce_phyluce_assembly_get_fastq_lengths

### Tool Description
Get summary (length) data from fastq

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_get_fastq_lengths [-h] --input INPUT [--csv]

Get summary (length) data from fastq

optional arguments:
  -h, --help     show this help message and exit
  --input INPUT  The directory of fastq files to summarize
  --csv          Give output in CSV
```

## phyluce_phyluce_assembly_get_trinity_coverage

### Tool Description
Get coverage of UCE assemblies from Trinity

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
NOTE: As we move phyluce to bioconda, some programs are going to
break. The coverage computation scripts are one of those programs
because of their dependence on Picard and GATK.  We are working on a
fix to the problem, which likely involves moving away from Picard and
GATK.  In the meantime, you may need to download your own version of
GATK-lite and put the path to that in your ~/.phyluce.conf




usage: phyluce_assembly_get_trinity_coverage [-h] --assemblies ASSEMBLIES
                                             [--assemblo-config ASSEMBLO_CONFIG]
                                             [--cores CORES]
                                             [--subfolder SUBFOLDER]
                                             [--verbosity {INFO,WARN,CRITICAL}]
                                             [--log-path LOG_PATH] [--clean]
                                             [--bwa-mem]
                                             [--assembler {velvet,abyss,trinity,trinity2,idba,spades}]
                                             [--trim]

Get coverage of UCE assemblies from Trinity

optional arguments:
  -h, --help            show this help message and exit
  --assemblies ASSEMBLIES
                        The directory containing the assemblies
  --assemblo-config ASSEMBLO_CONFIG
                        The assemblo_trinity configuration file
  --cores CORES         The number of compute cores/threads to run with
                        Trinity
  --subfolder SUBFOLDER
                        A subdirectory, below the level of the group,
                        containing the reads
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use
  --log-path LOG_PATH   The path to a directory to hold logs.
  --clean               Cleanup all intermediate Trinity files
  --bwa-mem             Use bwa-mem instead of standard bwa
  --assembler {velvet,abyss,trinity,trinity2,idba,spades}
                        Program used to asemble raw reads
  --trim                Trim contigs to a minimum coverage amount
```

## phyluce_phyluce_assembly_get_trinity_coverage_for_uce_loci

### Tool Description
Given the input file generated by get_trinity_coverage, extract the values for UCE loci

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
NOTE: As we move phyluce to bioconda, some programs are going to
break. The coverage computation scripts are one of those programs
because of their dependence on Picard and GATK.  We are working on a
fix to the problem, which likely involves moving away from Picard and
GATK.  In the meantime, you may need to download your own version of
GATK-lite and put the path to that in your ~/.phyluce.conf




usage: phyluce_assembly_get_trinity_coverage_for_uce_loci [-h] --assemblies
                                                          ASSEMBLIES
                                                          --match-count-output
                                                          MATCH_COUNT_OUTPUT
                                                          --type
                                                          {trimmed,untrimmed}
                                                          [--exclude EXCLUDE [EXCLUDE ...]]
                                                          --locus-db LOCUS_DB
                                                          (--output OUTPUT | --resume RESUME)
                                                          [--verbosity {INFO,WARN,CRITICAL}]
                                                          [--log-path LOG_PATH]

Given the input file generated by get_trinity_coverage, extract the values for
UCE loci

optional arguments:
  -h, --help            show this help message and exit
  --assemblies ASSEMBLIES
                        The directory containing the assemblies
  --match-count-output MATCH_COUNT_OUTPUT
                        The output file containing taxa and loci in
                        complete/incomplete matrices generated by
                        get_match_counts.py.
  --type {trimmed,untrimmed}
                        Whether to compute stats on trimmed or untrimmed UCE
                        data.
  --exclude EXCLUDE [EXCLUDE ...]
                        A list of assemblies to ignore.
  --locus-db LOCUS_DB   The SQL database file holding probe matches to
                        targeted loci (usually "lastz/probe.matches.sqlite").
  --output OUTPUT       The output directory to hold the UCE coverage files
  --resume RESUME       The output directory in which to resume after a
                        failure.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_assembly_match_contigs_to_barcodes

### Tool Description
Match a folder of contig files against a barcode sequence(s) for a given group of taxa

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_match_contigs_to_barcodes [-h] --contigs CONTIGS
                                                  --barcodes BARCODES --output
                                                  OUTPUT
                                                  [--verbosity {INFO,WARN,CRITICAL}]
                                                  [--log-path LOG_PATH]
                                                  [--no-bold]
                                                  [--database {COX1,COX1_SPECIES,COX1_SPECIES_PUBLIC}]

Match a folder of contig files against a barcode sequence(s) for a given group
of taxa

optional arguments:
  -h, --help            show this help message and exit
  --contigs CONTIGS     The directory containing the assembled contigs in
                        which you are searching for UCE loci.
  --barcodes BARCODES   A FASTA-formatted file of barcode(s).
  --output OUTPUT       The directory in which to store the resulting SQL
                        database and LASTZ files.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --no-bold             Don't run matches against BOLD
  --database {COX1,COX1_SPECIES,COX1_SPECIES_PUBLIC}
                        The COI database to use. Defaults to all BOLD records
                        for COI > 500 bp.
```

## phyluce_phyluce_assembly_match_contigs_to_probes

### Tool Description
Match UCE probes/baits to assembled contigs and store the data in a relational database. The matching process is dependent on the probe names in the file. If the probe names are not like 'uce-1001_p1' where 'uce-' indicates we're searching for uce loci, '1001' indicates locus 1001, '_p1' indicates this is probe 1 for locus 1001, you will need to set the optional --regex parameter. So, if your probe names are 'MyProbe-A_probe1', the --regex will look like --regex='^(MyProbe-\W+)(?:_probe\d+.*)'

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_match_contigs_to_probes [-h] --contigs CONTIGS
                                                --probes PROBES --output
                                                OUTPUT
                                                [--verbosity {INFO,WARN,CRITICAL}]
                                                [--log-path LOG_PATH]
                                                [--min-coverage MIN_COVERAGE]
                                                [--min-identity MIN_IDENTITY]
                                                [--dupefile DUPEFILE]
                                                [--regex REGEX]
                                                [--keep-duplicates KEEP_DUPLICATES]

Match UCE probes/baits to assembled contigs and store the data in a relational
database. The matching process is dependent on the probe names in the file. If
the probe names are not like 'uce-1001_p1' where 'uce-' indicates we're
searching for uce loci, '1001' indicates locus 1001, '_p1' indicates this is
probe 1 for locus 1001, you will need to set the optional --regex parameter.
So, if your probe names are 'MyProbe-A_probe1', the --regex will look like
--regex='^(MyProbe-\W+)(?:_probe\d+.*)'

optional arguments:
  -h, --help            show this help message and exit
  --contigs CONTIGS     The directory containing the assembled contigs in
                        which you are searching for UCE loci.
  --probes PROBES       The bait/probe file in FASTA format.
  --output OUTPUT       The directory in which to store the resulting SQL
                        database and LASTZ files.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --min-coverage MIN_COVERAGE
                        The minimum percent coverage required for a match
                        [default=80].
  --min-identity MIN_IDENTITY
                        The minimum percent identity required for a match
                        [default=80].
  --dupefile DUPEFILE   Path to self-to-self lastz results for baits to remove
                        potential duplicate probes.
  --regex REGEX         A regular expression to apply to the probe names for
                        replacement [default='^(uce-\d+)(?:_p\d+.*)'].
  --keep-duplicates KEEP_DUPLICATES
                        A optional output file in which to store those loci
                        that appear to be duplicates.
```

## phyluce_phyluce_assembly_parse_trinity_coverage_for_uce_loci_log

### Tool Description
Parse the log file from get_trinity_coverage_for_uce_loci.py to output a nice table of results

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_parse_trinity_coverage_for_uce_loci_log
       [-h] --log LOG [--output OUTPUT]

Parse the log file from get_trinity_coverage_for_uce_loci.py to output a nice
table of results

optional arguments:
  -h, --help       show this help message and exit
  --log LOG        The log file to parse
  --output OUTPUT  The output CSV file to create
```

## phyluce_phyluce_assembly_parse_trinity_coverage_log

### Tool Description
Parse the log file from get_trinity_coverage.py to output a nice table of results

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_parse_trinity_coverage_log [-h] --log LOG
                                                   [--output OUTPUT]

Parse the log file from get_trinity_coverage.py to output a nice table of
results

optional arguments:
  -h, --help       show this help message and exit
  --log LOG        The log file to parse
  --output OUTPUT  The output CSV file to create
```

## phyluce_phyluce_assembly_screen_probes_for_dupes

### Tool Description
Screen a lastz file of self-to-self matches for dupes

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_screen_probes_for_dupes [-h] --lastz LASTZ

Screen a lastz file of self-to-self matches for dupes

optional arguments:
  -h, --help     show this help message and exit
  --lastz LASTZ  The lastz input
```

## phyluce_phyluce_ncbi_chunk_fasta_for_ncbi

### Tool Description
Split an input fasta into chunks for processing in 10k sequence units

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_ncbi_chunk_fasta_for_ncbi [-h] --input INPUT
                                         [--chunk-size CHUNK_SIZE]
                                         [--output-prefix OUTPUT_PREFIX]
                                         [--output-suffix OUTPUT_SUFFIX]

Split an input fasta into chunks for processing in 10k sequence units

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The input FASTA
  --chunk-size CHUNK_SIZE
  --output-prefix OUTPUT_PREFIX
  --output-suffix OUTPUT_SUFFIX
```

## phyluce_phyluce_ncbi_prep_uce_fasta_files_for_ncbi

### Tool Description
use fasta + sqlite to format files for NCBI

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_ncbi_prep_uce_fasta_files_for_ncbi [-h]
                                                  [--start-value START_VALUE]
                                                  [--trinity] [--dry-run]
                                                  fastas db conf outfile

use fasta + sqlite to format files for NCBI

positional arguments:
  fastas                The directory containing fasta files
  db                    The db containing UCE matches
  conf                  A configuration file containing general and sample-
                        specific metadata
  outfile               The outfile fasta to hold results

optional arguments:
  -h, --help            show this help message and exit
  --start-value START_VALUE
                        The starting index value to append to sequences
  --trinity             Contigs are from Trinity assemblies
  --dry-run             Do a dry run.
```

## phyluce_phyluce_utilities_cleanup_trinity

### Tool Description
Remove the extra files from trinity assemblies (keeps Trinity.fasta and trinity.log)

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_utilities_cleanup_trinity [-h] --path-to-clean PATH_TO_CLEAN
                                         [--verbosity {INFO,WARN,CRITICAL}]
                                         [--log-path LOG_PATH]

Assemble raw reads using trinity

optional arguments:
  -h, --help            show this help message and exit
  --path-to-clean PATH_TO_CLEAN
                        The directory holding the trinity files to clean
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_utilities_combine_reads

### Tool Description
Combine groups of reads based on an input file in config format

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_utilities_combine_reads [-h] --config CONFIG --output OUTPUT
                                       [--subfolder SUBFOLDER]

Combine groups of reads based on an input file in config format

optional arguments:
  -h, --help            show this help message and exit
  --config CONFIG       The configuration file for reads we are combining
  --output OUTPUT       The configuration file for reads we are combining
  --subfolder SUBFOLDER
                        A subdirectory, below the level of the group,
                        containing the reads
```

## phyluce_phyluce_utilities_filter_bed_by_fasta

### Tool Description
Filter a BED file of UCEs given a FASTA file of UCEs

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_utilities_filter_bed_by_fasta [-h] --bed BED --fasta FASTA
                                             [--output OUTPUT]

Filter a BED file of UCEs given a FASTA file of UCEs

optional arguments:
  -h, --help       show this help message and exit
  --bed BED        The BED file to filter.
  --fasta FASTA    The FASTA file to use as a filter.
  --output OUTPUT  The output BED file
```

## phyluce_phyluce_utilities_get_bed_from_fasta

### Tool Description
Get a BED from fasta file

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_utilities_get_bed_from_fasta [-h] --input INPUT --output OUTPUT
                                            [--locus-prefix LOCUS_PREFIX]

Get a BED from fasta file

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The fasta file to parse
  --output OUTPUT       The BED file to create
  --locus-prefix LOCUS_PREFIX
                        A prefix to add to each locus name
```

## phyluce_phyluce_utilities_merge_multiple_gzip_files

### Tool Description
Given a config file and inputs, merge multiple gz files into one

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_utilities_merge_multiple_gzip_files [-h] --config CONFIG
                                                   --output OUTPUT
                                                   [--section SECTION]
                                                   [--verbosity {INFO,WARN,CRITICAL}]
                                                   [--log-path LOG_PATH]
                                                   [--trimmed]

Given a config file and inputs, merge multiple gz files into one

optional arguments:
  -h, --help            show this help message and exit
  --config CONFIG       The path to the config file to use for merging.
  --output OUTPUT       The path to a directory in which to store the output.
  --section SECTION     The section holding the merge info.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --trimmed             If the reads have already been trimmed.
```

## phyluce_phyluce_utilities_merge_next_seq_gzip_files

### Tool Description
Given a config file and inputs, merge multiple read files output by the NextSeq into one

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_utilities_merge_next_seq_gzip_files [-h] --input INPUT --config
                                                   CONFIG --output OUTPUT
                                                   [--section SECTION]
                                                   [--verbosity {INFO,WARN,CRITICAL}]
                                                   [--log-path LOG_PATH]
                                                   [--se]

Given a config file and inputs, merge multiple read files output by the
NextSeq into one

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The path to a directory containing the reads to merge.
  --config CONFIG       The path to the config file to use for merging.
  --output OUTPUT       The path to a directory in which to store the output.
  --section SECTION     The section holding the merge info.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --se                  Run is single-end.
```

## phyluce_phyluce_utilities_replace_many_links

### Tool Description
Replace a part of the target path in many symlinks and write the updated symlinks to a new directory

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_utilities_replace_many_links [-h] --indir INDIR --oldpath
                                            OLDPATH --newpath NEWPATH --outdir
                                            OUTDIR

Program description

optional arguments:
  -h, --help         show this help message and exit
  --indir INDIR      The directory containing the links to rename
  --oldpath OLDPATH  The text you want to replace in the oldpath (include '/')
  --newpath NEWPATH  The text you want to use as a replacement in the newpath
                     (include '/')
  --outdir OUTDIR    The output directory to hold updated symlinks
```

## phyluce_phyluce_utilities_sample_reads_from_files

### Tool Description
Sample reads from files (with seqtk) according to a configuration file

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_utilities_sample_reads_from_files [-h] --conf CONF --output
                                                 OUTPUT

optional arguments:
  -h, --help       show this help message and exit
  --conf CONF      The path to the config file giving reads to sample
  --output OUTPUT  The path to output directory
```

## phyluce_phyluce_utilities_unmix_fasta_reads

### Tool Description
Turn a mixed file of fasta reads into R1, R2, and singleton reads

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_utilities_unmix_fasta_reads [-h] --mixed-reads MIXED_READS
                                           [--singleton-reads SINGLETON_READS]
                                           --out-r1 OUT_R1 --out-r2 OUT_R2
                                           --out-r-singleton OUT_R_SINGLETON
                                           [--verbosity {INFO,WARN,CRITICAL}]
                                           [--log-path LOG_PATH] [--new-style]

Turn a mixed file of fasta reads into R1, R2, and singleton reads

optional arguments:
  -h, --help            show this help message and exit
  --mixed-reads MIXED_READS
                        The file containing mixed fasta reads with  and 
                        designators for reads.
  --singleton-reads SINGLETON_READS
                        The file containing singleton fasta reads.
  --out-r1 OUT_R1       The output fasta for R1.
  --out-r2 OUT_R2       The output fasta for R2.
  --out-r-singleton OUT_R_SINGLETON
                        The output fasta for singleton reads (RS).
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --new-style
```

## phyluce_phyluce_align_add_missing_data_designators

### Tool Description
Add missing data designators to a set of incomplete alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_add_missing_data_designators [-h] --alignments ALIGNMENTS
                                                  --output OUTPUT
                                                  --match-count-output
                                                  MATCH_COUNT_OUTPUT
                                                  [--incomplete-matrix INCOMPLETE_MATRIX]
                                                  [--min-taxa MIN_TAXA]
                                                  [--missing-character MISSING_CHARACTER]
                                                  [--verbatim]
                                                  [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                                  [--output-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                                  [--no-check-missing]
                                                  [--verbosity {INFO,WARN,CRITICAL}]
                                                  [--log-path LOG_PATH]
                                                  [--cores CORES]

Add missing data designators to a set of incomplete alignments.

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        Alignment files to process (default: None)
  --output OUTPUT       The output dir in which to store copies of the
                        alignments (default: None)
  --match-count-output MATCH_COUNT_OUTPUT
                        The output file containing taxa and loci in
                        complete/incomplete matrices generated by
                        get_match_counts.py. (default: None)
  --incomplete-matrix INCOMPLETE_MATRIX
                        The output file for incomplete-matrix records
                        generated by get_match_counts.py. (default: None)
  --min-taxa MIN_TAXA   The minimum number of taxa to keep (default: 3)
  --missing-character MISSING_CHARACTER
                        The character to use for missing data (default: ?)
  --verbatim            Do not parse species names at all - use them verbatim
                        (default: False)
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format. (default: nexus)
  --output-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The output alignment format. (default: nexus)
  --no-check-missing    Do not check the list of missing loci (default: True)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
```

## phyluce_phyluce_align_convert_degen_bases

### Tool Description
Screen a given set of alignments for problematic nucleotides.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_convert_degen_bases [-h] --alignments ALIGNMENTS --output
                                         OUTPUT
                                         [--input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}]
                                         [--output-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}]
                                         [--verbosity {INFO,WARN,CRITICAL}]
                                         [--log-path LOG_PATH] [--cores CORES]

Screen a given set of alignments for problematic nucleotides

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments to be screened.
                        (default: None)
  --output OUTPUT       The directory in which to store the resulting
                        alignments. (default: None)
  --input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}
                        The input alignment format (default: nexus)
  --output-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}
                        The output alignment format (default: nexus)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
```

## phyluce_phyluce_align_convert_one_align_to_another

### Tool Description
Convert alignments from one format to another.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_convert_one_align_to_another [-h] --alignments ALIGNMENTS
                                                  --output OUTPUT
                                                  [--input-format {fasta,nexus,phylip,phylip-relaxed,phylip-sequential,clustal,emboss,stockholm}]
                                                  [--output-format {fasta,nexus,phylip,phylip-relaxed,phylip-sequential,clustal,emboss,stockholm}]
                                                  [--cores CORES]
                                                  [--shorten-names]
                                                  [--name-conf NAME_CONF]
                                                  [--verbosity {INFO,WARN,CRITICAL}]
                                                  [--log-path LOG_PATH]

Convert alignments from one format to another.

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing the alignments to convert.
  --output OUTPUT       An output directory to hold the converted alignments.
  --input-format {fasta,nexus,phylip,phylip-relaxed,phylip-sequential,clustal,emboss,stockholm}
                        The input alignment format
  --output-format {fasta,nexus,phylip,phylip-relaxed,phylip-sequential,clustal,emboss,stockholm}
                        The input alignment format
  --cores CORES         The number of compute cores to use
  --shorten-names       Convert names to a 6 or 7 character representation
  --name-conf NAME_CONF
                        A config-formatted file containing full-name:shortname
                        mappings
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_align_explode_alignments

### Tool Description
Explode a directory of alignments into FASTA-formatted files for each locus or taxon.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_explode_alignments [-h] --alignments ALIGNMENTS --output
                                        OUTPUT
                                        [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                        [--conf CONF] [--section SECTION]
                                        [--exclude EXCLUDE [EXCLUDE ...]]
                                        [--by-taxon] [--include-locus]

Explode a directory of alignments into FASTA-formatted files for each locus or
taxon

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        Input folder of alignments
  --output OUTPUT       Output folder of fasta files
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format
  --conf CONF           Config file for renaming
  --section SECTION     Section of config file to use
  --exclude EXCLUDE [EXCLUDE ...]
                        Taxa/taxon to exclude
  --by-taxon            Explode file by taxon instead of by-locus
  --include-locus       Include the locus name in the FASTA header
```

## phyluce_phyluce_align_extract_taxa_from_alignments

### Tool Description
Create a new set of alignments from an old set of alignments by excluding or keeping certain taxa.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_extract_taxa_from_alignments [-h] --alignments ALIGNMENTS
                                                  --output OUTPUT
                                                  [--input-format {nexus,newick,fasta,phylip}]
                                                  [--output-format {fasta,nexus,phylip,phylip-relaxed,phylip-sequential,clustal,emboss,stockholm}]
                                                  [--verbosity {INFO,WARN,CRITICAL}]
                                                  [--log-path LOG_PATH]
                                                  [--cores CORES]
                                                  [--skip-check]
                                                  [--exclude EXCLUDE [EXCLUDE ...]
                                                  | --include INCLUDE
                                                  [INCLUDE ...]]

Create a new set of alignments from an old set of alignments by excluding or
keeping certain taxa

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The input directory containing nexus files
  --output OUTPUT       The directory in which to store the output files
  --input-format {nexus,newick,fasta,phylip}
                        The input format of the alignments
  --output-format {fasta,nexus,phylip,phylip-relaxed,phylip-sequential,clustal,emboss,stockholm}
                        The input alignment format
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
  --skip-check          Skip the initial taxon determination
  --exclude EXCLUDE [EXCLUDE ...]
                        Taxa to exclude
  --include INCLUDE [INCLUDE ...]
                        Taxa to include
```

## phyluce_phyluce_align_extract_taxon_fasta_from_alignments

### Tool Description
From a set of input alignments, create a FASTA file of all sequences associated with a given taxon.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_extract_taxon_fasta_from_alignments [-h] --alignments
                                                         ALIGNMENTS --taxon
                                                         TAXON --output OUTPUT
                                                         [--input-format {nexus,newick,fasta,phylip}]
                                                         [--verbosity {INFO,WARN,CRITICAL}]
                                                         [--log-path LOG_PATH]

From a set of input alignments, create a FASTA file of all sequences
associated with a given taxon

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory of alignments
  --taxon TAXON         The taxon to extract
  --output OUTPUT       The output FASTA file
  --input-format {nexus,newick,fasta,phylip}
                        The input format of the alignments
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_align_filter_alignments

### Tool Description
Filter alignments containing certain taxa or having certain lengths.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_filter_alignments [-h] --alignments ALIGNMENTS --output
                                       OUTPUT
                                       [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                       [--containing-data-for CONTAINING [CONTAINING ...]]
                                       [--min-length MIN_LENGTH]
                                       [--min-taxa MIN_TAXA]
                                       [--verbosity {INFO,WARN,CRITICAL}]
                                       [--log-path LOG_PATH]

Filter alignments containing certain taxa or having certain lengths

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing the alignment files
  --output OUTPUT       The directory to write alignments meeting criteria.
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format
  --containing-data-for CONTAINING [CONTAINING ...]
                        Output only alignments --containing-data-for a taxon
  --min-length MIN_LENGTH
                        Filter out alignments shorter than --min-length
  --min-taxa MIN_TAXA   Filter out alignments with fewer than --min-taxa
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_align_filter_characters_from_alignments

### Tool Description
For a given folder of alignments, replace masked bases and/or insertion characters and convert to FASTA sequence files.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_filter_characters_from_alignments [-h] --alignments
                                                       ALIGNMENTS --output
                                                       OUTPUT
                                                       [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]

For a given folder of alignments, replace masked bases and/or insertion
characters and convert to FASTA sequence files

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The input alignment files to filter
  --output OUTPUT       The output FASTA file to create
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format
```

## phyluce_phyluce_align_format_concatenated_phylip_for_paml

### Tool Description
Given an input phylip file and an input config file, create a PAML-formatted file (Format #1).

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_format_concatenated_phylip_for_paml [-h]
                                                         --phylip-alignment
                                                         PHYLIP_ALIGNMENT
                                                         --config CONFIG
                                                         --output OUTPUT
                                                         [--verbosity {INFO,WARN,CRITICAL}]
                                                         [--log-path LOG_PATH]

Given an input phylip file and an input config file, create a PAML-formatted
file (Format #1)

optional arguments:
  -h, --help            show this help message and exit
  --phylip-alignment PHYLIP_ALIGNMENT
                        The PATH to a PHYLIP-formatted alignment
  --config CONFIG       The PATH to a config file containing partition
                        information (RAxML-formatted)
  --output OUTPUT       The PATH to an output file (will be PHYLIP formatted)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_align_format_nexus_files_for_mrbayes

### Tool Description
Generate a Nexus file for MrBayes given an raw_input file of Nexus-formatted alignments and a file of models associated with loci.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_format_nexus_files_for_mrbayes [-h] --alignments
                                                    ALIGNMENTS --models MODELS
                                                    --output OUTPUT
                                                    [--fully-partition]
                                                    [--interleave] [--unlink]

Generate a Nexus file for MrBayes given an raw_input file of Nexus-formatted
alignments and a file of models associated with loci.

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The path to the alignments directory
  --models MODELS       The path to the model configuration file
  --output OUTPUT       The path to the output file
  --fully-partition     Fully partition the output
  --interleave          Interleave sequence in nexus files
  --unlink              Unlink the models
```

## phyluce_phyluce_align_format_nexus_files_for_raxml

### Tool Description
Convert individual nexus files to concatenated phylip format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_format_nexus_files_for_raxml [-h] --alignments ALIGNMENTS
                                                  --output OUTPUT [--nexus]
                                                  [--charsets]
                                                  [--verbosity {INFO,WARN,CRITICAL}]
                                                  [--log-path LOG_PATH]

Convert individual nexus files to concatenated phylip format

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments to concatenate
                        (NEXUS-ONLY). (default: None)
  --output OUTPUT       The output file for the concatenated phylip data
                        (default: None)
  --nexus               Export as NEXUS format (default: False)
  --charsets            Add charsets to phylip file (default: False)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
```

## phyluce_phyluce_align_get_aligns_partitioned_by_cluster

### Tool Description
Given an input cluster CSV file, partition the input alignments by their cluster in the CSV file.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_aligns_partitioned_by_cluster [-h] --alignments
                                                       ALIGNMENTS
                                                       --cluster-csv
                                                       CLUSTER_CSV --output
                                                       OUTPUT
                                                       [--input-format {fasta,nexus,phylip,phylip-relaxed,phylip-sequential,clustal,emboss,stockholm}]
                                                       [--output-format {fasta,nexus,phylip,phylip-relaxed,phylip-sequential,clustal,emboss,stockholm}]
                                                       [--cores CORES]
                                                       [--verbosity {INFO,WARN,CRITICAL}]
                                                       [--log-path LOG_PATH]

Given an input cluster CSV file, partition the input alignments by their
cluster in the CSV file

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing the alignment files
  --cluster-csv CLUSTER_CSV
                        The cluster CSV file
  --output OUTPUT       An output directory to hold the converted alignments.
  --input-format {fasta,nexus,phylip,phylip-relaxed,phylip-sequential,clustal,emboss,stockholm}
                        The input alignment format
  --output-format {fasta,nexus,phylip,phylip-relaxed,phylip-sequential,clustal,emboss,stockholm}
                        The input alignment format
  --cores CORES         The number of cores to use.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_align_get_bed_from_lastz

### Tool Description
Output a BED file from a LASTZ alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_bed_from_lastz [-h] --lastz LASTZ --output OUTPUT
                                        [--identity IDENTITY]
                                        [--continuity CONTINUITY]
                                        [--long-format] [--conf CONF]
                                        [--sections SECTIONS [SECTIONS ...]]

Output a BED file from a LASTZ alignment

optional arguments:
  -h, --help            show this help message and exit
  --lastz LASTZ         The input lastz file.
  --output OUTPUT       The output BED file
  --identity IDENTITY   The minimum percent identity to output
  --continuity CONTINUITY
                        The minimum percent continuity to output
  --long-format         Long-format LASTZ file
  --conf CONF           A python INI formatted file containins loci to keep
  --sections SECTIONS [SECTIONS ...]
                        The sections of files to move
```

## phyluce_phyluce_align_get_gblocks_trimmed_alignments_from_untrimmed

### Tool Description
Use GBLOCKS to trim existing alignments in parallel.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_gblocks_trimmed_alignments_from_untrimmed
       [-h] --alignments ALIGNMENTS --output OUTPUT
       [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
       [--output-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
       [--b1 B1] [--b2 B2] [--b3 B3] [--b4 B4]
       [--verbosity {INFO,WARN,CRITICAL}] [--log-path LOG_PATH]
       [--cores CORES]

Use GBLOCKS to trim existing alignments in parallel

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments to be trimmed.
                        (default: None)
  --output OUTPUT       The directory in which to store the resulting
                        alignments. (default: None)
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format. (default: fasta)
  --output-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The output alignment format. (default: nexus)
  --b1 B1               The GBLOCKS -b1 proportion. (default: 0.5)
  --b2 B2               The GBLOCKS -b2 proportion. (default: 0.85)
  --b3 B3               The GBLOCKS -b3 integer value. (default: 8)
  --b4 B4               The GBLOCKS -b4 integer value. (default: 10)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
```

## phyluce_phyluce_align_get_incomplete_matrix_estimates

### Tool Description
Query a probes.matches.sqlite db for matrix completeness.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_incomplete_matrix_estimates [-h] --db DB [--min MIN]
                                                     [--max MAX] [--step STEP]
                                                     [--exclude EXCLUDE [EXCLUDE ...]
                                                     | --include INCLUDE
                                                     [INCLUDE ...]]

Query a probes.matches.sqlite db for matrix completeness

optional arguments:
  -h, --help            show this help message and exit
  --db DB               The probe.matches.sqlite database to query
  --min MIN             The minimum of the range to evaluate
  --max MAX             The maximum of the range to evaluate
  --step STEP           The step of the range to evaluate
  --exclude EXCLUDE [EXCLUDE ...]
                        Taxa to exclude
  --include INCLUDE [INCLUDE ...]
                        Taxa to include
```

## phyluce_phyluce_align_get_indels_from_alignments

### Tool Description
Count indels in alignments, relative to (but excluding) the outgroup.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_indels_from_alignments [-h] --alignments ALIGNMENTS
                                                --output OUTPUT --outgroup
                                                OUTGROUP
                                                [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                                [--trim {absolute,relative,none}]
                                                [--cores CORES]

Count indels in alignments, relative to (but excluding) the outgroup

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing the alignment files
  --output OUTPUT       The output filename (without extension - code will add
                        .sqlite)
  --outgroup OUTGROUP   The outgroup taxon
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format
  --trim {absolute,relative,none}
                        Count indels only after removing gaps/missing data
                        from alignment ends
  --cores CORES         The number of cores to use.
```

## phyluce_phyluce_align_get_informative_sites

### Tool Description
Count the number of informative sites in a given set of alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_informative_sites [-h] --alignments ALIGNMENTS
                                           [--output OUTPUT]
                                           [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                           [--cores CORES]
                                           [--verbosity {INFO,WARN,CRITICAL}]
                                           [--log-path LOG_PATH]

Count the number of informative sites in a given set of alignment

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing the alignment files
  --output OUTPUT       The output filename
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format
  --cores CORES         The number of cores to use.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_align_get_ry_recoded_alignments

### Tool Description
Recode alignments to R and Y (purine and pyrimidine) characters.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_ry_recoded_alignments [-h] --alignments ALIGNMENTS
                                               --output OUTPUT
                                               [--input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}]
                                               [--output-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}]
                                               [--verbosity {INFO,WARN,CRITICAL}]
                                               [--log-path LOG_PATH]
                                               [--cores CORES] [--binary]

Remove the UCE locus name from nexus alignments.

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The input directory containing nexus files to filter
  --output OUTPUT       The output directory to hold the converted nexus files
  --input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}
                        The input alignment format.
  --output-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}
                        The output alignment format.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
  --binary              Output alignments in binary encoding (A or G) = 1 and
                        (C or T) = 0
```

## phyluce_phyluce_align_get_smilogram_from_alignments

### Tool Description
Record variant positions in alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_smilogram_from_alignments [-h] --alignments
                                                   ALIGNMENTS --output OUTPUT
                                                   [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                                   [--cores CORES]
                                                   [--smilogram]

Record variant positions in alignments

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing the alignment files
  --output OUTPUT       The output filename (without extension - code will add
                        .sqlite)
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format
  --cores CORES         The number of cores to use.
  --smilogram           Prepare output for smilogram figure
```

## phyluce_phyluce_align_get_taxon_locus_counts_in_alignments

### Tool Description
Given an input directory of alignments, determine the number of alignments per taxon.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_taxon_locus_counts_in_alignments [-h] --alignments
                                                          ALIGNMENTS
                                                          [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]

Given an input directory of alignments, determine the number of alignments per
taxon

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The input directory of alignment files
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format
```

## phyluce_phyluce_align_get_trimal_trimmed_alignments_from_untrimmed

### Tool Description
Use trimAl to trim existing alignments in parallel.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_trimal_trimmed_alignments_from_untrimmed
       [-h] --alignments ALIGNMENTS --output OUTPUT
       [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
       [--output-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
       [--verbosity {INFO,WARN,CRITICAL}] [--log-path LOG_PATH]
       [--cores CORES]

Use GBLOCKS to trim existing alignments in parallel

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments to be trimmed.
                        (default: None)
  --output OUTPUT       The directory in which to store the resulting
                        alignments. (default: None)
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format. (default: fasta)
  --output-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The output alignment format. (default: nexus)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
```

## phyluce_phyluce_align_move_align_by_conf_file

### Tool Description
Move alignment files as denoted by config file (or do not move if using --opposite).

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_move_align_by_conf_file [-h] --conf CONF --alignments
                                             ALIGNMENTS --output OUTPUT
                                             [--sections SECTIONS [SECTIONS ...]]
                                             [--opposite]
                                             [--extension EXTENSION]

Move alignment files as denoted by config file (or do not move if using
--opposite)

optional arguments:
  -h, --help            show this help message and exit
  --conf CONF           The configuration file giving locus names
  --alignments ALIGNMENTS
                        The input directory for the alignments
  --output OUTPUT       The output directory for the alignments
  --sections SECTIONS [SECTIONS ...]
                        The sections of files to use as a filter (defaults to
                        all)
  --opposite            Move alignments based on what is NOT in the conf file
  --extension EXTENSION
                        The extension of the files to move
```

## phyluce_phyluce_align_output_list_of_taxon_counts

### Tool Description
Compute summary statistics for alignments in parallel; list FASTA files with fewer taxa than a minimum.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_output_list_of_taxon_counts [-h] --fastas FASTAS
                                                 [--input-format {fasta}]
                                                 [--min-count MIN_COUNT]
                                                 [--cores CORES]

Compute summary statistics for alignments in parallel

optional arguments:
  -h, --help            show this help message and exit
  --fastas FASTAS       The directory containing fastas to checked. (default:
                        None)
  --input-format {fasta}
                        The input file format. (default: fasta)
  --min-count MIN_COUNT
                        The min count of taxa allowed in a fasta file
                        (default: 3)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
```

## phyluce_phyluce_align_parallel_sate

### Tool Description
Run SATe alignments in parallel on a directory of FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_parallel_sate [-h] --input INPUT --output OUTPUT
                                   --sate-conf SATE_CONF [--cores CORES]

parallel_sate.py

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The input directory containing fasta files
  --output OUTPUT       The output directory to hold alignments
  --sate-conf SATE_CONF
                        The path to the SATé config file
  --cores CORES         The number of compute cores to use
```

## phyluce_phyluce_align_randomly_sample_and_concatenate

### Tool Description
Randomly sample a directory of NEXUS files, concatenate, and output.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_randomly_sample_and_concatenate [-h] --alignments
                                                     ALIGNMENTS --output
                                                     OUTPUT
                                                     [--sample-size SAMPLE_SIZE]
                                                     [--replicates REPLICATES]
                                                     [--verbosity {INFO,WARN,CRITICAL}]
                                                     [--log-path LOG_PATH]

Randomly sample a directory of NEXUS files, concatenate, and output

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing NEXUS alignments to sample
                        and concatenate
  --output OUTPUT       The output directory to hold concatenated files
  --sample-size SAMPLE_SIZE
                        The number of loci to sample
  --replicates REPLICATES
                        The number of replicate samples to take
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_align_reduce_alignments_with_raxml

### Tool Description
Reduce a directory of alignments using RAxML.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_reduce_alignments_with_raxml [-h] --alignments ALIGNMENTS
                                                  --output OUTPUT
                                                  [--input-format {fasta,phylip,phylip-relaxed}]
                                                  [--cores CORES]
                                                  [--verbosity {INFO,WARN,CRITICAL}]
                                                  [--log-path LOG_PATH]

Reduce a directory of alignments using RAxML

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        Input folder of alignments
  --output OUTPUT       Output folder for reduced alignments
  --input-format {fasta,phylip,phylip-relaxed}
                        The input alignment format
  --cores CORES         The number of compute cores to use
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_align_remove_empty_taxa

### Tool Description
Remove taxa having no data from a set of input nucleotides.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_remove_empty_taxa [-h] --alignments ALIGNMENTS --output
                                       OUTPUT
                                       [--input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}]
                                       [--output-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}]
                                       [--verbosity {INFO,WARN,CRITICAL}]
                                       [--log-path LOG_PATH] [--cores CORES]

Remove taxa having no data from a set of input nucleotides

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments to be screened.
                        (default: None)
  --output OUTPUT       The directory in which to store the resulting
                        alignments. (default: None)
  --input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}
                        The input alignment format (default: nexus)
  --output-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}
                        The input alignment format (default: nexus)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
```

## phyluce_phyluce_align_remove_locus_name_from_nexus_lines

### Tool Description
Remove the UCE locus name from nexus alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_remove_locus_name_from_nexus_lines [-h] --alignments
                                                        ALIGNMENTS --output
                                                        OUTPUT [--taxa TAXA]
                                                        [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                                        [--output-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                                        [--verbosity {INFO,WARN,CRITICAL}]
                                                        [--log-path LOG_PATH]
                                                        [--cores CORES]

Remove the UCE locus name from nexus alignments.

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The input directory containing nexus files to filter
  --output OUTPUT       The output directory to hold the converted nexus files
  --taxa TAXA           The expected number of taxa in all alignments
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format.
  --output-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The output alignment format.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
```

## phyluce_phyluce_align_screen_alignments_for_problems

### Tool Description
Screen a given set of alignments for problematic nucleotides.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_screen_alignments_for_problems [-h] --alignments
                                                    ALIGNMENTS --output OUTPUT
                                                    [--do-not-screen-n]
                                                    [--do-not-screen-x]
                                                    [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                                    [--verbosity {INFO,WARN,CRITICAL}]
                                                    [--log-path LOG_PATH]
                                                    [--cores CORES]

Screen a given set of alignments for problematic nucleotides

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments to be screened.
                        (default: None)
  --output OUTPUT       The directory in which to store the resulting
                        alignments. (default: None)
  --do-not-screen-n     Screen alignments for taxa containing ambiguous (N)
                        bases. (default: False)
  --do-not-screen-x     Screen alignments for taxa containing ambiguous (X)
                        bases. (default: False)
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format (default: nexus)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
```

## phyluce_phyluce_align_split_concat_nexus_to_loci

### Tool Description
Split a concatenated NEXUS file into component loci using the charsets values.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_split_concat_nexus_to_loci [-h] --nexus NEXUS --output
                                                OUTPUT

Split a concatenated NEXUS file into component loci using the charsets values

optional arguments:
  -h, --help       show this help message and exit
  --nexus NEXUS    The input NEXUS file
  --output OUTPUT  The output directory in which to store alignments
```

## phyluce_phyluce_ncbi_prep_uce_align_files_for_ncbi

### Tool Description
Format a monolithic NCBI fasta file for tbl2asn from alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_ncbi_prep_uce_align_files_for_ncbi [-h] --alignments ALIGNMENTS
                                                  --conf CONF --output OUTPUT
                                                  [--input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}]
                                                  [--verbosity {INFO,WARN,CRITICAL}]
                                                  [--log-path LOG_PATH]

Format a monolithic NCBI fasta file for tbl2asn from alignments

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments
  --conf CONF           The config file name
  --output OUTPUT       The output file name
  --input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}
                        The input alignment format
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_ncbi_prep_uce_align_files_for_ncbi_targeted_locus_db

### Tool Description
Format a monolithic NCBI fasta file for tbl2asn from alignments (targeted locus database).

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_ncbi_prep_uce_align_files_for_ncbi_targeted_locus_db
       [-h] --alignments ALIGNMENTS --conf CONF --output OUTPUT
       [--input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}]
       [--verbosity {INFO,WARN,CRITICAL}] [--log-path LOG_PATH]

Format a monolithic NCBI fasta file for tbl2asn from alignments

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments
  --conf CONF           The config file name
  --output OUTPUT       The directory in which to store output files
  --input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}
                        The input alignment format
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_genetrees_generate_multilocus_bootstrap_count

### Tool Description
Performs multi-locus bootstrapping and ML tree searches for a folder of phylip-formatted alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_generate_multilocus_bootstrap_count
       [-h] --alignments ALIGNMENTS --bootstrap_replicates
       BOOTSTRAP_REPLICATES [--directory DIRECTORY] --bootstrap_counts
       BOOTSTRAP_COUNTS [--bootreps BOOTREPS]
       [--verbosity {INFO,WARN,CRITICAL}] [--log-path LOG_PATH]

Performs multi-locus bootstrapping and ML tree searches for a folder of
phylip-formatted alignments

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The input directory containing alignments in phylip
                        format
  --bootstrap_replicates BOOTSTRAP_REPLICATES
                        The file that will hold bootstrap replicates sampling
  --directory DIRECTORY
                        Optional path to directory containing alignments.
                        Defaults to alignment directory if not provided.
  --bootstrap_counts BOOTSTRAP_COUNTS
                        The CSV file that will hold bootstrap replicate counts
                        for each locus
  --bootreps BOOTREPS   The number of bootstrap replicates to run
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_genetrees_get_mean_bootrep_support

### Tool Description
Root some genetrees

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_get_mean_bootrep_support [-h] --trees TREES --config
                                                  CONFIG
                                                  [--schema {nexus,newick,nexml,fasta,phylip}]
                                                  --root ROOT

Root some genetrees

optional arguments:
  -h, --help            show this help message and exit
  --trees TREES         Tree file
  --config CONFIG       config file
  --schema {nexus,newick,nexml,fasta,phylip}
                        The scheme of the input data
  --root ROOT           The taxon on which to root trees
```

## phyluce_phyluce_genetrees_get_tree_counts

### Tool Description
Count gene tree topologies

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_get_tree_counts [-h] --trees TREES
                                         --locus-support-output
                                         LOCUS_SUPPORT_OUTPUT
                                         [--schema {nexus,newick,nexml,fasta,phylip}]
                                         --root ROOT --extension EXTENSION
                                         [--exclude EXCLUDE [EXCLUDE ...]]

Count gene tree topologies

optional arguments:
  -h, --help            show this help message and exit
  --trees TREES         Tree file
  --locus-support-output LOCUS_SUPPORT_OUTPUT
                        The output file in which to store trees and their
                        associated loci (config format)
  --schema {nexus,newick,nexml,fasta,phylip}
                        The scheme of the input data
  --root ROOT           The taxon on which to root trees
  --extension EXTENSION
                        File extension used with each 'best' tree
  --exclude EXCLUDE [EXCLUDE ...]
                        Loci to exclude
```

## phyluce_phyluce_genetrees_locus_stats

### Tool Description
Program description

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_locus_stats [-h] --config CONFIG --alignments
                                     ALIGNMENTS
                                     [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                     [--verbosity {INFO,WARN,CRITICAL}]
                                     [--log-path LOG_PATH] [--cores CORES]

Program description

optional arguments:
  -h, --help            show this help message and exit
  --config CONFIG       The gene tree configuration file
  --alignments ALIGNMENTS
                        Alignment files to process
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
```

## phyluce_phyluce_genetrees_order_gene_tree_file

### Tool Description
Root some genetrees

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_order_gene_tree_file [-h] --newick-treefile
                                              NEWICK_TREEFILE --output OUTPUT
                                              --root ROOT
                                              [--verbosity {INFO,WARN,CRITICAL}]
                                              [--log-path LOG_PATH]

Root some genetrees

optional arguments:
  -h, --help            show this help message and exit
  --newick-treefile NEWICK_TREEFILE
                        A newick-formatted treefile to input
  --output OUTPUT       The output newick-formatted treefile to create
  --root ROOT           The taxon on which to root trees
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.

(The program fails with "ImportError: No module named ete2" in the image, so this help text was rebuilt from the argparse definitions in /usr/local/bin/phyluce_genetrees_order_gene_tree_file.)
```

## phyluce_phyluce_genetrees_phybase

### Tool Description
Phybase.py calculates species trees from gene trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_phybase [-h] --input INPUT [--outgroup OUTGROUP]
                                 [--method {star,njst}] [--cores CORES]
                                 (--genetrees | --bootreps)

Phybase.py calculates species trees from gene trees.

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The path to the input genetrees or bootreps. Must be
                        parsed using reformat_raxml_output.py.
  --outgroup OUTGROUP   The name of the outgroup on which the trees are
                        rooted.Not needed for NJst
  --method {star,njst}  The method to use.
  --cores CORES         The number of compute cores to use
  --genetrees           Choose this if you want to generate the species tree
                        from gene trees.
  --bootreps            Choose this if you want to generate support values for
                        bootrepped gene trees

(The program fails with "ImportError: No module named rpy2.robjects" in the image, so this help text was rebuilt from the argparse definitions in /usr/local/bin/phyluce_genetrees_phybase.)
```

## phyluce_phyluce_genetrees_reformat_raxml_output

### Tool Description
Program description

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_reformat_raxml_output [-h] [--genetrees GENETREES]
                                               [--bootreps BOOTREPS] --output
                                               OUTPUT

Program description

optional arguments:
  -h, --help            show this help message and exit
  --genetrees GENETREES
                        The path to the directory containing RAxML best trees
  --bootreps BOOTREPS   The path to the directory containing RAxML bootreps
  --output OUTPUT       The output file name
```

## phyluce_phyluce_genetrees_reformat_trees

### Tool Description
Rename the leaves of an input tree

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_reformat_trees [-h] --input INPUT --output OUTPUT
                                        [--input-format {nexus,newick,fasta,phylip}]
                                        [--output-format {nexus,newick,fasta,phylip}]
                                        [--do-not-preserve-spaces DO_NOT_PRESERVE_SPACES]

Rename the leaves of an input tree

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The input trees directory
  --output OUTPUT       The output trees directory
  --input-format {nexus,newick,fasta,phylip}
                        The tree file format
  --output-format {nexus,newick,fasta,phylip}
                        The tree file format
  --do-not-preserve-spaces DO_NOT_PRESERVE_SPACES
                        Do not retain spaces in output names
```

## phyluce_phyluce_genetrees_rename_tree_leaves

### Tool Description
Rename the leaves of an input tree

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_rename_tree_leaves [-h] --input INPUT --config CONFIG
                                            --output OUTPUT --section SECTION
                                            [--order {left:right,right:left}]
                                            [--input-format {nexus,newick,fasta,phylip}]
                                            [--output-format {nexus,newick,fasta,phylip}]
                                            [--reroot REROOT]
                                            [--do-not-preserve-spaces DO_NOT_PRESERVE_SPACES]

Rename the leaves of an input tree

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The input tree file
  --config CONFIG       A python config file mapping one name to another
  --output OUTPUT       The output tree file
  --section SECTION     The section of the conf file to use
  --order {left:right,right:left}
                        Map the names as entered or in reverse
  --input-format {nexus,newick,fasta,phylip}
                        The tree file format
  --output-format {nexus,newick,fasta,phylip}
                        The tree file format
  --reroot REROOT       The resulting name to root the tree on
  --do-not-preserve-spaces DO_NOT_PRESERVE_SPACES
                        Do not retain spaces in output names
```

## phyluce_phyluce_genetrees_run_raxml_bootstraps

### Tool Description
Program description

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_run_raxml_bootstraps [-h] --alignments ALIGNMENTS
                                              --best-trees BEST_TREES --output
                                              OUTPUT [--bootreps BOOTREPS]
                                              [--outgroup OUTGROUP]
                                              [--threads THREADS]
                                              [--cores CORES] [--quiet]

Program description

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments to be summarized.
  --best-trees BEST_TREES
                        The directory containing the best trees
  --output OUTPUT       The output directory to hold alignments
  --bootreps BOOTREPS   The number of bootstrap replicates to run
  --outgroup OUTGROUP   The outgroup to use
  --threads THREADS     The number of RAxML threads to run (best to determine
                        empirically)
  --cores CORES         The number of concurrent RAxML jobs to run
  --quiet               Suppress the CPU usage question
```

## phyluce_phyluce_genetrees_run_raxml_genetrees

### Tool Description
Performs ML tree search on a folder of phylip-formatted alignments using RAxML

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_run_raxml_genetrees [-h] --input INPUT --output
                                             OUTPUT [--outgroup OUTGROUP]
                                             [--threads THREADS]
                                             [--tree-searches TREE_SEARCHES]
                                             [--cores CORES] [--quiet]
                                             [--verbosity {INFO,WARN,CRITICAL}]
                                             [--log-path LOG_PATH]

Performs ML tree search on a folder of phylip-formatted alignments using RAxML

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The input directory containing alignments in phylip
                        format
  --output OUTPUT       The output directory to hold alignments
  --outgroup OUTGROUP   The outgroup to use
  --threads THREADS     The number of RAxML threads to run (best to determine
                        empirically)
  --tree-searches TREE_SEARCHES
                        The number of tree searches to run.
  --cores CORES         The number of concurrent RAxML jobs to run
  --quiet               Suppress the CPU usage question
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_genetrees_run_raxml_multilocus_bootstraps

### Tool Description
Performs multi-locus bootstrapping and ML tree searches for a folder of phylip-formatted alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_run_raxml_multilocus_bootstraps [-h] --input INPUT
                                                         --best-trees
                                                         BEST_TREES --output
                                                         OUTPUT
                                                         [--bootreps BOOTREPS]
                                                         [--outgroup OUTGROUP]
                                                         [--threads THREADS]
                                                         [--cores CORES]
                                                         [--quiet]
                                                         [--verbosity {INFO,WARN,CRITICAL}]
                                                         [--log-path LOG_PATH]

Performs multi-locus bootstrapping and ML tree searches for a folder of
phylip-formatted alignments

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The input directory containing alignments in phylip
                        format
  --best-trees BEST_TREES
                        The directory containing the best trees
  --output OUTPUT       The output directory to hold alignments
  --bootreps BOOTREPS   The number of bootstrap replicates to run
  --outgroup OUTGROUP   The outgroup to use
  --threads THREADS     The number of RAxML threads to run (best to determine
                        empirically)
  --cores CORES         The number of concurrent RAxML jobs to run
  --quiet               Suppress the CPU usage question
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_genetrees_sort_multilocus_bootstraps

### Tool Description
Sorts RAxML bootstrap output into multi-locus bootstrap replicates.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_sort_multilocus_bootstraps [-h] --input INPUT
                                                    --bootstrap_replicates
                                                    BOOTSTRAP_REPLICATES
                                                    --output OUTPUT

Sorts RAxML bootstrap output into multi-locus bootstrap replicates.

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The input directory containing bootstrap replicates
                        for each locus
  --bootstrap_replicates BOOTSTRAP_REPLICATES
                        The file containing bootstrap replicate sampling
  --output OUTPUT       The output directory to multi-locus bootstraps
```

## phyluce_phyluce_genetrees_split_models_from_genetrees

### Tool Description
Split the substitution models from genetrees output by CloudForest

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_genetrees_split_models_from_genetrees [-h] --genetrees
                                                     GENETREES --output OUTPUT

Split the substitution models from genetrees output by CloudForest

optional arguments:
  -h, --help            show this help message and exit
  --genetrees GENETREES
                        The cloudforest genetree file containing models
  --output OUTPUT       The output file to hold the parsed substitution model
                        data
```

## phyluce_phyluce_snp_bwa_align

### Tool Description
Call SNPs

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_snp_bwa_align [-h] --config CONFIG --output OUTPUT
                             [--subfolder SUBFOLDER] [--cores CORES]
                             [--verbosity {INFO,WARN,CRITICAL}]
                             [--log-path LOG_PATH] [--no-remove-duplicates]
                             [--mem]

Call SNPs

optional arguments:
  -h, --help            show this help message and exit
  --config CONFIG       A configuration file containing
  --output OUTPUT       The directory in which to store the SNPs files
  --subfolder SUBFOLDER
                        A subdirectory, below the level of the group,
                        containing the reads
  --cores CORES         The number of compute cores/threads to use
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use
  --log-path LOG_PATH   The path to a directory to hold logs.
  --no-remove-duplicates
                        Do not remove duplicate reads.
  --mem                 Use bwa mem.
```

## phyluce_phyluce_snp_bwa_multiple_align

### Tool Description
Call SNPs from multiple samples across a sample-specific reference

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_snp_bwa_multiple_align [-h] --config CONFIG --output OUTPUT
                                      [--subfolder SUBFOLDER] [--cores CORES]
                                      [--verbosity {INFO,WARN,CRITICAL}]
                                      [--log-path LOG_PATH]
                                      [--no-remove-duplicates] [--mem]

Call SNPs from multiple samples across a sample-specific reference

optional arguments:
  -h, --help            show this help message and exit
  --config CONFIG       A configuration file containing the reference-to-read
                        sample mapping and some metadata
  --output OUTPUT       The directory in which to store the SNPs files
  --subfolder SUBFOLDER
                        A subdirectory, below the level of the group,
                        containing the reads
  --cores CORES         The number of compute cores/threads to use
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use
  --log-path LOG_PATH   The path to a directory to hold logs.
  --no-remove-duplicates
                        Do not remove duplicate reads.
  --mem                 Use bwa mem.
```

## phyluce_phyluce_snp_convert_vcf_to_snapp

### Tool Description
Parse fastq files and drop reads containing Ns.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_snp_convert_vcf_to_snapp [-h] --input INPUT --output OUTPUT
                                        [--filter-identical | --filter-informative]

Parse fastq files and drop reads containing Ns.

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The VCF file to process
  --output OUTPUT       The STRUCTURE file to write
  --filter-identical    Remove sites with only a single genotype.
  --filter-informative  Remove uninformative sites.
```

## phyluce_phyluce_snp_convert_vcf_to_structure

### Tool Description
Parse fastq files and drop reads containing Ns.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_snp_convert_vcf_to_structure [-h] --input INPUT --output OUTPUT
                                            [--filter-identical | --filter-informative]

Parse fastq files and drop reads containing Ns.

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The VCF file to process
  --output OUTPUT       The STRUCTURE file to write
  --filter-identical    Remove sites with only a single genotype.
  --filter-informative  Remove uninformative sites.
```

## phyluce_phyluce_snp_find_snps_in_bed_interval

### Tool Description
Match UCE probes to assembled contigs and store the data

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_snp_find_snps_in_bed_interval [-h] --uce UCE --snp SNP
                                             [--output OUTPUT]

Match UCE probes to assembled contigs and store the data

optional arguments:
  -h, --help       show this help message and exit
  --uce UCE        The UCE BED file
  --snp SNP        The SNP intersection BED file
  --output OUTPUT  The output file
```

## phyluce_phyluce_snp_get_dbsnp_freq_stats

### Tool Description
Get the average contig length, by species, within a combined fasta

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_snp_get_dbsnp_freq_stats [-h] --dbsnp DBSNP --xml XML
                                        [--output OUTPUT] [--output2 OUTPUT2]
                                        [--dupefile DUPEFILE]

Get the average contig length, by species, within a combined fasta

optional arguments:
  -h, --help           show this help message and exit
  --dbsnp DBSNP        CSV input from dbSNP giving SNP positions within UCE
  --xml XML            The XML file holiding locus data from dbSNP
  --output OUTPUT      The output file
  --output2 OUTPUT2    The output file
  --dupefile DUPEFILE  The path to a lastz file of lastz-against-self results
```

## phyluce_phyluce_snp_get_dbsnp_variability_for_all_uces

### Tool Description
Get the average contig length, by species, within a combined fasta

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_snp_get_dbsnp_variability_for_all_uces [-h] --dbsnp DBSNP --xml
                                                      XML [--output OUTPUT]
                                                      [--dupefile DUPEFILE]

Get the average contig length, by species, within a combined fasta

optional arguments:
  -h, --help           show this help message and exit
  --dbsnp DBSNP        CSV input from dbSNP giving SNP positions within UCE
  --xml XML            The XML file holiding locus data from dbSNP
  --output OUTPUT      The output file
  --dupefile DUPEFILE  The path to a lastz file of lastz-against-self results
```

## phyluce_phyluce_snp_get_from_uce_alignments

### Tool Description
Clean and trim raw Illumina read files

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_snp_get_from_uce_alignments [-h] --input INPUT [--config CONFIG]
                                           [--phased] [--missing] --output
                                           OUTPUT

Clean and trim raw Illumina read files

optional arguments:
  -h, --help       show this help message and exit
  --input INPUT    The directory containing all fasta-alignment files
                   (default: None)
  --config CONFIG  A configuration file containing all taxa names to be used
                   for SNP extraction (default: None)
  --phased         Use flag if alignments contain phased sequences (default:
                   False)
  --missing        Use flag if you want to include missing data into the SNP
                   alignment for a higher SNP yield (default: False)
  --output OUTPUT  The output directory where results will be saved (default:
                   None)

(The program fails with "ImportError: No module named cogent" in the image, so this help text was rebuilt from the argparse definitions in /usr/local/bin/phyluce_snp_get_from_uce_alignments.)
```

## phyluce_phyluce_snp_phase_uces

### Tool Description
Phase reads in a BAM file into two separate alleles. Then produce a consensus sequence for each allele.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_snp_phase_uces [-h] --config CONFIG --bams BAMS --output OUTPUT
                              [--conservative] [--cores CORES]
                              [--verbosity {INFO,WARN,CRITICAL}]
                              [--log-path LOG_PATH]

Phase reads in a BAM file into two separate alleles. Then produce a consensus
sequence for each allele.

optional arguments:
  -h, --help            show this help message and exit
  --config CONFIG       A configuration file containing the reference-to-read
                        sample mapping and some metadata
  --bams BAMS           The directory containing sample-specific BAM files
  --output OUTPUT       The directory in which to store the SNPs files
  --conservative        Use this flag if you want to discard all base calls
                        with limited certainty (covered by <3 reads). This
                        will produce the ambiguity character "N" instead of
                        that potential base call in the final sequence.
  --cores CORES         For parallel processing you can choose the number of
                        cores you want CLC to run on.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_snp_prep_interval_list_file_for_picard

### Tool Description
Given an input BED file and BAM file, output an interval.list file

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_snp_prep_interval_list_file_for_picard [-h] --bed BED --bam BAM
                                                      [--output OUTPUT]

Given an input BED file and BAM file, output an interval.list file

optional arguments:
  -h, --help       show this help message and exit
  --bed BED        The BED file to filter.
  --bam BAM        The BED file to filter.
  --output OUTPUT  The output BED file
```

## phyluce_phyluce_snp_screen_phased_alignments

### Tool Description
Program description

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_snp_screen_phased_alignments [-h] --alignments ALIGNMENTS
                                            --output OUTPUT
                                            [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                            [--output-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                            [--include-missing] [--random]
                                            [--numerical-encoding]
                                            [--cores CORES]
                                            [--verbosity {INFO,WARN,CRITICAL}]
                                            [--log-path LOG_PATH]

Program description

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing the alignment files
  --output OUTPUT       The directory in which to store the output files
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format
  --output-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format
  --include-missing     Include sites within missing/ambiguous information (-,
                        ?, N, X)
  --random              Pick one random site from each locus
  --numerical-encoding  Output SNP calls encoded as 0 (ref/ref), 1 (ref/alt),
                        or 2 (alt/alt)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
```

## phyluce_phyluce_snp_screen_vcf_files

### Tool Description
Parse fastq files and drop reads containing Ns.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_snp_screen_vcf_files [-h] --input INPUT --output OUTPUT
                                    [--complete COMPLETE]

Parse fastq files and drop reads containing Ns.

optional arguments:
  -h, --help           show this help message and exit
  --input INPUT        The vcf file to process
  --output OUTPUT      The vcf file to write
  --complete COMPLETE  The percentage of missing data to allow.
```

## phyluce_phyluce_snp_summarize_vcf_file

### Tool Description
Parse fastq files and drop reads containing Ns.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_snp_summarize_vcf_file [-h] --input INPUT

Parse fastq files and drop reads containing Ns.

optional arguments:
  -h, --help     show this help message and exit
  --input INPUT  The vcf file to process
```

## Metadata
- **Skill**: generated

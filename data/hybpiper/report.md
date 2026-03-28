# hybpiper CWL Generation Report

## hybpiper_assemble

### Tool Description
HybPiper is a pipeline for assembling target-capture data.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/mossmatters/HybPiper
- **Package**: https://anaconda.org/channels/bioconda/packages/hybpiper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hybpiper/overview
- **Total Downloads**: 13.4K
- **Last updated**: 2026-01-12
- **GitHub**: https://github.com/mossmatters/HybPiper
- **Stars**: N/A
### Original Help Text
```text
T
                                                        T
                                         C  G
 _    _            _       _____      T        G        A
| |  | |          | |     |  _  \  A              A  A
| |__| | __    __ | |___  | |_| |  _   _____   _____   _____
|  __  | \ \  / / |  _  \ |  ___/ | | |  _  \ |  _  | |  _  \
| |  | |  \ \/ /  | |_| | | |     | | | |_| | |  __/  | |  --
|_|  |_|   \  /   |_____/ |_|     |_| |  ___/ |_____| |_|
           / /                        | |
          /_/                         |_|


usage: hybpiper assemble [-h] --readfiles READFILES [READFILES ...]
                         (--targetfile_dna TARGETFILE_DNA |
                         --targetfile_aa TARGETFILE_AA) [--unpaired UNPAIRED]
                         [--bwa | --diamond]
                         [--diamond_sensitivity {mid-sensitive,sensitive,more-sensitive,very-sensitive,ultra-sensitive}]
                         [--evalue FLOAT] [--max_target_seqs INTEGER]
                         [--distribute_low_mem] [--cov_cutoff INTEGER]
                         [--single_cell_assembly]
                         [--kvals INTEGER [INTEGER ...]] [--merged]
                         [--timeout_assemble_reads INTEGER] [--no_spades_eta]
                         [--not_protein_coding]
                         [--extract_contigs_blast_task {blastn,blastn-short,megablast,dc-megablast}]
                         [--extract_contigs_blast_evalue FLOAT]
                         [--extract_contigs_blast_word_size INTEGER]
                         [--extract_contigs_blast_gapopen INTEGER]
                         [--extract_contigs_blast_gapextend INTEGER]
                         [--extract_contigs_blast_penalty INTEGER]
                         [--extract_contigs_blast_reward INTEGER]
                         [--extract_contigs_blast_perc_identity INTEGER]
                         [--extract_contigs_blast_max_target_seqs INTEGER]
                         [--thresh INTEGER]
                         [--paralog_min_length_percentage FLOAT]
                         [--depth_multiplier INTEGER] [--target TARGET]
                         [--exclude EXCLUDE]
                         [--timeout_extract_contigs INTEGER]
                         [--no_stitched_contig]
                         [--no_pad_stitched_contig_gaps_with_n]
                         [--chimeric_stitched_contig_check]
                         [--bbmap_memory INTEGER] [--bbmap_subfilter INTEGER]
                         [--bbmap_threads INTEGER]
                         [--chimeric_stitched_contig_edit_distance INTEGER]
                         [--chimeric_stitched_contig_discordant_reads_cutoff INTEGER]
                         [--trim_hit_sliding_window_size INTEGER]
                         [--trim_hit_sliding_window_thresh INTEGER]
                         [--exonerate_skip_hits_with_frameshifts]
                         [--exonerate_skip_hits_with_internal_stop_codons]
                         [--exonerate_skip_hits_with_terminal_stop_codons]
                         [--exonerate_refine_full] [--no_intronerate]
                         [--no_padding_supercontigs] [--prefix PREFIX]
                         [--start_from {map_reads,distribute_reads,assemble_reads,extract_contigs}]
                         [--end_with {map_reads,distribute_reads,assemble_reads,extract_contigs}]
                         [--force_overwrite] [--cpu INTEGER]
                         [--compress_sample_folder] [--skip_targetfile_checks]
                         [--keep_intermediate_files] [--verbose_logging]
                         [--hybpiper_output OUTPUT_FOLDER] [--run_profiler]

options:
  -h, --help            show this help message and exit

Required input:
  --readfiles, -r READFILES [READFILES ...]
                        One or more read files to start the pipeline. If
                        exactly two are specified, HybPiper will assume it is
                        paired Illumina reads.
  --targetfile_dna, -t_dna TARGETFILE_DNA
                        FASTA file containing DNA target sequences for each
                        gene. The fasta headers must follow the naming
                        convention: >TaxonID-geneName
  --targetfile_aa, -t_aa TARGETFILE_AA
                        FASTA file containing amino-acid target sequences for
                        each gene. The fasta headers must follow the naming
                        convention: >TaxonID-geneName

Optional input:
  --unpaired UNPAIRED   Include a single FASTQ file with unpaired reads along
                        with two paired read files

Options for step: map_reads:
  --bwa                 Use BWA to map reads to targets. Requires BWA and a
                        target file that is nucleotides! Default is: False
  --diamond             Use DIAMOND instead of BLASTx for read mapping.
                        Default is: False
  --diamond_sensitivity {mid-sensitive,sensitive,more-sensitive,very-sensitive,ultra-sensitive}
                        Use the provided sensitivity for DIAMOND read-mapping
                        searches.
  --evalue FLOAT        e-value threshold for mapping blastx hits. Default is:
                        0.0001
  --max_target_seqs INTEGER
                        Max target seqs to save in BLASTx search. Default is:
                        10

Options for step: distribute_reads:
  --distribute_low_mem  Distributing and writing reads to individual gene
                        directories will be 40-50 percent slower, but can use
                        less memory/RAM with large input files (see wiki).
                        Default is: False

Options for step: assemble_reads:
  --cov_cutoff INTEGER  Coverage cutoff for SPAdes. Default is: 8
  --single_cell_assembly
                        Run SPAdes assemblies in MDA (single-cell) mode.
                        Default is: False
  --kvals INTEGER [INTEGER ...]
                        Values of k for SPAdes assemblies. SPAdes needs to be
                        compiled to handle larger k-values! Default is auto-
                        detection by SPAdes.
  --merged              For assembly with both merged and unmerged
                        (interleaved) reads. Default is: False.
  --timeout_assemble_reads INTEGER
                        Kill long-running gene assemblies if they take longer
                        than X percent of average.
  --no_spades_eta       When SPAdes is run concurrently using GNU parallel,
                        the "--eta" flag can result in many "sh: /dev/tty:
                        Device not configured" errors written to stderr. Using
                        this option removes the "--eta" flag to GNU parallel.
                        Default is False.

Options for step: extract_contigs:
  --not_protein_coding  If provided, extract sequences from SPAdes contigs
                        using BLASTn rather than Exonerate (step:
                        extract_contigs)
  --extract_contigs_blast_task {blastn,blastn-short,megablast,dc-megablast}
                        Task to use for BLASTn searches during the
                        extract_contigs step of the assembly pipeline. See
                        https://www.ncbi.nlm.nih.gov/books/NBK569839/ for a
                        description of tasks. Default is: blastn
  --extract_contigs_blast_evalue FLOAT
                        Expectation value (E) threshold for saving hits.
                        Default is: 10
  --extract_contigs_blast_word_size INTEGER
                        Word size for wordfinder algorithm (length of best
                        perfect match).
  --extract_contigs_blast_gapopen INTEGER
                        Cost to open a gap.
  --extract_contigs_blast_gapextend INTEGER
                        Cost to extend a gap.
  --extract_contigs_blast_penalty INTEGER
                        Penalty for a nucleotide mismatch.
  --extract_contigs_blast_reward INTEGER
                        Reward for a nucleotide match.
  --extract_contigs_blast_perc_identity INTEGER
                        Percent identity. Can be used as a pre-filter at the
                        BLASTn stage, followed by --thresh (see below).
  --extract_contigs_blast_max_target_seqs INTEGER
                        Maximum number of aligned sequences to keep (value of
                        5 or more is recommended). Default is: 500
  --thresh INTEGER      Percent identity threshold for retaining
                        Exonerate/BLASTn hits. Default is 55, but increase
                        this if you are worried about contaminant sequences.
                        Exonerate hit identity is calculated using amino-
                        acids, BLASTn hit identity is calculated using
                        nucleotides.
  --paralog_min_length_percentage FLOAT
                        Minimum length percentage of a contig Exonerate hit vs
                        reference protein length for a paralog warning and
                        sequence to be generated. Default is: 0.75
  --depth_multiplier INTEGER
                        Assign a long paralog as the "main" sequence if it has
                        a coverage depth <depth_multiplier> times all other
                        long paralogs. Set to zero to not use depth. Default
                        is: 10
  --target TARGET       Use the target file sequence with this taxon name in
                        Exonerate/BLASTn searches for each gene. Other targets
                        for that gene will be used only for read sorting. Can
                        be a tab-delimited file (one <gene>\t<taxon_name> per
                        line) or a single taxon name.
  --exclude EXCLUDE     Do not use any sequence with the specified taxon name
                        string in Exonerate/BLASTn searches. Sequences from
                        this taxon will still be used for read sorting.
  --timeout_extract_contigs INTEGER
                        Kill long-running processes if they take longer than X
                        seconds. Default is: 120
  --no_stitched_contig  Do not create any stitched contigs. The longest single
                        Exonerate/BLASTn hit will be used. Default is: False.
  --no_pad_stitched_contig_gaps_with_n
                        When constructing stitched contigs, do not pad any
                        gaps between hits (with respect to the "best" protein
                        reference) with a number of Ns corresponding to the
                        reference gap multiplied by 3 (Exonerate) or reference
                        gap (BLASTn). Default is: True.
  --chimeric_stitched_contig_check
                        Attempt to determine whether a stitched contig is a
                        potential chimera of contigs from multiple paralogs.
                        Default is: False.
  --bbmap_memory INTEGER
                        MB memory (RAM) to use for bbmap.sh if a chimera check
                        is performed during step extract_contigs. Default: is
                        1000.
  --bbmap_subfilter INTEGER
                        Ban alignments with more than this many substitutions.
                        Default is: 7.
  --bbmap_threads INTEGER
                        Number of threads to use for BBmap when searching for
                        chimeric stitched contig. Default is: 1.
  --chimeric_stitched_contig_edit_distance INTEGER
                        Minimum number of differences between one read of a
                        read pair vs the stitched contig reference for a read
                        pair to be flagged as discordant. Default is: 5.
  --chimeric_stitched_contig_discordant_reads_cutoff INTEGER
                        Minimum number of discordant reads pairs required to
                        flag a stitched contig as a potential chimera of
                        contigs from multiple paralogs. Default is 5.
  --trim_hit_sliding_window_size INTEGER
                        Size of the sliding window (amino acids for Exonerate,
                        nucleotides for BLASTn) when trimming hit termini.
                        Default is: 5 (Exonerate) or 15 (BLASTn).
  --trim_hit_sliding_window_thresh INTEGER
                        Percentage similarity threshold for the sliding window
                        (amino acids for Exonerate, nucleotides for BLASTn)
                        when trimming hit termini. Default is: 75 (Exonerate)
                        or 65 (BLASTn).
  --exonerate_skip_hits_with_frameshifts
                        Skip Exonerate hits where the SPAdes sequence contains
                        a frameshift. See: https://github.com/mossmatters/HybP
                        iper/wiki/Troubleshooting-common-issues,-and-
                        recommendations#42-hits-where-the-spades-contig-
                        contains-frameshifts. Default is: False.
  --exonerate_skip_hits_with_internal_stop_codons
                        Skip Exonerate hits where the SPAdes sequence contains
                        an internal in-frame stop codon. See: https://github.c
                        om/mossmatters/HybPiper/wiki/Troubleshooting,-common-
                        issues,-and-recommendations#31-sequences-containing-
                        stop-codons. A single terminal stop codon is allowed,
                        but see option "--
                        exonerate_skip_hits_with_terminal_stop_codons" below.
                        Default is: False.
  --exonerate_skip_hits_with_terminal_stop_codons
                        Skip Exonerate hits where the SPAdes sequence contains
                        a single terminal stop codon. Only applies when option
                        "--exonerate_skip_hits_with_internal_stop_codons" is
                        also provided. Only use this flag if your target file
                        exclusively contains protein-coding genes with no stop
                        codons included, and you would like to prevent any in-
                        frame stop codons in the output sequences. Default is:
                        False.
  --exonerate_refine_full
                        Run Exonerate searches using the parameter "--refine
                        full". Default is: False.
  --no_intronerate      Do not run intronerate to recover fasta files for
                        supercontigs with introns (if present), and introns-
                        only. Default is: False.
  --no_padding_supercontigs
                        If Intronerate is run, and a supercontig is created by
                        concatenating multiple SPAdes contigs, do not add 10
                        "N" characters between contig joins. By default, Ns
                        will be added. Default is: False.

General pipeline options:
  --prefix PREFIX       Directory name for pipeline output, default is to use
                        the FASTQ file name.
  --start_from {map_reads,distribute_reads,assemble_reads,extract_contigs}
                        Start the pipeline from the given step. Note that this
                        relies on the presence of output files for previous
                        steps, produced by a previous run attempt. Default is:
                        map_reads
  --end_with {map_reads,distribute_reads,assemble_reads,extract_contigs}
                        End the pipeline at the given step. Default is:
                        extract_contigs
  --force_overwrite     Overwrite any output from a previous run for pipeline
                        steps >= --start_from and <= --end_with. Default is:
                        False
  --cpu INTEGER         Limit the number of CPUs. Default is to use all cores
                        available minus one.
  --compress_sample_folder
                        Tarball and compress the sample folder after assembly
                        has completed (<sample_name>.tar.gz). Default is:
                        False.
  --skip_targetfile_checks
                        Skip the target file checks. Can be used if you are
                        confident that your target file has no issues (e.g. if
                        you have previously run "hybpiper check_targetfile".
                        Default is: False
  --keep_intermediate_files
                        Keep all intermediate files and logs, which can be
                        useful for debugging. Default action is to delete
                        them, which greatly reduces the total file number.
                        Default is: False.
  --verbose_logging     If supplied, enable verbose logging. NOTE: this can
                        increase the size of the log files by an order of
                        magnitude. Default is: False.
  --hybpiper_output, -o OUTPUT_FOLDER
                        Folder for HybPiper output. Default is None.
  --run_profiler        If supplied, run the subcommand using cProfile. Saves
                        a *.csv file of results. Default is: False.
```


## hybpiper_stats

### Tool Description
Sequence type (gene or supercontig) to recover lengths for.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/mossmatters/HybPiper
- **Package**: https://anaconda.org/channels/bioconda/packages/hybpiper/overview
- **Validation**: PASS

### Original Help Text
```text
T
                                                        T
                                         C  G
 _    _            _       _____      T        G        A
| |  | |          | |     |  _  \  A              A  A
| |__| | __    __ | |___  | |_| |  _   _____   _____   _____
|  __  | \ \  / / |  _  \ |  ___/ | | |  _  \ |  _  | |  _  \
| |  | |  \ \/ /  | |_| | | |     | | | |_| | |  __/  | |  --
|_|  |_|   \  /   |_____/ |_|     |_| |  ___/ |_____| |_|
           / /                        | |
          /_/                         |_|


usage: hybpiper stats [-h] (--targetfile_dna TARGETFILE_DNA |
                      --targetfile_aa TARGETFILE_AA)
                      [--seq_lengths_filename SEQ_LENGTHS_FILENAME]
                      [--stats_filename STATS_FILENAME]
                      [--hybpiper_dir HYBPIPER_DIR] [--cpu INTEGER]
                      [--gene_read_counts_filename GENE_READ_COUNTS_FILENAME]
                      [--no_heatmap] [--heatmap_filename HEATMAP_FILENAME]
                      [--figure_length INTEGER] [--figure_height INTEGER]
                      [--sample_text_size INTEGER] [--gene_text_size INTEGER]
                      [--heatmap_filetype {png,pdf,eps,tiff,svg}]
                      [--heatmap_dpi INTEGER] [--no_xlabels] [--no_ylabels]
                      [--run_profiler]
                      {gene,GENE,supercontig,SUPERCONTIG} namelist

positional arguments:
  {gene,GENE,supercontig,SUPERCONTIG}
                        Sequence type (gene or supercontig) to recover lengths
                        for.
  namelist              Text file with names of HybPiper output directories,
                        one per line.

options:
  -h, --help            show this help message and exit
  --targetfile_dna, -t_dna TARGETFILE_DNA
                        FASTA file containing DNA target sequences for each
                        gene. The fasta headers must follow the naming
                        convention: >TaxonID-geneName
  --targetfile_aa, -t_aa TARGETFILE_AA
                        FASTA file containing amino-acid target sequences for
                        each gene. The fasta headers must follow the naming
                        convention: >TaxonID-geneName
  --seq_lengths_filename SEQ_LENGTHS_FILENAME
                        File name for the sequence lengths *.tsv file. Default
                        is <seq_lengths.tsv>.
  --stats_filename STATS_FILENAME
                        File name for the stats *.tsv file. Default is:
                        <hybpiper_stats.tsv>
  --hybpiper_dir HYBPIPER_DIR
                        Specify directory containing HybPiper output sample
                        folders. Default is the current working directory.
  --cpu INTEGER         Limit the number of CPUs. Default is to use all cores
                        available minus one.
  --gene_read_counts_filename GENE_READ_COUNTS_FILENAME
                        File name for the gene read counts *.tsv file. Default
                        is: <gene_read_counts.tsv>.
  --no_heatmap          If supplied, do not create a gene read counts heatmap.
                        Default is: False.
  --heatmap_filename HEATMAP_FILENAME
                        Filename for the output heatmap, saved by default as a
                        *.png file. Default is: gene_read_counts_all_heatmap.
  --figure_length INTEGER
                        Length dimension (in inches) for the output heatmap
                        file. Default is automatically calculated based on the
                        number of genes.
  --figure_height INTEGER
                        Height dimension (in inches) for the output heatmap
                        file. Default is automatically calculated based on the
                        number of samples.
  --sample_text_size INTEGER
                        Size (in points) for the sample text labels in the
                        output heatmap file. Default is automatically
                        calculated based on the number of samples.
  --gene_text_size INTEGER
                        Size (in points) for the gene text labels in the
                        output heatmap file. Default is automatically
                        calculated based on the number of genes.
  --heatmap_filetype {png,pdf,eps,tiff,svg}
                        File type to save the output heatmap image as. Default
                        is: png.
  --heatmap_dpi INTEGER
                        Dots per inch (DPI) for the output heatmap image.
                        Default is: 300.
  --no_xlabels          If supplied, do not render labels for x-axis (loci) in
                        the saved heatmap figure. Default is: False.
  --no_ylabels          If supplied, do not render labels for y-axis (samples)
                        in the saved heatmap figure. Default is: False.
  --run_profiler        If supplied, run the subcommand using cProfile. Saves
                        a *.csv file of results
```


## hybpiper_retrieve_sequences

### Tool Description
Type of sequence to extract.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/mossmatters/HybPiper
- **Package**: https://anaconda.org/channels/bioconda/packages/hybpiper/overview
- **Validation**: PASS

### Original Help Text
```text
T
                                                        T
                                         C  G
 _    _            _       _____      T        G        A
| |  | |          | |     |  _  \  A              A  A
| |__| | __    __ | |___  | |_| |  _   _____   _____   _____
|  __  | \ \  / / |  _  \ |  ___/ | | |  _  \ |  _  | |  _  \
| |  | |  \ \/ /  | |_| | | |     | | | |_| | |  __/  | |  --
|_|  |_|   \  /   |_____/ |_|     |_| |  ___/ |_____| |_|
           / /                        | |
          /_/                         |_|


usage: hybpiper retrieve_sequences [-h] (--targetfile_dna TARGETFILE_DNA |
                                   --targetfile_aa TARGETFILE_AA)
                                   (--sample_names SAMPLE_NAMES |
                                   --single_sample_name SINGLE_SAMPLE_NAME)
                                   [--hybpiper_dir HYBPIPER_DIR]
                                   [--fasta_dir FASTA_DIR]
                                   [--skip_chimeric_genes]
                                   [--stats_file STATS_FILE]
                                   [--filter_by column comparison threshold]
                                   [--cpu INTEGER] [--run_profiler]
                                   {dna,aa,intron,supercontig}

positional arguments:
  {dna,aa,intron,supercontig}
                        Type of sequence to extract.

options:
  -h, --help            show this help message and exit
  --targetfile_dna, -t_dna TARGETFILE_DNA
                        FASTA file containing DNA target sequences for each
                        gene. The fasta headers must follow the naming
                        convention: >TaxonID-geneName
  --targetfile_aa, -t_aa TARGETFILE_AA
                        FASTA file containing amino-acid target sequences for
                        each gene. The fasta headers must follow the naming
                        convention: >TaxonID-geneName
  --sample_names SAMPLE_NAMES
                        Text file with names of HybPiper output directories,
                        one per line.
  --single_sample_name SINGLE_SAMPLE_NAME
                        A single sample name to recover sequences for
  --hybpiper_dir HYBPIPER_DIR
                        Specify directory containing HybPiper output sample
                        folders. Default is the current working directory.
  --fasta_dir FASTA_DIR
                        Specify directory for output FASTA files.
  --skip_chimeric_genes
                        Do not recover sequences for putative chimeric genes.
                        This only has an effect for a given sample if the
                        option "--chimeric_stitched_contig_check" was provided
                        to command "hybpiper assemble".
  --stats_file STATS_FILE
                        Stats file produced by "hybpiper stats", required for
                        selective filtering of retrieved sequences.
  --filter_by column comparison threshold
                        Provide three space-separated arguments: 1) column of
                        the stats_file to filter by, 2) "greater" or
                        "smaller", 3) a threshold - either an integer (raw
                        number of genes) or float (percentage of genes in
                        analysis). This parameter can be supplied more than
                        once to filter by multiple criteria.
  --cpu INTEGER         Limit the number of CPUs. Default is to use all cores
                        available minus one.
  --run_profiler        If supplied, run the subcommand using cProfile. Saves
                        a *.csv file of results.
```


## hybpiper_paralog_retriever

### Tool Description
Extracts paralogous genes from HybPiper output.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/mossmatters/HybPiper
- **Package**: https://anaconda.org/channels/bioconda/packages/hybpiper/overview
- **Validation**: PASS

### Original Help Text
```text
T
                                                        T
                                         C  G
 _    _            _       _____      T        G        A
| |  | |          | |     |  _  \  A              A  A
| |__| | __    __ | |___  | |_| |  _   _____   _____   _____
|  __  | \ \  / / |  _  \ |  ___/ | | |  _  \ |  _  | |  _  \
| |  | |  \ \/ /  | |_| | | |     | | | |_| | |  __/  | |  --
|_|  |_|   \  /   |_____/ |_|     |_| |  ___/ |_____| |_|
           / /                        | |
          /_/                         |_|


usage: hybpiper paralog_retriever [-h] (--targetfile_dna TARGETFILE_DNA |
                                  --targetfile_aa TARGETFILE_AA)
                                  [--hybpiper_dir HYBPIPER_DIR]
                                  [--fasta_dir_all FASTA_DIR_ALL]
                                  [--fasta_dir_no_chimeras FASTA_DIR_NO_CHIMERAS]
                                  [--paralog_report_filename PARALOG_REPORT_FILENAME]
                                  [--paralogs_above_threshold_report_filename PARALOGS_ABOVE_THRESHOLD_REPORT_FILENAME]
                                  [--paralogs_list_threshold_percentage FLOAT]
                                  [--no_heatmap]
                                  [--heatmap_filename HEATMAP_FILENAME]
                                  [--figure_length INTEGER]
                                  [--figure_height INTEGER]
                                  [--sample_text_size INTEGER]
                                  [--gene_text_size INTEGER]
                                  [--heatmap_filetype {png,pdf,eps,tiff,svg}]
                                  [--heatmap_dpi INTEGER] [--no_xlabels]
                                  [--no_ylabels] [--cpu INTEGER]
                                  [--run_profiler]
                                  namelist

positional arguments:
  namelist              Text file containing list of HybPiper output
                        directories, one per line.

options:
  -h, --help            show this help message and exit
  --targetfile_dna, -t_dna TARGETFILE_DNA
                        FASTA file containing DNA target sequences for each
                        gene. Used to extract unique gene names for paralog
                        recovery. The fasta headers must follow the naming
                        convention: >TaxonID-geneName
  --targetfile_aa, -t_aa TARGETFILE_AA
                        FASTA file containing amino-acid target sequences for
                        each gene. Used to extract unique gene names for
                        paralog recovery. The fasta headers must follow the
                        naming convention: >TaxonID-geneName
  --hybpiper_dir HYBPIPER_DIR
                        Specify directory containing HybPiper output sample
                        folders. Default is the current working directory.
  --fasta_dir_all FASTA_DIR_ALL
                        Specify directory for output FASTA files (ALL).
                        Default is: paralogs_all.
  --fasta_dir_no_chimeras FASTA_DIR_NO_CHIMERAS
                        Specify directory for output FASTA files (no putative
                        chimeric sequences). Default is: paralogs_no_chimeras.
  --paralog_report_filename PARALOG_REPORT_FILENAME
                        Specify the filename for the paralog *.tsv report
                        table. Default is: paralog_report.
  --paralogs_above_threshold_report_filename PARALOGS_ABOVE_THRESHOLD_REPORT_FILENAME
                        Specify the filename for the *.txt list of genes with
                        paralogs in <paralogs_list_threshold_percentage>
                        number of samples. Default is:
                        paralogs_above_threshold_report.
  --paralogs_list_threshold_percentage FLOAT
                        Percent of total number of samples and genes that must
                        have paralog warnings to be reported in the
                        <genes_with_paralogs.txt> report file. The default is
                        0.0, meaning that all genes and samples with at least
                        one paralog warning will be reported
  --no_heatmap          If supplied, do not create a heatmap figure. Default
                        is: False.
  --heatmap_filename HEATMAP_FILENAME
                        Filename for the output heatmap, saved by default as a
                        *.png file. Default is: paralog_heatmap.
  --figure_length INTEGER
                        Length dimension (in inches) for the output heatmap
                        file. Default is automatically calculated based on the
                        number of genes.
  --figure_height INTEGER
                        Height dimension (in inches) for the output heatmap
                        file. Default is automatically calculated based on the
                        number of samples.
  --sample_text_size INTEGER
                        Size (in points) for the sample text labels in the
                        output heatmap file. Default is automatically
                        calculated based on the number of samples.
  --gene_text_size INTEGER
                        Size (in points) for the gene text labels in the
                        output heatmap file. Default is automatically
                        calculated based on the number of genes.
  --heatmap_filetype {png,pdf,eps,tiff,svg}
                        File type to save the output heatmap image as. Default
                        is: png.
  --heatmap_dpi INTEGER
                        Dots per inch (DPI) for the output heatmap image.
                        Default is: 100.
  --no_xlabels          If supplied, do not render labels for x-axis (loci) in
                        the saved heatmap figure. Default is: False.
  --no_ylabels          If supplied, do not render labels for y-axis (samples)
                        in the saved heatmap figure. Default is: False.
  --cpu INTEGER         Limit the number of CPUs. Default is to use all cores
                        available minus one.
  --run_profiler        If supplied, run the subcommand using cProfile. Saves
                        a *.csv file of results. Default is: False.
```


## hybpiper_recovery_heatmap

### Tool Description
Generates a heatmap of recovery based on sequence lengths.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/mossmatters/HybPiper
- **Package**: https://anaconda.org/channels/bioconda/packages/hybpiper/overview
- **Validation**: PASS

### Original Help Text
```text
T
                                                        T
                                         C  G
 _    _            _       _____      T        G        A
| |  | |          | |     |  _  \  A              A  A
| |__| | __    __ | |___  | |_| |  _   _____   _____   _____
|  __  | \ \  / / |  _  \ |  ___/ | | |  _  \ |  _  | |  _  \
| |  | |  \ \/ /  | |_| | | |     | | | |_| | |  __/  | |  --
|_|  |_|   \  /   |_____/ |_|     |_| |  ___/ |_____| |_|
           / /                        | |
          /_/                         |_|


usage: hybpiper recovery_heatmap [-h] [--heatmap_filename HEATMAP_FILENAME]
                                 [--figure_length INTEGER]
                                 [--figure_height INTEGER]
                                 [--sample_text_size INTEGER]
                                 [--gene_text_size INTEGER]
                                 [--heatmap_filetype {png,pdf,eps,tiff,svg}]
                                 [--heatmap_dpi INTEGER] [--no_xlabels]
                                 [--no_ylabels] [--run_profiler]
                                 seq_lengths_file

positional arguments:
  seq_lengths_file      Filename for the seq_lengths file (output of the
                        'hybpiper stats' command)

options:
  -h, --help            show this help message and exit
  --heatmap_filename HEATMAP_FILENAME
                        Filename for the output heatmap, saved by default as a
                        *.png file. Defaults to "recovery_heatmap"
  --figure_length INTEGER
                        Length dimension (in inches) for the output heatmap
                        file. Default is automatically calculated based on the
                        number of genes
  --figure_height INTEGER
                        Height dimension (in inches) for the output heatmap
                        file. Default is automatically calculated based on the
                        number of samples
  --sample_text_size INTEGER
                        Size (in points) for the sample text labels in the
                        output heatmap file. Default is automatically
                        calculated based on the number of samples
  --gene_text_size INTEGER
                        Size (in points) for the gene text labels in the
                        output heatmap file. Default is automatically
                        calculated based on the number of genes
  --heatmap_filetype {png,pdf,eps,tiff,svg}
                        File type to save the output heatmap image as. Default
                        is *.png
  --heatmap_dpi INTEGER
                        Dot per inch (DPI) for the output heatmap image.
                        Default is 100
  --no_xlabels          If supplied, do not render labels for x-axis (loci) in
                        the saved heatmap figure
  --no_ylabels          If supplied, do not render labels for y-axis (samples)
                        in the saved heatmap figure
  --run_profiler        If supplied, run the subcommand using cProfile. Saves
                        a *.csv file of results
```


## hybpiper_check_dependencies

### Tool Description
Checks for external dependencies required by HybPiper.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/mossmatters/HybPiper
- **Package**: https://anaconda.org/channels/bioconda/packages/hybpiper/overview
- **Validation**: PASS

### Original Help Text
```text
T
                                                        T
                                         C  G
 _    _            _       _____      T        G        A
| |  | |          | |     |  _  \  A              A  A
| |__| | __    __ | |___  | |_| |  _   _____   _____   _____
|  __  | \ \  / / |  _  \ |  ___/ | | |  _  \ |  _  | |  _  \
| |  | |  \ \/ /  | |_| | | |     | | | |_| | |  __/  | |  --
|_|  |_|   \  /   |_____/ |_|     |_| |  ___/ |_____| |_|
           / /                        | |
          /_/                         |_|


[INFO]:    Checking for external dependencies:

blastx               found at /usr/local/bin/blastx
exonerate            found at /usr/local/bin/exonerate
parallel             found at /usr/local/bin/parallel
makeblastdb          found at /usr/local/bin/makeblastdb
spades.py            found at /usr/local/bin/spades.py
bwa                  found at /usr/local/bin/bwa
samtools             found at /usr/local/bin/samtools
bbmap.sh             found at /usr/local/bin/bbmap.sh
bbmerge.sh           found at /usr/local/bin/bbmerge.sh
diamond              found at /usr/local/bin/diamond
mafft                found at /usr/local/bin/mafft
```


## hybpiper_check_targetfile

### Tool Description
Check target files for issues such as stop codons and low complexity regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/mossmatters/HybPiper
- **Package**: https://anaconda.org/channels/bioconda/packages/hybpiper/overview
- **Validation**: PASS

### Original Help Text
```text
T
                                                        T
                                         C  G
 _    _            _       _____      T        G        A
| |  | |          | |     |  _  \  A              A  A
| |__| | __    __ | |___  | |_| |  _   _____   _____   _____
|  __  | \ \  / / |  _  \ |  ___/ | | |  _  \ |  _  | |  _  \
| |  | |  \ \/ /  | |_| | | |     | | | |_| | |  __/  | |  --
|_|  |_|   \  /   |_____/ |_|     |_| |  ___/ |_____| |_|
           / /                        | |
          /_/                         |_|


usage: hybpiper check_targetfile [-h] (--targetfile_dna TARGETFILE_DNA |
                                 --targetfile_aa TARGETFILE_AA)
                                 [--no_terminal_stop_codons]
                                 [--sliding_window_size INTEGER]
                                 [--complexity_minimum_threshold COMPLEXITY_MINIMUM_THRESHOLD]
                                 [--run_profiler]

options:
  -h, --help            show this help message and exit
  --targetfile_dna, -t_dna TARGETFILE_DNA
                        FASTA file containing DNA target sequences for each
                        gene. The fasta headers must follow the naming
                        convention: >TaxonID-geneName
  --targetfile_aa, -t_aa TARGETFILE_AA
                        FASTA file containing amino-acid target sequences for
                        each gene. The fasta headers must follow the naming
                        convention: >TaxonID-geneName
  --no_terminal_stop_codons
                        When testing for open reading frames, do not allow a
                        translated frame to have a single stop codon at the
                        C-terminus of the translated protein sequence. Default
                        is False.
  --sliding_window_size INTEGER
                        Number of characters (single-letter DNA or amino-acid
                        codes) to include in the sliding window when checking
                        for sequences with low-complexity-regions.
  --complexity_minimum_threshold COMPLEXITY_MINIMUM_THRESHOLD
                        Minimum threshold value. Beneath this value, the
                        sequence in the sliding window is flagged as low
                        complexity, and the corresponding target file sequence
                        is reported as having low-complexity regions.
  --run_profiler        If supplied, run the subcommand using cProfile. Saves
                        a *.csv file of results
```


## hybpiper_fix_targetfile

### Tool Description
Fixes DNA and amino-acid target files by testing for open reading frames, removing stop codons, and filtering sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/mossmatters/HybPiper
- **Package**: https://anaconda.org/channels/bioconda/packages/hybpiper/overview
- **Validation**: PASS

### Original Help Text
```text
T
                                                        T
                                         C  G
 _    _            _       _____      T        G        A
| |  | |          | |     |  _  \  A              A  A
| |__| | __    __ | |___  | |_| |  _   _____   _____   _____
|  __  | \ \  / / |  _  \ |  ___/ | | |  _  \ |  _  | |  _  \
| |  | |  \ \/ /  | |_| | | |     | | | |_| | |  __/  | |  --
|_|  |_|   \  /   |_____/ |_|     |_| |  ___/ |_____| |_|
           / /                        | |
          /_/                         |_|


usage: hybpiper fix_targetfile [-h] (--targetfile_dna TARGETFILE_DNA |
                               --targetfile_aa TARGETFILE_AA)
                               [--no_terminal_stop_codons]
                               [--allow_gene_removal]
                               [--reference_protein_file REFERENCE_PROTEIN_FILE]
                               [--maximum_distance FLOAT]
                               [--filter_by_length_percentage FLOAT]
                               [--keep_low_complexity_sequences]
                               [--alignments]
                               [--concurrent_alignments INTEGER]
                               [--threads_per_concurrent_alignment INTEGER]
                               [--write_all_fasta_files] [--verbose_logging]
                               [--run_profiler]
                               control_file

positional arguments:
  control_file          The *.ctl file, as output by the command "hybpiper
                        check_targetfile".

options:
  -h, --help            show this help message and exit
  --targetfile_dna, -t_dna TARGETFILE_DNA
                        FASTA file containing DNA target sequences for each
                        gene. The fasta headers must follow the naming
                        convention: >TaxonID-geneName
  --targetfile_aa, -t_aa TARGETFILE_AA
                        FASTA file containing amino-acid target sequences for
                        each gene. The fasta headers must follow the naming
                        convention: >TaxonID-geneName
  --no_terminal_stop_codons
                        When testing for open reading frames, do not allow a
                        translated frame to have a single stop codon at the
                        C-terminus of the translated protein sequence. Default
                        is False. If supplied, this parameter will override
                        the setting in the *.ctl file.
  --allow_gene_removal  Allow frame-correction and filtering steps to remove
                        all representative sequences for a given gene. Default
                        is False; HybPiper will exit with an information
                        message instead. If supplied, this parameter will
                        override the setting in the *.ctl file.
  --reference_protein_file REFERENCE_PROTEIN_FILE
                        If a given DNA sequence can be translated in more than
                        one forward frame without stop codons, choose the
                        translation that best matches the corresponding
                        reference protein provided in this fasta file. The
                        fasta headers must follow the naming convention:
                        >TaxonID-geneName
  --maximum_distance FLOAT
                        When comparing candidate DNA translation frames to a
                        reference protein, the maximum distance allowed
                        between the translated frame and the reference
                        sequence for any candidate translation frame to be
                        selected. Useful to filter out sequences with
                        frameshifts that do NOT introduce stop codons. 0.0
                        means identical sequences, 1.0 means completely
                        different sequences. Default is 0.5
  --filter_by_length_percentage FLOAT
                        If more than one representative sequence is present
                        for a given gene, filter out sequences shorter than
                        this percentage of the longest gene sequence length.
                        Default is 0.0 (all sequences retained).
  --keep_low_complexity_sequences
                        Keep sequences that contain regions of low complexity,
                        as identified by the command "hybpiper
                        check_targetfile". Default is to remove these
                        sequences.
  --alignments          Create per-gene alignments from the final
                        fixed/filtered target file sequences. Note that DNA
                        sequences will be translated prior to alignment.
  --concurrent_alignments INTEGER
                        Number of alignments to run concurrently. Default is
                        1.
  --threads_per_concurrent_alignment INTEGER
                        Number of threads to run each concurrent alignment
                        with. Default is 1.
  --write_all_fasta_files
                        If provided, *.fasta files will be written for
                        sequences removed from the fixed/filtered target file,
                        according to filtering categories (length threshold,
                        low-complexity regions, etc.). By default, these files
                        will not be written.
  --verbose_logging     If supplied, enable verbose logging. NOTE: this will
                        increase the size of the log files.
  --run_profiler        If supplied, run the subcommand using cProfile. Saves
                        a *.csv file of results
```


## hybpiper_filter_by_length

### Tool Description
Filters sequences based on length criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/mossmatters/HybPiper
- **Package**: https://anaconda.org/channels/bioconda/packages/hybpiper/overview
- **Validation**: PASS

### Original Help Text
```text
T
                                                        T
                                         C  G
 _    _            _       _____      T        G        A
| |  | |          | |     |  _  \  A              A  A
| |__| | __    __ | |___  | |_| |  _   _____   _____   _____
|  __  | \ \  / / |  _  \ |  ___/ | | |  _  \ |  _  | |  _  \
| |  | |  \ \/ /  | |_| | | |     | | | |_| | |  __/  | |  --
|_|  |_|   \  /   |_____/ |_|     |_| |  ___/ |_____| |_|
           / /                        | |
          /_/                         |_|


usage: hybpiper filter_by_length [-h] (--denylist DENYLIST |
                                 --seq_lengths_file SEQ_LENGTHS_FILE)
                                 [--denylist_filename DENYLIST_FILENAME]
                                 [--length_filter INTEGER]
                                 [--percent_filter FLOAT]
                                 [--sequence_dir SEQUENCE_DIR]
                                 [--filtered_dir FILTERED_DIR]
                                 [--run_profiler]
                                 {dna,aa,supercontig,intron}

positional arguments:
  {dna,aa,supercontig,intron}
                        File sequence type for all FASTA files to filter in
                        current directory. For example, the amino-acid output
                        of HybPiper would be: aa

options:
  -h, --help            show this help message and exit
  --denylist DENYLIST   Text file containing gene-sample combinations to omit.
                        The format of the file should be one gene per line, a
                        tab, and then a comma-delimited list of samples to
                        disallow: gene[tab]sample1,sample2,sample3
  --seq_lengths_file SEQ_LENGTHS_FILE
                        Filename for the seq_lengths file (output of the
                        "hybpiper stats" command), with a list of genes in the
                        first row, mean target lengths in the second row, and
                        sample recovery in other rows.
  --denylist_filename DENYLIST_FILENAME
                        File name for the "deny list" text file (if written).
                        Default is <denylist.txt>
  --length_filter INTEGER
                        Minimum length to allow a sequence in nucleotides for
                        DNA or amino acids for protein sequences
  --percent_filter FLOAT
                        Minimum fraction (between 0 and 1) of the mean target
                        length to allow a sequence for a gene. Lengths taken
                        from HybPiper stats file.
  --sequence_dir SEQUENCE_DIR
                        Specify directory containing sequences output by the
                        "hybpiper retrieve_sequences" command. Default is to
                        search in the current working directory
  --filtered_dir FILTERED_DIR
                        Specify directory for output filtered FASTA files.
                        Default is to write to the current working directory
  --run_profiler        If supplied, run the subcommand using cProfile. Saves
                        a *.csv file of results
```


## Metadata
- **Skill**: generated

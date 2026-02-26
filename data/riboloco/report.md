# riboloco CWL Generation Report

## riboloco

### Tool Description
riboloco is a tool for analyzing ribosome profiling data to identify translation initiation sites and quantify ribosome occupancy.

### Metadata
- **Docker Image**: quay.io/biocontainers/riboloco:0.3.10--pyhdfd78af_0
- **Homepage**: https://github.com/Delayed-Gitification/riboloco.git
- **Package**: https://anaconda.org/channels/bioconda/packages/riboloco/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/riboloco/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-06-03
- **GitHub**: https://github.com/Delayed-Gitification/riboloco
- **Stars**: N/A
### Original Help Text
```text
usage: riboloco [-h] [-s SAMPLES] [-i INFO] [-f TRANSCRIPT_FASTA] -o OUTPUT
                [--orf_file ORF_FILE] [-a MIN_ABUNDANCE]
                [-ar MIN_ABUNDANCE_REF] [-t READ_TYPE [READ_TYPE ...]] [-pg]
                [-ms MIN_SCORE] [-g] [-r REFERENCE] [--allow_out_of_frame]
                [-ct CONVERSION_TYPES_LIST [CONVERSION_TYPES_LIST ...]] [-k]
                [-rkl] [-ukl] [-p PERIODICITY] [-kll KL_LENGTH] [-us]
                [-minao MIN_A_OFFSET] [-maxao MAX_A_OFFSET] [-mino MIN_OFFSET]
                [-maxo MAX_OFFSET] [-ig IGNORE] [-wif] [-krd] [-ss]
                [--min_counts_start MIN_COUNTS_START]
                [--min_ratio_start MIN_RATIO_START]
                [--min_counts_stop MIN_COUNTS_STOP]
                [--min_ratio_stop MIN_RATIO_STOP]
                [--max_distance MAX_DISTANCE]
                [--frameness_ratio FRAMENESS_RATIO] [-mm]
                [--ambiguity AMBIGUITY] [--oof_plot_start OOF_PLOT_START]
                [--oof_plot_end OOF_PLOT_END]
                [--oof_plot_stride OOF_PLOT_STRIDE] [-nii] [--verbose]
                [--oof_smooth_window OOF_SMOOTH_WINDOW] [-sd SAMPLE_DIR]
                [-d OUTPUT_DIRECTORY] [-m] [-fcb] [--write_full_data]

options:
  -h, --help            show this help message and exit
  -s SAMPLES, --samples SAMPLES
                        In reference generation mode this may either be a .csv
                        file of samples (you MUST ensure that the file is of
                        '.csv' otherwise it will not be recognised) or a
                        single bed file. In conversion mode it must be a
                        single bed file. Bed files should be transcriptome-
                        aligned; only reads in the + strand are used. Bed
                        files should be 6 column, with transcript_id, start,
                        end, and strand in columns 1, 2, 3 and 6 respectively
                        (the default output from bedtools' 'bamtobed'). Bed
                        files can be in .gzip format if desired.
  -i INFO, --info INFO  Info file on transcripts. This should be a tab
                        separated file with details on the CDS within each
                        transcript. It should contain the columns
                        'transcript_id', 'cds_start' and 'cds_stop'. The
                        coordinates MUST be 1-based!
  -f TRANSCRIPT_FASTA, --transcript_fasta TRANSCRIPT_FASTA
                        Fasta file of transcripts
  -o OUTPUT, --output OUTPUT
                        Output file
  --orf_file ORF_FILE   An orf csv generated with riboloco_find_orfs.
                        Supplying this will activate more intensive searching
                        for out of frame ribosomes.
  -a MIN_ABUNDANCE, --min_abundance MIN_ABUNDANCE
                        Minimum abundance of read length/frame to be included
                        in final output. Default is 0.01. Set to zero to
                        disable. This can me lower than --min_abundance_ref,
                        the rationale being that you want to use abundant read
                        lengths to build the reference, but any read length
                        that matches the reference well should be included in
                        the final file.
  -ar MIN_ABUNDANCE_REF, --min_abundance_ref MIN_ABUNDANCE_REF
                        Minimum fraction of total reads that a read type must
                        represent for calculation of a reference offset (using
                        start and stop codon enrichment) to be attempted.
                        Default=0.1 (10pc). Warning - using low values may
                        promote inclusion of reads which are primarily out of
                        frame. Recommended to keep above 0.05. Read fractions
                        are calculated for reads within the annotated CDS -
                        UTRs are ignored.
  -t READ_TYPE [READ_TYPE ...], --read_type READ_TYPE [READ_TYPE ...]
                        Set the read type for which the reference is
                        calculated in reference generation mode.Additionally,
                        you can specify the offset with a colon, eg 28_0:-12.
  -pg, --plot_graphs    When selected, dislocate plots various graphs and
                        heatmaps which may be useful for downstream analysis,
                        or to verify accuracy of offset assignments.
  -ms MIN_SCORE, --min_score MIN_SCORE
                        The minimum correlation between the reference and the
                        RUST ratios for the assigned offset for the file to be
                        written. Default = 0.7
  -g, --generate_reference
                        Activates reference generation mode - use this mode to
                        make a reference before converting bed files to single
                        nucleotide resolution
  -r REFERENCE, --reference REFERENCE
                        Pre-computed reference file csv, generated by
                        dislocate in 'generate reference' mode. Multiple
                        references can be specified by adding a colon between
                        files. Optional when running in conversion mode.
  --allow_out_of_frame  Allow out of frame offsets to be assigned
  -ct CONVERSION_TYPES_LIST [CONVERSION_TYPES_LIST ...], --conversion_types_list CONVERSION_TYPES_LIST [CONVERSION_TYPES_LIST ...]
                        Types to output. Can specify an offset with colon, eg
                        28_0:-12. Using this command will cause other types to
                        be ignored, unless you also use --keep_all_valid
  -k, --keep_all_valid  This option (only applicable during conversion mode)
                        keeps all valid read types (i.e. all those that pass
                        periodicity and abundance filters) even when specific
                        read lengths and offsets are set.
  -rkl, --reference_use_KL
                        Use KL divergence to find best offset during reference
                        generation
  -ukl, --use_KL        Use KL divergence to determine best A site offset
                        during assignment
  -p PERIODICITY, --periodicity PERIODICITY
                        Periodicity filter - the minimum ratio of reads in the
                        major frame to the minor frame for a given read length
                        to pass filtering. Default is 2; higher numbers are
                        more stringent. Set to 1 to remove filtering
  -kll KL_LENGTH, --kl_length KL_LENGTH
                        The number of codons to use for KL-based determination
                        of offsets. By default = 2 i.e. the P and A sites.
  -us, --use_stop       If argument is used, riboloco will attempt to assign
                        offsets based on stop codon as well as the start
                        codon. Riboloco will use this value during reference
                        generation if either it is consistent with the start
                        codon determined offset, or if no start codon-based
                        offset could be determined (e.g. with disomes)
  -minao MIN_A_OFFSET, --min_A_offset MIN_A_OFFSET
                        The miniumum offset length from the 3' end of the E
                        site. (Not the A site) Length is measured in nt.
                        Default = 3
  -maxao MAX_A_OFFSET, --max_A_offset MAX_A_OFFSET
                        The maximum offset length from the 3' end of the E
                        site (not the A site). Length is measured in nt.
                        Default = -22
  -mino MIN_OFFSET, --min_offset MIN_OFFSET
                        The miniumum which is analysed when plotting Length is
                        measured in nt. Default = 10
  -maxo MAX_OFFSET, --max_offset MAX_OFFSET
                        The maximum offset which is analysed when plotting.
                        Length is measured in nt. Default = -40
  -ig IGNORE, --ignore IGNORE
                        Read types to ignore. Can add multiple with a colon
                        separator. Eg -ig 27_2:23_1.
  -wif, --write_individual_files
                        When selected, dislocate also writes individual
                        bedgraph files for each read length/frame. This could
                        be useful for downstream analysis.
  -krd, --keep_read_types_distinct
                        Write out a single bedgraph, but keep the read types
                        distinct (useful for downstreamanalysis). Default =
                        False
  -ss, --save_stats     Save a csv of the r values for each type, read and
                        offset.
  --min_counts_start MIN_COUNTS_START
                        The minimum number of counts of a given read type at
                        the start codon for a read's offset to be confidently
                        assigned. Default=25
  --min_ratio_start MIN_RATIO_START
                        The minimum ratio of the start codon counts of a given
                        read type versus the previous position for an offset
                        based on the start codon to be confidently assigned.
                        Default=4
  --min_counts_stop MIN_COUNTS_STOP
                        The minimum number of counts of a given read type at
                        the stop codon for a read's offset to be confidently
                        assigned. Default=25. To block stop offsets being
                        used, set to large number eg 100000
  --min_ratio_stop MIN_RATIO_STOP
                        The minimum ratio of the stop codon counts of a given
                        read type versus the next position for an offset based
                        on the stop codon to be confidently assigned.
                        Default=4
  --max_distance MAX_DISTANCE
                        Maximum distance in nucleotides around start and stop
                        codons for which offsets are attempted to be
                        calculated. Default is 20. Twenty is plenty.
  --frameness_ratio FRAMENESS_RATIO
                        The level of enrichment near the start codon versus
                        downstream for a read type to be reported as
                        potentially having strong bias towards out of frame
                        ribosomes. Default = 1.2 i.e. 20percent
  -mm, --mismatches     Whether to consider first nt mismatches. Only
                        available when a bam file is provided
  --ambiguity AMBIGUITY
                        Much much better the best r value must be compared to
                        the second best for an offset to be confidently
                        assigned. Default = 0.8, i.e. the r value of second
                        best offset must be less than 0.8x the value of the
                        best offset. Lower values are more stringent. Should
                        be less than 1, and more than 0
  --oof_plot_start OOF_PLOT_START
                        How far downstream of the annotated start to look for
                        out of frame reads. Default=0. Set to negative values
                        to search for uORFs
  --oof_plot_end OOF_PLOT_END
                        How far downstream of the annotated start to look for
                        out of frame reads. Default=2000.
  --oof_plot_stride OOF_PLOT_STRIDE
                        How wide each of the windows in the oof heatmap should
                        be in nucleotides. Default=50nt
  -nii, --no_iterative_improvement
                        By default, when using RUST ratio correlations to
                        determine offsets, when new matches are found they are
                        added to the reference. This option stops this
                        behaviour
  --verbose
  --oof_smooth_window OOF_SMOOTH_WINDOW
                        Rolling average smoothing for oof heatmap
  -sd SAMPLE_DIR, --sample_dir SAMPLE_DIR
                        Directory of the input files. This optional argument
                        can be useful when passing a csv of filenames to -s in
                        reference generation mode.
  -d OUTPUT_DIRECTORY, --output_directory OUTPUT_DIRECTORY
                        The directory to save outputs.
  -m, --monosome_priority
                        During reference generation mode, and if a .csv of
                        sample files is passed to the function, this option
                        ensures that only monosome files, i.e. those with
                        'Mon' in the sample name(!), are used for reference
                        generation.
  -fcb, --four_column_bed
                        select if using a four column bed with the strand in
                        the 4th column
  --write_full_data     Write out the raw bed/bam file reads with read type
                        and info
```


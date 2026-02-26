# hafez CWL Generation Report

## hafez_hafeZ.py

### Tool Description
Identify inducible prophages through bacterial genomic read mapping. Minimum required input outlined above.

### Metadata
- **Docker Image**: quay.io/biocontainers/hafez:1.0.4--pyh7cba7a3_0
- **Homepage**: https://github.com/Chrisjrt/hafeZ
- **Package**: https://anaconda.org/channels/bioconda/packages/hafez/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hafez/overview
- **Total Downloads**: 5.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Chrisjrt/hafeZ
- **Stars**: N/A
### Original Help Text
```text
Running hafeZ version 1.0.4 with the following settings:
hafeZ.py -f None -r1 None -r2 None -o None -D None -c 3.5 -b 3001 -w 4000 -m 6 -t 1 -p 0.1 -z 3.5
usage:  setup:  hafeZ.py -G db_path
	run: hafeZ.py -f assembly.fasta -r1 reads.fastq.gz -r2 reads.fastq.gz -o output_folder -D db_folder

Identify inducible prophages through bacterial genomic read mapping. Minimum
required input outlined above.

required arguments for initial setup:
  -G [path], --get_db [path]
                        use this option to get and format pVOGs database in
                        the given directory
  -T [db], --db_type [db]
                        choose which database you want to download, currently
                        available ones are pVOGs or PHROGs

required arguments for running hafeZ:
  -f [path], --fasta [path]
                        path to genome assembly in fasta format
  -r1 [path], --reads1 [path]
                        path to read set in fastq/fastq.gz format.
  -r2 [path], --reads2 [path]
                        path to second read set in fastq/fastq.gz format
  -o [path], --output_folder [path]
                        desired output folder path
  -D [path], --db_path [path]
                        path to the directory containing the pVOGs files

optional arguments:
  -b [int], --bin_size [int]
                        set bin size in bp to use for coverage depth
                        smoothing. Must be an odd number. (default = 3001)
  -c [float], --cutoff [float]
                        set Z-score cutoff for initially detecting rois
                        (default = 3.5)
  -w [int], --width [int]
                        set minimum width (bp) of roi that passes Z-score
                        cutoff for initially detecting rois. (default = 4000)
  -m [int], --min_orfs [int]
                        set minimum number of ORFs needed in an roi (default =
                        6)
  -p [float], --pvog_fract [float]
                        set minimum fraction of ORFs in an roi showing
                        homology to pVOGs (default = 0.1)
  -z [float], --median_z_cutoff [float]
                        set minimum median Z-score for an roi to be retained
                        (default = 3.5)
  -k [int], --keep_threshold [int]
                        set threshold for number of best soft clip
                        combinations to keep for each roi (default=50)
  -S, --sub_sample      Randomly sub-sample reads to adjust overall mapping
                        coverage of genome. N.B. Use -C/--coverage to adjust
                        coverage desired
  -C [float], --coverage [float]
                        set desired coverage of genome to be used for
                        subsampling reads (default = 100.0). N.B. Must be used
                        with -S\--sub_sample flag
  -N, --no_extra        use to turn off extra accuracy checks using clipped
                        sequences, might give same results, might give extra
                        rois
  -t [int], --threads [int]
                        set number of threads to use (default = 1)
  -M [limit], --memory_limit [limit]
                        set upper bound per thread memory limit for samtools,
                        suffix K/M/G recognized (default = 768M)
  -O, --overwrite       force overwrite of ouput folder if already exists
  -Z, --all_Zscores     make graphs of all contig Z-scores even if no roi
                        found (useful for manual inspection). N.B. This will
                        make graphs for each contig, so if you have 100
                        contigs you will get 100 graphs.
  -e, --expect_mad_zero
                        allow MAD == 0 to exit without non-zero exit code.
                        Will also cause coverage plots for each contig to be
                        output to help with debugging. Useful for uninduced
                        lysates.
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
hafeZ: error: either --get_db or --db_path options must be used and should contain a path
```


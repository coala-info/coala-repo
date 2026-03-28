# metagem CWL Generation Report

## metagem_fastp

### Tool Description
an ultra-fast all-in-one FASTQ preprocessor

### Metadata
- **Docker Image**: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
- **Homepage**: https://github.com/franciscozorrilla/metaGEM
- **Package**: https://anaconda.org/channels/bioconda/packages/metagem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metagem/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/franciscozorrilla/metaGEM
- **Stars**: N/A
### Original Help Text
```text
fastp: an ultra-fast all-in-one FASTQ preprocessor
version 0.23.2
usage: fastp [options] ... 
options:
  -i, --in1                            read1 input file name (string [=])
  -o, --out1                           read1 output file name (string [=])
  -I, --in2                            read2 input file name (string [=])
  -O, --out2                           read2 output file name (string [=])
      --unpaired1                      for PE input, if read1 passed QC but read2 not, it will be written to unpaired1. Default is to discard it. (string [=])
      --unpaired2                      for PE input, if read2 passed QC but read1 not, it will be written to unpaired2. If --unpaired2 is same as --unpaired1 (default mode), both unpaired reads will be written to this same file. (string [=])
      --overlapped_out                 for each read pair, output the overlapped region if it has no any mismatched base. (string [=])
      --failed_out                     specify the file to store reads that cannot pass the filters. (string [=])
  -m, --merge                          for paired-end input, merge each pair of reads into a single read if they are overlapped. The merged reads will be written to the file given by --merged_out, the unmerged reads will be written to the files specified by --out1 and --out2. The merging mode is disabled by default.
      --merged_out                     in the merging mode, specify the file name to store merged output, or specify --stdout to stream the merged output (string [=])
      --include_unmerged               in the merging mode, write the unmerged or unpaired reads to the file specified by --merge. Disabled by default.
  -6, --phred64                        indicate the input is using phred64 scoring (it'll be converted to phred33, so the output will still be phred33)
  -z, --compression                    compression level for gzip output (1 ~ 9). 1 is fastest, 9 is smallest, default is 4. (int [=4])
      --stdin                          input from STDIN. If the STDIN is interleaved paired-end FASTQ, please also add --interleaved_in.
      --stdout                         stream passing-filters reads to STDOUT. This option will result in interleaved FASTQ output for paired-end output. Disabled by default.
      --interleaved_in                 indicate that <in1> is an interleaved FASTQ which contains both read1 and read2. Disabled by default.
      --reads_to_process               specify how many reads/pairs to be processed. Default 0 means process all reads. (int [=0])
      --dont_overwrite                 don't overwrite existing files. Overwritting is allowed by default.
      --fix_mgi_id                     the MGI FASTQ ID format is not compatible with many BAM operation tools, enable this option to fix it.
  -V, --verbose                        output verbose log information (i.e. when every 1M reads are processed).
  -A, --disable_adapter_trimming       adapter trimming is enabled by default. If this option is specified, adapter trimming is disabled
  -a, --adapter_sequence               the adapter for read1. For SE data, if not specified, the adapter will be auto-detected. For PE data, this is used if R1/R2 are found not overlapped. (string [=auto])
      --adapter_sequence_r2            the adapter for read2 (PE data only). This is used if R1/R2 are found not overlapped. If not specified, it will be the same as <adapter_sequence> (string [=auto])
      --adapter_fasta                  specify a FASTA file to trim both read1 and read2 (if PE) by all the sequences in this FASTA file (string [=])
      --detect_adapter_for_pe          by default, the auto-detection for adapter is for SE data input only, turn on this option to enable it for PE data.
  -f, --trim_front1                    trimming how many bases in front for read1, default is 0 (int [=0])
  -t, --trim_tail1                     trimming how many bases in tail for read1, default is 0 (int [=0])
  -b, --max_len1                       if read1 is longer than max_len1, then trim read1 at its tail to make it as long as max_len1. Default 0 means no limitation (int [=0])
  -F, --trim_front2                    trimming how many bases in front for read2. If it's not specified, it will follow read1's settings (int [=0])
  -T, --trim_tail2                     trimming how many bases in tail for read2. If it's not specified, it will follow read1's settings (int [=0])
  -B, --max_len2                       if read2 is longer than max_len2, then trim read2 at its tail to make it as long as max_len2. Default 0 means no limitation. If it's not specified, it will follow read1's settings (int [=0])
  -D, --dedup                          enable deduplication to drop the duplicated reads/pairs
      --dup_calc_accuracy              accuracy level to calculate duplication (1~6), higher level uses more memory (1G, 2G, 4G, 8G, 16G, 24G). Default 1 for no-dedup mode, and 3 for dedup mode. (int [=0])
      --dont_eval_duplication          don't evaluate duplication rate to save time and use less memory.
  -g, --trim_poly_g                    force polyG tail trimming, by default trimming is automatically enabled for Illumina NextSeq/NovaSeq data
      --poly_g_min_len                 the minimum length to detect polyG in the read tail. 10 by default. (int [=10])
  -G, --disable_trim_poly_g            disable polyG tail trimming, by default trimming is automatically enabled for Illumina NextSeq/NovaSeq data
  -x, --trim_poly_x                    enable polyX trimming in 3' ends.
      --poly_x_min_len                 the minimum length to detect polyX in the read tail. 10 by default. (int [=10])
  -5, --cut_front                      move a sliding window from front (5') to tail, drop the bases in the window if its mean quality < threshold, stop otherwise.
  -3, --cut_tail                       move a sliding window from tail (3') to front, drop the bases in the window if its mean quality < threshold, stop otherwise.
  -r, --cut_right                      move a sliding window from front to tail, if meet one window with mean quality < threshold, drop the bases in the window and the right part, and then stop.
  -W, --cut_window_size                the window size option shared by cut_front, cut_tail or cut_sliding. Range: 1~1000, default: 4 (int [=4])
  -M, --cut_mean_quality               the mean quality requirement option shared by cut_front, cut_tail or cut_sliding. Range: 1~36 default: 20 (Q20) (int [=20])
      --cut_front_window_size          the window size option of cut_front, default to cut_window_size if not specified (int [=4])
      --cut_front_mean_quality         the mean quality requirement option for cut_front, default to cut_mean_quality if not specified (int [=20])
      --cut_tail_window_size           the window size option of cut_tail, default to cut_window_size if not specified (int [=4])
      --cut_tail_mean_quality          the mean quality requirement option for cut_tail, default to cut_mean_quality if not specified (int [=20])
      --cut_right_window_size          the window size option of cut_right, default to cut_window_size if not specified (int [=4])
      --cut_right_mean_quality         the mean quality requirement option for cut_right, default to cut_mean_quality if not specified (int [=20])
  -Q, --disable_quality_filtering      quality filtering is enabled by default. If this option is specified, quality filtering is disabled
  -q, --qualified_quality_phred        the quality value that a base is qualified. Default 15 means phred quality >=Q15 is qualified. (int [=15])
  -u, --unqualified_percent_limit      how many percents of bases are allowed to be unqualified (0~100). Default 40 means 40% (int [=40])
  -n, --n_base_limit                   if one read's number of N base is >n_base_limit, then this read/pair is discarded. Default is 5 (int [=5])
  -e, --average_qual                   if one read's average quality score <avg_qual, then this read/pair is discarded. Default 0 means no requirement (int [=0])
  -L, --disable_length_filtering       length filtering is enabled by default. If this option is specified, length filtering is disabled
  -l, --length_required                reads shorter than length_required will be discarded, default is 15. (int [=15])
      --length_limit                   reads longer than length_limit will be discarded, default 0 means no limitation. (int [=0])
  -y, --low_complexity_filter          enable low complexity filter. The complexity is defined as the percentage of base that is different from its next base (base[i] != base[i+1]).
  -Y, --complexity_threshold           the threshold for low complexity filter (0~100). Default is 30, which means 30% complexity is required. (int [=30])
      --filter_by_index1               specify a file contains a list of barcodes of index1 to be filtered out, one barcode per line (string [=])
      --filter_by_index2               specify a file contains a list of barcodes of index2 to be filtered out, one barcode per line (string [=])
      --filter_by_index_threshold      the allowed difference of index barcode for index filtering, default 0 means completely identical. (int [=0])
  -c, --correction                     enable base correction in overlapped regions (only for PE data), default is disabled
      --overlap_len_require            the minimum length to detect overlapped region of PE reads. This will affect overlap analysis based PE merge, adapter trimming and correction. 30 by default. (int [=30])
      --overlap_diff_limit             the maximum number of mismatched bases to detect overlapped region of PE reads. This will affect overlap analysis based PE merge, adapter trimming and correction. 5 by default. (int [=5])
      --overlap_diff_percent_limit     the maximum percentage of mismatched bases to detect overlapped region of PE reads. This will affect overlap analysis based PE merge, adapter trimming and correction. Default 20 means 20%. (int [=20])
  -U, --umi                            enable unique molecular identifier (UMI) preprocessing
      --umi_loc                        specify the location of UMI, can be (index1/index2/read1/read2/per_index/per_read, default is none (string [=])
      --umi_len                        if the UMI is in read1/read2, its length should be provided (int [=0])
      --umi_prefix                     if specified, an underline will be used to connect prefix and UMI (i.e. prefix=UMI, UMI=AATTCG, final=UMI_AATTCG). No prefix by default (string [=])
      --umi_skip                       if the UMI is in read1/read2, fastp can skip several bases following UMI, default is 0 (int [=0])
  -p, --overrepresentation_analysis    enable overrepresented sequence analysis.
  -P, --overrepresentation_sampling    one in (--overrepresentation_sampling) reads will be computed for overrepresentation analysis (1~10000), smaller is slower, default is 20. (int [=20])
  -j, --json                           the json format report file name (string [=fastp.json])
  -h, --html                           the html format report file name (string [=fastp.html])
  -R, --report_title                   should be quoted with ' or ", default is "fastp report" (string [=fastp report])
  -w, --thread                         worker thread number, default is 3 (int [=3])
  -s, --split                          split output by limiting total split file number with this option (2~999), a sequential number prefix will be added to output name ( 0001.out.fq, 0002.out.fq...), disabled by default (int [=0])
  -S, --split_by_lines                 split output by limiting lines of each file with this option(>=1000), a sequential number prefix will be added to output name ( 0001.out.fq, 0002.out.fq...), disabled by default (long [=0])
  -d, --split_prefix_digits            the digits for the sequential number padding (1~10), default is 4, so the filename will be padded as 0001.xxx, 0 to disable padding (int [=4])
      --cut_by_quality5                DEPRECATED, use --cut_front instead.
      --cut_by_quality3                DEPRECATED, use --cut_tail instead.
      --cut_by_quality_aggressive      DEPRECATED, use --cut_right instead.
      --discard_unmerged               DEPRECATED, no effect now, see the introduction for merging.
  -?, --help                           print this message
```


## metagem_megahit

### Tool Description
MEGAHIT v1.2.9

### Metadata
- **Docker Image**: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
- **Homepage**: https://github.com/franciscozorrilla/metaGEM
- **Package**: https://anaconda.org/channels/bioconda/packages/metagem/overview
- **Validation**: PASS

### Original Help Text
```text
megahit: MEGAHIT v1.2.9

contact: Dinghua Li <voutcn@gmail.com>

Usage:
  megahit [options] {-1 <pe1> -2 <pe2> | --12 <pe12> | -r <se>} [-o <out_dir>]

  Input options that can be specified for multiple times (supporting plain text and gz/bz2 extensions)
    -1                       <pe1>          comma-separated list of fasta/q paired-end #1 files, paired with files in <pe2>
    -2                       <pe2>          comma-separated list of fasta/q paired-end #2 files, paired with files in <pe1>
    --12                     <pe12>         comma-separated list of interleaved fasta/q paired-end files
    -r/--read                <se>           comma-separated list of fasta/q single-end files

Optional Arguments:
  Basic assembly options:
    --min-count              <int>          minimum multiplicity for filtering (k_min+1)-mers [2]
    --k-list                 <int,int,..>   comma-separated list of kmer size
                                            all must be odd, in the range 15-255, increment <= 28)
                                            [21,29,39,59,79,99,119,141]

  Another way to set --k-list (overrides --k-list if one of them set):
    --k-min                  <int>          minimum kmer size (<= 255), must be odd number [21]
    --k-max                  <int>          maximum kmer size (<= 255), must be odd number [141]
    --k-step                 <int>          increment of kmer size of each iteration (<= 28), must be even number [12]

  Advanced assembly options:
    --no-mercy                              do not add mercy kmers
    --bubble-level           <int>          intensity of bubble merging (0-2), 0 to disable [2]
    --merge-level            <l,s>          merge complex bubbles of length <= l*kmer_size and similarity >= s [20,0.95]
    --prune-level            <int>          strength of low depth pruning (0-3) [2]
    --prune-depth            <int>          remove unitigs with avg kmer depth less than this value [2]
    --disconnect-ratio       <float>        disconnect unitigs if its depth is less than this ratio times 
                                            the total depth of itself and its siblings [0.1]  
    --low-local-ratio        <float>        remove unitigs if its depth is less than this ratio times
                                            the average depth of the neighborhoods [0.2]
    --max-tip-len            <int>          remove tips less than this value [2*k]
    --cleaning-rounds        <int>          number of rounds for graph cleanning [5]
    --no-local                              disable local assembly
    --kmin-1pass                            use 1pass mode to build SdBG of k_min

  Presets parameters:
    --presets                <str>          override a group of parameters; possible values:
                                            meta-sensitive: '--min-count 1 --k-list 21,29,39,49,...,129,141'
                                            meta-large: '--k-min 27 --k-max 127 --k-step 10'
                                            (large & complex metagenomes, like soil)

  Hardware options:
    -m/--memory              <float>        max memory in byte to be used in SdBG construction
                                            (if set between 0-1, fraction of the machine's total memory) [0.9]
    --mem-flag               <int>          SdBG builder memory mode. 0: minimum; 1: moderate;
                                            others: use all memory specified by '-m/--memory' [1]
    -t/--num-cpu-threads     <int>          number of CPU threads [# of logical processors]
    --no-hw-accel                           run MEGAHIT without BMI2 and POPCNT hardware instructions

  Output options:
    -o/--out-dir             <string>       output directory [./megahit_out]
    --out-prefix             <string>       output prefix (the contig file will be OUT_DIR/OUT_PREFIX.contigs.fa)
    --min-contig-len         <int>          minimum length of contigs to output [200]
    --keep-tmp-files                        keep all temporary files
    --tmp-dir                <string>       set temp directory

Other Arguments:
    --continue                              continue a MEGAHIT run from its last available check point.
                                            please set the output directory correctly when using this option.
    --test                                  run MEGAHIT on a toy test dataset
    -h/--help                               print the usage message
    -v/--version                            print version
```


## metagem_concoct

### Tool Description
concoct

### Metadata
- **Docker Image**: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
- **Homepage**: https://github.com/franciscozorrilla/metaGEM
- **Package**: https://anaconda.org/channels/bioconda/packages/metagem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: concoct [-h] [--coverage_file COVERAGE_FILE]
               [--composition_file COMPOSITION_FILE] [-c CLUSTERS]
               [-k KMER_LENGTH] [-t THREADS] [-l LENGTH_THRESHOLD]
               [-r READ_LENGTH] [--total_percentage_pca TOTAL_PERCENTAGE_PCA]
               [-b BASENAME] [-s SEED] [-i ITERATIONS]
               [--no_cov_normalization] [--no_total_coverage]
               [--no_original_data] [-o] [-d] [-v]

options:
  -h, --help            show this help message and exit
  --coverage_file COVERAGE_FILE
                        specify the coverage file, containing a table where
                        each row correspond to a contig, and each column
                        correspond to a sample. The values are the average
                        coverage for this contig in that sample. All values
                        are separated with tabs.
  --composition_file COMPOSITION_FILE
                        specify the composition file, containing sequences in
                        fasta format. It is named the composition file since
                        it is used to calculate the kmer composition (the
                        genomic signature) of each contig.
  -c CLUSTERS, --clusters CLUSTERS
                        specify maximal number of clusters for VGMM, default
                        400.
  -k KMER_LENGTH, --kmer_length KMER_LENGTH
                        specify kmer length, default 4.
  -t THREADS, --threads THREADS
                        Number of threads to use
  -l LENGTH_THRESHOLD, --length_threshold LENGTH_THRESHOLD
                        specify the sequence length threshold, contigs shorter
                        than this value will not be included. Defaults to
                        1000.
  -r READ_LENGTH, --read_length READ_LENGTH
                        specify read length for coverage, default 100
  --total_percentage_pca TOTAL_PERCENTAGE_PCA
                        The percentage of variance explained by the principal
                        components for the combined data.
  -b BASENAME, --basename BASENAME
                        Specify the basename for files or directory where
                        outputwill be placed. Path to existing directory or
                        basenamewith a trailing '/' will be interpreted as a
                        directory.If not provided, current directory will be
                        used.
  -s SEED, --seed SEED  Specify an integer to use as seed for clustering. 0
                        gives a random seed, 1 is the default seed and any
                        other positive integer can be used. Other values give
                        ArgumentTypeError.
  -i ITERATIONS, --iterations ITERATIONS
                        Specify maximum number of iterations for the VBGMM.
                        Default value is 500
  --no_cov_normalization
                        By default the coverage is normalized with regards to
                        samples, then normalized with regards of contigs and
                        finally log transformed. By setting this flag you skip
                        the normalization and only do log transorm of the
                        coverage.
  --no_total_coverage   By default, the total coverage is added as a new
                        column in the coverage data matrix, independently of
                        coverage normalization but previous to log
                        transformation. Use this tag to escape this behaviour.
  --no_original_data    By default the original data is saved to disk. For big
                        datasets, especially when a large k is used for
                        compositional data, this file can become very large.
                        Use this tag if you don't want to save the original
                        data.
  -o, --converge_out    Write convergence info to files.
  -d, --debug           Debug parameters.
  -v, --version         show program's version number and exit
```


## metagem_metabat

### Tool Description
Metagenome Binning based on Abundance and Tetranucleotide frequency

### Metadata
- **Docker Image**: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
- **Homepage**: https://github.com/franciscozorrilla/metaGEM
- **Package**: https://anaconda.org/channels/bioconda/packages/metagem/overview
- **Validation**: PASS

### Original Help Text
```text
MetaBAT: Metagenome Binning based on Abundance and Tetranucleotide frequency (version 2:2.15 (Bioconda); 2022-11-19T22:34:33)
by Don Kang (ddkang@lbl.gov), Feng Li, Jeff Froula, Rob Egan, and Zhong Wang (zhongwang@lbl.gov) 

Allowed options:
  -h [ --help ]                     produce help message
  -i [ --inFile ] arg               Contigs in (gzipped) fasta file format [Mandatory]
  -o [ --outFile ] arg              Base file name and path for each bin. The default output is fasta format.
                                    Use -l option to output only contig names [Mandatory].
  -a [ --abdFile ] arg              A file having mean and variance of base coverage depth (tab delimited; 
                                    the first column should be contig names, and the first row will be 
                                    considered as the header and be skipped) [Optional].
  -m [ --minContig ] arg (=2500)    Minimum size of a contig for binning (should be >=1500).
  --maxP arg (=95)                  Percentage of 'good' contigs considered for binning decided by connection
                                    among contigs. The greater, the more sensitive.
  --minS arg (=60)                  Minimum score of a edge for binning (should be between 1 and 99). The 
                                    greater, the more specific.
  --maxEdges arg (=200)             Maximum number of edges per node. The greater, the more sensitive.
  --pTNF arg (=0)                   TNF probability cutoff for building TNF graph. Use it to skip the 
                                    preparation step. (0: auto).
  --noAdd                           Turning off additional binning for lost or small contigs.
  --cvExt                           When a coverage file without variance (from third party tools) is used 
                                    instead of abdFile from jgi_summarize_bam_contig_depths.
  -x [ --minCV ] arg (=1)           Minimum mean coverage of a contig in each library for binning.
  --minCVSum arg (=1)               Minimum total effective mean coverage of a contig (sum of depth over 
                                    minCV) for binning.
  -s [ --minClsSize ] arg (=200000) Minimum size of a bin as the output.
  -t [ --numThreads ] arg (=0)      Number of threads to use (0: use all cores).
  -l [ --onlyLabel ]                Output only sequence labels as a list in a column without sequences.
  --saveCls                         Save cluster memberships as a matrix format
  --unbinned                        Generate [outFile].unbinned.fa file for unbinned contigs
  --noBinOut                        No bin output. Usually combined with --saveCls to check only contig 
                                    memberships
  --seed arg (=0)                   For exact reproducibility. (0: use random seed)
  -d [ --debug ]                    Debug output
  -v [ --verbose ]                  Verbose output


[Error!] There was no --inFile specified
[Error!] There was no --outFile specified
```


## metagem_gtdbtk

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
- **Homepage**: https://github.com/franciscozorrilla/metaGEM
- **Package**: https://anaconda.org/channels/bioconda/packages/metagem/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
================================================================================
                                     ERROR                                      
________________________________________________________________________________

           The GTDB-Tk reference data does not exist or is corrupted.           
               GTDBTK_DATA_PATH=/usr/local/share/gtdbtk-1.7.0/db/               

   Please compare the checksum to those provided in the download repository.    
          https://github.com/Ecogenomics/GTDBTk#gtdb-tk-reference-data          
================================================================================
```


## Metadata
- **Skill**: generated

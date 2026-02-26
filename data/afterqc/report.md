# afterqc CWL Generation Report

## afterqc_after.py

### Tool Description
Automatic Filtering, Trimming, Error Removing and Quality Control for Illumina fastq data

### Metadata
- **Docker Image**: quay.io/biocontainers/afterqc:0.9.7--py27_0
- **Homepage**: https://github.com/OpenGene/AfterQC
- **Package**: https://anaconda.org/channels/bioconda/packages/afterqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/afterqc/overview
- **Total Downloads**: 13.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/OpenGene/AfterQC
- **Stars**: N/A
### Original Help Text
```text
Usage: Automatic Filtering, Trimming, Error Removing and Quality Control for Illumina fastq data 

Simplest usage:
cd to the folder containing your fastq data, run <python after.py>

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -1 READ1_FILE, --read1_file=READ1_FILE
                        file name of read1, required. If input_dir is
                        specified, then this arg is ignored.
  -2 READ2_FILE, --read2_file=READ2_FILE
                        file name of read2, if paired. If input_dir is
                        specified, then this arg is ignored.
  -7 INDEX1_FILE, --index1_file=INDEX1_FILE
                        file name of 7' index. If input_dir is specified, then
                        this arg is ignored.
  -5 INDEX2_FILE, --index2_file=INDEX2_FILE
                        file name of 5' index. If input_dir is specified, then
                        this arg is ignored.
  -d INPUT_DIR, --input_dir=INPUT_DIR
                        the input dir to process automatically. If read1_file
                        are input_dir are not specified, then current dir (.)
                        is specified to input_dir
  -g GOOD_OUTPUT_FOLDER, --good_output_folder=GOOD_OUTPUT_FOLDER
                        the folder to store good reads, by default it is named
                        'good', in the current directory
  -b BAD_OUTPUT_FOLDER, --bad_output_folder=BAD_OUTPUT_FOLDER
                        the folder to store bad reads, by default it is named
                        'bad', in the same folder as good_output_folder
  -r REPORT_OUTPUT_FOLDER, --report_output_folder=REPORT_OUTPUT_FOLDER
                        the folder to store QC reports, by default it is named
                        'QC', in the same folder as good_output_folder
  --read1_flag=READ1_FLAG
                        specify the name flag of read1, default is R1, which
                        means a file with name *R1* is read1 file
  --read2_flag=READ2_FLAG
                        specify the name flag of read2, default is R2, which
                        means a file with name *R2* is read2 file
  --index1_flag=INDEX1_FLAG
                        specify the name flag of index1, default is I1, which
                        means a file with name *I1* is index2 file
  --index2_flag=INDEX2_FLAG
                        specify the name flag of index2, default is I2, which
                        means a file with name *I2* is index2 file
  -f TRIM_FRONT, --trim_front=TRIM_FRONT
                        number of bases to be trimmed in the head of read. -1
                        means auto detect
  -t TRIM_TAIL, --trim_tail=TRIM_TAIL
                        number of bases to be trimmed in the tail of read. -1
                        means auto detect
  --trim_pair_same=TRIM_PAIR_SAME
                        use same trimming configuration for read1 and read2 to
                        keep their sequence length identical, default is true
  -q QUALIFIED_QUALITY_PHRED, --qualified_quality_phred=QUALIFIED_QUALITY_PHRED
                        the quality value that a base is qualifyed. Default 15
                        means phred base quality >=Q15 is qualified.
  -u UNQUALIFIED_BASE_LIMIT, --unqualified_base_limit=UNQUALIFIED_BASE_LIMIT
                        if exists more than unqualified_base_limit bases that
                        quality is lower than qualified quality, then this
                        read/pair is bad. Default is 60
  -p POLY_SIZE_LIMIT, --poly_size_limit=POLY_SIZE_LIMIT
                        if exists one polyX(polyG means GGGGGGGGG...), and its
                        length is >= poly_size_limit, then this read/pair is
                        bad. Default is 35
  -a ALLOW_MISMATCH_IN_POLY, --allow_mismatch_in_poly=ALLOW_MISMATCH_IN_POLY
                        the count of allowed mismatches when detection polyX.
                        Default 2 means allow 2 mismatches for polyX detection
  -n N_BASE_LIMIT, --n_base_limit=N_BASE_LIMIT
                        if exists more than maxn bases have N, then this
                        read/pair is bad. Default is 5
  -s SEQ_LEN_REQ, --seq_len_req=SEQ_LEN_REQ
                        if the trimmed read is shorter than seq_len_req, then
                        this read/pair is bad. Default is 35
  --debubble            specify whether apply debubble algorithm to remove the
                        reads in the bubbles. Default is False
  --debubble_dir=DEBUBBLE_DIR
                        specify the folder to store output of debubble
                        algorithm, default is debubble
  --draw=DRAW           specify whether draw the pictures or not, when use
                        debubble or QC. Default is on
  --barcode=BARCODE     specify whether deal with barcode sequencing files,
                        default is on, which means all files with barcode_flag
                        in filename will be treated as barcode sequencing
                        files
  --barcode_length=BARCODE_LENGTH
                        specify the designed length of barcode
  --barcode_flag=BARCODE_FLAG
                        specify the name flag of a barcoded file, default is
                        barcode, which means a file with name *barcode* is a
                        barcoded file
  --barcode_verify=BARCODE_VERIFY
                        specify the verify sequence of a barcode which is
                        adjunct to the barcode
  --store_overlap=STORE_OVERLAP
                        specify whether store only overlapped bases of the
                        good reads
  --overlap_output_folder=OVERLAP_OUTPUT_FOLDER
                        the folder to store only overlapped bases of the good
                        reads
  --qc_only             if qconly is true, only QC result will be output, this
                        can be much fast
  --qc_sample=QC_SAMPLE
                        sample up to qc_sample reads when do QC, 0 means
                        sample all reads. Default is 200,000
  --qc_kmer=QC_KMER     specify the kmer length for KMER statistics for QC,
                        default is 8
  --no_correction       disable base correction for mismatched base pairs in
                        overlapped areas
  --mask_mismatch       set the qual num to 0 for mismatched base pairs in
                        overlapped areas to mask them out
  --no_overlap          disable overlap analysis (usually much faster with
                        this option)
  -z, --gzip            force gzip compression for output, even the input is
                        not gzip compressed
  --compression=COMPRESSION
                        set compression level (0~9) for gzip output, default
                        is 2 (0 = best speed, 9 = best compression).
```


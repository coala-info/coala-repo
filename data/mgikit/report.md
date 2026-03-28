# mgikit CWL Generation Report

## mgikit_demultiplex

### Tool Description
Demultipex fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgikit:2.1.1--h3ab6199_0
- **Homepage**: https://sagc-bioinformatics.github.io/mgikit/
- **Package**: https://anaconda.org/channels/bioconda/packages/mgikit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mgikit/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-12-07
- **GitHub**: https://github.com/sagc-bioinformatics/mgikit
- **Stars**: N/A
### Original Help Text
```text
███╗░░░███╗░██████╗░██╗██╗░░██╗██╗████████╗
                  ████╗░████║██╔════╝░██║██║░██╔╝██║╚══██╔══╝
                  ██╔████╔██║██║░░██╗░██║█████═╝░██║░░░██║░░░
                  ██║╚██╔╝██║██║░░╚██╗██║██╔═██╗░██║░░░██║░░░
                  ██║░╚═╝░██║╚██████╔╝██║██║░╚██╗██║░░░██║░░░
                  ╚═╝░░░░░╚═╝░╚═════╝░╚═╝╚═╝░░╚═╝╚═╝░░░╚═╝░░░
                                  (v2.1.1)                 
                  Ziad Al-Bkhetan (ziad.albkhetan@gmail.com)
                  ACGCGAGACGAGAGATT-MGIKIT-GCGAGAGAGACGCTCGAA



Demultipex fastq files.

Usage: mgikit demultiplex [OPTIONS] --sample-sheet <arg_sample_sheet_file_path>

Options:
  -i, --input <arg_input_folder_path>
          The path to read2.fastq.gz See the example for the required format. [default: ]
  -l, --log-level <arg_log_level>
          log level for output messages. Expected values: [error, warn, info, debug, trace]. Default is info. [default: info]
  -r, --read2 <arg_read2_file_path>
          The path to read2.fastq.gz See the example for the required format. [default: ]
  -f, --read1 <arg_read1_file_path>
          The path to read1.fastq.gz See the example for the required format. [default: ]
  -s, --sample-sheet <arg_sample_sheet_file_path>
          The path to the sample/index map.
  -o, --output <arg_ouput_dir>
          Path to the output folder. If not provided, the output will be written at mgiKit_ followed by current data and time. [default: ]
      --reports <arg_report_dir>
          Prefix of report file. If not provided, the output will be written at output_ followed by current data and time. [default: ]
  -m, --mismatches <arg_allowed_mismatches>
          The number of allowed mismatches when detecting indexes from reads. [default: 1]
      --template <arg_template>
          The general template of the indexes to be used for demultiplexing. [default: ]
      --i7-rc
          Convert i7 to reveres complement. Only valid when using general template.
      --i5-rc
          Convert i5 to reveres complement. Only valid when using general template.
      --disable-illumina
          Disable illumina file naming and read header format. Output file names and reads' header using MGI format.
      --keep-barcode
          Keep the barcode at the tail of read sequence.
      --writing-buffer-size <arg_writing_buffer_size>
          The size of the buffer for each sample to be filled with data then written once to the disk. [default: 67108864]
      --lane <arg_lane>
          The lane number, required for Illumina format. [default: ]
      --instrument <arg_instrument>
          The Id of the instrument required for Illumina format. [default: ]
      --run <arg_run>
          The run number, required for Illumina format. [default: ]
      --undetermined-label <arg_undetermined_label>
          The name of the file that contains undetermined reads. [default: Undetermined]
      --ambiguous-label <arg_ambiguous_label>
          The name of the file that contains ambiguous reads. [default: Ambiguous]
      --comprehensive-scan
          Check all possible matches, otherwise, search will stop after first match. Only needed for mixed library.
      --force
          Force running the tool and overwrite existed output/report files.
      --report-limit <arg_report_limit>
          The number of barcodes to be reported in the list of undetermined and ambiguous barcodes for short/multiqc report. [default: 20]
      --in-r1-file-suf <arg_read1_file_name_suf>
          The suffix to read1 file name. When using the --input parameter, the tool looks for the file that ends with this suffix and use it as read1 file. There should be one file with this suffix in the input directory. [default: _read_1.fq.gz]
      --in-r2-file-suf <arg_read2_file_name_suf>
          The suffix to read2 file name. When using the --input parameter, the tool looks for the file that ends with this suffix and use it as read2 file. There should be one file with this suffix in the input directory. [default: _read_2.fq.gz]
      --info-file <arg_info_file>
          The path to the info file that contains the run information (similar to `BioInfo.csv` generated by MGI machines under the lane directory). Check the documentation for more details. [default: ]
      --report-level <arg_report_level>
          The level of reporting. 0 no reports will be generated!, 1 data quality and demultipexing reports. 2: all reports (reports on data quality, demultipexing, undetermined and ambigouse barcodes). [default: 2]
      --compression-level <arg_compression_level>
          The level of compression (between 0 and 12). 0 is fast but no compression, 12 is slow but high compression. [default: 1]
      --compression-buffer-size <arg_compression_buffer_size>
          The size of the buffer for data compression for each sample. [default: 131072]
      --ignore-undetermined
          Do not stop if there are many undetermined reads in the dataset.
      --log <arg_log_path>
          Path to the output log, instead of writing to the stdout. [default: ]
      --mgi-full-header
          Add sample barcode and UMI to MGI header when MGI format is enabled.
      --all-index-error
          By default, the allowed mismatches `-m or --mismatches` are considered to be per index. This flag will make it for the total mismatches across all indices.
      --memory <arg_memory>
          The requested maximum memory to be used (in giga byte). Check the documentation for memory optimisation options. Default is 0 then the tool will use the available memory on the machine. [default: 0]
      --not-mgi
          This flag needs to be enabled if the input fastq files don't have MGI format.
  -t, --threads <arg_threads>
          The requested threads to be used. Default is 0 which means to use all available CPUs. [default: 0]
      --validate
          Validate the content of the fastq files.
      --reader-threads <arg_threads_r>
          The requested threads to be used for input reading. Default is 0 which means auto configuration. [default: 0]
      --writer-threads <arg_threads_w>
          The requested threads to be used for processing and writing outputs. Default is 0 which means auto configuration. [default: 0]
  -h, --help
          Print help
  -V, --version
          Print version
```


## mgikit_template

### Tool Description
Detect barcode template.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgikit:2.1.1--h3ab6199_0
- **Homepage**: https://sagc-bioinformatics.github.io/mgikit/
- **Package**: https://anaconda.org/channels/bioconda/packages/mgikit/overview
- **Validation**: PASS

### Original Help Text
```text
███╗░░░███╗░██████╗░██╗██╗░░██╗██╗████████╗
                  ████╗░████║██╔════╝░██║██║░██╔╝██║╚══██╔══╝
                  ██╔████╔██║██║░░██╗░██║█████═╝░██║░░░██║░░░
                  ██║╚██╔╝██║██║░░╚██╗██║██╔═██╗░██║░░░██║░░░
                  ██║░╚═╝░██║╚██████╔╝██║██║░╚██╗██║░░░██║░░░
                  ╚═╝░░░░░╚═╝░╚═════╝░╚═╝╚═╝░░╚═╝╚═╝░░░╚═╝░░░
                                  (v2.1.1)                 
                  Ziad Al-Bkhetan (ziad.albkhetan@gmail.com)
                  ACGCGAGACGAGAGATT-MGIKIT-GCGAGAGAGACGCTCGAA



Detect barcode template.

Usage: mgikit template [OPTIONS] --sample-sheet <arg_sample_sheet_file_path>

Options:
  -i, --input <arg_input_folder_path>
          The path to read2.fastq.gz See the example for the required format. [default: ]
  -l, --log-level <arg_log_level>
          log level for output messages. Expected values: [error, warn, info, debug, trace]. Default is info. [default: info]
  -r, --read2 <arg_read2_file_path>
          The path to read2.fastq.gz See the example for the required format. [default: ]
  -f, --read1 <arg_read1_file_path>
          The path to read1.fastq.gz See the example for the required format. [default: ]
  -s, --sample-sheet <arg_sample_sheet_file_path>
          The path to the sample/index map.
      --info-file <arg_info_file>
          The path to the info file that contains the run information (similar to `BioInfo.csv` generated by MGI machines under the lane directory). Check the documentation for more details. [default: ]
  -o, --output <arg_ouput_dir>
          Path to the output file prefix. If not provided, the output will be written at mgiKit_ followed by current data and time. [default: ]
      --barcode-length <arg_barcode_length>
          The barcode length to detect the template. When set to 0, the barcode length will be length's difference between R2 and R1. [default: 0]
      --popular-template
          Use the most frequent template for all samples even if some of them have more matches with other template.
      --no-umi
          Don't extract UMI from the read barcode.
      --testing-reads <arg_testing_reads>
          The number of reads used to detect the barcode. [default: 5000]
      --max-umi-len <arg_max_umi_length>
          The maximum expected UMI length. [default: 10]
      --in-r1-file-suf <arg_read1_file_name_suf>
          The suffix to read1 file name. When using the --input parameter, the tool looks for the file that ends with this suffix and use it as read1 file. There should be one file with this suffix in the input directory. [default: _read_1.fq.gz]
      --in-r2-file-suf <arg_read2_file_name_suf>
          The suffix to read2 file name. When using the --input parameter, the tool looks for the file that ends with this suffix and use it as read2 file. There should be one file with this suffix in the input directory. [default: _read_2.fq.gz]
  -h, --help
          Print help
  -V, --version
          Print version
```


## mgikit_report

### Tool Description
Merge demultipexing reports.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgikit:2.1.1--h3ab6199_0
- **Homepage**: https://sagc-bioinformatics.github.io/mgikit/
- **Package**: https://anaconda.org/channels/bioconda/packages/mgikit/overview
- **Validation**: PASS

### Original Help Text
```text
███╗░░░███╗░██████╗░██╗██╗░░██╗██╗████████╗
                  ████╗░████║██╔════╝░██║██║░██╔╝██║╚══██╔══╝
                  ██╔████╔██║██║░░██╗░██║█████═╝░██║░░░██║░░░
                  ██║╚██╔╝██║██║░░╚██╗██║██╔═██╗░██║░░░██║░░░
                  ██║░╚═╝░██║╚██████╔╝██║██║░╚██╗██║░░░██║░░░
                  ╚═╝░░░░░╚═╝░╚═════╝░╚═╝╚═╝░░╚═╝╚═╝░░░╚═╝░░░
                                  (v2.1.1)                 
                  Ziad Al-Bkhetan (ziad.albkhetan@gmail.com)
                  ACGCGAGACGAGAGATT-MGIKIT-GCGAGAGAGACGCTCGAA



Merge demultipexing reports.

Usage: mgikit report [OPTIONS] --qc-report <arg_qc_report_path>

Options:
  -l, --log-level <arg_log_level>       log level for output messages. Expected values: [error, warn, info, debug, trace]. Default is info. [default: info]
      --qc-report <arg_qc_report_path>  The paths to the QC reports, repeat it for each report.
  -o, --output <arg_ouput_dir>          output directory
      --lane <arg_lane>                 The lane number, required for report name. [default: all]
      --prefix <arg_prefix>             The prefix of the report. By default, it is the first part of the last input report. [default: ]
  -h, --help                            Print help
  -V, --version                         Print version
```


## mgikit_reformat

### Tool Description
Reformat MGI fastq headers to Illumina's and prepare quality report.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgikit:2.1.1--h3ab6199_0
- **Homepage**: https://sagc-bioinformatics.github.io/mgikit/
- **Package**: https://anaconda.org/channels/bioconda/packages/mgikit/overview
- **Validation**: PASS

### Original Help Text
```text
███╗░░░███╗░██████╗░██╗██╗░░██╗██╗████████╗
                  ████╗░████║██╔════╝░██║██║░██╔╝██║╚══██╔══╝
                  ██╔████╔██║██║░░██╗░██║█████═╝░██║░░░██║░░░
                  ██║╚██╔╝██║██║░░╚██╗██║██╔═██╗░██║░░░██║░░░
                  ██║░╚═╝░██║╚██████╔╝██║██║░╚██╗██║░░░██║░░░
                  ╚═╝░░░░░╚═╝░╚═════╝░╚═╝╚═╝░░╚═╝╚═╝░░░╚═╝░░░
                                  (v2.1.1)                 
                  Ziad Al-Bkhetan (ziad.albkhetan@gmail.com)
                  ACGCGAGACGAGAGATT-MGIKIT-GCGAGAGAGACGCTCGAA



Reformat MGI fastq headers to Illumina's and prepare quality report.

Usage: mgikit reformat [OPTIONS]

Options:
  -l, --log-level <arg_log_level>
          log level for output messages. Expected values: [error, warn, info, debug, trace]. Default is info. [default: info]
  -r, --read2 <arg_read2_file_path>
          The path to read2.fastq.gz See the example for the required format. [default: ]
  -f, --read1 <arg_read1_file_path>
          The path to read1.fastq.gz See the example for the required format. [default: ]
  -o, --output <arg_ouput_dir>
          Path to the output folder. If not provided, the output will be written at mgiKit_ followed by current data and time. [default: ]
      --reports <arg_report_dir>
          Prefix of report file. If not provided, the output will be written at output_ followed by current data and time. [default: ]
      --disable-illumina
          Disable illumina file naming and read header format. Output file names and reads' header using MGI format.
      --writing-buffer-size <arg_writing_buffer_size>
          The size of the buffer for each sample to be filled with data then written once to the disk. [default: 67108864]
      --lane <arg_lane>
          The lane number, required for Illumina format. [default: ]
      --instrument <arg_instrument>
          The Id of the instrument required for Illumina format. [default: ]
      --run <arg_run>
          The run number, required for Illumina format. [default: ]
      --force
          Force running the tool and overwrite existed output/report files.
      --info-file <arg_info_file>
          The path to the info file that contains the run information (similar to `BioInfo.csv` generated by MGI machines under the lane directory). Check the documentation for more details. [default: ]
      --report-level <arg_report_level>
          The level of reporting. 0 no reports will be generated!, 1 data quality and demultipexing reports. 2: all reports (reports on data quality, demultipexing, undetermined and ambigouse barcodes). [default: 2]
      --compression-level <arg_compression_level>
          The level of compression (between 0 and 12). 0 is fast but no compression, 12 is slow but high compression. [default: 1]
      --compression-buffer-size <arg_compression_buffer_size>
          The size of the buffer for data compression for each sample. [default: 131072]
      --memory <arg_memory>
          The requested maximum memory to be used (in giga byte). Check the documentation for memory optimisation options. Default is 0 then the tool will use the available memory on the machine. [default: 0]
      --validate
          Validate the content of the fastq files.
      --umi-length <arg_umi_length>
          The length of UMI expected at the end of the read (r1 for single-end, or r2 for paired-end). [default: 0]
      --sample-index <arg_sample_index>
          The index of the sample in the sample sheet, needed for file naming. [default: 1]
      --barcode <arg_barcode>
          The barcode of the specific sample to calulate the mismatches for the reports. If not provided, no mismtahces will be calculated. [default: ]
      --sample-label <arg_sample_label>
          Sample label to be used for file naming. if not provided, it will be taken from the name of the input file [default: ]
  -h, --help
          Print help
  -V, --version
          Print version
```


## Metadata
- **Skill**: generated

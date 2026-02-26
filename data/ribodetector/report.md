# ribodetector CWL Generation Report

## ribodetector

### Tool Description
rRNA sequence detector

### Metadata
- **Docker Image**: quay.io/biocontainers/ribodetector:0.3.3--pyhdfd78af_0
- **Homepage**: https://github.com/hzi-bifo/RiboDetector
- **Package**: https://anaconda.org/channels/bioconda/packages/ribodetector/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ribodetector/overview
- **Total Downloads**: 17.2K
- **Last updated**: 2026-02-06
- **GitHub**: https://github.com/hzi-bifo/RiboDetector
- **Stars**: N/A
### Original Help Text
```text
usage: ribodetector [-h] [-c CONFIG] [-d DEVICEID] -l LEN -i [INPUT ...] -o
                    [OUTPUT ...] [-r [RRNA ...]] [-e {rrna,norrna,both,none}]
                    [-t THREADS] [-s SEED] [-m MEMORY]
                    [--chunk_size CHUNK_SIZE] [--log LOG]
                    [--model-file MODEL_FILE] [-v]

rRNA sequence detector

options:
  -h, --help            show this help message and exit
  -c CONFIG, --config CONFIG
                        Path of config file
  -d DEVICEID, --deviceid DEVICEID
                        Indices of GPUs to enable. Quotated comma-separated device ID numbers. (default: all)
  -l LEN, --len LEN     Sequencing read length. Note: the accuracy reduces for reads shorter than 40.
  -i [INPUT ...], --input [INPUT ...]
                        Path of input sequence files (fasta and fastq), the second file will be considered as second end if two files given.
  -o [OUTPUT ...], --output [OUTPUT ...]
                        Path of the output sequence files after rRNAs removal (same number of files as input). 
                        (Note: 2 times slower to write gz files)
  -r [RRNA ...], --rrna [RRNA ...]
                        Path of the output sequence file of detected rRNAs (same number of files as input)
  -e {rrna,norrna,both,none}, --ensure {rrna,norrna,both,none}
                        Ensure which classificaion has high confidence for paired end reads.
                        norrna: output only high confident non-rRNAs, the rest are clasified as rRNAs;
                        rrna: vice versa, only high confident rRNAs are classified as rRNA and the rest output as non-rRNAs;
                        both: both non-rRNA and rRNA prediction with high confidence;
                        none: give label based on the mean probability of read pair.
                              (Only applicable for paired end reads, discard the read pair when their predicitons are discordant)
  -t THREADS, --threads THREADS
                        Number of threads to use. (default: 10)
  -s SEED, --seed SEED  Random seed.
  -m MEMORY, --memory MEMORY
                        Amount (GB) of GPU RAM. (default: 12)
  --chunk_size CHUNK_SIZE
                        Use this parameter when having low memory. Parsing the file in chunks.
                        Not needed when free RAM >=5 * your_file_size (uncompressed, sum of paired ends).
                        When chunk_size=256, memory=16 it will load 256 * 16 * 1024 reads each chunk (use ~20 GB for 100bp paired end).
  --log LOG             Log file name
  --model-file MODEL_FILE
                        Model file path without extension (uses .pth). Default: packaged model_len70_101.
  -v, --version         show program's version number and exit
```


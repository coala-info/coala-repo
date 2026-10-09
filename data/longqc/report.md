# longqc CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| longqc_runqc | Not completed | needs a raw sequencing run folder (PacBio or Nanopore run files), no small real run folder available; the image has the same missing sdust problem |
| longqc_sampleqc | Failed | image problem: longQC.py looks for sdust inside a minimap2-coverage folder that does not exist in the image, so the sdust table is empty and the run crashes (the script also has no shebang line, so the CWL runs it through python) |

## longqc_sampleqc

### Tool Description
Quality control of long reads (fasta, fastq or pbbam) by sampling a subset of the reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/longqc:1.2.0c--hdfd78af_0
- **Homepage**: https://github.com/yfukasawa/LongQC
- **Package**: https://anaconda.org/channels/bioconda/packages/longqc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: LongQC sampleqc [-h] -o OUT -x preset [-t] [-n NSAMPLE] [-s SUF]
                       [-c TRIM] [--adapter_5 ADP5] [--adapter_3 ADP3] [-f]
                       [-p NCPU] [-d] [-m MEM] [-i INDS] [-b]
                       input

positional arguments:
  input                 Input [fasta, fastq or pbbam]

optional arguments:
  -h, --help            show this help message and exit
  -o OUT, --output OUT  path for output directory
  -x preset, --preset preset
                        a platform/kit to be evaluated. adapter and some ovlp
                        parameters are automatically applied. (pb-rs2, pb-
                        sequel, pb-hifi, ont-ligation, ont-rapid, ont-1dsq)
  -t, --transcript      applies the preset for transcripts, RNA or cDNA
                        sequences
  -n NSAMPLE, --n_sample NSAMPLE
                        the number of sequences for sampling. (>0 and <=10000)
                        [Default is 5000].
  -s SUF, --sample_name SUF
                        sample name is added as a suffix for each output file.
  -c TRIM, --trim_output TRIM
                        path for trimmed reads. If this is not given, trimmed
                        reads won't be saved.
  --adapter_5 ADP5      adapter sequence for 5'.
  --adapter_3 ADP3      adapter sequence for 3'.
  -f, --fast            this turns off sensitive setting. Faster but less
                        accurate.
  -p NCPU, --ncpu NCPU  the number of cpus for LongQC analysis [Default is 4.
                        >=4 is required.]
  -d, --db              make minimap2 db in parallel to other tasks.
  -m MEM, --mem MEM     memory limit for chunking. Please specify in gigabytes
                        (>0 and <=2). [Default is 0.5]
  -i INDS, --index INDS
                        Give index size for minimap2 (-I) in bp. Reduce when
                        running on a small memory machine.Default is 4G.
  -b, --short           this turns on the highly sensitive setting for very
                        short and erroneous reads (<500bp).
```

## longqc_runqc

### Tool Description
Quality control of a whole sequencing run from the raw data folder of a PacBio or Nanopore run.

### Metadata
- **Docker Image**: quay.io/biocontainers/longqc:1.2.0c--hdfd78af_0
- **Homepage**: https://github.com/yfukasawa/LongQC
- **Package**: https://anaconda.org/channels/bioconda/packages/longqc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: LongQC runqc [-h] [-s SUF] [-o OUT] platform raw_data_dir

positional arguments:
  platform              a platform to be evaluated. [rs2, sequel, minion,
                        gridion]
  raw_data_dir          a path for a dir containing the raw data

optional arguments:
  -h, --help            show this help message and exit
  -s SUF, --suffix SUF  suffix for each output file.
  -o OUT, --output OUT  path for output directory
```

## Metadata
- **Conda**: https://anaconda.org/channels/bioconda/packages/longqc/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yfukasawa/LongQC
- **Stars**: N/A

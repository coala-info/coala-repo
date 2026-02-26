# stream_atac CWL Generation Report

## stream_atac

### Tool Description
STREAM single cell ATAC-seq preprocessing steps

### Metadata
- **Docker Image**: quay.io/biocontainers/stream_atac:0.3.5--py_5
- **Homepage**: https://github.com/pinellolab/STREAM_atac
- **Package**: https://anaconda.org/channels/bioconda/packages/stream_atac/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/stream_atac/overview
- **Total Downloads**: 48.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pinellolab/STREAM_atac
- **Stars**: N/A
### Original Help Text
```text
- STREAM single cell ATAC-seq preprocessing steps -
Version 0.3.5

usage: stream_atac [-h] -c FILE -r FILE_REGION -s FILE_SAMPLE [-g GENOME]
                   [-f FEATURE] [-k K] [--resize_peak]
                   [--peak_width PEAK_WIDTH] [--n_jobs N_JOBS]
                   [--file_format FILE_FORMAT] [-o OUTPUT_FOLDER]

stream_atac Parameters

optional arguments:
  -h, --help            show this help message and exit
  -c FILE, --file_count FILE
                        scATAC-seq counts file name (default: None)
  -r FILE_REGION, --file_region FILE_REGION
                        scATAC-seq regions file name in .bed or .bed.gz format
                        (default: None)
  -s FILE_SAMPLE, --file_sample FILE_SAMPLE
                        scATAC-seq samples file name (default: None)
  -g GENOME, --genome GENOME
                        Reference genome. Choose from {{'mm9', 'mm10', 'hg38',
                        'hg19'}} (default: hg19)
  -f FEATURE, --feature FEATURE
                        Features used to have the analysis. Choose from
                        {{'kmer', 'motif'}} (default: kmer)
  -k K                  k-mer length for scATAC-seq analysis (default: 7)
  --resize_peak         Resize peaks when peaks have different widths.
                        (default: False)
  --peak_width PEAK_WIDTH
                        Specify the width of peak when resizing them. Only
                        valid when resize_peak is True. (default: 450)
  --n_jobs N_JOBS       The number of parallel jobs to run. (default,1)
                        (default: 1)
  --file_format FILE_FORMAT
                        File format of file_count. Currently supported file
                        formats: 'tsv','txt','csv','mtx'. (default: tsv)
  -o OUTPUT_FOLDER, --output_folder OUTPUT_FOLDER
                        Output folder (default: None)
```


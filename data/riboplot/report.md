# riboplot CWL Generation Report

## riboplot

### Tool Description
Plot and output read counts for a single transcript

### Metadata
- **Docker Image**: quay.io/biocontainers/riboplot:0.3.1--py27_0
- **Homepage**: https://github.com/hsinyenwu/RiboPlotR
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/riboplot/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hsinyenwu/RiboPlotR
- **Stars**: N/A
### Original Help Text
```text
usage: riboplot.py [-h] -b RIBO_FILE -f TRANSCRIPTOME_FASTA -t TEXT
                   [-n RNA_FILE] [-l READ_LENGTHS] [-s READ_OFFSETS]
                   [-c {default,colorbrewer,rgb,greyorfs}] [-m HTML_FILE]
                   [-o OUTPUT_PATH] [-d]

Plot and output read counts for a single transcript

optional arguments:
  -h, --help            show this help message and exit
  -n RNA_FILE, --rna_file RNA_FILE
                        RNA-Seq alignment file (BAM)
  -l READ_LENGTHS, --read_lengths READ_LENGTHS
                        Read lengths to consider (default: 0). Multiple read
                        lengths should be separated by commas. If multiple
                        read lengths are specified, corresponding read offsets
                        should also be specified. If you do not wish to apply
                        an offset, please input 0 for the corresponding read
                        length
  -s READ_OFFSETS, --read_offsets READ_OFFSETS
                        Read offsets (default: 0). Multiple read offsets
                        should be separated by commas
  -c {default,colorbrewer,rgb,greyorfs}, --color_scheme {default,colorbrewer,rgb,greyorfs}
                        Color scheme to use (default: default)
  -m HTML_FILE, --html_file HTML_FILE
                        Output file for results (HTML)
  -o OUTPUT_PATH, --output_path OUTPUT_PATH
                        Files are saved in this directory
  -d, --debug           Flag. Produce debug output

required arguments:
  -b RIBO_FILE, --ribo_file RIBO_FILE
                        Ribo-Seq alignment file in BAM format
  -f TRANSCRIPTOME_FASTA, --transcriptome_fasta TRANSCRIPTOME_FASTA
                        FASTA format file of the transcriptome
  -t TEXT, --transcript_name TEXT
                        Transcript name
```


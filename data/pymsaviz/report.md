# pymsaviz CWL Generation Report

## pymsaviz

### Tool Description
MSA(Multiple Sequence Alignment) visualization CLI tool

### Metadata
- **Docker Image**: quay.io/biocontainers/pymsaviz:0.5.0--pyhdfd78af_0
- **Homepage**: https://moshi4.github.io/pyMSAviz/
- **Package**: https://anaconda.org/channels/bioconda/packages/pymsaviz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pymsaviz/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/moshi4/pyMSAviz
- **Stars**: N/A
### Original Help Text
```text
usage: pymsaviz [options] -i msa.fa -o msa_viz.png

MSA(Multiple Sequence Alignment) visualization CLI tool

options:
  -i I, --infile I    Input MSA file
  -o O, --outfile O   Output MSA visualization file (*.png|*.jpg|*.svg|*.pdf)
  --format            MSA file format (Default: 'fasta')
  --color_scheme      Color scheme (Default: 'Zappo')
  --start             Start position of MSA visualization (Default: 1)
  --end               End position of MSA visualization (Default: 'MSA
                      Length')
  --wrap_length       Wrap length (Default: None)
  --wrap_space_size   Space size between wrap MSA plot area (Default: 3.0)
  --label_type        Label type ('id'[default]|'description')
  --show_grid         Show grid (Default: OFF)
  --show_count        Show seq char count without gap on right side (Default:
                      OFF)
  --show_consensus    Show consensus sequence (Default: OFF)
  --consensus_color   Consensus identity bar color (Default: '#1f77b4')
  --consensus_size    Consensus identity bar height size (Default: 2.0)
  --sort              Sort MSA order by NJ tree constructed from MSA distance
                      matrix (Default: OFF)
  --dpi               Figure DPI (Default: 300)
  -v, --version       Print version information
  -h, --help          Show this help message and exit

Available Color Schemes:
['Clustal', 'Zappo', 'Taylor', 'Flower', 'Blossom', 'Sunset', 'Ocean', 'Hydrophobicity', 'HelixPropensity', 'StrandPropensity', 'TurnPropensity', 'BuriedIndex', 'Nucleotide', 'Purine/Pyrimidine', 'Identity', 'None']
```


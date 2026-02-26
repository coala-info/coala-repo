# maskrc-svg CWL Generation Report

## maskrc-svg_maskrc-svg.py

### Tool Description
Mask recombination from ClonalFrameML/Gubbins output and draw SVG of recombinant regions

### Metadata
- **Docker Image**: quay.io/biocontainers/maskrc-svg:0.5--0
- **Homepage**: https://github.com/kwongj/maskrc-svg
- **Package**: https://anaconda.org/channels/bioconda/packages/maskrc-svg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/maskrc-svg/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kwongj/maskrc-svg
- **Stars**: N/A
### Original Help Text
```text
usage: 
  maskrc-svg.py --aln FASTA --out OUTFILE [--gubbins] <PREFIX>

Mask recombination from ClonalFrameML/Gubbins output and draw SVG of recombinant regions

positional arguments:
  PREFIX               prefix used for CFML/Gubbins input files (required)

optional arguments:
  -h, --help           show this help message and exit
  --gubbins            parse as Gubbins instead of ClonalFrameML
  --aln FASTA          multiFASTA alignment used as input for CFML (required)
  --out OUTFILE        output file for masked alignment (default="maskrc.aln")
  --symbol CHAR        symbol to use for masking (default="?")
  --regions FILE       output recombinant regions to file
  --svg FILE           draw SVG output of recombinant regions and save as specified file
  --svgsize WIDExHIGH  specify width and height of SVG in pixels (default="800x600")
  --svgorder FILE      specify file containing list of taxa (1 per line) in desired order
  --svgcolour COLOUR   specify colour of recombination regions in HEX format (default=black)
  --consensus          add consensus row of recombination hotspots
  --version            show program's version number and exit
```


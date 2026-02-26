# hsdfinder CWL Generation Report

## hsdfinder

### Tool Description
A tool to find HSDs (Highly Similar Domains) using BLAST and InterProScan output files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hsdfinder:1.1.1--hdfd78af_0
- **Homepage**: https://github.com/zx0223winner/HSDFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/hsdfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hsdfinder/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/zx0223winner/HSDFinder
- **Stars**: N/A
### Original Help Text
```text
hsdfinder -i <inputfile> -p <percentage identity> -l <length> -f <pfam file> -t <type> -o <output file>
or use hsdfinder --input_file=<input file> --percentage_identity=<percentage identity> --length=<length> --file=<pfam file> --type=<type> --output_file=<output file>
-i or --input_file	 the BLAST output file 
-p or --percentage_identity	identity percent e.g. For 90%, input 90.0
-l or --length	length e.g. 10
-f or --file	the InterProScan output file 
-t or --type	type e.g. Pfam
-o or --output_file	output file name

Try other command: hsd_to_kegg -h
```


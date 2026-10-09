# hsdfinder CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hsdfinder | Not completed | runs to success on the tutorial input, but only 238 of 279 shared lines match the tutorial output (the tutorial used extra manual threshold curation), so the result cannot be confirmed. |
| hsdfinder_hsd_to_kegg | Failed | image problem: script uses __location__ before it is defined, so it always raises NameError |

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

## hsdfinder_hsd_to_kegg

### Tool Description
Annotate HSDs (highly similar duplicates) found by hsdfinder with KEGG KO categories

### Metadata
- **Docker Image**: quay.io/biocontainers/hsdfinder:1.1.1--hdfd78af_0
- **Homepage**: https://github.com/zx0223winner/HSDFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/hsdfinder/overview
- **Validation**: PASS

### Original Help Text
```text
KEGG.py -i <HSD file> -k <Gene list file with KO annotation> -n <species name> -o <output file name>
or use KEGG.py --input_file=<HSD file> --ko_file=<Gene list file with KO annotation> --species_name=<species name> --output_file <output file name>
```


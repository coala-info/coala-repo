# hsdecipher CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hsdecipher | Failed | image problem: script uses DataFrame.append, which pandas 2 in the image no longer has |
| hsdecipher_add_on | PASS |  |
| hsdecipher_batch_run | PASS |  |
| hsdecipher_categories | PASS |  |
| hsdecipher_statistics | PASS |  |

## hsdecipher

### Tool Description
Generate a heatmap from HSD and KO file folders with specified dimensions.

### Metadata
- **Docker Image**: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
- **Homepage**: https://github.com/zx0223winner/HSDecipher
- **Package**: https://anaconda.org/channels/bioconda/packages/hsdecipher/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hsdecipher/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/zx0223winner/HSDecipher
- **Stars**: N/A
### Original Help Text
```text
HSD_heatmap.py -f <HSD file folder> -k <KO file folder> -r <width of output heatmap> -c <length of output heatmap>
HSD_heatmap.py --hsd_files_path=<HSD file folder> --ko_files_path=<KO file folder> --row_size=<width of output heatmap> --col_size=<height of output heatmap>
```

## hsdecipher_statistics

### Tool Description
Calculate statistics of highly similar duplicates (HSDs) found with a variety of HSDFinder thresholds

### Metadata
- **Docker Image**: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
- **Homepage**: https://github.com/zx0223winner/HSDecipher
- **Package**: https://anaconda.org/channels/bioconda/packages/hsdecipher/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:python3 HSD_statistics.py <path to HSD species folder> <format of HSD file. e.g., 'txt' or 'tsv'> <output file name. e,g. species_stat.tsv>
```

## hsdecipher_categories

### Tool Description
Count HSDs with two, three, and more than four gene copies

### Metadata
- **Docker Image**: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
- **Homepage**: https://github.com/zx0223winner/HSDecipher
- **Package**: https://anaconda.org/channels/bioconda/packages/hsdecipher/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:python3 HSD_categories.py <path to HSD species folder> <format of HSD file. e.g., 'txt' or 'tsv'> <output file name. e,g. species_groups.tsv>
```

## hsdecipher_add_on

### Tool Description
Add HSDs found at a later threshold on to HSDs found at a former threshold, removing redundant candidates

### Metadata
- **Docker Image**: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
- **Homepage**: https://github.com/zx0223winner/HSDecipher
- **Package**: https://anaconda.org/channels/bioconda/packages/hsdecipher/overview
- **Validation**: PASS

### Original Help Text
```text
HSD_add_on.py  -i <inputfile> -a <adding_file> -o <output file>
or use HSD_add_on.py  --input_file=<input file> --adding_file=<adding_file> --output_file=<output file>
 -i or --input_file	your HSD file
-a or --adding_file	HSDs to be added
-o or --output_file	output file name
```

## hsdecipher_batch_run

### Tool Description
Add HSDs of a series of combined thresholds in one run

### Metadata
- **Docker Image**: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
- **Homepage**: https://github.com/zx0223winner/HSDecipher
- **Package**: https://anaconda.org/channels/bioconda/packages/hsdecipher/overview
- **Validation**: PASS

### Original Help Text
```text
batch_run.py -i <inputfolder>
For example, batch_run.py -i hsdfinder
Note: The hsdfinder folder should have the sub_folder with species name, such as Arabidopsis_thaliana which should exactly match Arabidopsis_thaliana.90_10.txt
```


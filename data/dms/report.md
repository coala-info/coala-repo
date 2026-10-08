# dms CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| dms_MS-make-ref | Failed | image problem: MS-make-ref calls Rscript with the package's Rscript/config.R and MS_new_tree.R, but the image has neither R nor those scripts, and the tool crashes (exit 139) |
| dms_MS-single-to-table | PASS |  |

## dms_MS-make-ref

### Tool Description
Make customized reference for dynamic-meta-storms

### Metadata
- **Docker Image**: quay.io/biocontainers/dms:1.1--h9948957_2
- **Homepage**: https://github.com/qibebt-bioinfo/dynamic-meta-storms
- **Package**: https://anaconda.org/channels/bioconda/packages/dms/overview
- **Validation**: PASS

### Original Help Text
```text
MS-make-ref version : 1.1
	Make customized reference for dynamic-meta-storms
Usage: 
MS-make-ref [Option] Value
Options: 
	[Input options, required]
	  -i Input tree file (newick format)
	  -r Input taxonomy annotation file (tabular format)
	[Output options]
	  -o Output reference name, default is "tree.dms" 
	  -h Help
```

## dms_MS-single-to-table

### Tool Description
Combine single files to table

### Metadata
- **Docker Image**: quay.io/biocontainers/dms:1.1--h9948957_2
- **Homepage**: https://github.com/qibebt-bioinfo/dynamic-meta-storms
- **Package**: https://anaconda.org/channels/bioconda/packages/dms/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/dms/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/qibebt-bioinfo/dynamic-meta-storms
- **Stars**: N/A

### Original Help Text
```text
Single2table version:1.1
	Combine single files to table
Usage: 
MS-single-to-table [Option] Value
Option: 
	[Input options, requried]
	  -i or -l Input files list
	  -p List file path prefix for '-l' [Optional]
	[Output options]
	  -o Output file name, default is "species.table"
	  -R (upper) If the output table is reversed, T(rue) or F(alse), default is false [Optional]
	[Other options]
	  -h Help
```


## Metadata
- **Skill**: generated

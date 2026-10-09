# hera CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hera_hera_build | Failed | image problem: hera_build crashes with NameError: name 'os' is not defined (missing import in the script) |
| hera_quant | Not completed | needs an index from hera_build, which crashes in this image, so quant could not be tested |

## hera_quant

### Tool Description
Hera is a program developed by BioTuring for RNA-Seq analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/hera:1.1--h8121788_3
- **Homepage**: https://github.com/bioturing/hera
- **Package**: https://anaconda.org/channels/bioconda/packages/hera/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hera/overview
- **Total Downloads**: 25.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bioturing/hera
- **Stars**: N/A
### Original Help Text
```text
Hera is a program developed by BioTuring for RNA-Seq analysis.
Please contact info@bioturing.com if you need further support
VERSION:
	hera-v1.1
QUANTILITY:
	 ./hera quant -i path/to/index_directory [options] <R1.fq> <R2.fq>
		-o:	 Output directory (default: ./)
		-t:	 Number of threads (default: 1)
		-z:	 Compress level (1 - 9) (default: -1)
		-b:	 Number of bootstraps (default: 0)
		-w:	 Output bam file 0:true, 1: false (default: 0)
		-f:	 Genome fasta file (if not define, genome mapping will be ignore
		-p:	 Output prefix (default: '')
```

## hera_hera_build

### Tool Description
Builds a Hera index from a reference genome FASTA and a GTF annotation file.

### Metadata
- **Docker Image**: quay.io/biocontainers/hera:1.1--h8121788_3
- **Homepage**: https://github.com/bioturing/hera
- **Package**: https://anaconda.org/channels/bioconda/packages/hera/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ./hera_build  --fasta FASTA  --gtf GTF  --outdir OUTDIR
[OPTIONAL]
	--full_index 0/1
	--grch38 0/1

Arguments:
  -h, --help     show this help message and exit
  --fasta        input reference genome fasta file
  --gtf          input reference annotation gtf file
  --outdir       output directory
  --full_index   0: none, 1: index full genome
  --grch38       is input fasta GRCh38? 0: No, 1: Yes
```

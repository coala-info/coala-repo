# minirmd CWL Generation Report

## minirmd

### Tool Description
v1, by Yuansheng Liu, October 2020.

### Metadata
- **Docker Image**: quay.io/biocontainers/minirmd:1.1--hd03093a_2
- **Homepage**: https://github.com/yuansliu/minirmd
- **Package**: https://anaconda.org/channels/bioconda/packages/minirmd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/minirmd/overview
- **Total Downloads**: 4.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yuansliu/minirmd
- **Stars**: N/A
### Original Help Text
```text
minirmd v1, by Yuansheng Liu, October 2020.
Usage: minirmd -i <file> -f <file> -o <output> [option parameters]
	 options:
		 -i reads file
		 -f reads file, if paired end
		 -o the output file
		 -d number of allowed mismatch
		 -k the file to store values of k
		 -r remove duplicates on reverse-complement strand
		 -t the number of threads
		 -h print help message
Example:
		./minirmd -i test.fastq -o test_rm_1.fastq -d 1
		./minirmd -i test_1.fastq -f test_2.fastq -o test_rm_2.fastq -d 2
```


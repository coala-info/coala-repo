# libis_moabs CWL Generation Report

## libis_moabs

### Tool Description
moabs

### Metadata
- **Docker Image**: quay.io/biocontainers/libis:0.1.6--py_0
- **Homepage**: https://github.com/Dangertrip/LiBis
- **Package**: https://anaconda.org/channels/bioconda/packages/libis_moabs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/libis_moabs/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Dangertrip/LiBis
- **Stars**: N/A
### Original Help Text
```text
Program : /usr/local/bin/moabs
        Version : 1.3.9.6
        Contact : dsun@tamu.edu
        Usage : /usr/local/bin/moabs [options]
                --help	Help
                -i 	<str>	input files.
                --cf 	<str>	configuration file.
                --def 	<str>	overwrite definitions in configuration file. --def key=value
                -v	<boleen>	verbose output	[0 or 1, default 0]

Example: /usr/local/bin/moabs -i s1_r1_1.fq -i s1_r1_2.fq -i s1_r2_1.fq -i s1_r2_2.fq 
	      -i s2_r1_1.fq -i s2_r1_2.fq -i s2_r2_1.fq -i s2_r2_2.fq
Example: /usr/local/bin/moabs --cf myrun.cfg
Example: /usr/local/bin/moabs --cf myrun.cfg --def MMAP.Path=./bsmap/bsmap

Note:
1. Input files should be set by either `--cf` or `-i`. Inputs are FASTQ files.
They can be defined in the [INPUT] block in the configuration file by `--cf`.
They can be also specified by the option `-i`. Inputs by `-i` will ovewrite the
ones configured by `--cf`.

2. `--def` overwrites parameters defined in the configuration file.
Multiple-level parameters are connected by `.`. E.g., "--def TASK.Label=wt,ko
--def A=a --def B.C=z". However, `--def` can not overwrite inputs. Inputs are
specified only by `--cf` or `-i`.

3. Analysis blocks will be skipped for downstream analysis when result files
are observed. For example, BSMAP will be skipped when `SampleID.bam` is under the
current directory. MCALL will be skipped when `SampleID.G.bed` is observed.

4. TASK.Label is used in MCOMP only. While SampleID is used for BSMAP BAM and
MCALL BED filenames. SampleID is inferred from input names. Input names are
split by `_`, say sampleid_replicateid_layout. For example, "s1_r1_1=file_1.fastq.gz
s1_r1_2=file_2.fastq.gz" by `--cf`. Or `-i s1_r1_1.fastq.gz -i s1_r1_2.fastq.gz`.
```


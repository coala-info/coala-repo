# discasm CWL Generation Report

## discasm_DISCASM

### Tool Description
Performs de novo transcriptome assembly on discordant and unmapped reads

### Metadata
- **Docker Image**: quay.io/biocontainers/discasm:0.1.3--py27pl5.22.0_0
- **Homepage**: https://github.com/DISCASM/DISCASM
- **Package**: https://anaconda.org/channels/bioconda/packages/discasm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/discasm/overview
- **Total Downloads**: 11.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/DISCASM/DISCASM
- **Stars**: N/A
### Original Help Text
```text
TRINITY_HOME has been set to: /usr/local/bin/../opt/trinity-2.5.1.
usage: DISCASM [-h] --chimeric_junctions CHIMERIC_JUNCTIONS
               [--aligned_bam ALIGNED_BAM_FILENAME] --left_fq LEFT_FQ_FILENAME
               --right_fq RIGHT_FQ_FILENAME --out_dir STR_OUT_DIR
               --denovo_assembler DENOVO_ASSEMBLER
               [--add_trinity_params ADD_TRINITY_PARAMS] [--normalize_reads]

Performs de novo transcriptome assembly on discordant and unmapped reads

optional arguments:
  -h, --help            show this help message and exit
  --chimeric_junctions CHIMERIC_JUNCTIONS
                        STAR Chimeric.out.junction file
  --aligned_bam ALIGNED_BAM_FILENAME
                        aligned bam file from your favorite rna-seq alignment
                        tool
  --left_fq LEFT_FQ_FILENAME
                        left fastq file
  --right_fq RIGHT_FQ_FILENAME
                        right fastq file
  --out_dir STR_OUT_DIR
                        output directory
  --denovo_assembler DENOVO_ASSEMBLER
                        de novo assembly method: Trinity|Oases|OasesMultiK
  --add_trinity_params ADD_TRINITY_PARAMS
                        any additional parameters to pass on to Trinity if
                        Trinity is the chosen assembler.
  --normalize_reads     perform in silico normalization prior to de novo
                        assembly (not needed if using Trinity, since Trinity
                        performs normalization internally
```


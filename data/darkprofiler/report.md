# darkprofiler CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| darkprofiler_download | Not completed | Downloads a 1 GB genome bundle into the image's own package folder, so a CWL run cannot keep the result. |
| darkprofiler_run | Not completed | Needs the 1 GB genome bundle installed inside the image's package folder, which a plain CWL run does not have. |

## darkprofiler_download

### Tool Description
Download reference genome assemblies for darkprofiler.

### Metadata
- **Docker Image**: quay.io/biocontainers/darkprofiler:0.2.6--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/darkprofiler/
- **Package**: https://anaconda.org/channels/bioconda/packages/darkprofiler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/darkprofiler/overview
- **Total Downloads**: 60
- **Last updated**: 2026-02-06
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: darkprofiler download [-h] {hg19,hg38,mm10,mm39}

positional arguments:
  {hg19,hg38,mm10,mm39}
                        Reference assembly version to download.

options:
  -h, --help            show this help message and exit
```


## darkprofiler_run

### Tool Description
Run darkprofiler

### Metadata
- **Docker Image**: quay.io/biocontainers/darkprofiler:0.2.6--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/darkprofiler/
- **Package**: https://anaconda.org/channels/bioconda/packages/darkprofiler/overview
- **Validation**: PASS

### Original Help Text
```text
usage: darkprofiler run [-h] [--vcf-path VCF_PATH]
                        [--database-path DATABASE_PATH]
                        [--num-threads NUM_THREADS] [-k {0,1,2}]
                        {hg19,hg38,mm10,mm39} peptide_fasta output_dir

positional arguments:
  {hg19,hg38,mm10,mm39}
                        Reference assembly version to use (must be downloaded
                        first).
  peptide_fasta         Path to peptide FASTA file.
  output_dir            Output directory.

options:
  -h, --help            show this help message and exit
  --vcf-path VCF_PATH   Optional path to VCF or VCF.GZ file with SNVs.
  --database-path DATABASE_PATH
                        Optional path to existing database directory
                        containing canonicalProteome.fa,
                        alternativeSplicing.fa, mutanome.fa,
                        mutatedCanonicalTranscriptome.fa,
                        mutatedAlternativeTranslatome.fa, and other index
                        files
  --num-threads NUM_THREADS
                        Threads used for peptide search / verification.
  -k, --hamming {0,1,2}
                        Hamming distance allowed for peptide search (0=exact,
                        1, or 2). Default: 0.
```


## Metadata
- **Skill**: not generated


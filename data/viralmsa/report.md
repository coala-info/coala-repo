# viralmsa CWL Generation Report

## viralmsa_ViralMSA.py

### Tool Description
Reference-guided multiple sequence alignment of viral genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/viralmsa:1.1.46--hdfd78af_0
- **Homepage**: https://github.com/niemasd/ViralMSA
- **Package**: https://anaconda.org/channels/bioconda/packages/viralmsa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/viralmsa/overview
- **Total Downloads**: 9.5K
- **Last updated**: 2025-11-09
- **GitHub**: https://github.com/niemasd/ViralMSA
- **Stars**: N/A
### Original Help Text
```text
usage: ViralMSA.py [-h] -s SEQUENCES -r REFERENCE -o OUTPUT [-e EMAIL]
                   [-a ALIGNER] [-t THREADS] [-b BUFFER_SIZE] [-l]
                   [--omit_ref] [--stdout] [-q] [--viralmsa_dir VIRALMSA_DIR]
                   [-u]

ViralMSA: Reference-guided multiple sequence alignment of viral genomes

options:
  -h, --help            show this help message and exit
  -s, --sequences SEQUENCES
                        Input Sequences (FASTA format, or SAM if already
                        mapped) (default: None)
  -r, --reference REFERENCE
                        Reference (default: None)
  -o, --output OUTPUT   Output Directory (default: None)
  -e, --email EMAIL     Email Address (for Entrez) (default: None)
  -a, --aligner ALIGNER
                        Aligner (options: bowtie2, bwa, dragmap, hisat2, lra,
                        minimap2, mm2-fast, ngmlr, seq-align, star, unimap,
                        wfmash, winnowmap) (default: minimap2)
  -t, --threads THREADS
                        Number of Threads (default: 20)
  -b, --buffer_size BUFFER_SIZE
                        File Stream Buffer Size (bytes) (default: 1048576)
  -l, --list_references
                        List all reference sequences (default: False)
  --omit_ref            Omit reference sequence from output alignment
                        (default: False)
  --stdout              Write MSA to standard output instead of to file
                        (default: False)
  -q, --quiet           Suppress log output (default: False)
  --viralmsa_dir VIRALMSA_DIR
                        ViralMSA Cache Directory (default: /root/.viralmsa)
  -u, --update          Update ViralMSA (current version: 1.1.46) (default:
                        False)
```


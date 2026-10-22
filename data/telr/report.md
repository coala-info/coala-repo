# telr CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| telr | Failed | image problem: RepeatMasker in the image must rebuild its library under root-owned /usr/local/share and fails (permission denied / read-only), so telr stops after the long-read alignment |

## telr

### Tool Description
Program for detecting non-reference TEs in long read data

### Metadata
- **Docker Image**: quay.io/biocontainers/telr:1.1--pyhdfd78af_0
- **Homepage**: https://github.com/bergmanlab/telr
- **Package**: https://anaconda.org/channels/bioconda/packages/telr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/telr/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bergmanlab/telr
- **Stars**: N/A
### Original Help Text
```text
usage: telr [-h] -i READS -r REFERENCE -l LIBRARY [--aligner ALIGNER]
            [--assembler ASSEMBLER] [--polisher POLISHER] [-x PRESETS]
            [-p POLISH_ITERATIONS] [-o OUT] [-t THREAD] [-g GAP] [-v OVERLAP]
            [--flank_len FLANK_LEN] [--af_flank_interval AF_FLANK_INTERVAL]
            [--af_flank_offset AF_FLANK_OFFSET]
            [--af_te_interval AF_TE_INTERVAL] [--af_te_offset AF_TE_OFFSET]
            [--different_contig_name] [--minimap2_family] [-k]

Program for detecting non-reference TEs in long read data

required arguments:
  -i READS, --reads READS
                        reads in fasta/fastq format or read alignments in bam
                        format
  -r REFERENCE, --reference REFERENCE
                        reference genome in fasta format
  -l LIBRARY, --library LIBRARY
                        TE consensus sequences in fasta format

optional arguments:
  -h, --help            show this help message and exit
  --aligner ALIGNER     choose method for read alignment, please provide
                        'nglmr' or 'minimap2' (default = 'nglmr')
  --assembler ASSEMBLER
                        Choose the method to be used for local contig assembly
                        step, please provide 'wtdbg2' or 'flye' (default =
                        'wtdbg2')
  --polisher POLISHER   Choose the method to be used for local contig
                        polishing step, please provide 'wtdbg2' or 'flye'
                        (default = 'wtdbg2')
  -x PRESETS, --presets PRESETS
                        parameter presets for different sequencing
                        technologies, please provide 'pacbio' or 'ont'
                        (default = 'pacbio')
  -p POLISH_ITERATIONS, --polish_iterations POLISH_ITERATIONS
                        iterations of contig polishing (default = 1)
  -o OUT, --out OUT     directory to output data (default = '.')
  -t THREAD, --thread THREAD
                        max cpu threads to use (default = '1')
  -g GAP, --gap GAP     max gap size for flanking sequence alignment (default
                        = '20')
  -v OVERLAP, --overlap OVERLAP
                        max overlap size for flanking sequence alignment
                        (default = '20')
  --flank_len FLANK_LEN
                        flanking sequence length (default = '500')
  --af_flank_interval AF_FLANK_INTERVAL
                        5' and 3'flanking sequence interval size used for
                        allele frequency estimation (default = '100')
  --af_flank_offset AF_FLANK_OFFSET
                        5' and 3' flanking sequence offset size used for
                        allele frequency estimation (default = '200')
  --af_te_interval AF_TE_INTERVAL
                        5' and 3' te sequence interval size used for allele
                        frequency estimation (default: '50')
  --af_te_offset AF_TE_OFFSET
                        5' and 3' te sequence offset size used for allele
                        frequency estimation (default: '50')
  --different_contig_name
                        If provided then TELR does not require the contig name
                        to match before and after annotation liftover
                        (default: require contig name to be the same before
                        and after liftover)
  --minimap2_family     If provided then minimap2 will be used to annotate TE
                        families in the assembled contigs (default: use
                        repeatmasker for contig TE annotation)
  -k, --keep_files      If provided then all intermediate files will be kept
                        (default: remove intermediate files)
```


## Metadata
- **Skill**: generated


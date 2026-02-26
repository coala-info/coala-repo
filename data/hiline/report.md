# hiline CWL Generation Report

## hiline_HiLine

### Tool Description
A HiC alignment and classification pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/hiline:0.2.4--py39h8aee962_0
- **Homepage**: https://github.com/wtsi-hpag/HiLine
- **Package**: https://anaconda.org/channels/bioconda/packages/hiline/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hiline/overview
- **Total Downloads**: 44.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wtsi-hpag/HiLine
- **Stars**: N/A
### Original Help Text
```text
Usage: HiLine [OPTIONS] COMMAND1 [ARGS]... [COMMAND2 [ARGS]...]...

  HiLine version 0.2.4. A HiC alignment and classification pipeline. Copyright
  (c) 2020 Ed Harry, Wellcome Sanger Institute.

  Usage Example
  -------------
  HiLine params -t 32 Data/reference.fa.bgz Arima align-sam-reads Data/HiC_reads.cram valid-pairs Results/valid_pairs.cram save-stats Results/stats

  Required Commands
  -----------------
      params:                         set pipeline parameters

  Input Commands (one and only-one must be invoked)
  --------------
      read-sam:                       read in external alignment
      align-one-read:                 alignment with one interleaved (gzipped) FASTQ read source
      align-two-reads:                alignment with two (gzipped) FASTQ read sources
      align-sam-reads:                alignment with a SAM/BAM/CRAM read source
      index-only:                     just create and save a reference index

  Output Commands
  ---------------
      all-reads:                      alias for good-reads + bad-reads
      good-reads:                     alias for valid-pairs + invalid-reads
      valid-pairs:                    alias for valid-ff + valid-fr + valid-rf + valid-rr        
      valid-ff:                       valid ff read pairs
      valid-fr:                       valid fr read pairs
      valid-rf:                       valid rf read pairs
      valid-rr:                       valid rr read pairs
      invalid-reads:                  alias for invalid-pairs + dumped
      invalid-pairs:                  alias for self-circle + dangling-end + same-frag-and-strand + re-ligated
      self-circle:                    self-circular read pairs
      dangling-end:                   dangling-end read pairs
      same-frag-and-strand:           read pairs on the same restriction fragment and strand
      re-ligated:                     re-ligated read pairs
      dumped:                         dumped reads (good reads with a bad mate read)
      bad-reads:                      alias for low-mapq + too-far-from-restriction-site + bad-reference + unmapped + unpaired + supplementary + qc-fail + duplicate + secondary
      low-mapq:                       reads below minimum mapping quality
      too-far-from-restriction-site:  reads too far from a restriction site
      bad-reference:                  reads aligned to an invalid reference
      unmapped:                       unmapped reads
      unpaired:                       unpaired reads
      supplementary:                  supplementary reads
      qc-fail:                        qc-failed reads
      duplicate:                      duplicate reads
      secondary:                      secondary reads

  Saving Statistics
  -----------------    
      save-stats:                     save alignment statistics to disk

Options:
  --version  Show the version and exit.
  --help     Show this message and exit.

Commands:
  align-one-read                 Alignment with one read source.
  align-sam-reads                Alignment with SAM/BAM/CRAM reads.
  align-two-reads                Alignment with two read sources.
  all-reads                      Write all-reads to OUTPUT.
  bad-reads                      Write bad-reads to OUTPUT.
  bad-reference                  Write bad-reference reads to OUTPUT.
  dangling-end                   Write dangling-end reads to OUTPUT.
  dumped                         Write dumped reads to OUTPUT.
  duplicate                      Write duplicate reads to OUTPUT.
  good-reads                     Write good-reads to OUTPUT.
  index-only                     Alignment index only.
  invalid-pairs                  Write invalid-pairs to OUTPUT.
  invalid-reads                  Write invalid-reads to OUTPUT.
  low-mapq                       Write low-mapq reads to OUTPUT.
  params                         Sets pipeline parameters.
  qc-fail                        Write qc-fail reads to OUTPUT.
  re-ligated                     Write re-ligated reads to OUTPUT.
  read-sam                       Read in an external alignment.
  same-frag-and-strand           Write same-frag-and-strand reads to OUTPUT.
  save-stats                     Save alignment statistics to disk.
  secondary                      Write secondary reads to OUTPUT.
  self-circle                    Write self-circle reads to OUTPUT.
  supplementary                  Write supplementary reads to OUTPUT.
  too-far-from-restriction-site  Write too-far-from-restriction-site...
  unmapped                       Write unmapped reads to OUTPUT.
  unpaired                       Write unpaired reads to OUTPUT.
  valid-ff                       Write valid-ff reads to OUTPUT.
  valid-fr                       Write valid-fr reads to OUTPUT.
  valid-pairs                    Write valid-pairs to OUTPUT.
  valid-rf                       Write valid-rf reads to OUTPUT.
  valid-rr                       Write valid-rr reads to OUTPUT.
```


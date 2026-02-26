# portello CWL Generation Report

## portello

### Tool Description
Projects read alignments from personal assembly to reference

### Metadata
- **Docker Image**: quay.io/biocontainers/portello:0.7.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/portello
- **Package**: https://anaconda.org/channels/bioconda/packages/portello/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/portello/overview
- **Total Downloads**: 329
- **Last updated**: 2026-01-02
- **GitHub**: https://github.com/PacificBiosciences/portello
- **Stars**: N/A
### Original Help Text
```text
portello 0.7.0
Chris Saunders <csaunders@pacificbiosciences.com>
Projects read alignments from personal assembly to reference

Usage: portello [OPTIONS] --assembly-to-ref <FILE> --read-to-assembly <FILE> --remapped-read-output <FILE> --unassembled-read-output <FILE> --ref <FILE> --input-assembly-mode <MODE>

Options:
      --assembly-to-ref <FILE>
          Assembly contig to reference genome alignment file in BAM/CRAM format
          
          Alignment file must be sorted and indexed. Minimap2 or pbmm2 alignments can be used.

      --read-to-assembly <FILE>
          Read to assembly alignment file in BAM/CRAM format
          
          Alignment file must be sorted and indexed. Only pbmm2 alignments are supported for these alignments.

      --remapped-read-output <FILE>
          Filename to use for remapped read output, our '-' for stdout
          
          This file is written in unsorted BAM format. If written to stdout, this output will be uncompressed to optimize piping into samtools sort or similar method.
          
          Unmapped reads in this file have a good alignment to an assembly contig region which is not mappable to the reference, they should not be remapped to the reference sequence.

      --unassembled-read-output <FILE>
          Filename to use for unmapped reads which are not (well) mapped to any assembly contig
          
          This file is written in BAM format

      --ref <FILE>
          Genome reference in FASTA format

      --input-assembly-mode <MODE>
          The input assembly mode changes portello's strategy for phasing annotation in the reampped read output

          Possible values:
          - fully-phased:     Set this option if input assembly contigs are fully phased (by trio-binning, Hi-C, etc..) such that the assembly haplotypes should be trusted when making read phasing haplotags
          - partially-phased: Set this option if input assembly assembly contigs are psuedo-phased/dual-assembly output that we assume contain many haplotype swich errors. In this case read support will be used to segment smaller phase sets for read phasing haplotags

      --target-region <TARGET_REGION>
          Specify a target region for conversion
          
          This option is for debugging only, to allow fast test conversion of smaller regions. This will not give the same result as a non-targeted run with region selection on the sorted remapped read bam.

      --phased-het-vcf-prefix <PREFIX>
          Specify an output VCF prefix for phased heterozygous small variant calls from the input assembly contigs
          
          This option is only valid for the "partially-phased" input-assembly-mode, and is only intended for debugging and benchmarking the accuracy of the read haplotagging. Per this goal, only phase-eligible heterozygous variants are included in the output. It is intended to be used with a benchmarking tool such as whatshap compare.
          
          The output files produced by this option will be {PREFIX}.vcf.gz and {PREFIX}.vcf.gz.tbi

      --threads <THREAD_COUNT>
          Number of threads to use. Defaults to all logical cpus detected

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


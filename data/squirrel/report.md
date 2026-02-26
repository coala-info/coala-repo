# squirrel CWL Generation Report

## squirrel

### Tool Description
Some QUIck Rearranging to Resolve Evolutionary Links

### Metadata
- **Docker Image**: quay.io/biocontainers/squirrel:1.3.2--pyhdfd78af_0
- **Homepage**: https://github.com/aineniamh/squirrel
- **Package**: https://anaconda.org/channels/bioconda/packages/squirrel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/squirrel/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2026-01-28
- **GitHub**: https://github.com/aineniamh/squirrel
- **Stars**: N/A
### Original Help Text
```text
usage: squirrel <input> [options]

squirrel: Some QUIck Rearranging to Resolve Evolutionary Links

options:
  -h, --help            show this help message and exit

Input-Output options:
  input                 Input fasta file of sequences to analyse.
  -o, --outdir OUTDIR   Output directory. Default: current working directory
  --outfile OUTFILE     Optional output file name. Default: <input>.aln.fasta
  --tempdir TEMPDIR     Specify where you want the temp stuff to go. Default:
                        $TMPDIR
  --no-temp             Output all intermediate files, for dev purposes.
  --epi2me-outdir EPI2ME_OUTDIR
                        Output directory for report paths in epi2me.

Alignment options:
  -qc, --seq-qc         Flag potentially problematic SNPs and sequences.
                        Default: don't run QC
  --assembly-refs ASSEMBLY_REFS
                        References to check for `calls to reference` against.
  --no-mask             Skip masking of repetitive regions. Default: masks
                        repeat regions
  --no-itr-mask         Skip masking of end ITR. Default: masks ITR
  --additional-mask ADDITIONAL_MASK
                        Masking additional sites provided as a csv. Needs
                        columns `Maximum` and `Minimum` in 1-base.
  --sequence-mask SEQUENCE_MASK
                        Mask sites in specific sequences in the alignment as a
                        csv, rather than the whole alignment column. Needs
                        `sequence` and `site` (1-based) column.
  -ex, --exclude EXCLUDE
                        Supply a csv file listing sequences that should be
                        excluded from the analysis.
  --extract-cds         Extract coding sequences based on coordinates in the
                        reference
  --concatenate         Concatenate coding sequences for each genome,
                        separated by `NNN`. Default: write out as separate
                        records
  --clade CLADE         Specify whether the alignment is primarily for
                        `cladei` or `cladeii` (can also specify a or b, e.g.
                        `cladeia`, `cladeiib`). `split` will separate input
                        sequences into separate cladei and cladeii alignments.
                        This will determine reference used for alignment, mask
                        file and background set used if `--include-background`
                        flag used in conjunction with the `--run-phylo`
                        option. Default: `cladeii`

Phylo options:
  -p, --run-phylo       Run phylogenetics pipeline
  -a, --run-apobec3-phylo
                        Run phylogenetics & APOBEC3-mutation reconstruction
                        pipeline
  --outgroups OUTGROUPS
                        Specify which MPXV outgroup(s) in the alignment to use
                        in the phylogeny. These will get pruned out from the
                        final tree.
  -bg, --include-background
                        Include a default background set of sequences for the
                        phylogenetics pipeline. The set will be determined by
                        the `--clade` specified.
  -bf, --background-file BACKGROUND_FILE
                        Include this additional FASTA file as background to
                        the phylogenetics.
  -bm, --binary-partition-mask
                        Calculate and write binary partition mask
  --bm-separate-dimers  Write partition mask with 0 for non-apo, 1 for GA and
                        2 for TC target sites
  -at, --asr-tree ASR_TREE
                        Precomputed tree with ancestral states reconstructed
  -as, --asr-state ASR_STATE
                        Precomputed ancestral states file
  -aln, --asr-alignment ASR_ALIGNMENT
                        Precomputed alignment file

Tree figure options:
  -tfig, --tree-figure-only
                        Re-render tree figure custom height and width
                        arguments. Requires: tree file, branch reconstruction
                        file, height, width.
  -tf, --tree-file TREE_FILE
                        Tree for re-rendering the figure.
  -brf, --branch-reconstruction-file BRANCH_RECONSTRUCTION_FILE
                        Reconstruction file for re-rendering the figure.
  --fig-height FIG_HEIGHT
                        Overwrite tree figure default height.
  --fig-width FIG_WIDTH
                        Overwrite tree figure default width.
  --point-style POINT_STYLE
                        Shape of points for apobec3 reconstruction figure.
                        Options: circle, square. Default: circle
  --point-justify POINT_JUSTIFY
                        Justification of points for apobec3 reconstruction
                        figure. Options: left, right. Default: left
  --interactive-tree    Create a separate interactive file built from R
                        functions

Misc options:
  -v, --version         show program's version number and exit
  --verbose             Print lots of stuff to screen
  -t, --threads THREADS
                        Number of threads
```


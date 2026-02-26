# snipit CWL Generation Report

## snipit

### Tool Description
snipit

### Metadata
- **Docker Image**: quay.io/biocontainers/snipit:1.7--pyhdfd78af_0
- **Homepage**: https://github.com/aineniamh/snipit
- **Package**: https://anaconda.org/channels/bioconda/packages/snipit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snipit/overview
- **Total Downloads**: 14.8K
- **Last updated**: 2026-01-14
- **GitHub**: https://github.com/aineniamh/snipit
- **Stars**: N/A
### Original Help Text
```text
usage: snipit <alignment> [options]

snipit

options:
  -h, --help            show this help message and exit

Input options:
  alignment             Input alignment fasta file
  -t, --sequence-type {nt,aa}
                        Input sequence type: aa or nt
  -r, --reference REFERENCE
                        Indicates which sequence in the alignment is the
                        reference (by sequence ID). Default: first sequence in
                        alignment
  -l, --labels LABELS   Optional csv file of labels to show in output snipit
                        plot. Default: sequence names
  --l-header LABEL_HEADERS
                        Comma separated string of column headers in label csv.
                        First field indicates sequence name column, second the
                        label column. Default: 'name,label'

Mode options:
  --recombi-mode        Allow colouring of query seqeunces by mutations
                        present in two 'recombi-references' from the input
                        alignment fasta file
  --recombi-references RECOMBI_REFERENCES
                        Specify two comma separated sequence IDs in the input
                        alignment to use as 'recombi-references'. Ex.
                        Sequence_ID_A,Sequence_ID_B
  --cds-mode            Assumes sequence supplied is a coding sequence

Output options:
  -d, --output-dir OUTPUT_DIR
                        Output directory. Default: current working directory
  -o, --output-file OUTFILE
                        Output file name stem. Default: snp_plot
  -s, --write-snps      Write out the SNPs in a csv file.
  -f, --format FORMAT   Format options (png, jpg, pdf, svg, tiff) Default: png

Figure options:
  --height HEIGHT       Overwrite the default figure height
  --width WIDTH         Overwrite the default figure width
  --size-option SIZE_OPTION
                        Specify options for sizing. Options: expand, scale
  --solid-background    Force the plot to have a solid background, rather than
                        a transparent one.
  -c, --colour-palette 
                        Specify colour palette. Options: [classic,
                        classic_extended, primary, purine-pyrimidine,
                        greyscale, wes, verity, ugene]. Use ugene for protein
                        alignments.
  --flip-vertical       Flip the orientation of the plot so sequences are
                        below the reference rather than above it.
  --sort-by-mutation-number
                        Render the graph with sequences sorted by the number
                        of SNPs relative to the reference (fewest to most).
                        Default: False
  --sort-by-id          Sort sequences alphabetically by sequence id. Default:
                        False
  --sort-by-mutations SORT_BY_MUTATIONS
                        Sort sequences by bases at specified positions.
                        Positions are comma separated integers. Ex. '1,2,3'
  --high-to-low         If sorted by mutation number is selected, show the
                        sequences with the fewest SNPs closest to the
                        reference. Default: False
  --remove-site-text    Do not annotate text on the individual columns in the
                        figure.

SNP options:
  --show-indels         Include insertion and deletion mutations in snipit
                        plot.
  --include-positions INCLUDED_POSITIONS [INCLUDED_POSITIONS ...]
                        One or more range (closed, inclusive; one-indexed) or
                        specific position only included in the output. Ex.
                        '100-150' or Ex. '100 101' Considered before '--
                        exclude-positions'.
  --exclude-positions EXCLUDED_POSITIONS [EXCLUDED_POSITIONS ...]
                        One or more range (closed, inclusive; one-indexed) or
                        specific position to exclude in the output. Ex.
                        '100-150' or Ex. '100 101' Considered after '--
                        include-positions'.
  --ambig-mode {all,snps,exclude}
                        Controls how ambiguous bases are handled - [all]
                        include all ambig such as N,Y,B in all positions;
                        [snps] only include ambig if a snp is present at the
                        same position; [exclude] remove all ambig, same as
                        depreciated --exclude-ambig-pos

Misc options:
  -v, --version         show program's version number and exit
```


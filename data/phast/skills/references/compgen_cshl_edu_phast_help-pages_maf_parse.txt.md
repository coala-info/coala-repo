PROGRAM: maf\_parse
USAGE: maf\_parse [OPTIONS]
DESCRIPTION:
Reads a MAF file and perform various operations on it.
Performs parsing operations block-by-block whenever possible,
rather than storing entire alignment in memory.
Can extract a sub-alignment from an alignment (by row
or by column). Can extract features given GFF, BED, or
genepred file. Can also extract sub-features such as CDS1,2,3
or 4d sites. Can perform various functions such as gap
stripping or re-ordering of sequences. Capable of reading and
writing in a few common formats, but will not load input or output
alignments into memory if output format is MAF.
OPTIONS:
(Output format)
--out-format, -o MAF|PHYLIP|FASTA|MPM|SS
(Default MAF). Output file format. SS format is only
available un-ordered. Note that some options, which involve
reversing alignments based on strand, or stripping gaps,
cannot be output in MAF format and use FASTA by default.
Also note that when output format is not MAF, the entire
output must be loaded into memory.
--pretty, -p
Pretty-print alignment (use '.' when character matches
corresponding character in first sequence). Ignored if
--out-format SS is selected.
(Obtaining sub-alignments and re-ordering rows)
--start, -s
Start index of sub-alignment (indexing starts with 1).
Coordinates are in terms of the reference sequence unless
the --no-refseq option is used, in which case they are in
terms of alignment columns. Default is 1.
--end, -e
End index of sub-alignment. Default is length of alignment.
Coordinates defined as in --start option, above.
--seqs, -l
Comma-separated list of sequences to include (default)
exclude (if --exclude). Indicate by sequence number or name
(numbering starts with 1 and is evaluated \*after\* --order is
applied).
--exclude, -x
Exclude rather than include specified sequences.
--order, -O
Change order of rows in alignment to match sequence names
specified in name\_list. The first name in the alignment becomes
the reference sequence.
--no-refseq, -n
Do not assume first sequence in MAF is refseq. Instead, use
coordinates given by absolute position in alignment (starting
from 1).
(Splitting into multiple MAFs by length)
--split, -S length
Split MAF into pieces by length, and puts output in
outRootX.maf, where X=1,2,...,numPieces. outRoot can be
modified with --out-root, and the minimum number of digits in X
can be modified with --out-root-digits.
Splits between blocks, so that each output file does not exceed
specified length. By default, length is counted by distance
spanned in alignment by refseq, unless --no-refseq is specified.
--out-root, -r
Filename root for output files produced by --split (default
"maf\_parse").
--out-root-digits, -d
(for use with --split). The minimum number of digits used to
index each output file produced by split.
(Extracting features from MAF)
--features, -g
Annotations file. May be GFF, BED, or genepred format.
Coordinates assumed to be in frame of first sequence of
alignment (reference sequence). By default, outputs subset of
MAF which are labeled in annotations file. But can be used with
--by-category, --by-group, and/or --do-cats to split MAF by
annotation type. Or if used with --mask-features, is only used
to determine regions to mask. Implies --strip-i-lines,
--strip-e-lines
--by-category, -L
(Requires --features). Split by category, as defined by
annotations file and (optionally) category map (see --catmap).
--do-cats, -C
(For use with --by-category) Output sub-alignments for only the
specified categories.
--catmap, -c |
(Optionally use with --by-category) Mapping of feature types to
category numbers. Can either give a filename or an "inline"
description of a simple category map, e.g.,
--catmap "NCATS = 3 ; CDS 1-3" or
--catmap "NCATS = 1; UTR 1".
--by-group, -P
(Requires --features). Split by groups in annotation file, as
defined by specified tag.
(Masking by quality score)
--mask-bases, -b
Mask all bases with quality score <= n. Note that n is in the
same units as displayed in the MAF (ranging from 0-9), and
represents min(9, floor(PHRED\_score/5)). Bases without any
quality score will not be masked.
--masked-file, -m
(For use with --mask-bases). Write a file containing all the
regions masked for low quality. The file will be in 0-based
coordinates relative to the refseq, with an additional column
giving the name of the species masked. Note that low-quality bases
masked at alignment columns with a gap in the reference sequence
may not be represented in the output file.
--mask-features -M
(Requires --features). Mask all bases annotated in features in the
given species (can be a comma-delimited list of species). Note that
coordinates are always in terms of refseq, even if a different species
is being masked.
(Other)
--strip-i-lines, -I
Remove lines in MAF starting with i.
--strip-e-lines, -E
Remove lines in MAF starting with e.
--help, -h
Print this help message.
PROGRAM: refeature
DESCRIPTION: Read a file representing a set of features, optionally
alter the set in one or more of several possible ways, then
output it in the desired format. Input and output formats
may be GFF, BED, or genepred.
The input format is recognized automatically, but auto-
recognition requires a 'seekable' input stream (e.g., an
actual file rather than a pipe from stdin).
USAGE: /home/mt269/phast/bin/refeature [OPTIONS]
OPTIONS:
--include-only, -i
Include only features of the specified types (comma-delimited list);
filter out everything else.
--include-groups, -l
Include only groups whose names are listed in the specified file.
Group names in file must be delimited by white-space (can be on
any number of lines).
--sort, -s
Sort features primarily by start position and secondarily
by end position (usually has desired effect in case of short
overlapping features, e.g., start & stop codons). Features
will be sorted both across groups and within groups, but members
of a group will be kept together.
--unique, -u
Ensures that output contains no overlapping groups (or
subgroups, if -e). If groups overlap, the one with the highest
score (if available) or longest length (if no score) is kept and
others are discarded. Warning: long UTRs can have undesirable
results; filter out UTR exons to avoid.
--groupby, -g
Group features according to specified tag (default "transcript\_id")
--exongroup, -e
Sub-group features into contiguous sets, and define
sub-groups using specified tag (e.g., "exon\_id"). Can be
used to group the features describing individual exons, e.g.,
each CDS and its flanking splice sites. Only features in the
same major group will be included in the same minor group
(e.g., exons of the same transcript).
--fix-start-stop, -f
Ensure that CDS features include start codons and exclude stop
codons, as required by the GTF2 standard. Assumes at most one
start\_codon and at most one stop\_codon per group.
--add-utrs, -U
Create UTR features for portions of exons outside CDS (only
useful with GFF output; features must be grouped at level
of transcript).
--add-introns, -I
Create intron features between exons (only useful with GFF output;
features must be grouped at level of transcript).
--add-signals, -S
Adds features for start and stop codons and 3' and 5' splice
sites (only useful with GFF output; features must be grouped
at level of transcript). Start and stop codons will be added
as required by the GTF2 standard (--fix-start-stop is not
necessary). Warning: does not correctly handle case of splice
site in middle of start or stop codon.
--output, -o gff|bed|genepred|wig
Output format (default gff). Note that wig output is fixedStep
can only be used if all elements have a score and are of equal
length.
--simplebed, -b
(for use with --output bed) Create a separate line for each
feature in bed output (by default, all features of a group are
described by a single line).
--discards, -d
Write any discarded features to specified file.
--help, -h
Print this help message.
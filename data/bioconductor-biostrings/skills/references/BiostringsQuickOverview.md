Biostrings Quick Overview

Hervé Pagès
Fred Hutchinson Cancer Research Center
Seattle, WA

October 29, 2025

Most but not all functions defined in the Biostrings package are summarized here.

Function
length
names
[
head, tail
rev
c
width, nchar
==, !=
match, %in%
duplicated, unique
sort, order

relist, split, extractList

Description
Return the number of sequences in an object.
Return the names of the sequences in an object.
Extract sequences from an object.
Extract the first or last sequences from an object.
Reverse the order of the sequences in an object.
Combine in a single object the sequences from 2 or more objects.
Return the sizes (i.e. number of letters) of all the sequences in an object.
Element-wise comparison of the sequences in 2 objects.
Analog to match and %in% on character vectors.
Analog to duplicated and unique on character vectors.
Analog to sort and order on character vectors, except that the order-
ing of DNA or Amino Acid sequences doesn’t depend on the locale.
Analog to relist and split on character vectors, except that the re-
sult is a DNAStringSetList or AAStringSetList object. extractList is
a generalization of relist and split that supports arbitrary group-
ings.

Table 1: Low-level manipulation of DNAStringSet and AAStringSet objects.

Function
alphabetFrequency
letterFrequency

uniqueLetters
letterFrequencyInSlidingView

consensusMatrix
dinucleotideFrequency
trinucleotideFrequency
oligonucleotideFrequency
nucleotideFrequencyAt

(all

letters

the
only

letters
the

in
the
specified

Description
Tabulate
the
alphabetFrequency,
letterFrequency) in a sequence or set of sequences.
Extract the unique letters from a sequence or set of sequences.
Specialized version of letterFrequency that tallies the requested
letter frequencies for a fixed-width view that is conceptually slid along
the input sequence.
Computes the consensus matrix of a set of sequences.
Fast 2-mer, 3-mer, and k-mer counting for DNA or RNA.

alphabet
letters

for
for

Tallies the short sequences formed by extracting the nucleotides found
at a set of fixed positions from each sequence of a set of DNA or RNA
sequences.

Table 2: Counting / tabulating.

1

Function
reverse
complement
reverseComplement
translate
chartr
replaceAmbiguities
subseq, subseq<-
extractAt, replaceAt
replaceLetterAt
padAndClip, stackStrings
strsplit, unstrsplit

Description
Compute the reverse, complement, or reverse-complement, of a set of
DNA sequences.

Translate a set of DNA sequences into a set of Amino Acid sequences.
Replace letters in a sequence or set of sequences.

Extract/replace arbitrary substrings from/in a string or set of strings.

Replace the letters specified by a set of positions by new letters.
Pad and clip strings.
strsplit splits the sequences in a set of sequences according to a
pattern. unstrsplit is the reverse operation i.e. a fast implementation
of sapply(x, paste0, collapse=sep) for collapsing the list
elements of a DNAStringSetList or AAStringSetList object.

Table 3: Sequence transformation and editing.

Function
matchPattern
countPattern
vmatchPattern
vcountPattern
matchPDict
countPDict
whichPDict
vmatchPDict
vcountPDict
vwhichPDict

pairwiseAlignment

matchPWM
countPWM
trimLRPatterns
matchLRPatterns

matchProbePair

findPalindromes

Description
Find/count all the occurrences of a given pattern (typically short) in a
reference sequence (typically long). Support mismatches and indels.
Find/count all the occurrences of a given pattern (typically short) in a set
of reference sequences. Support mismatches and indels.
Find/count all the occurrences of a set of patterns in a reference sequence.
(whichPDict only identifies which patterns in the set have at least one
match.) Support a small number of mismatches.
[Note: vmatchPDict not implemented yet.] Find/count all the occur-
rences of a set of patterns in a set of reference sequences. (whichPDict
only identifies for each reference sequence which patterns in the set have
at least one match.) Support a small number of mismatches.
Solve (Needleman-Wunsch) global alignment, (Smith-Waterman) local
alignment, and (ends-free) overlap alignment problems.
Find/count all the occurrences of a Position Weight Matrix in a reference
sequence.
Trim left and/or right flanking patterns from sequences.
Find all paired matches in a reference sequence i.e. matches specified by
a left and a right pattern, and a maximum distance between them.
Find all the amplicons that match a pair of probes in a reference se-
quence.
Find palindromic regions in a sequence.

Table 4: String matching / alignments.

2

Function
readBStringSet
readDNAStringSet
readRNAStringSet
readAAStringSet
writeXStringSet
writePairwiseAlignments

readDNAMultipleAlignment
readRNAMultipleAlignment
readAAMultipleAlignment
write.phylip

Description
Read ordinary/DNA/RNA/Amino Acid sequences from files (FASTA or
FASTQ format).

Write sequences to a file (FASTA or FASTQ format).
Write pairwise alignments (as produced by pairwiseAlignment) to
a file (“pair” format).
Read multiple alignments from a file (FASTA, “stockholm”, or “clustal”
format).

Write multiple alignments to a file (Phylip format).

Table 5: I/O functions.

3


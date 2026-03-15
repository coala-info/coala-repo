# The MEME Suite

## Motif-based sequence analysis tools

## FASTA Sequence Format

### Description

Various MEME Suite programs require as input a file containing
sequences of [protein](alphabets.html#protein),
[DNA](alphabets.html#dna), [RNA](alphabets.html#rna)
or potentially some other [custom alphabet](alphabet-format.html).
These input files must be in FASTA format, which must be **plain text**,
not WORD, .doc, .docx, .rtf or any other word-processor format.

### Format Specification

Each FASTA entry consists of a sequence identifier line followed by
one or more sequence lines. The sequence identifier line begins with
the ">" character in column 1, which must be immediately followed
by a sequence identifier (ID). The
ID may be followed by an (optional) sequence description (COMMENT).
There may be no whitespace between the ">" and the ID, and whitespace
must separate the end of the ID from the COMMENT. The format looks like this:

```
>ID1 COMMENT
SEQUENCE
SEQUENCE
...
>ID2 COMMENT
SEQUENCE
...
```

Some rules about the sequence lines that follow the sequence identifier line:

* For the built-in alphabets like [DNA](alphabets.html#dna),
  [RNA](alphabets.html#rna) and
  [protein](alphabets.html#protein) case doesn't matter.
* White space (spaces and newlines) within the sequence are ignored.
* Characters should be from the alphabet in use which may be a
  [built-in standard](alphabets.html) or be
  [custom defined](alphabet-format.html).
* The end of a FASTA entry is indicated by the next sequence identifier line
  (starting with the ">" character in column 1), or by the end of the file.

Here is an example of three protein sequences in FASTA format:

```
>ICYA_MANSE
GDIFYPGYCPDVKPVNDFDLSAFAGAWHEIAKLPLENENQGKCTIAEYKY
DGKKASVYNSFVSNGVKEYMEGDLEIAPDAKYTKQGKYVMTFKFGQRVVN
LVPWVLATDYKNYAINYNCDYHPDKKAHSIHAWILSKSKVLEGNTKEVVD
NVLKTFSHLIDASKFISNDFSEAACQYSTTYSLTGPDRH

>LACB_BOVIN
MKCLLLALALTCGAQALIVTQTMKGLDIQKVAGTWYSLAMAASDISLLDA
QSAPLRVYVEELKPTPEGDLEILLQKWENGECAQKKIIAEKTKIPAVFKI
DALNENKVLVLDTDYKKYLLFCMENSAEPEQSLACQCLVRTPEVDDEALE
KFDKALKALPMHIRLSFNPTQLEEQCHI

>BBP_PIEBR
NVYHDGACPEVKPVDNFDWSNYHGKWWEVAKYPNSVEKYGKCGWAEYTPE
GKSVKVSNYHVIHGKEYFIEGTAYPVGDSKIGKIYHKLTYGGVTKENVFN
VLSTDNKNYIIGYYCKYDEDKKGHQDFVWVLSRSKVLTGEAKTAVENYLI
GSPVVDSQKLVYSDFSEAACKVN
```

### Weights (MEME-only extension)

When running MEME sequence weights may be specified in the dataset file
by special header lines where the unique name is "WEIGHTS" (all caps) and
the descriptive text is a list of sequence weights.

Sequence weights are numbers in the range 0 < w ≤ 1. All weights
are assigned in order to the sequences in the file. If there are more
sequences than weights, the remainder are given weight one. Weights may be
specified by more than one "WEIGHTS" entry which may appear anywhere in
the file. When weights are used, sequences will contribute to motifs in
proportion to their weights.

Here is an example for a file of three sequences where the first two
sequences are very similar and it is desired to down-weight them:

```
>WEIGHTS 0.5 .5 1.0
>seq1
GDIFYPGYCPDVKPVNDFDLSAFAGAWHEIAK
>seq2
GDMFCPGYCPDVKPVGDFDLSAFAGAWHELAK
>seq3
QKVAGTWYSLAMAASDISLLDAQSAPLRVYVEELKPTPEGDLEILLQKW
```
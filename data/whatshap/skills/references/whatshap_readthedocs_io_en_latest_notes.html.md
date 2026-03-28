[whatshap](index.html)

* [Installation](installation.html)
* [User guide](guide.html)
* [Questions and Answers](faq.html)
* [Contributing](develop.html)
* Various notes
  + [Allele detection with re-alignment](#allele-detection-with-re-alignment)
    - [Insertion next to a SNP](#insertion-next-to-a-snp)
    - [Ambiguous](#ambiguous)
* [How to cite](howtocite.html)
* [Changes](changes.html)

[whatshap](index.html)

* Various notes
* [View page source](_sources/notes.rst.txt)

---

# Various notes[](#various-notes "Link to this heading")

* There is a step in which variants are re-discovered in the BAM file. This may
  fail when the variant caller has used some type of re-alignment (as
  freebayes does). Would be better to integrate this into the variant caller or
  to get the information out of it. This applies only to indels, which are not
  supported right now anyway.
* Input format for HapCompass: <http://www.brown.edu/Research/Istrail_Lab/resources/hapcompass_manual.html#sec11>

## Allele detection with re-alignment[](#allele-detection-with-re-alignment "Link to this heading")

WhatsHap can detect which allele a read contains at a variant position by
aligining a part of the read to the two possible haplotypes. The haplotype
for which the alignment is better wins.

Allele detection through re-alignment is enabled when the `--reference`
parameter is used on the command-line.

Re-alignment in this version detects slightly *fewer* alleles than the old
algorithm, but this is typically justified because the old algorithm gave
wrong results. Re-alignment however correctly detects that both haplotypes are
equally good and then refuses to choose.

The alignment algorithm uses edit distance at the moment, which allows us to
detect alleles correctly most of the time, but does not allow us to make use
of base qualities (in fact, the weighted algorithm degenerates into an
unweighted one). To fix this, we need a better alignment algorithm.

Here are some examples for how re-alignment works.

### Insertion next to a SNP[](#insertion-next-to-a-snp "Link to this heading")

Haplotypes:

```
ref:   CCTTAGT
alt:   CCTCAGT
```

Alignment as reported in BAM file:

```
ref:   CCT-TAGT
query: CCTCAAGT
```

The second `T` is aligned to an `A`, which is not one of the expected bases.
Thus, no variant would be detected here.

Re-aligning the query to the “alt” haplotype, we get:

```
alt:   CCTCA-GT
query: CCTCAAGT
```

This alignment has lower cost and we therefore detect that the allele in this
read is probably the alternative one.

### Ambiguous[](#ambiguous "Link to this heading")

This was previously detected incorrectly:

```
ref:   TGCTTTAAGG
alt:   TGCTTTCAGG
query: TGCCTTCAAGG
```

Two possible alignments are

```
ref:   TGC-TTTAAGG
query: TGCCTTCAAGG
```

and

```
alt:   TGCTTTCA-GG
query: TGCCTTCAAGG
```

Both have cost two and therefore the correct allele is unclear.

[Previous](develop.html "Contributing")
[Next](howtocite.html "How to cite")

---

© Copyright 2014.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).
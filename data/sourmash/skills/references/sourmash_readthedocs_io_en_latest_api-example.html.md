# [`sourmash` Python API examples](#id1)[¶](#sourmash-python-api-examples "Link to this heading")

All of sourmash’s functionality is available via its [Python API](api.html). Below are both basic and advanced examples that use the API to accomplish common tasks.

Contents

* [`sourmash` Python API examples](#sourmash-python-api-examples)

  + [A first example: two k-mers](#a-first-example-two-k-mers)
  + [Introduction: k-mers, molecule types, and hashing.](#introduction-k-mers-molecule-types-and-hashing)
  + [Set operations on hashes](#set-operations-on-hashes)
  + [Creating MinHash sketches programmatically, from genome files](#creating-minhash-sketches-programmatically-from-genome-files)
  + [Plotting dendrograms and matrices](#plotting-dendrograms-and-matrices)
  + [Saving and loading signature files](#saving-and-loading-signature-files)
  + [Going from signatures back to MinHash objects and their hashes -](#going-from-signatures-back-to-minhash-objects-and-their-hashes)
  + [Advanced features of sourmash MinHash objects - `scaled` and `num`](#advanced-features-of-sourmash-minhash-objects-scaled-and-num)
  + [Working with indexed collections of signatures](#working-with-indexed-collections-of-signatures)

## [A first example: two k-mers](#id2)[¶](#a-first-example-two-k-mers "Link to this heading")

Define two sequences:

```
>>> seq1 = "ATGGCA"
>>> seq2 = "AGAGCA"
```

Create two MinHashes using 3-mers, and add the sequences:

```
>>> import sourmash
>>> mh1 = sourmash.MinHash(n=0, ksize=3, scaled=1)
>>> mh1.add_sequence(seq1)
```

```
>>> mh2 = sourmash.MinHash(n=0, ksize=3, scaled=1)
>>> mh2.add_sequence(seq2)
```

One of the 3-mers (out of 7) overlaps, so Jaccard index is 1/7:

```
>>> round(mh1.jaccard(mh2), 2)
0.14
```

and of course the MinHashes match themselves:

```
>>> mh1.jaccard(mh1)
1.0
```

We can add sequences to the MinHash objects and query at any time –

```
>>> mh1.add_sequence(seq2)
>>> x = mh1.jaccard(mh2)
>>> round(x, 3)
0.571
```

## [Introduction: k-mers, molecule types, and hashing.](#id3)[¶](#introduction-k-mers-molecule-types-and-hashing "Link to this heading")

### DNA k-mers[¶](#dna-k-mers "Link to this heading")

The basis of sourmash is k-mers. Suppose we have a 35 base DNA sequence, and
we break it into four 31-mers:

```
>>> K = 31
>>> dnaseq = "ATGCGAGTGTTGAAGTTCGGCGGTACATCAGTGGC"
>>> for i in range(0, len(dnaseq) - K + 1):
...    kmer = dnaseq[i:i+K]
...    print(i, kmer)
0 ATGCGAGTGTTGAAGTTCGGCGGTACATCAG
1 TGCGAGTGTTGAAGTTCGGCGGTACATCAGT
2 GCGAGTGTTGAAGTTCGGCGGTACATCAGTG
3 CGAGTGTTGAAGTTCGGCGGTACATCAGTGG
4 GAGTGTTGAAGTTCGGCGGTACATCAGTGGC
```

sourmash uses a hash function (by default MurmurHash) that converts
each k-mer into 64-bit numbers. These numbers form the basis of everything
else sourmash does; the k-mer strings are not used internally at all.

The easiest way to access the hash
function is via the `seq_to_hashes` method on `MinHash` objects, which
returns a list:

```
>>> from sourmash import MinHash
>>> mh = MinHash(n=0, ksize=K, scaled=1)
>>> for i in range(0, len(dnaseq) - K + 1):
...    kmer = dnaseq[i:i+K]
...    print(i, kmer, mh.seq_to_hashes(kmer))
0 ATGCGAGTGTTGAAGTTCGGCGGTACATCAG [7488148386897425535]
1 TGCGAGTGTTGAAGTTCGGCGGTACATCAGT [3674733966066518639]
2 GCGAGTGTTGAAGTTCGGCGGTACATCAGTG [2135725670290847794]
3 CGAGTGTTGAAGTTCGGCGGTACATCAGTGG [14521729668397845245]
4 GAGTGTTGAAGTTCGGCGGTACATCAGTGGC [15919051675656106963]
```

Note that this is the same as using the MurmurHash hash function with a seed
of 42 and taking the first 64 bits.

Because DNA is double-stranded and has no inherent directionality, but
computers represent DNA with only one strand, it’s important for
sourmash to represent both strands. sourmash does this by building a
canonical representation for each k-mer so that reverse-complement
sequences match to their forward sequence.

Underneath, sourmash DNA hashing does this by taking each k-mer,
building the reverse complement, choosing the lexicographically lesser of
the two, and then hashes it - for example, for the first and second
k-mers above, you get:

```
>>> from sourmash.minhash import hash_murmur
>>> from screed import rc
>>> kmer_1 = "ATGCGAGTGTTGAAGTTCGGCGGTACATCAG"
>>> hash_murmur(kmer_1)
7488148386897425535
>>> hash_murmur(kmer_1) == mh.seq_to_hashes(kmer_1)[0]
True
>>> kmer_2 = "TGCGAGTGTTGAAGTTCGGCGGTACATCAGT"
>>> hash_murmur(kmer_2)
6388498842523164783
>>> kmer_2_rc = rc(kmer_2)
>>> kmer_2_rc
'ACTGATGTACCGCCGAACTTCAACACTCGCA'
>>> hash_murmur(kmer_2_rc) == mh.seq_to_hashes(kmer_2)[0]
True
```

where the second k-mer’s reverse complement starts with ‘A’ and is therefore
chosen for hashing by sourmash. This method was chosen to be compatible
with [mash](https://mash.readthedocs.io/.

### Protein-based encodings[¶](#protein-based-encodings "Link to this heading")

By default, `MinHash` objects work with DNA. However, sourmash
supports amino acid, Dayhoff, and hydrophobic-polar (hp) encodings as
well. The Dayhoff and hp encodings support degenerate
matching that is less stringent than exact matches.

The simplest way to use a protein `MinHash` object is to create one and
call `add_protein` on it –

```
>>> K = 7
>>> mh = MinHash(0, K, is_protein=True, scaled=1)
>>> protseq = "MVKVYAPAS"
>>> mh.add_protein(protseq)
```

This creates three 7-mers from the sequence and hashes them:

```
>>> list(sorted(mh.hashes))
[5834377656419371297, 8846570680426381265, 10273850291677879123]
```

As with DNA k-mers, above, you can also use `seq_to_hashes` to generate
the hashes for protein k-mers, if you add the `is_protein=True` flag:

```
>>> for i in range(0, len(protseq) - K + 1):
...    kmer = protseq[i:i+K]
...    print(i, kmer, mh.seq_to_hashes(kmer, is_protein=True))
0 MVKVYAP [5834377656419371297]
1 VKVYAPA [10273850291677879123]
2 KVYAPAS [8846570680426381265]
```

In this case, the k-mers are always hashed in the forward direction
(because protein sequence always has an orientation, unlike DNA).

sourmash also supports the
[Dayhoff](https://en.wikipedia.org/wiki/Margaret_Oakley_Dayhoff#Table_of_Dayhoff_encoding_of_amino_acids)
and hydrophobic-polar encodings; here, amino acids are first mapped to
their encodings and then hashed. So, for example, the amino acid sequence
`CADHIF*` is mapped to `abcdef*` in the Dayhoff encoding:

```
>>> mh = MinHash(0, K, dayhoff=True, scaled=1)
>>> h1 = mh.seq_to_hashes('CADHIF*', is_protein=True)[0]
>>> h1
12061624913065022412
>>> h1 == hash_murmur('abcdef*')
True
```

### Translating DNA into protein-based encodings.[¶](#translating-dna-into-protein-based-encodings "Link to this heading")

If you use `add_sequence(...)` to add DNA sequence to a protein encoding,
or call `seq_to_hashes(...)` on a protein encoding without `is_protein=True`,
sourmash will *translate* the sequences in all possible reading frames
and hash the translated amino acids. The k-mer size for the `MinHash`
is used as the k-mer size of the amino acids, i.e. 7 aa is 21 DNA bases.

```
>>> dnaseq = "ATGCGAGTGTTGAAGTTCGGCGGTACATCAGTGGC"
>>> len(dnaseq)
35
>>> K = 7
>>> mh = MinHash(n=0, ksize=K, is_protein=True, scaled=1)
>>> mh.add_sequence(dnaseq)
>>> len(mh)
30
```

Here, 30 hashes are added to the `MinHash` object because we are starting
with a 35 base DNA sequence, and using 21-mers of DNA (7-mer of protein),
which give us 15 distinct 21-mers in the three forward frames, and
15 distinct 21-mers in the three reverse-complement frames, for a total
of 30.

If a dayhoff or hp `MinHash` object is used, then `add_sequence(...)`
will first translate each sequence into protein space in all six frames,
and then further encode the sequences into Dayhoff or hp encodings.

### Invalid characters in DNA and protein sequences[¶](#invalid-characters-in-dna-and-protein-sequences "Link to this heading")

sourmash detects invalid DNA characters (non-ACTG) and raises an
exception on `add_sequence`, unless `force=True`, in which case
k-mers containing invalid characters are ignored.

```
>>> dnaseq = "nTGCGAGTGTTGAAGTTCGGCGGTACATCAGTGGC"
>>> K = 31
>>> mh = MinHash(n=0, ksize=K, scaled=1)
>>> mh.add_sequence(dnaseq)
Traceback (most recent call last):
    ...
ValueError: invalid DNA character in input k-mer: NTGCGAGTGTTGAAGTTCGGCGGTACATCAG
>>> mh.add_sequence(dnaseq, force=True)
>>> len(mh)
4
```

For protein sequences, sourmash does not currently do any invalid
character detection; k-mers are hashed as they are, and can only be
matched by an identical k-mer (with the same invalid character).
(Please [file an issue](https://github.com/sourmash-bio/sourmash/issues) if
you’d like us to change this!)

```
>>> K = 7
>>> mh = MinHash(n=0, ksize=K, is_protein=True, scaled=1)
>>> protseq = "XVKVYAPAS"
>>> mh.add_protein(protseq)
>>> len(mh)
3
```

For the Dayhoff and hp encodings on top of amino acids, invalid amino
acids (any letter for which no encoded character exists) are replaced with
‘X’.

```
>>> K = 7
>>> mh = MinHash(n=0, ksize=K, dayhoff=True, scaled=1)
>>> protseq1 = ".VKVYAPAS"
>>> hashes1 = mh.seq_to_hashes(protseq1, is_protein=True)
>>> protseq2 = "XVKVYAPAS"
>>> hashes2 = mh.seq_to_hashes(protseq2, is_protein=True)
>>> hashes1 == hashes2
True
```

### Extracting both k-mers and hashes for a sequence[¶](#extracting-both-k-mers-and-hashes-for-a-sequence "Link to this heading")

As of sourmash 4.2.2, `MinHash` objects provide a method called
`kmers_and_hashes` that will return the k-mers and their corresponding
hashes for an input sequence –

```
>>> mh = MinHash(n=0, ksize=31, scaled=1)
>>> dnaseq = "ATGCGAGTGTTGAAGTTCGGCGGTACATCAGTGGC"
>>> for kmer, hashval in mh.kmers_and_hashes(dnaseq):
...    print(kmer, hashval)
ATGCGAGTGTTGAAGTTCGGCGGTACATCAG 7488148386897425535
TGCGAGTGTTGAAGTTCGGCGGTACATCAGT 3674733966066518639
GCGAGTGTTGAAGTTCGGCGGTACATCAGTG 2135725670290847794
CGAGTGTTGAAGTTCGGCGGTACATCAGTGG 14521729668397845245
GAGTGTTGAAGTTCGGCGGTACATCAGTGGC 15919051675656106963
```

This works for protein `MinHash` objects as well, of course, although
you have to provide the `is_protein` flag, since `MinHash` objects assume
input sequence is DNA otherwise –

```
>>> K = 7
>>> mh = MinHash(n=0, ksize=K, is_protein=True, scaled=1)
>>> protseq = "XVKVYAPAS"
>>> for (kmer, hashval) in mh.kmers_and_hashes(protseq, is_protein=True):
...     print(kmer, hashval)
XVKVYAP 3140823561012061964
VKVYAPA 10273850291677879123
KVYAPAS 8846570680426381265
```

For translated `MinHash`, the k-mers and hashes corresponding to all
six reading frames are returned.

```
>>> dnaseq = "ATGCGAGTGTTGAAGTTCGGCGGTA"
>>> K = 7
>>> mh = MinHash(n=0, ksize=K, is_protein=True, scaled=1)
>>> for (kmer, hashval) in mh.kmers_and_hashes(dnaseq):
...    print(kmer, hashval)
ATGCGAGTGTTGAAGTTCGGC 16652503548557650904
CGAGTGTTGAAGTTCGGCGGT 9978056796243419534
TACCGCCGAACTTCAACACTC 2748622134668949083
CGCCGAACTTCAACACTCGCA 4263227699724621735
TGCGAGTGTTGAAGTTCGGCG 14299765336094039482
GAGTGTTGAAGTTCGGCGGTA 18155608748862746902
ACCGCCGAACTTCAACACTCG 14490181201772650983
GCCGAACTTCAACACTCGCAT 17205086974168937105
GCGAGTGTTGAAGTTCGGCGG 13354527969598897281
CCGCCGAACTTCAACACTCGC 16506504121672505595
```

In all cases, the k-mers are taken from the sequence itself, so the
k-mers will match to the input sequence, even when there are multiple
k-mers that hash to the same value (e.g. in the case of reverse
complements, or DNA k-mers that are translated to the same amino acid
sequence).

Note that sourmash also provides a `translate_codon` function if you
need to get the specific amino acids -

```
>>> from sourmash.minhash import translate_codon
>>> kmer = 'ATGCGAGT'
>>> for start in range(0, len(kmer) - 3 + 1, 3):
...    codon = kmer[start:start+3]
...    print(codon, translate_codon(codon))
ATG M
CGA R
```

### Summary[¶](#summary "Link to this heading")

In sum,

* `MinHash.add_sequence(...)` converts DNA sequence into DNA or protein k-mers, and then hashes them and stores them.
* `MinHash.add_protein(...)` converts protein sequence into protein k-mers, and then hashes them and stores them.
* `MinHash.seq_to_hashes(...)` will give you the hash values without adding them to the `MinHash` object.
* `MinHash.kmers_and_hashes(...)` will provide tuples of `(kmer, hashval)` for an input sequence.
* The `dayhoff` and `hp` encodings can be calculated on amino acid k-mers as well, using `MinHash` objects.

Note that this is the code that is used by the command-line
functionality in `sourmash sketch`, so the results at the command-line
will match the results from the Python API.

## [Set operations on hashes](#id4)[¶](#set-operations-on-hashes "Link to this heading")

All of the hashes in a `MinHash` object are available via the `hashes`
property:

```
>>> mh1 = sourmash.MinHash(n=0, ksize=3, scaled=1)
>>> seq1 = "ATGGCA"
>>> mh1.add_sequence(seq1)
>>> seq2 = "AGAGCA"
>>> mh1.add_sequence(seq2)
>>> list(mh1.hashes)
[1274996984489324440, 2529443451610975987, 3115010115530738562, 5059920851104263793, 5740495330885152257, 8652222673649005300, 18398176440806921933]
```

and you can easily do your own set operations with `.hashes` - e.g.
the following calculates the Jaccard similarity (intersection over union) of two

```
>>> s1 = set(mh1.hashes)
>>> s2 = set(mh2.hashes)
>>> round(len(s1 & s2) / len(s1 | s2), 3)
0.571
```

However, the MinHash class also supports a number of basic operations - the following operations work directly on the hashes:

```
>>> combined = mh1 + mh2
>>> combined += mh1
>>> combined.remove_many(mh1.hashes)
>>> combined.add_many(mh2.hashes)
```

You can create an empty copy of a MinHash object with `copy_and_clear`:

```
>>> new_mh = mh1.copy_and_clear()
```

and you can also access the various parameters of a MinHash object directly as properties –

```
>>> mh1.ksize
3
>>> mh1.scaled
1
>>> mh1.num
0
>>> mh1.is_dna
True
>>> mh1.is_protein
False
>>> mh1.dayhoff
False
>>> mh1.hp
False
>>> mh1.moltype
'DNA'
```

see the “Advanced” section, below, for a more complete discussion of MinHash objects.

## [Creating MinHash sketches programmatically, from genome files](#id5)[¶](#creating-minhash-sketches-programmatically-from-genome-files "Link to this heading")

Suppose we want to create MinHash sketches from genomes –

```
>>> import glob, pprint
>>> genomes = glob.glob('data/GCF*.fna.gz')
>>> genomes = list(sorted(genomes))
>>> pprint.pprint(genomes)
['data/GCF_000005845.2_ASM584v2_genomic.fna.gz',
 'data/GCF_000006945.1_ASM694v1_genomic.fna.gz',
 'data/GCF_000783305.1_ASM78330v1_genomic.fna.gz']
```

We have to read them in (here using screed), but then they can be fed
into `add_sequence` directly; here we set `force=True` in `add_sequence`
to skip over k-mers containing characters other than ACTG, rather than
raising an exception.

(Note, just for speed reasons, we’re truncating the sequences to 50kb in length.)

```
>>> import screed
>>> minhashes = []
>>> for g in genomes:
...     mh = sourmash.MinHash(n=500, ksize=31)
...     for record in screed.open(g):
...         mh.add_seq
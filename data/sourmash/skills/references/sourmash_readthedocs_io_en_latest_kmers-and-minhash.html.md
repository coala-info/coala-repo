# An introduction to k-mers for genome comparison and analysis[¶](#An-introduction-to-k-mers-for-genome-comparison-and-analysis "Link to this heading")

k-mers provide sensitive and specific methods for comparing and analyzing genomes.

This notebook provides pure Python implementations of some of the basic k-mer comparison techniques implemented in sourmash, including hash-based subsampling techniques.

## Running this notebook.[¶](#Running-this-notebook. "Link to this heading")

You can run this notebook interactively via mybinder; click on this button: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/dib-lab/sourmash/latest?labpath=doc%2Fkmers-and-minhash.ipynb)

A rendered version of this notebook is available at [sourmash.readthedocs.io](https://sourmash.readthedocs.io) under “Tutorials and notebooks”.

You can also get this notebook from the [doc/ subdirectory of the sourmash github repository](https://github.com/dib-lab/sourmash/tree/latest/doc). See [binder/environment.yaml](https://github.com/dib-lab/sourmash/blob/latest/binder/environment.yml) for installation dependencies.

## What is this?[¶](#What-is-this? "Link to this heading")

This is a Jupyter Notebook using Python 3. If you are running this via [binder](https://mybinder.org), you can use Shift-ENTER to run cells, and double click on code cells to edit them.

Contact: C. Titus Brown, ctbrown@ucdavis.edu. Please [file issues on GitHub](https://github.com/dib-lab/sourmash/issues/) if you have any questions or comments!

### Calculating Jaccard similarity and containment[¶](#Calculating-Jaccard-similarity-and-containment "Link to this heading")

Given any two collections of k-mers, we can calculate similarity and containment using the union and intersection functionality in Python.

```
[1]:
```

```
def jaccard_similarity(a, b):
    a = set(a)
    b = set(b)

    intersection = len(a.intersection(b))
    union = len(a.union(b))

    return intersection / union
```

```
[2]:
```

```
def jaccard_containment(a, b):
    a = set(a)
    b = set(b)

    intersection = len(a.intersection(b))

    return intersection / len(a)
```

### Let’s try these functions out on some simple examples![¶](#Let's-try-these-functions-out-on-some-simple-examples! "Link to this heading")

```
[3]:
```

```
a = ["ATGG", "AACC"]
b = ["ATGG", "CACA"]
c = ["ATGC", "CACA"]
```

```
[4]:
```

```
jaccard_similarity(a, a)
```

```
[4]:
```

```
1.0
```

```
[5]:
```

```
jaccard_containment(a, a)
```

```
[5]:
```

```
1.0
```

```
[6]:
```

```
jaccard_similarity(b, a)
```

```
[6]:
```

```
0.3333333333333333
```

```
[7]:
```

```
jaccard_similarity(a, c)
```

```
[7]:
```

```
0.0
```

```
[8]:
```

```
jaccard_containment(b, a)
```

```
[8]:
```

```
0.5
```

```
[9]:
```

```
%matplotlib inline
from matplotlib_venn import venn2, venn3

venn2([set(a), set(b)])
```

```
[9]:
```

```
<matplotlib_venn._common.VennDiagram at 0x132a99340>
```

![_images/kmers-and-minhash_12_1.png](_images/kmers-and-minhash_12_1.png)

```
[10]:
```

```
venn3([set(a), set(b), set(c)])
```

```
[10]:
```

```
<matplotlib_venn._common.VennDiagram at 0x132c42430>
```

![_images/kmers-and-minhash_13_1.png](_images/kmers-and-minhash_13_1.png)

### Calculating k-mers from DNA sequences[¶](#Calculating-k-mers-from-DNA-sequences "Link to this heading")

To extract k-mers from DNA sequences, we walk over the sequence with a sliding window:

```
[11]:
```

```
def build_kmers(sequence, ksize):
    kmers = []
    n_kmers = len(sequence) - ksize + 1

    for i in range(n_kmers):
        kmer = sequence[i : i + ksize]
        kmers.append(kmer)

    return kmers
```

```
[12]:
```

```
build_kmers("ATGGACCAGATATAGGGAGAGCCAGGTAGGACA", 21)
```

```
[12]:
```

```
['ATGGACCAGATATAGGGAGAG',
 'TGGACCAGATATAGGGAGAGC',
 'GGACCAGATATAGGGAGAGCC',
 'GACCAGATATAGGGAGAGCCA',
 'ACCAGATATAGGGAGAGCCAG',
 'CCAGATATAGGGAGAGCCAGG',
 'CAGATATAGGGAGAGCCAGGT',
 'AGATATAGGGAGAGCCAGGTA',
 'GATATAGGGAGAGCCAGGTAG',
 'ATATAGGGAGAGCCAGGTAGG',
 'TATAGGGAGAGCCAGGTAGGA',
 'ATAGGGAGAGCCAGGTAGGAC',
 'TAGGGAGAGCCAGGTAGGACA']
```

In the k-mers that are output, you can see how the sequence shifts to the right - look at the pattern in the middle.

So, now, you can compare two sequences!

```
[13]:
```

```
seq1 = "ATGGACCAGATATAGGGAGAGCCAGGTAGGACA"
seq2 = "ATGGACCAGATATTGGGAGAGCCGGGTAGGACA"
# differences:       ^         ^
```

```
[14]:
```

```
K = 10
kmers1 = build_kmers(seq1, K)
kmers2 = build_kmers(seq2, K)

print(K, jaccard_similarity(kmers1, kmers2))
```

```
10 0.09090909090909091
```

### Reading k-mers in from a file[¶](#Reading-k-mers-in-from-a-file "Link to this heading")

In practice, we often need to work with 100s of thousands of k-mers, and this means loading them in from sequences in files.

There are three cut-down genome files in the `genomes/` directory that we will use below:

```
akkermansia.fa
shew_os185.fa
shew_os223.fa
```

The latter two are two strains of *Shewanella baltica*, and the first one is an unrelated genome *Akkermansia muciniphila*.

```
[15]:
```

```
import screed  # a library for reading in FASTA/FASTQ

def read_kmers_from_file(filename, ksize):
    all_kmers = []
    for record in screed.open(filename):
        sequence = record.sequence

        kmers = build_kmers(sequence, ksize)
        all_kmers += kmers

    return all_kmers
```

```
[16]:
```

```
akker_kmers = read_kmers_from_file("genomes/akkermansia.fa", 31)
```

```
[17]:
```

```
akker_kmers[:5]
```

```
[17]:
```

```
['AAATCTTATAAAATAACCACATAACTTAAAA',
 'AATCTTATAAAATAACCACATAACTTAAAAA',
 'ATCTTATAAAATAACCACATAACTTAAAAAG',
 'TCTTATAAAATAACCACATAACTTAAAAAGA',
 'CTTATAAAATAACCACATAACTTAAAAAGAA']
```

```
[18]:
```

```
print(len(akker_kmers))
```

```
499970
```

```
[19]:
```

```
shew1_kmers = read_kmers_from_file("genomes/shew_os185.fa", 31)
shew2_kmers = read_kmers_from_file("genomes/shew_os223.fa", 31)
```

We can see the relationship between these three like so:

```
[20]:
```

```
print("akker vs shew1", jaccard_similarity(akker_kmers, shew1_kmers))
print("akker vs shew2", jaccard_similarity(akker_kmers, shew2_kmers))
print("shew1 vs shew2", jaccard_similarity(shew1_kmers, shew2_kmers))
```

```
akker vs shew1 0.0
akker vs shew2 0.0
shew1 vs shew2 0.23675152210020398
```

```
[21]:
```

```
print("akker vs shew1", jaccard_containment(akker_kmers, shew1_kmers))
print("akker vs shew2", jaccard_containment(akker_kmers, shew2_kmers))
print("shew1 vs shew2", jaccard_containment(shew1_kmers, shew2_kmers))
```

```
akker vs shew1 0.0
akker vs shew2 0.0
shew1 vs shew2 0.38397187523995907
```

```
[22]:
```

```
venn3([set(akker_kmers), set(shew1_kmers), set(shew2_kmers)])
```

```
[22]:
```

```
<matplotlib_venn._common.VennDiagram at 0x15aa8d8b0>
```

![_images/kmers-and-minhash_29_1.png](_images/kmers-and-minhash_29_1.png)

### Let’s hash![¶](#Let's-hash! "Link to this heading")

### Choose a hash function![¶](#Choose-a-hash-function! "Link to this heading")

We need to pick a hash function that takes DNA k-mers and converts them into numbers.

Both the [mash](https://mash.readthedocs.io/en/latest/) software for MinHash, and the [sourmash](https://sourmash.readthedocs.io) software for modulo and MinHash, use MurmurHash:

<https://en.wikipedia.org/wiki/MurmurHash>

this is implemented in the ‘mmh3’ library in Python.

The other thing we need to do here is take into account the fact that DNA is double stranded, and so

```
hash_kmer('ATGG')
```

should be equivalent to

```
hash_kmer('CCAT')
```

Following mash’s lead, for every input k-mer we will choose a *canonical* k-mer that is the lesser of the k-mer and its reverse complement.

```
[23]:
```

```
import mmh3

def hash_kmer(kmer):
    # calculate the reverse complement
    rc_kmer = screed.rc(kmer)

    # determine whether original k-mer or reverse complement is lesser
    if kmer < rc_kmer:
        canonical_kmer = kmer
    else:
        canonical_kmer = rc_kmer

    # calculate murmurhash using a hash seed of 42
    hash = mmh3.hash64(canonical_kmer, 42)[0]
    if hash < 0:
        hash += 2**64

    # done
    return hash
```

This is now a function that we can use to turn any DNA “word” into a number:

```
[24]:
```

```
hash_kmer("ATGGC")
```

```
[24]:
```

```
13663093258475204077
```

The same input word always returns the same number:

```
[25]:
```

```
hash_kmer("ATGGC")
```

```
[25]:
```

```
13663093258475204077
```

as does its reverse complement:

```
[26]:
```

```
hash_kmer("GCCAT")
```

```
[26]:
```

```
13663093258475204077
```

and nearby words return very different numbers:

```
[27]:
```

```
hash_kmer("GCCAA")
```

```
[27]:
```

```
1777382721305265773
```

### Note that hashing collections of k-mers doesn’t change Jaccard calculations:[¶](#Note-that-hashing-collections-of-k-mers-doesn't-change-Jaccard-calculations: "Link to this heading")

```
[28]:
```

```
def hash_kmers(kmers):
    hashes = []
    for kmer in kmers:
        hashes.append(hash_kmer(kmer))
    return hashes
```

```
[29]:
```

```
shew1_hashes = hash_kmers(shew1_kmers)
shew2_hashes = hash_kmers(shew2_kmers)
```

```
[30]:
```

```
print(jaccard_similarity(shew1_kmers, shew2_kmers))
```

```
0.23675152210020398
```

```
[31]:
```

```
print(jaccard_similarity(shew1_hashes, shew2_hashes))
```

```
0.2371520123045373
```

(ok, it changes it a little, because of the canonical k-mer calculation!)

### Implementing subsampling with modulo hashing[¶](#Implementing-subsampling-with-modulo-hashing "Link to this heading")

We are now ready to implement k-mer subsampling with modulo hash.

We need to pick a sampling rate, and know the maximum possible hash value.

For a sampling rate, let’s start with 1000.

The MurmurHash function turns k-mers into numbers between 0 and `2**64 - 1` (the maximum 64-bit number).

Let’s define these as variables:

```
[32]:
```

```
scaled = 1000
MAX_HASH = 2**64
```

Now, choose the range of hash values that we’ll keep.

```
[33]:
```

```
keep_below = MAX_HASH / scaled
print(keep_below)
```

```
1.844674407370955e+16
```

and write a filter function:

```
[34]:
```

```
def subsample_modulo(kmers):
    keep = []
    for kmer in kmers:
        if hash_kmer(kmer) < keep_below:
            keep.append(kmer)
        # otherwise, discard

    return keep
```

### Now let’s apply this to our big collections of k-mers![¶](#Now-let's-apply-this-to-our-big-collections-of-k-mers! "Link to this heading")

```
[35]:
```

```
akker_sub = subsample_modulo(akker_kmers)
shew1_sub = subsample_modulo(shew1_kmers)
shew2_sub = subsample_modulo(shew2_kmers)
```

```
[36]:
```

```
print(len(akker_kmers), len(akker_sub))
print(len(shew1_kmers), len(shew1_sub))
print(len(shew2_kmers), len(shew2_sub))
```

```
499970 502
499970 513
499970 503
```

So we go from ~500,000 k-mers to ~500 hashes! Do the Jaccard calculations change??

```
[37]:
```

```
print("akker vs akker, total", jaccard_similarity(akker_kmers, akker_kmers))
print("akker vs akker, sub", jaccard_similarity(akker_sub, akker_sub))
```

```
akker vs akker, total 1.0
akker vs akker, sub 1.0
```

```
[38]:
```

```
print("akker vs shew1, total", jaccard_similarity(akker_kmers, shew1_kmers))
print("akker vs shew1, sub", jaccard_similarity(akker_sub, shew1_sub))
```

```
akker vs shew1, total 0.0
akker vs shew1, sub 0.0
```

```
[39]:
```

```
print("shew1 vs shew2, total", jaccard_similarity(shew1_kmers, shew2_kmers))
print("shew1 vs shew2, sub", jaccard_similarity(shew1_sub, shew2_sub))
```

```
shew1 vs shew2, total 0.23675152210020398
shew1 vs shew2, sub 0.2281795511221945
```

And you can see that the numbers are different, but not very much - the Jaccard similarity is being *estimated*, so it is not exact but it is close.

### Let’s visualize –[¶](#Let's-visualize--- "Link to this heading")

```
[40]:
```

```
venn3([set(akker_kmers), set(shew1_kmers), set(shew2_kmers)])
```

```
[40]:
```

```
<matplotlib_venn._common.VennDiagram at 0x163888190>
```

![_images/kmers-and-minhash_62_1.png](_images/kmers-and-minhash_62_1.png)

```
[41]:
```

```
venn3([set(akker_sub), set(shew1_sub), set(shew2_sub)])
```

```
[41]:
```

```
<matplotlib_venn._common.VennDiagram at 0x1638e11c0>
```

![_images/kmers-and-minhash_63_1.png](_images/kmers-and-minhash_63_1.png)

### Other pointers[¶](#Other-pointers "Link to this heading")

[Sourmash: a practical guide](https://sourmash.readthedocs.io/en/latest/using-sourmash-a-guide.html)

[Classifying signatures taxonomically](https://sourmash.readthedocs.io/en/latest/classifying-signatures.html)

[Pre-built search databases](https://sourmash.readthedocs.io/en/latest/databases.html)

### A full list of notebooks[¶](#A-full-list-of-notebooks "Link to this heading")

An introduction to k-mers for genome comparison and analysis

[Some sourmash command line examples!](sourmash-examples.html)

[Working with private collections of signatures.](sourmash-collections.html)

[Using the LCA\_Database API.](using-LCA-database-API.html)

```
[ ]:
```

```

```

[![Logo](_static/logo.png)

# sourmash](index.html)

Quickly search, compare, and analyze genomic and metagenomic data sets

### Navigation

* [Tutorials and examples](sidebar.html)
* [How-To Guides](sidebar.html#how-to-guides)
* [Frequently Asked Questions](sidebar.html#frequently-asked-questions)
* [How sourmash works under the hood](sidebar.html#how-sourmash-works-under-the-hood)
* [Reference material](sidebar.html#reference-material)
* [Developing and extending sourmash](sidebar.html#developing-and-extending-sourmash)
* [Full table of contents for all docs](sidebar.html#full-table-of-contents-for-all-docs)
* [Using sourmash from the command line](command-line.html)
* [Prepared databases](databases.html)
* [`sourmash` Python API examples](api-example.html)
* [How to cite sourmash](cite.html)

### Related Topics

* [Documentation overview](index.html)

### This Page

* [Show Source](_sources/kmers-and-minhash.ipynb.txt)

### Quick search

©2016-2023, C. Titus Brown, Luiz Irber, and N. Tessa Pierce-Ward.
|
Powered by [Sphinx 9.0.4](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](_sources/kmers-and-minhash.ipynb.txt)
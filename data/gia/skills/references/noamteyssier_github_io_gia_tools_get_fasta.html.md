1. [Introduction](../introduction.html)
2. [Installation](../installation.html)
3. [Background](../background.html)
4. [Purpose](../purpose.html)
6. - Tools
   - [**1.** Closest](../tools/closest.html)
   - [**2.** Complement](../tools/complement.html)
   - [**3.** Extend](../tools/extend.html)
   - [**4.** Get Fasta](../tools/get_fasta.html)
   - [**5.** Intersect](../tools/intersect.html)
   - [**6.** Merge](../tools/merge.html)
   - [**7.** Random](../tools/random.html)
   - [**8.** Sample](../tools/sample.html)
   - [**9.** Sort](../tools/sort.html)
   - [**10.** Subtract](../tools/subtract.html)

* Light (default)
* Rust
* Coal
* Navy
* Ayu

# gia

# [`[ gia get-fasta ]`](#-gia-get-fasta-)

## [Background](#background)

This subcommand is used to extract sequences from intervals provided in an input BED file
from an indexed fasta.

The fasta is assumed indexed using `samtools faidx` and assumes the index is `</path/to.fasta>.fai`.

## [Usage](#usage)

See full arguments and options using:

```
gia get-fasta --help
```

### [Extract Sequences](#extract-sequences)

If the chromosome names are integers we can extract the sequences using the following command:

```
gia get-fasta -b <input.bed> -f <input.fa>
```

#### [Input Integer BED](#input-integer-bed)

```
1	20	30
2	30	40
```

#### [Input Integer Fasta](#input-integer-fasta)

```
>1
ACCCCTATCTATCACACTTCAGCGACTA
CGACTACGACCATCGACGATCAGCATCA
GCATCGACTACGACGATCAGCGACTACG
AGCTACGACGAGCG
>2
GGTAGTTAGTAGAGTTAGACTACGATCG
ATCGATCGATCGAGCGGCGCGCATCGAT
CGTAGCCGCGGCGTACGTAGCGCAGCAG
TCGTAGCTACGTAG
```

#### [Output Integer Fasta](#output-integer-fasta)

```
>1:20-30
AGCGACTACG
>2:30-40
CGATCGATCG
```

### [Extract Sequences with non-integer named bed and chromosome names](#extract-sequences-with-non-integer-named-bed-and-chromosome-names)

If the chromosome names are non-integers, `gia` can handle the conversion
and no extra flags are required.

```
gia get-fasta -b <input.bed> -f <input.fa>
```

#### [Input Non-Integer BED](#input-non-integer-bed)

```
chr1	20	30
chr2	30	40
```

#### [Input Non-Integer Fasta](#input-non-integer-fasta)

```
>chr1
ACCCCTATCTATCACACTTCAGCGACTA
CGACTACGACCATCGACGATCAGCATCA
GCATCGACTACGACGATCAGCGACTACG
AGCTACGACGAGCG
>chr2
GGTAGTTAGTAGAGTTAGACTACGATCG
ATCGATCGATCGAGCGGCGCGCATCGAT
CGTAGCCGCGGCGTACGTAGCGCAGCAG
TCGTAGCTACGTAG
```

#### [Output Non-Integer Fasta](#output-non-integer-fasta)

```
>chr1:20-30
AGCGACTACG
>chr2:30-40
CGATCGATCG
```
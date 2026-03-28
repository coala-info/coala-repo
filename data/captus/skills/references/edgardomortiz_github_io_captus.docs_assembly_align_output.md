1. [Captus](/captus.docs/) >
2. [Assembly](/captus.docs/assembly/) >
3. [Align](/captus.docs/assembly/align/) >
4. Output Files

* + [1. **`01_unaligned`**](#1-01_unaligned)
  + [2. **`02_untrimmed`**](#2-02_untrimmed)
  + [3. **`03_trimmed`**](#3-03_trimmed)
  + [4. **`01_unfiltered_w_refs`**](#4-01_unfiltered_w_refs)
  + [5. **`02_naive_w_refs`**](#5-02_naive_w_refs)
  + [6. **`03_informed_w_refs`**](#6-03_informed_w_refs)
  + [7. **`04_unfiltered`**, **`05_naive`**, **`06_informed`**](#7-04_unfiltered-05_naive-06_informed)
  + [8. **`01_coding_NUC`**, **`02_coding_PTD`**, **`03_coding_MIT`**](#8-01_coding_nuc-02_coding_ptd-03_coding_mit)
  + [9. **`01_AA`**](#9-01_aa)
  + [10. **`02_NT`**](#10-02_nt)
  + [11. **`03_genes`**](#11-03_genes)
  + [12. **`04_genes_flanked`**](#12-04_genes_flanked)
  + [13. **`04_misc_DNA`**, **`05_clusters`**](#13-04_misc_dna-05_clusters)
  + [14. **`01_matches`**](#14-01_matches)
  + [15. **`02_matches_flanked`**](#15-02_matches_flanked)
  + [16. **`captus-align_paralogs.tsv`**](#16-captus-align_paralogstsv)
  + [17. **`captus-align_alignments.tsv`**](#17-captus-align_alignmentstsv)
  + [18. **`captus-align_samples.tsv`**](#18-captus-align_samplestsv)
  + [19. **`captus-align_astral-pro.tsv`**](#19-captus-align_astral-protsv)
  + [20. **`captus-align_report.html`**](#20-captus-align_reporthtml)
  + [21. **`captus-align.log`**](#21-captus-alignlog)

# Output Files

For this example we will use the directory `03_extractions` previously created with the [`extract` module](https://edgardomortiz.github.io/captus.docs/assembly/extract/output/). We run the following `Captus` command to collect markers across samples and align them:

```
captus align -e 03_extractions_CAP/ -o 04_alignments_CAP -m ALL -f ALL
```

After the run is finished we should see a new directory called `04_alignments` with the following structure and files:

![Alignments](/captus.docs/images/alignments.png?width=640&classes=shadow)

---

Complete structure of the alignment output directory

![Alignment directory](/captus.docs/images/alignment_stages.png?width=1200&classes=shadow)

---

### 1. **`01_unaligned`**

This directory contains the unaligned FASTA files corresponding to each marker that were gathered from the extractions directory. The files are organized in subdirectories, first by [marker type](/captus.docs/assembly/align/options/#-m---markers) and then by [format](/captus.docs/assembly/align/options/#-f---formats).

---

### 2. **`02_untrimmed`**

This directory contains the aligned FASTA files corresponding to each file in the `01_unaligned` directory. The files are organized in subdirectories, first by filtering strategy, then by [marker type](/captus.docs/assembly/align/options/#-m---markers), and finally by [format](/captus.docs/assembly/align/options/#-f---formats). The subdirectory structure is identical to the one inside the `03_trimmed` directory (see **4** to **15** below).
![Untrimmed alignments](/captus.docs/images/alignment_untrimmed_stages.png?width=1200&classes=shadow)

---

### 3. **`03_trimmed`**

All the files present in the `02_untrimmed` directory are trimmed using `ClipKIT` which removes columns that are mostly empty (see options [`--clipkit_algorithm`](/captus.docs/assembly/align/options/#--clipkit_algorithm), [`--clipkit_gaps`](/captus.docs/assembly/align/options/#--clipkit_gaps)), then `Captus` removes sequences that are too short after trimming ([`--min_coverage`](/captus.docs/assembly/align/options/#--min_coverage)). The files are organized in subdirectories, first by filtering strategy, then by [marker type](/captus.docs/assembly/align/options/#-m---markers), and finally by [format](/captus.docs/assembly/align/options/#-f---formats). The subdirectory structure is identical to the one inside the `02_untrimmed` directory (see **4** to **15** below).
![Trimmed alignments](/captus.docs/images/alignment_trimmed_stages.png?width=1200&classes=shadow)

---

### 4. **`01_unfiltered_w_refs`**

This directory contains the alignments before performing any filtering. All the reference sequences selected by at least a sample will be present as well as all the paralogs per sample. The files are organized in subdirectories, first by [marker type](/captus.docs/assembly/align/options/#-m---markers) and then by [format](/captus.docs/assembly/align/options/#-f---formats).

---

### 5. **`02_naive_w_refs`**

This directory contains the alignments where paralogs have been filtered by the `naive` method, which consists in simply keeping the best hit per sample (hit ranked as `00`). All the reference sequences selected by at least a sample will still be present. The files are organized in subdirectories, first by [marker type](/captus.docs/assembly/align/options/#-m---markers) and then by [format](/captus.docs/assembly/align/options/#-f---formats).
![Naive paralog filter](/captus.docs/images/paralog_filter_naive.png?width=1200&classes=shadow)

---

### 6. **`03_informed_w_refs`**

This directory contains the alignments where paralogs have been filtered by the `informed` method. Under this strategy, `Captus` compares every copy to the most commonly used reference sequence (sequence `ABCD-3400` in the figure) and retains the copy with the highest similarity to that reference, regardless of its paralog ranking (in the figure, `Sample1` and `Sample4` whose selected copies had paralog rankings of `01` and `02` respectively). All the reference sequences selected by at least a sample will still be present. The files are organized in subdirectories, first by [marker type](/captus.docs/assembly/align/options/#-m---markers) and then by [format](/captus.docs/assembly/align/options/#-f---formats).
![Informed paralog filter](/captus.docs/images/paralog_filter_informed.png?width=1200&classes=shadow)

---

### 7. **`04_unfiltered`**, **`05_naive`**, **`06_informed`**

These contain equivalent alignments to directories `01_unfiltered_w_refs`, `02_naive_w_refs`, and `03_informed_w_refs` respectively, but excluding the reference sequences. *In most cases you will estimate phylogenies from the trimmed versions of these alignments.*

---

### 8. **`01_coding_NUC`**, **`02_coding_PTD`**, **`03_coding_MIT`**

These directories contain the aligned **coding** markers from the **NUC**lear, **P**las**T**i**D**ial, and **MIT**ochondrial genomes respectively.
The alignments are presented in four formats: protein sequence (**coding\_AA**), coding sequence in nucleotide (**coding\_NT**), exons and introns concatenated (**genes**), and the concatenation of exons and introns flanked by a fixed length of sequence (**genes\_flanked**):

![Protein extraction formats](/captus.docs/images/protein_extraction.png?width=600&classes=shadow)

---

### 9. **`01_AA`**

This directory contains the protein alignments (`AA` in the figure above) of the extracted markers gathered across samples. One FASTA file per marker, with extension `.faa`.

---

### 10. **`02_NT`**

This directory contains the alignments of coding sequence in nucleotides (`NT` in the figure above) of the extracted markers gathered across samples. One FASTA file per marker, with extension `.fna`.

---

### 11. **`03_genes`**

This directory contains the alignments of gene sequence (exons + introns) in nucleotides (`GE` in the figure above) of the extracted markers gathered across samples. One FASTA file per marker, with extension `.fna`.

---

### 12. **`04_genes_flanked`**

This directory contains the alignments of flanked gene sequence in nucleotides (`GF` in the figure above) of the extracted markers gathered across samples. One FASTA file per marker, with extension `.fna`.

---

### 13. **`04_misc_DNA`**, **`05_clusters`**

These directories contain the aligned **miscellaneous DNA** markers, either from a **DNA** custom set of references or from the **CL**uste**R**ing resulting from using the option `--cluster_leftovers` during the extraction step.
The alignments are presented in two formats: matching DNA segments (**matches**), and the matched segments including flanks and other intervening segments not present in the reference (**matches\_flanked**).

![Miscellaneous DNA extraction formats](/captus.docs/images/misc_dna_extraction.png?width=600&classes=shadow)

---

### 14. **`01_matches`**

This directory contains the alignments of DNA sequence matches (`MA` in the figure above) for the extracted markers gathered across samples. One FASTA file per marker, with extension `.fna`.

---

### 15. **`02_matches_flanked`**

This directory contains the alignments of DNA sequence matches (`MF` in the figure above) including flanks and intervening segments not present in the references for the extracted markers gathered across samples. One FASTA file per marker, with extension `.fna`.

---

### 16. **`captus-align_paralogs.tsv`**

A tab-separated-values table recording which copy was selected during the `informed` filtering of paralogs.

Information included in the table

| Column | Description |
| --- | --- |
| **marker\_type** | Type of marker. Possible values are `NUC`, `PTD`, `MIT`, `DNA`, or `CLR`. |
| **format\_filtered** | Alignment format used for identity comparison and filtering. For protein references, if the reference is provided both in aminoacids and nucleotides, the nucleotide format is used. |
| **locus** | Name of the locus. |
| **ref** | Name of most common the reference observed in the alignment. |
| **sample** | Name of the sample. |
| **hit** | Paralog ranking. |
| **sequence** | Name of the sequence as it appears in the alignments. |
| **length** | Lenght of the sequence in aminoacids if `format_filtered` is `AA`, or in nucleotides if `format_filtered` is `NT` |
| **identity** | Identity of the sequence to the `ref` sequence, over the overlapping segment, ignoring internal gaps. |
| **paralog\_score** | (`length` / length of `ref`) \* (`identity` / 100), the highest score decides the selected copy. |
| **accepted** | Whether the copy is accepted (`TRUE`) or not (`FALSE`). |

---

### 17. **`captus-align_alignments.tsv`**

A tab-separated-values table recording alignment statistics for each of the alignments produced.

Information included in the table

| Column | Description |
| --- | --- |
| **path** | Absolute path to the alignment file. |
| **trimmed** | Whether the alignment has been trimmed (`TRUE`) or not (`FALSE`). |
| **paralog\_filter** | Filtering strategy applied to the file. Possible values are `unfiltered`, `naive`, or `informed`. |
| **with\_refs** | Whether the file still contains the reference sequences (`TRUE`) or they have been removed (`FALSE`). |
| **marker\_type** | Type of marker. Possible values are `NUC`, `PTD`, `MIT`, `DNA`, or `CLR`. |
| **format** | Alignment format. Possible values are `AA`,`NT`,`GE`,`GF`,`MA`,`MF`. |
| **locus** | Name of the locus. |
| **seqs** | Number of sequences in the alignment. |
| **samples** | Number of samples represented in the alignment. The number can be smaller than `seqs` if the alignment has paralogs. |
| **avg\_copies** | `seqs` / `samples` |
| **sites** | Alignment length. |
| **informative** | Number of parsimony-informative-sites in the alignment. |
| **informativeness** | (`informative` / `sites`) \* 100 |
| **uninformative** | `constant` + `singleton` |
| **constant** | Number of invariant sites in the alignment. |
| **singleton** | Number of sites with variaton in a single sequence. |
| **paterns** | Number of unique columns, for a detailed explanation see IQ-TREE’s F.A.Q.: [What are the differences between alignment columns/sites and patterns?](http://www.iqtree.org/doc/Frequently-Asked-Questions). |
| **avg\_pid** | Average pairwise identity between sequences in the alignment. |
| **missingness** | Proportion of missing data (`-`, `N`, `X`, `?`, `.`, `~`) in the alignment. |
| **gc** |  |
| **gc\_codon\_p1** |  |
| **gc\_codon\_p2** |  |
| **gc\_codon\_p3** |  |

---

### 18. **`captus-align_samples.tsv`**

A tab-separated-values table recording sample statistics across the different filtering and trimming stages, as well as marker types and formats.

Information included in the table

| Column | Description |
| --- | --- |
| **sample** | Sample name. |
| **stage\_marker\_format** | Trimming stage / Filtering strategy / Marker type / Format. |
| **locus** | Name of the locus. |
| **len\_total** |  |
| **len\_gapped** |  |
| **len\_ungapped** |  |
| **cov\_gapped** | Coverage of the sequence relative to alignment length, including internal gaps. |
| **cov\_ungapped** | Coverage of the sequence relative to alignment length, excluding internal gaps. |
| **ambigs** |  |
| **pct\_ambig** | Percentage of ambiguities in the sequence, excluding gaps. |
| **gc** |  |
| **gc\_codon\_p1** |  |
| **gc\_codon\_p2** |  |
| **gc\_codon\_p3** |  |
| **num\_copies** | Number of copies in the alignment. |

---

### 19. **`captus-align_astral-pro.tsv`**

ASTRAL-Pro requires a tab-separated-values file for mapping the names of the paralog sequence names (first column) to the name of the sample (second column). `Captus` produces this file automatically.

Example

```
GenusA_speciesA_CAP	GenusA_speciesA_CAP
GenusA_speciesA_CAP__00	GenusA_speciesA_CAP
GenusA_speciesA_CAP__01	GenusA_speciesA_CAP
GenusA_speciesA_CAP__02	GenusA_speciesA_CAP
GenusA_speciesA_CAP__03	GenusA_speciesA_CAP
GenusA_speciesA_CAP__04	GenusA_speciesA_CAP
GenusA_speciesA_CAP__05	GenusA_speciesA_CAP
GenusB_speciesB_CAP	GenusB_speciesB_CAP
GenusB_speciesB_CAP__00	GenusB_speciesB_CAP
GenusB_speciesB_CAP__01	GenusB_speciesB_CAP
GenusB_speciesB_CAP__02	GenusB_speciesB_CAP
GenusC_speciesC_CAP	GenusC_speciesC_CAP
GenusC_speciesC_CAP__00	GenusC_speciesC_CAP
GenusC_speciesC_CAP__01	GenusC_speciesC_CAP
GenusC_speciesC_CAP__02	GenusC_speciesC_CAP
GenusC_speciesC_CAP__03	GenusC_speciesC_CAP
GenusC_speciesC_CAP__04	GenusC_speciesC_CAP
GenusC_speciesC_CAP__05	GenusC_speciesC_CAP
GenusD_speciesD_CAP	GenusD_speciesD_CAP
GenusD_speciesD_CAP__00	GenusD_speciesD_CAP
GenusD_speciesD_CAP__01	GenusD_speciesD_CAP
GenusD_speciesD_CAP__02	GenusD_speciesD_CAP
GenusD_speciesD_CAP__03	GenusD_speciesD_CAP
GenusD_speciesD_CAP__04	GenusD_speciesD_CAP
GenusD_speciesD_CAP__05	GenusD_speciesD_CAP
```

---

### 20. **`captus-align_report.html`**

This is the final [Aligment report](https://edgardomortiz.github.io/captus.docs/assembly/align/report/), summarizing alignment statistics across all processing stages, marker types, and formats.

---

### 21. **`captus-align.log`**

This is the log from `Captus`, it contains the command used and all the information shown during the run. Even if the option `--show_more` was disabled, the log will contain all the extra detailed information that was hidden during the run.

---

Created by [Edgardo M. Ortiz](https://edgardomortiz.github.io/captus.docs/more/credits/#edgardo-m-ortiz) (06.08.2021)
Last modified by [Edgardo M. Ortiz](https://edgardomortiz.github.io/captus.docs/more/credits/#edgardo-m-ortiz) (23.12.2024)

[![](/captus.docs/images/
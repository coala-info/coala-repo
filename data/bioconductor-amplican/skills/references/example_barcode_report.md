# Report breakdown by barcode

#### ampliCan

#### 13 November 2025

---

# 1 Description

---

**Read distribution plot** - plot shows number of reads assigned during read grouping
**Filtered Reads** - plot shows percentage of assigned reads that have been recognized as PRIMER DIMERS or filtered based on low alignment score
**Edit rates** - plot gives overview of percentage of reads (not filtered as PRIMER DIMER) that have edits
**Frameshift** - plot shows what percentage of reads that have frameshift
**Read heterogeneity plot** - shows what is the share of each of the unique reads in total count of all reads. The more yellow each row, the less heterogeneity in the reads, more black means reads don’t repeat often and are unique
**Top unassigned reads** - take a look at the alignment of most abundant forward and reverse complemented reverse reads for each barcode, if you find that there is many unassigned reads you can ivestigate here.

---

# 2 Barcode Summary

---

## 2.1 Groups IDs

| group | IDs |
| --- | --- |
| barcode\_1 | ID\_1, ID\_2 |
| barcode\_2 | ID\_3, ID\_4, ID\_5 |

## 2.2 Read distribution

![](data:image/png;base64...)

## 2.3 Filtered Reads

![](data:image/png;base64...)

## 2.4 Edit rates

![](data:image/png;base64...)

## 2.5 Frameshift

![](data:image/png;base64...)

## 2.6 Heterogeneity of reads

![](data:image/png;base64...)

---

# 3 Top unassigned reads

---

## 3.1 barcode\_1

| Forward | Reverse | Counts | Frequency |
| --- | --- | --- | --- |
| P1 | S1 | 1 | 0.0588235 |
| P2 | S2 | 1 | 0.0588235 |
| P3 | S3 | 1 | 0.0588235 |
| P4 | S4 | 1 | 0.0588235 |

```
P1                 1 AAATACTGTCTTGTGACCAAACCTTCTTAAGGTGCTGTTTTGATGATAAA     50
                     ||   ||| |    | | |||   |   ||    |||          |||
S1                 1 AAG--CTGAC----GGCTAAA---TGAAAAATATCTG----------AAA     31

P1                51 CTTTATTGTGCTTTTGTAGTTGTGCCCCTTGTGTT--GGCAGAG-----G     93
                     | |       || ||  ||  ||||  | | ||    |||||||     |
S1                32 CAT-------CTGTTCCAG--GTGCTGCGTATGCCAGGGCAGAGAAGAAG     72

P1                94 GTCAGC--AGACCAGT--AAGTCTTCTCAATTTCTTTTATTT----ATGT    135
                     |||||   ||  || |  | |||      ||  | ||| ||     |
S1                73 GTCAGGGAAGGTCACTGGAGGTCACTGGGATACCCTTTCTTCCCACACCA    122

P1               136 AT-----ATGTAGT-------GATAAA-A    151
                     ||     | | |||       ||| |  |
S1               123 ATGGGGAAAGGAGTCCTGCCAGATGACCA    151

P2                 1 AAATACTGTCTTGTGACCAAACCTTCTTAAGGTGCTG---TTTTGATGAT     47
                             | || | || | |  | | |||      |   ||  || ||
S2                 1 --------TTTTATCACTACATATACATAAATAAAAGAAATTGAGAAGAC     42

P2                48 NNNCTTTATTGTGCTTTTGTAGTTGTGCCCCTTGTGTTGGCAGAGGGTCA     97
                          ||| ||  ||  ||    | ||||         |||| |    ||
S2                43 -----TTACTGGTCTGCTGACCCTCTGCCAACACAAGGGGCACAACTACA     87

P2                98 GCAGACCAGTAAG-----TCTTCTCAATTTCTTTTATTTATGTATATGTA    142
                       ||  || |||      || ||  ||   |   |   || | |  | |
S2                88 AAAGCACAATAAAGNNNATCATCAAAACAGCACCT---TAAGAAGGTTTG    134

P2               143 GTGATAAAA--------    151
                     || | || |
S2               135 GTCACAAGACAGTATTT    151

P3                 1 AAGCTGACGGCTAAATNNNAAATATCTGAAACATCTGTTCCAGGTGCTGC     50
                     ||||||||||||||||   |||||||||||||||||||||||||||||||
S3                 1 AAGCTGACGGCTAAATGAAAAATATCTGAAACATCTGTTCCAGGTGCTGC     50

P3                51 GTATGCCAGGGCAGAGAAGAAGGTCAGGGAAGGTCACTGGAGGTCACTGG    100
                     ||||||||||||||||||||||||||||||||||||||||||||||||||
S3                51 GTATGCCAGGGCAGAGAAGAAGGTCAGGGAAGGTCACTGGAGGTCACTGG    100

P3               101 GATACCCTTTCTTCCCACACCAATGGGGAAAGGAGTCCTGCCAGATGACC    150
                     ||||||||||||||||||||||||||||||||||||||||||||||||||
S3               101 GATACCCTTTCTTCCCACACCAATGGGGAAAGGAGTCCTGCCAGATGACC    150

P3               151 A    151
                     |
S3               151 A    151

P4                 1 AAGCTNGCGGCTAAATGAAAAATATCTGAAACATCTGTTCCAGGTGCTGC     50
                        ||  |||||||||||||||||||||||||||||||||||||||||||
S4                 1 NNNCTGACGGCTAAATGAAAAATATCTGAAACATCTGTTCCAGGTGCTGC     50

P4                51 GTATGCCAGGGCAGAGAAGAAGGTCAGGGAAGGTCACTGGAGGTCACTGG    100
                     ||||||||||||||||||||||||||||||||||||||||||||||||||
S4                51 GTATGCCAGGGCAGAGAAGAAGGTCAGGGAAGGTCACTGGAGGTCACTGG    100

P4               101 GATACCCTTTCTTCCCACACCANNNGGGAAAGGAGTCCTGCCAGATGACC    150
                     |||||||   ||||||||||||   ||||||||||||||    |||||||
S4               101 GATACCCNNNCTTCCCACACCAATGGGGAAAGGAGTCCTNNNNGATGACC    150

P4               151 A    151
                     |
S4               151 A    151
```
# Summary Read Report

#### ampliCan

#### 13 November 2025

---

# 1 Other Reports

---

1. [Report by id](./example_id_report.html)
2. [Report by barcode](./example_barcode_report.html)
3. [Report by group](./example_group_report.html)
4. [Report by guide](./example_guide_report.html)
5. [Report by amplicon](./example_amplicon_report.html)

---

# 2 Explanation of variables

---

**Experiment Count** - how many IDs belongs to this barcode
**Read Count** - how many reads belongs to this barcode
**Bad Base Quality** - how many reads had base quality worse than specified (default is 0)
**Bad Average Quality** - how many reads had average base quality worse than specified (default is 0)
**Bad Alphabet** - how many reads had alphabet with bases other than A, C, G, T
**Filtered Read Count** - how many reads were left after filtering
**Unique Reads** - how many reads (forward and reverse together) for this barcode is unique
**Assigned Reads/Unassigned Reads** - how many reads have been assigned/not assigned to any of the experiments

---

# 3 Total reads

---

## 3.1 Read Quality

![](data:image/png;base64...)![](data:image/png;base64...)

## 3.2 Read assignment

![](data:image/png;base64...)![](data:image/png;base64...)

## 3.3 Edits

![](data:image/png;base64...)![](data:image/png;base64...)

---

# 4 Reads by barcode

---

![](data:image/png;base64...)

![](data:image/png;base64...)

![](data:image/png;base64...)

---

# 5 Summary Table

---

| Barcodes | Experiment Count | Read Count | Bad base quality | Bad average quality | Bad alphabet | Good Reads | Unique Reads | Unassigned Reads | Assigned Reads |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| barcode\_1 | 2 | 20 | 0 | 3 | 0 | 17 | 11 | 4 | 7 |
| barcode\_2 | 3 | 21 | 0 | 0 | 0 | 21 | 9 | 0 | 9 |

Table 1. Reads distributed for each barcode

---
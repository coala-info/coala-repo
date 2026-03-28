1. [Captus](/captus.docs/) >
2. [Assembly](/captus.docs/assembly/) >
3. [Extract](/captus.docs/assembly/extract/) >
4. Output Files

* + [1. **`[SAMPLE_NAME]__captus-ext`**](#1-sample_name__captus-ext)
  + [2. **`01_coding_NUC`**, **`02_coding_PTD`**, **`03_coding_MIT`**](#2-01_coding_nuc-02_coding_ptd-03_coding_mit)
  + [3. **`[MARKER_TYPE]_coding_AA.faa`**, **`01_AA`**](#3-marker_type_coding_aafaa-01_aa)
  + [4. **`[MARKER_TYPE]_coding_NT.fna`**, **`02_NT`**](#4-marker_type_coding_ntfna-02_nt)
  + [5. **`[MARKER_TYPE]_genes.fna`**, **`03_genes`**](#5-marker_type_genesfna-03_genes)
  + [6. **`[MARKER_TYPE]_genes_flanked.fna`**, **`04_genes_flanked`**](#6-marker_type_genes_flankedfna-04_genes_flanked)
  + [7. **`[MARKER_TYPE]_contigs_list.txt`**](#7-marker_type_contigs_listtxt)
  + [8. **`[MARKER_TYPE]_contigs.gff`**](#8-marker_type_contigsgff)
  + [9. **`[MARKER_TYPE]_recovery_stats.tsv`**](#9-marker_type_recovery_statstsv)
  + [10. **`[MARKER_TYPE]_scipio_final.log`**](#10-marker_type_scipio_finallog)
  + [11. **`00_initial_scipio_[MARKER_TYPE]`**](#11-00_initial_scipio_marker_type)
  + [12. **`04_misc_DNA`**, **`05_clusters`**](#12-04_misc_dna-05_clusters)
  + [13. **`[MARKER_TYPE]_matches.fna`**, **`01_matches`**](#13-marker_type_matchesfna-01_matches)
  + [14. **`[MARKER_TYPE]_matches_flanked.fna`**, **`02_matches_flanked`**](#14-marker_type_matches_flankedfna-02_matches_flanked)
  + [15. **`[MARKER_TYPE]_contigs_list.txt`**](#15-marker_type_contigs_listtxt)
  + [16. **`[MARKER_TYPE]_contigs.gff`**](#16-marker_type_contigsgff)
  + [17. **`[MARKER_TYPE]_recovery_stats.tsv`**](#17-marker_type_recovery_statstsv)
  + [18. **`[MARKER_TYPE]_blat_search.log`**](#18-marker_type_blat_searchlog)
  + [19. **`06_assembly_annotated`**](#19-06_assembly_annotated)
  + [20. **`[SAMPLE_NAME]_hit_contigs.fasta`**](#20-sample_name_hit_contigsfasta)
  + [21. **`[SAMPLE_NAME]_hit_contigs.gff`**](#21-sample_name_hit_contigsgff)
  + [22. **`[SAMPLE_NAME]_recovery_stats.tsv`**](#22-sample_name_recovery_statstsv)
  + [23. **`leftover_contigs.fasta.gz`**](#23-leftover_contigsfastagz)
  + [24. **`leftover_contigs_after_custering.fasta.gz`**](#24-leftover_contigs_after_custeringfastagz)
  + [25. **`captus-extract_refs.json`**](#25-captus-extract_refsjson)
  + [26. **`captus-extract_stats.tsv`**](#26-captus-extract_statstsv)
  + [27. **`captus-extract_report.html`**](#27-captus-extract_reporthtml)
  + [28. **`captus-extract.log`**](#28-captus-extractlog)
  + [29. **`clust_id##.##_cov##.##_captus_clusters_refs.fasta`**](#29-clust_id_cov_captus_clusters_refsfasta)
  + [FASTA headers explanation](#fasta-headers-explanation)

# Output Files

For this example we will use the directory `02_assemblies` previously created with the [`assemble` module](https://edgardomortiz.github.io/captus.docs/assembly/assemble/output/). We run the following `Captus` command to search and extract our reference markers from the assemblies:

```
captus extract -a 02_assemblies \
-n Angiosperms353 \
-p SeedPlantsPTD \
-m SeedPlantsMIT \
-d noncoding_DNA.fasta \
-c \
--max_loci_files 500
```

Warning

Notice the addition of option `--max_loci_files 500`, which is used only for showing the output directories containing separate FASTA file per marker (**3’**, **4’**, **5’**, **6’**, **13’**, and **14’** in the image below, not created by default), we don’t recommend using this option in your runs since it will unnecesarily create large numbers of small FASTA files which would have to be concatenated again anyways during the alignment step.
You can read more about the option here: [**–max\_loci\_files**](/captus.docs/assembly/extract/options/#--max_loci_files)

After the run is finished we should see a new directory called `03_extractions` with the following structure and files:

![Extractions](/captus.docs/images/extractions.png?width=640&classes=shadow)

### 1. **`[SAMPLE_NAME]__captus-ext`**

A subdirectory ending in `__captus-ext` is created to contain the extracted markers of each sample separately (**S1**, **S2**, **S3**, and **S4** in the image).

---

### 2. **`01_coding_NUC`**, **`02_coding_PTD`**, **`03_coding_MIT`**

These directories contain the extracted **coding** markers from the **NUC**lear, **P**las**T**i**D**ial, and **MIT**ochondrial genomes respectively.
The markers are presented in four formats: protein sequence (**coding\_AA**), coding sequence in nucleotide (**coding\_NT**), exons and introns concatenated (**genes**), and the concatenation of exons and introns flanked by a fixed length of sequence (**genes\_flanked**):

![Protein extraction formats](/captus.docs/images/protein_extraction.png?width=600&classes=shadow)

---

### 3. **`[MARKER_TYPE]_coding_AA.faa`**, **`01_AA`**

Coding sequence in **aminoacids**. Prefixes can be `NUC`, `PTD`, or `MIT`. For details on sequence headers see [FASTA headers explanation](/captus.docs/assembly/extract/output/#fasta-headers-explanation).

Example

![AA format](/captus.docs/images/coding_AA.png?width=1000&classes=shadow)

---

### 4. **`[MARKER_TYPE]_coding_NT.fna`**, **`02_NT`**

Coding sequence in **nucleotides**, a.k.a. CDS. Prefixes can be `NUC`, `PTD`, or `MIT`. For details on sequence headers see [FASTA headers explanation](/captus.docs/assembly/extract/output/#fasta-headers-explanation).

Example

![NT format](/captus.docs/images/coding_NT.png?width=1000&classes=shadow)

---

### 5. **`[MARKER_TYPE]_genes.fna`**, **`03_genes`**

Gene sequence (exons in capital letters + introns in lowercase letters) in **nucleotides**. A contig connector of 50 `n` characters is included when the protein match spans more than a single contig. Prefixes can be `NUC`, `PTD`, or `MIT`. For details on sequence headers see [FASTA headers explanation](/captus.docs/assembly/extract/output/#fasta-headers-explanation).

Example

![GE format](/captus.docs/images/genes.png?width=1000&classes=shadow)

---

### 6. **`[MARKER_TYPE]_genes_flanked.fna`**, **`04_genes_flanked`**

Gene sequence (exons in capital letters + introns in lowercase letters) plus additional flanking sequence in lowercase **nucleotides**. A contig connector of 50 `n` characters is included when the protein match spans more than a single contig. Prefixes can be `NUC`, `PTD`, or `MIT`. For details on sequence headers see [FASTA headers explanation](/captus.docs/assembly/extract/output/#fasta-headers-explanation).

Example

![GF format](/captus.docs/images/genes_flanked.png?width=1000&classes=shadow)

---

### 7. **`[MARKER_TYPE]_contigs_list.txt`**

List of contig names that had protein hits. Prefixes can be `NUC`, `PTD`, or `MIT`.

Example

```
NODE_138_length_18304_cov_18.0000_k_175_flag_1
NODE_635_length_5337_cov_17.0000_k_175_flag_1
NODE_46_length_16959_cov_19.0000_k_175_flag_1
NODE_321_length_4728_cov_10.0000_k_175_flag_1
NODE_760_length_19021_cov_17.9856_k_175_flag_0
NODE_621_length_11511_cov_11.9845_k_175_flag_0
NODE_965_length_6331_cov_15.0000_k_175_flag_1
NODE_948_length_26295_cov_58.0000_k_175_flag_0
NODE_1726_length_1438_cov_9.0000_k_175_flag_1
NODE_210_length_2896_cov_9.9471_k_175_flag_0
NODE_677_length_10733_cov_14.0000_k_175_flag_1
NODE_996_length_2375_cov_11.0000_k_175_flag_1
NODE_1837_length_366_cov_3.0000_k_175_flag_1
NODE_1647_length_529_cov_7.0000_k_175_flag_1
NODE_792_length_4384_cov_17.0000_k_175_flag_1
NODE_1378_length_5491_cov_21.0000_k_175_flag_1
NODE_602_length_14961_cov_47.0000_k_175_flag_1
NODE_1293_length_649_cov_3.0000_k_175_flag_1
NODE_949_length_2240_cov_50.0000_k_175_flag_1
NODE_751_length_2777_cov_34.7909_k_175_flag_0
```

---

### 8. **`[MARKER_TYPE]_contigs.gff`**

Annotation track in [GFF](http://www.ensembl.org/info/website/upload/gff.html) format for protein hits to contigs in assembly. Prefixes can be `NUC`, `PTD`, or `MIT`.

See [19. 06\_assembly\_annotated](/captus.docs/assembly/extract/output/#19-06_assembly_annotated)

---

### 9. **`[MARKER_TYPE]_recovery_stats.tsv`**

Tab-separated-values table with marker recovery statistics, these are concatenated across marker types and samples and summarized in the final [Marker Recovery report](https://edgardomortiz.github.io/captus.docs/assembly/extract/report/). Prefixes can be `NUC`, `PTD`, or `MIT`.

Information included in the table

| Column | Description |
| --- | --- |
| **sample\_name** | Name of the sample. |
| **marker\_type** | Type of marker. Possible values are `NUC`, `PTD`, `MIT`, `DNA`, or `CLR`. |
| **locus** | Name of the locus. |
| **ref\_name** | Name of the reference selected for the locus. Relevant when the reference contains multiple sequences per locus like in Angiosperms353 for example. |
| **ref\_coords** | Match coordinates with respect to the reference, each segment is expressed as `[start]-[end]`, segments within the same contig are separated by `,`, and segments in different contigs are separated by `;`. For example: `1-47;48-354,355-449` indicates that a contig contained a segment matching reference coordinates `1-49` and a different contig matched two segments, `48-354` and `355-449` respectively. |
| **ref\_type** | Whether the reference is an aminoacid (`prot`) or nucleotide (`nucl`) sequence. |
| **ref\_len\_matched** | Number of residues matched in the reference. |
| **hit** | Paralog ranking, `00` is assigned to the best hit, secondary hits start at `01`. |
| **pct\_recovered** | Percentage of the total length of the reference sequence that was matched. |
| **pct\_identity** | Percentage of sequence identity between the hit and the reference sequence. |
| **score** | Inspired by `Scipio`’s score: `(matches - mismatches) / reference length`. |
| **wscore** | Weighted score. When the reference contains multiple sequences per locus, the best-matching reference is decided after normalizing their recovered length across references in the locus and multiplying that value by their respective `score`, thus producing the `wscore`. Finally `wscore` is also penalized by the number of frameshifts (if the marker is coding) and number of contigs used in the assembly of the hit. |
| **hit\_len** | Number of residues matched in the sample’s contig(s) plus the length of the flanking sequence. |
| **cds\_len** | If `ref_type` is `prot` this number represents the number of residues corresponding to coding sequence (i.e. exons). If the `ref_type` is `nucl` this field shows `NA`. |
| **intron\_len** | If `ref_type` is `prot` this number represents the number of residues corresponding to intervening non-coding sequence segments (i.e. introns). If the `ref_type` is `nucl` this field shows `NA`. |
| **flanks\_len** | Number of residues included in the flanking sequence. |
| **frameshifts** | Positions of the corrected frameshifts in the output sequence. If the `ref_type` is `nucl` this field shows `NA`. |
| **hit\_contigs** | Number of contigs used to assemble the hit. |
| **hit\_l50** | Least number of contigs in the hit that contain 50% of the recovered length. |
| **hit\_l90** | Least number of contigs in the hit that contain 90% of the recovered length. |
| **hit\_lg50** | Least number of contigs in the hit that contain 50% of the reference locus length. |
| **hit\_lg90** | Least number of contigs in the hit that contain 90% of the reference locus length. |
| **ctg\_names** | Name of the contigs used in the reconstruction of the hit. Example: `NODE_6256_length_619_cov_3.0000_k_169_flag_1;NODE_3991_length_1778_cov_19.0000_k_169_flag_1`, for a hit where two contigs were used. |
| **ctg\_strands** | Contig strands (`+` or `-`) provided in the same order as `ctg_names`. Example: `+;-` indicates that the contig `NODE_6256_length_619_cov_3.0000_k_169_flag_1` was matched in the positive strand while the contig `NODE_3991_length_1778_cov_19.0000_k_169_flag_1` was matched in the ngeative strand. |
| **ctg\_coords** | Match coordinates with respect to the contigs in the sample’s assembly. Each segment is expressed as `[start]-[end]`, segments within the same contig are separated by `,`, and segments in different contigs are separated by `;` which are provided in the same order as `ctg_names` and `ctg_strands`. Example: `303-452;694-1626,301-597` indicates that a single segment was matched in contig `NODE_6256_length_619_cov_3.0000_k_169_flag_1` in the `+` strand with coordinates `303-452`, while two segments were matched in contig `NODE_3991_length_1778_cov_19.0000_k_169_flag_1` in the `-` strand with coordinates `694-1626` and `301-597` respectively. |

---

### 10. **`[MARKER_TYPE]_scipio_final.log`**

Log of the second Scipio’s run, where best references have already been selected (when using multi-sequence per locus references) and only the contigs that had hits durin Scipio’s initial run are used. Prefixes can be `NUC`, `PTD`, or `MIT`.

---

### 11. **`00_initial_scipio_[MARKER_TYPE]`**

Directory for Scipio’s initial run results. The directory contains the set of filtered protein references `[MARKER_TYPE]_best_proteins.faa` (when using multi-sequence per locus references) and the log of Scipio’s initial run `[MARKER_TYPE]_scipio_initial.log`. Suffixes can be `NUC`, `PTD`, or `MIT`.

---

### 12. **`04_misc_DNA`**, **`05_clusters`**

These directories contain the extracted **miscellaneous DNA** markers, either from a **DNA** custom set of references or from the **CL**uste**R**ing resulting from using the option `--cluster_leftovers`.
The markers are presented in two formats: matching DNA segments (**matches**), and the matched segments including flanks and other intervening segments not present in the reference (**matches\_flanked**).

![Miscellaneous DNA extraction formats](/captus.docs/images/misc_dna_extraction.png?width=600&classes=shadow)

---

### 13. **`[MARKER_TYPE]_matches.fna`**, **`01_matches`**

Matches per miscellaneous DNA marker in **nucleotides**. Prefixes can be `DNA` or `CLR`. For details on sequence headers see [FASTA headers explanation](/captus.docs/assembly/extract/output/#fasta-headers-explanation).

Example

![MA format](/captus.docs/images/matches.png?width=1000&classes=shadow)

---

### 14. **`[MARKER_TYPE]_matches_flanked.fna`**, **`02_matches_flanked`**

Matches plus additional flanking sequence per miscellaneous DNA marker in **nucleotides**. Prefixes can be `DNA` or `CLR`. For details on sequence headers see [FASTA headers explanation](/captus.docs/assembly/extract/output/#fasta-headers-explanation).

Example

![MF format](/captus.docs/images/matches_flanked.png?width=1000&classes=shadow)

---

### 15. **`[MARKER_TYPE]_contigs_list.txt`**

List of contig names that had miscellaneous DNA marker hits. Prefixes can be `DNA` or `CLR`.

Example

```
NODE_1858_length_3636_cov_14.0000_k_175_flag_1
NODE_2876_length_3179_cov_25.0000_k_175_flag_1
NODE_502_length_5771_cov_37.0000_k_175_flag_1
NODE_347_length_475_cov_2.0000_k_175_flag_1
NODE_1393_length_297_cov_4.0000_k_175_flag_1
NODE_3093_length_960_cov_17.0000_k_175_flag_1
NODE_3265_length_1041_cov_18.0000_k_175_flag_1
```

---

### 16. **`[MARKER_TYPE]_contigs.gff`**

Annotation track in [GFF]
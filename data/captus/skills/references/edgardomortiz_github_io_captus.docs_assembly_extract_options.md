1. [Captus](/captus.docs/) >
2. [Assembly](/captus.docs/assembly/) >
3. [Extract](/captus.docs/assembly/extract/) >
4. Options

* [*Input*](#input)
  + [**`-a, --captus_assemblies_dir`**](#-a---captus_assemblies_dir)
  + [**`-f, --fastas`**](#-f---fastas)
* [*Output*](#output)
  + [**`-o, --out`**](#-o---out)
  + [**`--ignore_depth`**](#--ignore_depth)
  + [**`--disable_stitching`**](#--disable_stitching)
  + [**`--max_paralogs`**](#--max_paralogs)
  + [**`--paralog_tolerance`**](#--paralog_tolerance)
  + [**`--keep_all`**](#--keep_all)
  + [**`--overwrite`**](#--overwrite)
* [*Proteins extraction global options (Scipio)*](#proteins-extraction-global-options-scipio)
  + [**`--max_loci_scipio_x2`**](#--max_loci_scipio_x2)
  + [**`--predict`**](#--predict)
* [*Nuclear proteins (Scipio)*](#nuclear-proteins-scipio)
  + [**`-n, --nuc_refs`**](#-n---nuc_refs)
  + [**`--nuc_transtable`**](#--nuc_transtable)
  + [**`--nuc_min_score`**](#--nuc_min_score)
  + [**`--nuc_min_identity`**](#--nuc_min_identity)
  + [**`--nuc_min_coverage`**](#--nuc_min_coverage)
  + [**`--nuc_depth_tolerance`**](#--nuc_depth_tolerance)
* [*Plastidial proteins (Scipio)*](#plastidial-proteins-scipio)
  + [**`-p, --ptd_refs`**](#-p---ptd_refs)
  + [**`--ptd_transtable`**](#--ptd_transtable)
  + [**`--ptd_min_score`**](#--ptd_min_score)
  + [**`--ptd_min_identity`**](#--ptd_min_identity)
  + [**`--ptd_min_coverage`**](#--ptd_min_coverage)
  + [**`--ptd_depth_tolerance`**](#--ptd_depth_tolerance)
* [*Mitochondrial proteins (Scipio)*](#mitochondrial-proteins-scipio)
  + [**`-m, --mit_refs`**](#-m---mit_refs)
  + [**`--mit_transtable`**](#--mit_transtable)
  + [**`--mit_min_score`**](#--mit_min_score)
  + [**`--mit_min_identity`**](#--mit_min_identity)
  + [**`--mit_min_coverage`**](#--mit_min_coverage)
  + [**`--mit_depth_tolerance`**](#--mit_depth_tolerance)
* [*Miscellaneous DNA markers (BLAT)*](#miscellaneous-dna-markers-blat)
  + [**`-d, --dna_refs`**](#-d---dna_refs)
  + [**`--dna_min_identity`**](#--dna_min_identity)
  + [**`--dna_min_coverage`**](#--dna_min_coverage)
  + [**`--dna_depth_tolerance`**](#--dna_depth_tolerance)
* [*Assemblies clustering (MMSeqs2)*](#assemblies-clustering-mmseqs2)
  + [**`-c, --cluster_leftovers`**](#-c---cluster_leftovers)
  + [**`--mmseqs_method`**](#--mmseqs_method)
  + [**`--cl_mode`**](#--cl_mode)
  + [**`--cl_sensitivity`**](#--cl_sensitivity)
  + [**`--cl_min_identity`**](#--cl_min_identity)
  + [**`--cl_seq_id_mode`**](#--cl_seq_id_mode)
  + [**`--cl_min_coverage`**](#--cl_min_coverage)
  + [**`--cl_cov_mode`**](#--cl_cov_mode)
  + [**`--cl_min_samples`**](#--cl_min_samples)
  + [**`--cl_rep_min_len`**](#--cl_rep_min_len)
  + [**`--cl_max_seq_len`**](#--cl_max_seq_len)
  + [**`--cl_max_copies`**](#--cl_max_copies)
  + [**`--cl_tmp_dir`**](#--cl_tmp_dir)
* [*Other*](#other)
  + [**`--scipio_path`**, **`--blat_path`**](#--scipio_path---blat_path)
  + [**`--mmseqs_path`**, **`--mafft_path`**](#--mmseqs_path---mafft_path)
  + [**`--ram`**, **`--threads`**, **`--concurrent`**, **`--debug`**, **`--show_less`**](#--ram---threads---concurrent---debug---show_less)

# Options

# extract

---

To show all available options and their default values you can type in your terminal:

```
captus extract --help
```

---

## *Input*

---

### **`-a, --captus_assemblies_dir`**

Path to the output directory from the `assemble` command, (e.g. `02_assemblies` if you used the default name). If you didn’t assemble any sample in `Captus` this directory will be created in order to import your contigs assembled elsewhere.

This argument is **required** , the default is **./02\_assemblies/**

---

### **`-f, --fastas`**

With this option you can provide the location of your own FASTA assembly files, there are several ways to list them:

* ***Directory:*** the path to the directory containing your FASTA files assembled elsewhere. This will be the typical way to tell `Captus` which assemblies to import prior to marker extraction. All subdirectories will be searched for FASTA (`.fa`, `.fna`, `.fasta`, `.fa.gz`, `.fna.gz`, `.fasta.gz`) files in this case.
* ***List of files:*** you can also provide the individual path to each of your FASTA file separated by a single space. This is useful if you only want to analyze only a couple of samples within a directory with many other samples. Another use for lists is when your FASTA assembly files are located in different directories.
* ***UNIX pattern:*** another easy way to provide lists of files is using the wildcards `*` and `?` to match many or just one character respectively.

Remember, all the FASTA files provided with this option will be imported to the path set by `--captus_assemblies_dir`

This argument is optional and has no default.

---

## *Output*

---

### **`-o, --out`**

With this option you can redirect the output directory to a path of your choice, that path will be created if it doesn’t already exist.

Inside this directory, the extracted markers for each sample will be stored in a subdirectory with the ending `__captus-ext`.

This argument is optinal, the default is **./03\_extractions/**

---

### **`--ignore_depth`**

Do not filter contigs based on their depth of coverage (default behavior before version 1.1.0).

---

### **`--disable_stitching`**

Use this flag only if you are sure your target loci will be found in a single contig (for example if you have a chromosome-level assembly). By default, Captus tries to join partial matches to a target that are scattered across multiple contigs if their structure and overlaps are compatible. Internally, this activates the `--single_target_hits` option for Scipio when searching for proteins.

---

### **`--max_paralogs`**

Maximum number of secondary hits (copies) of any particular reference marker allowed in the output. We recommend disabling the removal of paralogs (secondary hits/copies) during the `extract` step because the `align` step uses a more sophisticated filter for paralogs. This can be useful for exploratory runs, for example: if after an initial run allowing all paralogs we found out that the average number of secondary hits across samples is 5, we could use this number to get rid of outliers.

This argument is optional, the default is **-1** (include all paralogs in the output).

---

### **`--paralog_tolerance`**

Only paralogs with a wscore >= (locus best hit wscore / paralog\_tolerance will be retained)

This argument is optional, the default is **5**

---

#### **`--max_loci_files`**

When the number of loci in the reference exceeds this value, `Captus` will not write a separate FASTA file per sample per marker, otherwise the hard drive fills up with tons of small files. The file that includes all the extracted markers grouped per sample is still written (this is the only file needed by the final step `align` to produce the marker alignments across all samples).

This argument is optional, the default is **0** (do not write separate loci files).

---

### **`--keep_all`**

Many intermediate files are created during the marker extraction, some are large (like `BLAT`’s `.psl` files) while others small temporary logs of intermediate steps, `Captus` deletes all the unnecesary intermediate files unless you enable this flag.

---

### **`--overwrite`**

Use this flag with caution, this will replace any previous result within the output directory (for the sample names that match).

---

## *Proteins extraction global options (Scipio)*

---

### **`--max_loci_scipio_x2`**

When the number of loci in a protein reference file exceeds this number, `Captus` will not run a second, more exhaustive round of `Scipio`. Usually the results from the first round are extremely similar and sufficient, the second round can become extremely slow as the number of reference proteins grows.

This argument is optional, the default is **2000**.

---

### **`--predict`**

Scipio flags introns as dubious when the splice signals are not found at the exon edges, this may indicate that there are additional aminoacids in the recovered protein that are not present in the reference protein. Enable this flag to attempt translation of these dubious introns, if the translation does not introduce premature stop codons they will be added to the recovered protein. Recommended if you are extracting from RNA assemblies (introns would have been removed in this type of data).

---

## *Nuclear proteins (Scipio)*

---

### **`-n, --nuc_refs`**

The reference set of nuclear proteins to search and extract from the assemblies. `Captus` includes two sets:

* `Angiosperms353` = extract the original Angiosperms353.
* `Mega353` = extract the later expanded version of Angiosperms353; because `Mega353` includes many more sequences, processing times become longer.
* Alternatively, you can provide the path to a FASTA file (e.g. `-n my_refs/my_nuclear_prots.fa`) that includes your own coding references either in nucleotide or aminoacid.

If you provide a nucleotide file, please also specify the translation table to be used, otherwise `Captus` will translate it using `--nuc_transtable 1`, the “Standard code”. See the [complete list of translation tables](https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi).

This argument is optional and has no default.

---

### **`--nuc_transtable`**

If you provide a nucleotide file for extraction you can specify the genetic code to translate it.

This argument is optional, the default is **1** (= the “Standard code”. See the [complete list of translation tables](https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi)).

---

### **`--nuc_min_score`**

Keep hits to the reference proteins that have at least this `Scipio` score. The default has been optimized to perform cross-species extraction in fragmented assemblies like the ones obtained from hybridization capture data. Accepted values are decimals from 0 to 1. For more details, read  [Scipio’s settings](https://www.webscipio.org/help/webscipio#setting).

This argument is optional, the default is **0.13**.

---

### **`--nuc_min_identity`**

Minimum percentage of identity to the reference protein for a hit to be retained. Accepted values are any number between 0 and 100. For more details, read  [Scipio’s settings](https://www.webscipio.org/help/webscipio#setting).

This argument is optional, the default is **65**.

---

### **`--nuc_min_coverage`**

Minimum percentage of coverage of the reference protein for a hit to be retained. Accepted values are any number between 0 and 100. For more details, read  [Scipio’s settings](https://www.webscipio.org/help/webscipio#setting).

This argument is optional, the default is **20**.

---

### **`--nuc_depth_tolerance`**

Minimum contig depth = 10^(log(depth of contig with best hit in locus) / nuc\_depth\_tolerance), values must be >= 1.0 (1 is the most strict).

This argument is optional, the default is **2.0**.

---

## *Plastidial proteins (Scipio)*

---

### **`-p, --ptd_refs`**

The reference set of plastidial proteins to search and extract from the assemblies. The options available are:

* `SeedPlantsPTD` = Set of chloroplast proteins that spans all Seed Plants (curated by us).
* Alternatively, you can provide the path to a FASTA file (e.g. `-p my_refs/my_plastome_prots.fa`) that includes your own coding references either in nucleotide or aminoacid.

If you provide a nucleotide file, please also specify the translation table to be used, otherwise `Captus` will translate it using `--ptd_transtable 11`, the “Bacterial, Archaeal and Plant Plastid code”. See the [complete list of translation tables](https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi).

This argument is optional and has no default.

---

### **`--ptd_transtable`**

If you provide a nucleotide file for extraction you can specify the genetic code to translate it.

This argument is optional, the default is **11** (= the “Bacterial, Archaeal and Plant Plastid code”. See the [complete list of translation tables](https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi)).

---

### **`--ptd_min_score`**

Keep hits to the reference proteins that have at least this `Scipio` score. The default has been optimized to perform cross-species extraction in fragmented assemblies like the ones obtained from hybridization capture data. Accepted values are decimals from 0 to 1. For more details, read  [Scipio’s settings](https://www.webscipio.org/help/webscipio#setting).

This argument is optional, the default is **0.2**.

---

### **`--ptd_min_identity`**

Minimum percentage of identity to the reference protein for a hit to be retained. Accepted values are any number between 0 and 100. For more details, read  [Scipio’s settings](https://www.webscipio.org/help/webscipio#setting).

This argument is optional, the default is **65**.

---

### **`--ptd_min_coverage`**

Minimum percentage of coverage of the reference protein for a hit to be retained. Accepted values are any number between 0 and 100. For more details, read  [Scipio’s settings](https://www.webscipio.org/help/webscipio#setting).

This argument is optional, the default is **20**.

---

### **`--ptd_depth_tolerance`**

Minimum contig depth = 10^(log(depth of contig with best hit in locus) / ptd\_depth\_tolerance), values must be >= 1.0 (1 is the most strict).

This argument is optional, the default is **2.0**.

---

## *Mitochondrial proteins (Scipio)*

---

### **`-m, --mit_refs`**

The reference set of mitochondrial proteins to search and extract from the assemblies. The options available are:

* `SeedPlantsMIT` = Set of mitochondrial proteins that spans all Seed Plants (curated by us).
* Alternatively, you can provide the path to a FASTA file (e.g. `-p my_refs/my_mitome_prots.fa`) that includes your own coding references either in nucleotide or aminoacid.

If you provide a nucleotide file, please also specify the translation table to be used, otherwise `Captus` will translate it using `--mit_transtable 1`, the “Standard code” which is the genetic code used by plant mitochondria. See the [complete list of translation tables](https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi).

This argument is optional and has no default.

---

### **`--mit_transtable`**

If you provide a nucleotide file for extraction you can specify the genetic code to translate it.

This argument is optional, the default is **1** (= the “Standard code”. See the [complete list of translation tables](https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi)).

---

### **`--mit_min_score`**

Keep hits to the reference proteins that have at least this `Scipio` score. The default has been optimized to perform cross-species extraction in fragmented assemblies like the ones obtained from hybridization capture data. Accepted values are decimals from 0 to 1. For more details, read  [Scipio’s settings](https://www.webscipio.org/help/webscipio#setting).

This argument is optional, the default is **0.2**.

---

### **`--mit_min_identity`**

Minimum percentage 
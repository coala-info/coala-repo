[SIDR](index.html)

latest

* [Installing SIDR](install.html)
* [Data Preparation](dataprep.html)
* [Running With Raw Input](rundefault.html)
* [Running With a Runfile](runfilerun.html)
* Runfile Example

[SIDR](index.html)

* [Docs](index.html) »
* Runfile Example
* [Edit on GitHub](https://github.com/damurdock/SIDR/blob/master/docs/runfileexample.rst)

---

# Runfile Example[¶](#runfile-example "Permalink to this headline")

SIDR’s runfile mode accepts any comma-delimited file with at least an “ID” column with the contigID, an “Origin” column with the species name as identified by an outside classification tool, and one or more variable columns with which to construct the model. One way to construct a runfile with GC content and coverage variables calcluated with [BBTools](https://jgi.doe.gov/data-and-tools/bbtools/) is described below. For this example, you will need:

* A preliminary assembly
* An alignment back to that preliminary assembly
* A copy of the NCBI Taxonomy Dump
* A local BLAST database

1. **BLAST the assembled data**:

   ```
   blastn \
   -task megablast \
   -query [assembly FASTA] \
   -db nt \
   -outfmt '6 qseqid qlen staxids bitscore std sscinames sskingdoms stitle' \
   -evalue 1e-25 \
   -max_target_seqs 2 \
   -out blast.out
   ```
2. **Select the best BLAST hits**:

   ```
   cat blast.out | awk '!_[$1]++' | cut -f 1,2,15 | sed 's/scaffold_//g' | sort -k1n > scaffold_identities.txt
   ```
3. **Use BBTools to calculate GC content and coverage**:

   ```
   pileup.sh countgc=t out=[organism].out in=[assembly BAM] ref=[assembly FASTA]
   ```
4. **Format the output from BBTools**:

   ```
   cat [organism].out | sed '1d' | sed 's/scaffold_//g' | sort -k1n > [organism].sorted
   ```
5. **Combine the BBTools and BLAST outputs**:

   ```
   paste [organism].sorted scaffold_identities.txt | cut -f 1-9,12 | sed 1i"ID          Avg_fold                Length   Ref_GC  Covered_percent                Covered_bases    Plus_reads            Minus_reads        Read_GC               Origin" | tr '\t' ',' > [organsim].csv
   ```

[Previous](runfilerun.html "Running With a Runfile")

---

© Copyright 2017, Duncan Murdock.
Revision `37d56e54`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).
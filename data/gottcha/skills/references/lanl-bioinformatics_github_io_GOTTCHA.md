[View on GitHub](https://github.com/LANL-Bioinformatics/GOTTCHA)

# GOTTCHA

### Accurate read-based metagenome characterization using a hierarchical suite of unique signatures

[Download this project as a .zip file](https://github.com/LANL-Bioinformatics/GOTTCHA/zipball/master)
[Download this project as a tar.gz file](https://github.com/LANL-Bioinformatics/GOTTCHA/tarball/master)

### What is GOTTCHA?

GOTTCHA (Genomic Origin Through Taxonomic CHAllenge) is an application of a novel, gene-independent and signature-based metagenomic
taxonomic profiling method with significantly smaller false discovery rates (FDR) that is also
laptop deployable. Our algorithm was tested and validated on twenty synthetic and mock
datasets ranging in community composition and complexity, was applied successfully to data
generated from spiked environmental and clinical samples, and robustly demonstrates
superior performance compared with other available tools.

---

### What's new?

GOTTCHA v1.0c released (2017/11/09):- Support long reads (read length >65535bp).
- Use rolled up depth of coverage at strain level to calculate relative abundance by default. This change significantly improves abundance estimation of organisms with less than 1 depth of coverage.
- Fix bugs.

GOTTCHA\_database\_v20150825 Released (2015/09/21):- We have updated GOTTCHA pre-computed bacterial and viral databases at 7 major levels. They are available at our ftp site. The new signature databases were generated using NCBI RefSeq complete genomes (as of 2015/08/25). For more details and improvements about the new databases, please visit the release note.

Updates (2015/07/20):- Databases can be downloaded through FTP server ftp://ftp.lanl.gov/public/genome/gottcha/.
  As a backup source, the human genome removed databases are also hosted at [Google Drive](https://drive.google.com/folderview?id=0B7RPWOdnygzafkNMZklSWXVic0c3LXhyTzFGaFR5QmNtLWFNSUpJdWltMnRlVXpIUmZuU3M&usp=sharing).
- Note that we took links off our web server due to LANL security policy.

GOTTCHA v1.0b released (2015/05/22):- Support multiple input files.
- The mapping result in SAM format can be dumpped using "--dumpSam" option.
- Fixed bugs.

Some major changes have been made in the v1.0 release:- The number of classified reads is reported in the READ\_COUNT column of the output.
- The number of split-trimmed reads that hit to plasmids is reported in the HIT\_COUNT\_PLASMID column of the output.
- GOTTCHA can now remove the plasmid hits using "--noPlasmidHit" option.

Note: The plasmid-related results and the "--noPlasmidHit" option need the new parsed databases to work properly. For users who downloaded the databases before 30th March 2015,
we encourage you to download the new parsed database (\*.parsedGOTTCHA.dmp) to replace the old one. GOTTCHA v1.0 still supports old databases but
plasmid relative results will show zero due to absence of the plasmid information. Please click [here](https://github.com/LANL-Bioinformatics/GOTTCHA#obtaining-pre-computed-databases) for more details.

---

### Can my system run GOTTCHA?

Either Linux (2.6 kernel or later) or Mac OS (OSX 10.6 Snow Leopard or later)
with a minimum of 8 GB of RAM is recommended. Perl v5.8 or above is required. The C/C++
compiling enviroment might be required for installing dependencies. Systems may vary.
Please assure that your system has the essential software building packages (e.g. build-essential
for Ubuntu, XCODE for Mac...etc) installed properly before running the installing
script.

GOTTCHA was tested successfully on our Linux servers (Ubuntu 12.10 w/ Perl v5.14.2;
Ubuntu 10.04 w/ Perl v5.10.1) and Macbook Pro laptops (MAC OSX 10.8 w/ XCODE v5.1).

---

### How to install GOTTCHA?

The installation guide and a quick tutorial can be found on the [Github page](https://github.com/LANL-Bioinformatics/GOTTCHA). A more detailed description can be found in [this section](https://github.com/LANL-Bioinformatics/GOTTCHA/tree/master#detail-instructions).

---

### Discussions / Bugs Reporting

We have created a mailing list for GOTTCHA users. If you would like to recieve notifications about the updates and join the discussion, please join the mailing list by becoming the member of GOTTCHA-users groups.

[GOTTCHA user's google group](https://groups.google.com/d/forum/gottcha-users)

Despite all these efforts, there are potential bugs and issues. Please help us to make it better by reporting them to GitHub issue tracker.

[GOTTCHA issue tracker](https://github.com/LANL-Bioinformatics/GOTTCHA/issues)

Any other questions? You are welcome to contact Po-E (Paul) Li via po-e[at]lanl.gov.

---

### How to Run GOTTCHA? (The "I Can't Wait!" instructions)

This is a quick example of profiling a "test.fastq" file using GOTTCHA with a species-level
pre-computed bacterial database. The testing FASTQ file comes along with the GOTTCHA package
in the "test" directory. More details are stated in the INSTRUCTION section.

1. Obtaining the GOTTCHA package:

   ```
   $ git clone https://github.com/LANL-Bioinformatics/GOTTCHA.git gottcha

   ```
2. Installing GOTTCHA:

   ```
   $ cd gottcha
   $ ./INSTALL.sh
   ```
3. Downloading lookup table and species-level database from our web server:

   ```
   $ wget ftp://ftp.lanl.gov/public/genome/gottcha/latest/GOTTCHA_lookup.tar.gz
   $ wget ftp://ftp.lanl.gov/public/genome/gottcha/latest/GOTTCHA_BACTERIA_c4937_k24_u30_xHUMAN3x.species.tar.gz
   ```

   If you have any difficulty obtaining the databases, please contact us.
4. Unpacking and decompressing the previous downloads:

   ```
   $ tar -zxvf GOTTCHA_lookup.tar.gz
   $ tar -zxvf GOTTCHA_BACTERIA_c4937_k24_u30_xHUMAN3x.species.tar.gz
   ```
5. Running gottcha.pl:

   ```
   $ bin/gottcha.pl              \
         --threads 8             \
         --outdir ./             \
         --input test/test.fastq \
         --database database/GOTTCHA_BACTERIA_c4937_k24_u30_xHUMAN3x.species
   ```
6. Enjoying the result at './test.gottcha.tsv'.

### --- What's the output?

GOTTCHA reports profiling results in a neat summary table (\*.gottcha.tsv) by default.
The tsv file will list the organism(s) at all taxonomic levels from STRAIN to PHYLUM,
their linear length, total bases mapped, linear depth of coverage, and the normalized
linear depth of coverage. The linear depth of coverage (LINEAR\_DOC) is used to calculate
relative abundance of each organism or taxonomic name in the sample.

Summary table:

| Column | Description |
| --- | --- |
| LEVEL | taxonomic rank |
| NAME | taxonomic name |
| REL\_ABUNDANCE | relative abundance (equivalent to NORM\_COV by default) |
| LINEAR\_LENGTH | number of non-overlapping bases covering the signatures |
| TOTAL\_BP\_MAPPED | sum total of all hit lengths recruited to signatures |
| HIT\_COUNT | number of hits recruited to signatures |
| HIT\_COUNT\_PLASMID | number of hits recruited to signatures |
| READ\_COUNT | number of reads recruited to signatures |
| LINEAR\_DOC | linear depth-of-coverage (TOTAL\_BP\_MAPPED / LINEAR\_LENGTH) |
| NORM\_COV | normalized linear depth-of-coverage (LINEAR\_DOC / SUM(LINEAR\_DOC in certain level)) |

### How to visualize the result?

[Krona](http://sourceforge.net/p/krona/home/krona/) is an interactive browser that allows
the exploration of hierarchical data with pie charts. Assuming you have Krona installed properly,
you are going to create a Krona chart from a text file listing abundance and lineages.
You must run GOTTCHA with the "--mode all" option; Use ".lineage.tsv" file found in the "\_temp" directory to run krona.

Use 'ktImportText' and save the chart to "test.krona.html":

```
    $ ktImportText test_temp/test.lineage.tsv -o test.krona.html
```

---

### Citation

Please cite GOTTCHA in your publications:

Tracey Allen K. Freitas, Po-E Li, Matthew B. Scholz and Patrick S. G. Chain (2015) **Accurate read-based metagenome characterization using a hierarchical suite of unique signatures,** Nucleic Acids Research (DOI: 10.1093/nar/gkv180)

GOTTCHA is maintained by Bioscience Div, [Los Alamos National Laboratory](http://www.lanl.gov/)

Published with [GitHub Pages](https://pages.github.com)

This project is funded by U.S. Defense Threat Reduction Agency [R-00059-12-0].
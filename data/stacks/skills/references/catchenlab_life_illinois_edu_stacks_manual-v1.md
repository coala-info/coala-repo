[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## *Stacks* Manual

Julian Catchen1, William A. Cresko2, Paul A. Hohenlohe3, Angel Amores4, Susan Bassham2, John Postlethwait4

|  |  |  |  |
| --- | --- | --- | --- |
| 2Department of Animal Biology  University of Illinois at Urbana-Champaign  Urbana, Illinois, 61820  USA | 2Institute of Ecology and Evolution  University of Oregon  Eugene, Oregon, 97403-5289  USA | 3Biological Sciences  University of Idaho  875 Perimeter Drive MS 3051  Moscow, ID 83844-3051  USA | 4Institute of Neuroscience  University of Oregon  Eugene, Oregon, 97403-1254  USA |

1. [Introduction](#intro)
2. [Installation](#install)
3. [What types of data does Stacks support?](#data)
   1. Sequencer Type
   2. Paried-end Reads
   3. Protocol Type
4. [Running the pipeline](#pipe)
   1. [Clean the data](#clean)
   2. [Align data against a reference genome](#align)
   3. [Run the pipeline](#prun)
      1. denovo\_map.pl versus ref\_map.pl
      2. Choosing parameters for building stacks *de novo*
      3. Examples
      4. [The Population Map](#popmap)
      5. [Whitelists and Blacklists](#wl)
      6. [Using the Database](#db)
      7. Separating Pipeline Execution from the Database
   4. [Run the pipeline by hand](#phand)
   5. [Using the corrections module](#corr)
   6. [Exporting data from Stacks](#export)
      1. Exporting data for STRUCTURE
      2. Exporting data for Adegenet
5. [Pipeline Components](#comps)
6. [What do the fields mean in Stacks output files?](#files)

1. [ustacks / pstacks](#ufiles)
   1. XXX.tags.tsv
   2. XXX.snps.tsv
   3. XXX.alleles.tsv
2. [cstacks](#cfiles)
3. [sstacks](#sfiles)
   1. XXX.matches.tsv
4. [populations](#pfiles)
   1. batch\_X.sumstats.tsv
   2. batch\_X.sumstats\_summary.tsv
   3. batch\_X.fst\_Y-Z.tsv
   4. batch\_X.hapstats.tsv
   5. batch\_X.phistats.tsv
   6. batch\_X.phistats\_Y-Z.tsv
   7. [batch\_X.fa - FASTA output](#pop_fasta)
   8. batch\_X.genomic.tsv

7. [Using vStacks](#vstacks)

### Introduction [[⇑top](#top)]

---

Several molecular approaches have been developed to focus short reads to specific,
restriction-enzyme anchored positions in the genome. Reduced representation techniques
such as CRoPS, RAD-seq, GBS, double-digest RAD-seq, and 2bRAD effectively subsample the
genome of multiple individuals at homologous locations, allowing for single nucleotide
polymorphisms (SNPs) to be identified and typed for tens or hundreds of thousands of
markers spread evenly throughout the genome in large numbers of individuals. This family
of reduced representation genotyping approaches has generically been called
genotype-by-sequencing (GBS) or Restriction-site Associated DNA sequencing (RAD-seq). For
a review of these technologies, see
[Davey et al. 2011](http://www.nature.com/nrg/journal/v12/n7/abs/nrg3012.html).

*Stacks* is designed to work with any restriction-enzyme based data, such as GBS, CRoPS, and
both single and double digest RAD. *Stacks* is designed as a modular pipeline to efficiently
curate and assemble large numbers of short-read sequences from multiple samples. *Stacks*
identifies loci in a set of individuals, either de novo or aligned to a reference genome
(including gapped alignments), and then genotypes each locus. *Stacks* incorporates a
maximum likelihood statistical model to identify sequence polymorphisms and distinguish
them from sequencing errors. *Stacks* employs a Catalog to record all loci identified in a
population and matches individuals to that Catalog to determine which haplotype alleles
are present at every locus in each individual.

*Stacks* is implemented in C++ with wrapper programs written in Perl. The core algorithms
are multithreaded via OpenMP libraries and the software can handle data from hundreds of
individuals, comprising millions of genotypes. *Stacks* incorporates a MySQL database
component linked to a web front end that allows efficient data visualization, management
and modification.

*Stacks* proceeds in five major stages. First, reads are demultiplexed and cleaned by the
process\_radtags program. The next three stages comprise the main *Stacks* pipeline: building
loci (ustacks/pstacks), creating the
catalog of loci (cstacks), and matching against the catalog
(sstacks). In the fifth stage, either the populations or genotypes program is
executed, depending on the type of input data. This flow is diagrammed in the following
figure.

![Stacks Pipeline](stacks_full_pipeline.png)

The *Stacks* pipeline.

---

### Installation [[⇑top](#top)]

---

#### Prerequisites

*Stacks* should build on any standard UNIX-like environment (Apple OS X, Linux,
etc.) *Stacks* is an independent pipeline and can be run without any additional
external software. To visualize *Stacks*’ data, however, *Stacks*
provides a web-based interface which depends on several other pieces of software.

Note: Apple OS X does not use the [GNU Compiler Collection](https://gcc.gnu.org/),
which is standard on Linux-based systems. Instead, Apple uses and distributes
[CLANG](http://clang.llvm.org/), which is a nice compiler but does not
yet support the OpenMP library which *Stacks* relies on for parallel processing.
Confusingly, there is a g++ command on Apple systems, but
it is just an alias for the CLANG compiler. *Stacks* can still be built
and run on an Apple system, however, you will have to disable building
with OpenMP (supply the --disable-openmp flag to
configure) and use non-parallelized code. If you want to install a parallelized
version of *Stacks*, you can install GCC by hand, or using a package system such as
Homebrew ([http://brew.sh](http://brew.sh/))
or MacPorts (<http://www.macports.org/>).

#### Install Optional Component for Wrapper Scripts

Several Perl scripts are distributed with *Stacks* to upload pipeline output
to the MySQL database server. For these to work, you must have the Perl DBI module
installed with the MySQL driver.

If you are running a version of Linux, the above software can be installed via the
package manager. If you are using Ubuntu, you can install the following package:

% sudo apt-get install libdbd-mysql-perl

A similar set of commands can be executed on Debian using apt-get, or on a RedHat derived Linux
system using yum, or another package manager on other Linux distributions.

#### Build the software

*Stacks* uses the standard autotools install:

% tar xfvz stacks-x.xx.tar.gz
% cd stacks-x.xx
% ./configure
% make
(become root)
# make install
(or, use sudo)
% sudo make install

You can change the root of the install location (/usr/local/ on most
operating systems) by specifying the --prefix command line option to
the configure script.

% ./configure --prefix=/home/smith/local

You can speed up the build if you have more than one processor:

% make -j 8

A default install will install files in the following way:

|  |  |
| --- | --- |
| /usr/local/bin | Stacks executables and Perl scripts. |
| /usr/local/share/stacks | PHP files for the web interface and SQL files for creating the MySQL database. |

The pipeline is now ready to run. The remaining install instructions are to get the
web interface up and running. The web interface is very useful for visualization and
more or less required for building genetic maps. However, Stacks does not depend on
the web interface to run.

#### The Stacks Web Interface

To visualize data, *Stacks* uses a web-based interface (written in PHP) that
interacts with a MySQL database server. MySQL provides various functions to store,
sort, and export data from a database.

##### Prerequisites

Most server installations will provide Apache, MySQL, Perl, and PHP by default. If you
want to export data in Microsoft Excel Spreadsheets, you will need the
Spreadsheet::WriteExcel Perl module. While installing these components is beyond these
instructions, here are some links that might be useful:

1. MySQL Database: <http://dev.mysql.com/downloads/mysql/>
2. Spreadsheet Perl Module: <http://search.cpan.org/~jmcnamara/Spreadsheet-WriteExcel-2.40/>

If you are running a version of Linux, the above software can be installed via the
package manager. If you are using Ubuntu, you can install the following packages:

% sudo apt-get install mysql-server mysql-client
% sudo apt-get install php5 php5-mysqlnd
% sudo apt-get install libspreadsheet-writeexcel-perl

A similar set of commands can be executed on Debian using apt-get, or on a RedHat derived Linux
system using yum, or another package manager on other Linux distributions.

##### Edit the MySQL configuration file

Edit the MySQL configuration file, installed in
/usr/local/share/stacks/sql/mysql.cnf.dist, to enable access to the
database from the *Stacks* scripts.

% cd /usr/local/share/stacks/sql/
% cp mysql.cnf.dist mysql.cnf

Edit the file to reflect the proper username, password, and host to
use to access MySQL.

The various scripts that access the database will search for a MySQL
configuration file in your home directory before using the
*Stacks*-distributed copy. If you already have a personal account set up
and configured (in ~/.my.cnf) you can continue to use these
credentials instead of setting up new, common ones.

If you just installed MySQL and have not added any users, you can do so with these
commands:

% mysql
mysql> GRANT ALL ON \*.\* TO 'stacks\_user'@'localhost' IDENTIFIED BY 'stackspassword';

Edit /usr/local/share/stacks/sql/mysql.cnf to contain the username and password
you specified to MySQL.

(This information was taken from: <http://dev.mysql.com/doc/refman/5.1/en/grant.html>)

##### Enable the *Stacks* web interface in the Apache webserver.

Add the following lines to your Apache configuration to make the *Stacks* PHP
files visible to the web server and to provide a easily readable URL to access
them:

<Directory "/usr/local/share/stacks/php">
Order deny,allow
Deny from all
Allow from all
Require all granted
</Directory>
Alias /stacks "/usr/local/share/stacks/php"

A sensible way to do this is to create the file stacks.conf with the above lines.

##### If you are using Apache 2.3 or earlier:

Place the stacks.conf file in either
/etc/apache2/conf.d/ or /etc/httpd/conf.d/
directory (depending on your Linux distro) and restart the apache server:

# vi /etc/apache2/conf.d/stacks.conf
# apachectl restart

(See the Apache configuration for more information on what these do:
<http://httpd.apache.org/docs/2.0/mod/core.html#directory>)

##### If you are using Apache 2.4 or later:

Place the stacks.conf file in the

/etc/apache2/conf-available

directory and then create a symlink to it in the

/etc/apache2/conf-enabled

directory. Then restart Apache. Like so:

# vi /etc/apache2/conf-available/stacks.conf
# ln -s /etc/apache2/conf-available/stacks.conf /etc/apache2/conf-enabled/stacks.conf
# apachectl restart

##### Provide access to the MySQL database from the web interface

Edit the PHP configuration file (constants.php.dist) to allow it access to the
MySQL database. Change the file to include the proper database
username ($db\_user), password ($db\_pass), and
hostname ($db\_host). Rename the distribution file so it is active.

% cp /usr/local/share/stacks/php/constants.php.dist /usr/local/share/stacks/php/constants.php
% vi /usr/local/share/stacks/php/constants.php

You may find it advantageous to create a specific MySQL user with limited
permissions - SELECT, UPDATE,
and DELETE to allow users to interact
with the database through the web interface.

##### Enable web-based exporting from the MySQL database

Edit the stacks\_export\_notify.pl script to specify the email and SMTP
server to use in notification messages.

Ensure that the permissions of the php/export directory allow the
webserver to write to it. Assuming your web server user is 'www':

% chown www /usr/local/share/stacks/php/export

---

### What types of data does *Stacks* support? [[⇑top](#top)]

---

*Stacks* is designed to process data that *stacks* together. Primarily this consists of restriction
enzyme-digested DNA. There are a few similar types of data that will stack-up and could be processed by
*Stacks*, such as DNA flanked by primers as is produced in metagenomic 16S rRNA studies.

The goal in *Stacks* is to assemble loci in large numbers of individuals in a population or
genetic cross, call SNPs within those loci, and then read haplotypes from them. Therefore *Stacks*
wants data that is a uniform length, with coverage high enough to confidently call SNPs. Although it is very
useful in other bioinformatic analyses to variably trim raw reads, this creates loci that have variable coverage,
particularly at the 3’ end of the locus. In a population analysis, this results in SNPs that are
called in some individuals but not in others, depending on the amount of trimming that went into the reads
assembled into each locus, and this interferes with SNP and haplotype calling in large populations.

#### Protocol Type

*Stacks* supports all the major restriction-enzyme digest protocols such as RAD-seq, double-digest
RAD-seq, and GBS, among others. For double-digest RAD data that has been paired-end sequenced, *Stacks*
supports this type of data by treating the loci built from the single-end and paired-end as two independent
loci. In the near future, we will support merging these two loci into a single haplotype.

#### Sequencer Type

*Stacks* is optimized for short-read, Illumina-style sequencing. There is no limit to the length
the sequences can be, although there is a hard-coded limit of 1024bp in the source code now for efficency
reasons, but this limit could be raised if the technology warranted it.

*Stacks* can also be used with data produced by the Ion Torrent platform, but that platform
produces reads of multiple lengths so to use this data with *Stacks* the reads have to be
truncated to a particular length, discarding those reads below the chosen length. The
process\_radtags program can truncate the reads from an Ion Torrent run.

Other sequencing technologies could be used in theory, but often the cost versus the number of
reads obtained is prohibitive for building stacks and calling SNPs.

#### Paired-end Reads

*Stacks* does not directly support paired-end reads where the paired-end read is not anchored by
a second restriction enzyme. In the case of double-digest RAD, both the single-end and paired-end read are
anchored by a restriction enzyme and can be assembled as independent loci. In cases such as with the RAD
protocol, where the molecules are sheared and the paired-end therefore does not stack-up, cannot be directly
used. However, they can be indirectly used by say, building contigs out of the paired-end reads that can be
used to build phylogenetic trees or to identify orthologous genes and *Stacks* includes some tools
to help do that.

---

### Running the pipeline [[⇑top](#top)]

---

#### Clean the data

In a typical analysis, data will be received from an Illumina sequencer, or some other
type of sequencer as FASTQ files. Th
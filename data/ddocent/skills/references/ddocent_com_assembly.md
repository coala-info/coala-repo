Toggle navigation

[dDocent](https://jpuritz.github.io/dDocent/)

* [Why dDocent?](/why)
* Documentation

  [Quick Start Guide](/quick)
  [Full User Guide](/UserGuide)
  [Assembly Tutorial](/assembly)
  [SNP Filtering Tutorial](/filtering)
  [Citing dDocent](/citing)
  [Papers using dDocent](/using)
* Download

  [Bioconda Download and Install](/bioconda)
  [Current Release and Manual Install](/downloads)
  [Developmental Version](https://github.com/jpuritz/dDocent)
* [Blog](/blog)
* [Help](/help)

[![](/dDocent.png)](https://jpuritz.github.io/dDocent/%20)

# Reference Assembly Tutorial

---

Designed by Jon Puritz

**NOTE: You can download the RefTut file from the repository and run this tutorial from the command line**

# GOALS

1. To demultiplex samples with process\_radtags and rename samples
2. To use the methods of dDocent (via rainbow) to assemble reference contigs
3. To learn how optimize a de novo reference assembly

*dDocent must be properly installed for this tutorial to work*

Start by downloading a small test dataset

```
curl -L -o data.zip https://www.dropbox.com/s/t09xjuudev4de72/data.zip?dl=0
```

Let’s check that everything went well.

```
unzip data.zip
ll
```

You should see something like this:

```
Archive:  data.zip
  inflating: SimRAD.barcodes
  inflating: SimRAD_R1.fastq.gz
  inflating: SimRAD_R2.fastq.gz
  inflating: simRRLs2.py
total 7664
-rw-rw-r--. 1 j.puritz j.puritz 3127907 Mar  1 10:26 data.zip
-rwxr--r--. 1 j.puritz j.puritz     600 Mar  6  2015 SimRAD.barcodes
-rwxr--r--. 1 j.puritz j.puritz 2574784 Mar  6  2015 SimRAD_R1.fastq.gz
-rwxr--r--. 1 j.puritz j.puritz 2124644 Mar  6  2015 SimRAD_R2.fastq.gz
-rwxr--r--. 1 j.puritz j.puritz   12272 Mar  6  2015 simRRLs2.py
```

The data that we are going to use was simulated using the simRRLs2.py script that I modified from the one published by Deren Eaton. You can find the original version [here](http://dereneaton.com/software/simrrls/). Basically, the script simulated ddRAD 1000 loci shared across an ancestral population and two extant populations. Each population had 180,000 individuals, and the two extant
population split from the ancestral population 576,000 generations ago and split from each other 288,000 generation ago. The two populations exchanged 4N\*0.001 migrants per generation until about 2,000 generations ago. 4Nu equaled 0.00504 and mutations had a 10% chance of being an INDEL polymorphism. Finally, reads for each locus were simulated on a per individual basis at a mean of 20X coverage (coming from a normaldistribution with a SD 8) and had an inherent sequencing error rate of 0.001.

In short, we have two highly polymorphic populations with only slight levels of divergence from each other. GST should be approximately
0.005. The reads are contained in the two fastq.gz files.

Let’s go ahead and demultiplex the data. This means we are going to separate individuals by barcode.
My favorite software for this task is process\_radtags from the Stacks package (http://creskolab.uoregon.edu/stacks/) process\_radtags takes fastq or fastq.gz files as input along with a file that lists barcodes. Data can be separated according to inline
barcodes (barcodes in the actual sequence), Illumina Index, or any combination of the two. Check out the manual at this website (http://creskolab.uoregon.edu/stacks/comp/process\_radtags.php)

Let’s start by making a list of barcodes. The SimRAD.barcodes file actually has the sample name and barcode listed. See for yourself.

You should see:

```
PopA_01 ATGGGG
PopA_02 GGGTAA
PopA_03 AGGAAA
PopA_04 TTTAAG
PopA_05 GGTGTG
PopA_06 TGATGT
PopA_07 GGTTGT
PopA_08 ATAAGT
PopA_09 AAGATA
PopA_10 TGTGAG
```

We need to turn this into a list of barcodes. We can do this easily with the cut command.

```
cut -f2 SimRAD.barcodes > barcodes
```

Now we have a list of just barcodes. The cut command let’s you select a column of text with the -f (field command). We used -f2 to get the second column.

```
head barcodes
```

Now we can run process\_radtags

```
process_radtags -1 SimRAD_R1.fastq.gz -2 SimRAD_R2.fastq.gz -b barcodes -e ecoRI --renz_2 mspI -r -i gzfastq
```

The option -e specifies the 5’ restriction site and `--renze_2` specifes the 3’ restriction site. `-i` states the format of the input
sequences.The `-r` option tells the program to fix cut sites and barcodes that have up to 1-2 mutations in them. This can be changed
with the `--barcode_dist flag`.

Once the program is completed. Your output directory should have several files that look like:
`sample_AAGAGG.1.fq.gz, sample_AAGAGG.2.fq.gz, sample_AAGAGG.rem.1.fq.gz, and sample_AAGAGG.rem.2.fq.gz`

The *.rem.*.fq.gz files would normally have files that fail process\_radtags (bad barcode, ambitious cut sites), but we have
simulated data and none of those bad reads. We can delete.

```
rm *rem*
```

The individual files are currently only names by barcode sequence. We can rename them in an easier convention using a simple bash script.
Download the “Rename\_for\_dDocent.sh” script from my github repository

```
curl -L -O https://github.com/jpuritz/dDocent/raw/master/Rename_for_dDocent.sh
```

Take a look at this simple script

```
cat Rename_for_dDocent.sh
```

Bash scripts are a wonderful tool to automate simple tasks. This script begins with an If statement to see if a file was provided as input. If the file is not it exits and says why. The file it requires is a two column list with the sample name in the first column and sample barcode in the second column. The script reads all the names into an array and all the barcodes into a second array, and then gets the length of both arrays. It then iterates with a for loop the task of renaming the samples.

Now run the script to rename your samples and take a look at the output

```
bash Rename_for_dDocent.sh SimRAD.barcodes
ls *.fq.gz
```

There should now be 40 individually labeled .F.fq.gz and 40 .R.fq.gz. Twenty from PopA and Twenty from PopB.
Now we are ready to rock!

Let’s start by examining how the dDocent pipeline assembles RAD data.

First, we are going to create a set of unique reads with counts for each individual

```
ls *.F.fq.gz > namelist
sed -i'' -e 's/.F.fq.gz//g' namelist
AWK1='BEGIN{P=1}{if(P==1||P==2){gsub(/^[@]/,">");print}; if(P==4)P=0; P++}'
AWK2='!/>/'
AWK3='!/NNN/'
PERLT='while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}'

cat namelist | parallel --no-notice -j 8 "zcat {}.F.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.forward"
cat namelist | parallel --no-notice -j 8 "zcat {}.R.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.reverse"
cat namelist | parallel --no-notice -j 8 "paste -d '-' {}.forward {}.reverse | mawk '$AWK3' | sed 's/-/NNNNNNNNNN/' | perl -e '$PERLT' > {}.uniq.seqs"
```

The first four lines simply set shell variables for various bits of AWK and perl code, to make parallelization with GNU-parallel easier. The first line after the variables, creates a set of forward reads for each individual by using mawk (a faster, c++ version of awk) to sort through the fastq file and strip away the quality scores. The second line does the same for the PE reads. Lastly, the final line concatentates the forward and PE reads together (with 10 Ns between them) and then find the unique reads within that individual and counts the occurences (coverage).

Now we can take advantage of some of the properties for RAD sequencing. Sequences with very small levels of coverage within an individual are likely to be sequencing errors. So for assembly we can eliminate reads with low copy numbers to remove non-informative data!

Let’s sum up the number the within individual coverage level of unique reads in our data set

```
cat *.uniq.seqs > uniq.seqs
for i in {2..20};
do
echo $i >> pfile
done
cat pfile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniq.seqs | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.data
rm pfile
```

This is another example of a BASH for loop. It uses mawk to query the first column and
select data above a certain copy number (from 2-20) and prints that to a file.

Take a look at the contents of uniqseq.data

```
more uniqseq.data
```

We can even plot this to the terminal using gnuplot

```
gnuplot << \EOF
set terminal dumb size 120, 30
set autoscale
set xrange [2:20]
unset label
set title "Number of Unique Sequences with More than X Coverage (Counted within individuals)"
set xlabel "Coverage"
set ylabel "Number of Unique Sequences"
plot 'uniqseq.data' with lines notitle
pause -1
EOF
```

```
                       Number of Unique Sequences with More than X Coverage (Counted within individuals)
  Number of Unique Sequences
    70000 ++----------+-----------+-----------+-----------+----------+-----------+-----------+-----------+----------++
          +           +           +           +           +          +           +           +           +           +
          |                                                                                                          |
    60000 ******                                                                                                    ++
          |     ******                                                                                               |
          |           ******                                                                                         |
          |                 ******                                                                                   |
    50000 ++                      *****                                                                             ++
          |                            *                                                                             |
          |                             *****                                                                        |
    40000 ++                                 *                                                                      ++
          |                                   ******                                                                 |
          |                                         *****                                                            |
          |                                              *                                                           |
    30000 ++                                              *****                                                     ++
          |                                                    *                                                     |
          |                                                     *****                                                |
    20000 ++                                                         ******                                         ++
          |                                                                ******                                    |
          |                                                                      ******                              |
          |                                                                            ******                        |
    10000 ++                                                                                 ************           ++
          |                                                                                              *************
          +           +           +           +           +          +           +           +           +           +
        0 ++----------+-----------+-----------+-----------+----------+-----------+-----------+-----------+----------++
          2           4           6           8           10         12          14          16          18          20
                                                           Coverage
```

Now we need to choose a cutoff value.
We want to choose a value that captures as much of the diversity of the data as possible
while simultaneously eliminating sequences that are likely errors.
Let’s try 4

```
parallel --no-notice -j 8 mawk -v x=4 \''$1 >= x'\' ::: *.uniq.seqs | cut -f2 | perl -e 'while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}' > uniqCperindv
wc -l uniqCperindv
```

We’ve now reduced the data to assemble down to 7598 sequences!
But, we can go even further.
Let’s now restrict data by the number of different individuals a sequence appears within.

```
for ((i = 2; i <= 10; i++));
do
echo $i >> ufile
done

cat ufile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniqCperindv | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.peri.data
rm ufile
```

Again, we can plot the data:

```
gnuplot << \EOF
set terminal dumb size 120, 30
set autoscale
unset label
set title "Number of Unique Sequences present in more than X Individuals"
set xlabel "Number of Individuals"
set ylabel "Number of Unique Sequences"
plot 'uniqseq.peri.data' with lines notitle
pause -1
EOF
```

```
                                 Number of Unique Sequences present in more than X Individuals
  Number of Unique Sequences
    6000 ++------------+------------+-------------+------------+-------------+------------+-------------+-----------++
         +             +            +             +            +             +            +             +            +
         |                                                                                                           |
    5500 *****                                                                                                      ++
         |    **                                                                                                     |
    5000 ++     ***                                                                                                 ++
         |         ***                                                                                               |
         |            *                                                                                              |
    4500 ++            *****                                                                                        ++
         |                  ****                                                                                     |
         |                      ***                                                                                  |
    4000 ++                        *                                                                                ++
         |                          ***********                                                                      |
    3500 ++                                    ***                                                                  ++
         |                                        **********                                                         |
         |                                                  ***                        
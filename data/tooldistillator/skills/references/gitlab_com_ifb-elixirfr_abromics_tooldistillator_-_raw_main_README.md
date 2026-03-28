# ToolDistillator: a tool to extract and aggregate information from different tool outputs to JSON parsable files
![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-brightgreen.svg)
![Python Version](https://img.shields.io/badge/Python-3.9-blue)
![GitHub release](https://img.shields.io/badge/release-1.0.5-blue)
ToolDistillator is a tool to extract information from output files of [specific tools](#available-tools), expose it as JSON files, and aggregate over several tools.
It can produce both a single file to each tool or a summarized file from a set of reports.
It was initially developped to be used on [Galaxy](https://galaxyproject.org/) and some options are only available on Galaxy (\*e.g.\* extract the historic ID from a galaxy analysis).
Tool was inspirated from the [hAMRonization](https://github.com/pha4ge/hAMRonization) project (author: @dfornika, @fmaguire, @raphenya, @jodyphelan, @pvanheus)
# Content
- [Installation](#installation)
- [Requirement](#requirement)
- [Conda installation](#conda-installation)
- [Github installation](#github-installation)
- [Usage](#usage)
- [Command list](#command-list)
- [Tool specification](#tool-specification)
- [Parse multiple same inputs](#parse-multiple-same-inputs)
- [Aggregate JSON reports from different tools](#aggregate-json-reports-from-different-tools)
- [Available tools](#available-tools)
- [Abricate](#abricate)
- [AMRFinderPlus](#amrfinderplus)
- [argNorm](#argnorm)
- [Bakta](#bakta)
- [Bakta specification](#bakta-specification)
- [Bandage](#bandage)
- [Bracken](#bracken)
- [BWA](#bwa)
- [Checkm2](#checkm2)
- [Concoct](#concoct)
- [CoreProfiler](#coreprofiler)
- [CoverM](#coverm)
- [DasTool](#dastool)
- [DeepARG](#deeparg)
- [dRep](#drep)
- [EggNOG-mapper](#eggnog-mapper)
- [Fastp](#fastp)
- [Fastqc](#fastqc)
- [Filtlong](#filtlong)
- [Flye](#flye)
- [Groot](#groot)
- [GTDB-tk](#gtdb-tk)
- [Integronfinder2](#integronfinder2)
- [ISEScan](#isescan)
- [Kraken2](#kraken2)
- [MaxBin2](#maxbin2)
- [Megahit](#megahit)
- [Metabat2](#metabat2)
- [MMseqs2 linclust](#mmseqs2linclust)
- [MMseqs2 taxonomy](#mmseqs2taxonomy)
- [MultiQC](#multiqc)
- [Plasmidfinder](#plasmidfinder)
- [Polypolish](#polypolish)
- [Prodigal](#prodigal)
- [Quast](#quast)
- [Recentrifuge](#recentrifuge)
- [RefseqMasher](#refseqmasher)
- [Shovill](#shovill)
- [StarAMR](#staramr)
- [Sylph](#sylph)
- [Sylph-tax](#sylph-tax)
- [Tabular\\_file](#tabular\_file)
- [Galaxy version (under progress)](#galaxy-version-under-progress)
- [Citation](#citation)
- [Licence](#licence)
- [Contact](#contact)
# Installation
## Requirement
- Python > 3.8
- pandas
- biopython
## Conda installation
```console
$ conda --name tooldistillator --channel bioconda tooldistillator
```
## Installation from sources
1. Clone the GitLab repository
```console
$ git clone https://gitlab.com/ifb-elixirfr/abromics/tooldistillator.git
```
2. Move inside the created folder
```console
$ cd tooldistillator
```
3. Install dependencies
```console
$ pip install .
```
# Usage
## Command list
```console
$ tooldistillator --help
usage: tooldistillator
Extract information from tool output(s) to JSON and/oraggregate several JSON reports
options:
-h, --help show this help message and exit
-v, --version show program's version number and exit
--logfile LOGFILE Log file location
Tools:
{abricate,amrfinderplus,argnorm,bakta,bandage,bracken,bwa,checkm2,coreprofiler,concoct,coverm,dastool,deeparg,drep,eggnogmapper,fastp,fastqc,filtlong,flye,groot,gtdbtk,integronfinder2,isescan,kraken2,maxbin2,megahit,metabat2,mmseqs2linclust,mmseqs2taxonomy,multiqc,plasmidfinder,polypolish,prodigal,quast,recentrifuge,refseqmasher,shovill,staramr,sylph,sylphtax,tabular\_file,tooltest,summarize}
abricate Extract information from abricate's output report i.e., OUTPUT.tsv
amrfinderplus Extract information from amrfinderplus's output report i.e., report.tsv
argnorm Extract information from argnorm's output report i.e., output.tsv
bakta Extract information from bakta's output report i.e., OUTPUT.json
bandage Extract information from bandage's output report i.e., OUTPUT.txt
bracken Extract information from bracken's output report i.e., report.tsv
bwa Extract information from bwa's output report i.e., input.bam
checkm2 Extract information from checkm2's output report i.e., quality\_report.tsv
concoct Extract information from concoct's output report i.e., merge\_cut\_clusters.csv
coreprofiler Extract information from coreprofiler's output report i.e., results.tsv
coverm Extract information from coverm coverage output report i.e., coverage\_report.tsv
dastool Extract information from dastool's summary report i.e., summary\_bins.tabular
deeparg Extract information from deeparg's output report i.e., report.txt
drep Extract information from drep's output report i.e., quality\_and\_cluster\_summary.csv (Widb file)
eggnogmapper Extract information from eggnogmapper's output report i.e., annotations\_report.tsv
fastp Extract information from fastp's output report i.e., report.json
fastqc Extract information from fastqc's output report i.e., report.txt
filtlong Extract information from filtlong's output report i.e., input.fastq
flye Extract information from flye's output report i.e., contig.fasta
groot Extract information from groot's output report i.e., report.tsv
gtdbtk Extract information from gtdbtk's output report i.e., taxonomy\_summary.tsv
integronfinder2 Extract information from integronfinder2's output report i.e., OUTPUT.integrons, OUTPUT.summary
isescan Extract information from isescan's output report i.e., OUTPUT.tsv
kraken2 Extract information from kraken2's output report i.e., report.tsv
maxbin2 Extract information from maxbin2's output report i.e., bin\_summary.tsv
megahit Extract information from megahit's output assembly i.e., assembly.fasta
metabat2 Extract information from metabat2's output report i.e., cluster\_membership.tsv
mmseqs2linclust Extract information from mmseqs2 linclust module output clustering i.e., cluster.fasta
mmseqs2taxonomy Extract information from mmseqs2 taxonomy module output i.e., tax\_output.tsv
multiqc Extract information from multiqc's output report i.e., output.html
plasmidfinder Extract information from plasmidfinder's output report i.e., plasmidfinder.tsv
polypolish Extract information from polypolish's output report i.e., contig.fasta
prodigal Extract information from prodigal's output fasta i.e., cds.fasta
quast Extract information from quast's output report i.e., report.tsv
recentrifuge Extract information from recentrifuge's output report i.e., data.tsv
refseqmasher Extract information from refseqmasher's output report i.e., OUTPUT.tsv
shovill Extract information from shovill's output report i.e., contig.fasta
staramr Extract information from staramr's output report i.e., resfinder.tsv
sylph Extract information from sylph's output report i.e., report.tsv
sylphtax Extract information from sylph-tax's output report i.e., merge\_report.tsv
tabular\_file Extract information from tabular\_file's output report i.e., report.tsv
tooltest Extract information from tooltest's output report i.e., unitest
summarize Aggregate several JSON reports generated from a tool output
```
## Tool specification
For each tool, the requirements can be accessed using the `--help` argument, e.g.
```console
$ tooldistillator abricate --help
usage: tooldistillator.py abricate
Extract information from output(s) of abricate (OUTPUT.tsv)
positional arguments:
report Path to report(s)
options:
-h, --help show this help message and exit
-o OUTPUT, --output OUTPUT
Output location
--analysis\_software\_version ANALYSIS\_SOFTWARE\_VERSION
abricate version for abricate
--reference\_database\_version REFERENCE\_DATABASE\_VERSION
DB version for abricate
--hid HID historic ID for abricate file from galaxy for abricate
```
You can also test the command using the test data available in `test/data/dummy` folders. For example:
```console
$ tooldistillator abricate test/data/dummy/abricate/report.tsv --reference\_database\_version 1.1.1 --analysis\_software\_version 1.0.0
```
## Parse multiple same inputs
It is possible to parse multiple reports from the same tool at once by giving a list of reports as the argument, e.g.:
```console
$ abromics abricate test/data/dummy/abricate/\*.tsv --reference\_database\_version 3.2.5 --analysis\_software\_version 1.0.0
```
This will generate only one JSON file for all reports.
When you can provide different kind of files to a tool (e.g. shovill option use the `contig.fasta`, but can also use the alignment bam and assembly graph file), you can not submit in multiple file mode!
## Aggregate JSON reports from different tools
To aggregate JSON reports from different tools in one final JSON file, you can use the `summarize` subcommand:
```console
$ tooldistillator summarize --help
usage: tooldistillator summarize

Aggregate several reports
positional arguments:
tooldistillator\_reports
list of tooldistillator reports
options:
-h, --help show this help message and exit
-o OUTPUT, --output OUTPUT
Output file path for summary
-f, --force Overwrite to the output file mandatory
```
You can try it using test data in `test/data/dummy/summarize` folder:
```console
$ abromics summarize test/data/dummy/summarize/\*output.json -o test/data/raw\_output/summarize/tooldistillator\_summary.json
```
# Available tools
A diverse set of tools is available, along with a generic one for tabular files with headers. There is also a command to aggregate JSON outputs.
| Tools | Version | Default input file | Optional files |
| ---------------: | :------: | :----------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Abricate | 1.0.1 | output.tsv | |
| AMRFinderPlus | 3.11.26 | report.tsv | point\_mutation\_report.tsv, nucleotide\_sequence.fasta |
| argNorm | 1.0.0 | output.tsv | |
| Bakta | 1.7.0 | output.json | protein.faa, nucleotide.fna, annotation.gff3, summary.txt |
| Bandage | 0.8.1 | info.txt | |
| Bracken | 2.8 | output.tsv | taxonomy.tsv |
| BWA | 2.2.1 | input1.bam | input2.bam |
| Checkm2 | 1.0.2 | quality\_report.tsv | DIAMOND\_RESULTS.tsv, protein\_files.zip, checkm2.log |
| Concoct | 1.1.0 | merge\_cut\_clusters.csv | bin\_folder.zip, cut\_up\_contigs.fasta, coordinates\_cut\_up.bed,
coverage\_table.tabular, log\_file.txt |
| CoreProfiler | 1.1.1 | calling\_results.tsv | profiles\_w\_tmp\_alleles.json, new\_alleles.fasta |
| CoverM | 0.7.0 | coverage\_report.tsv | drep\_output\_cluster\_definition.tsv, drep\_directory.zip |
| DasTool | 1.1.7 | summary\_bins.tabular | bins\_folder.zip, contigs\_to\_bin.tabular, quality\_and\_completeness.tabular,
proteins.fasta, unbinned.fasta, log\_file.txt  |
| DeepARG | 1.0.4 | report.txt | report\_ARG\_merged.txt, report\_ARG\_merged\_quant\_subtype.txt,
report\_ARG\_merged\_quant\_type.txt, report\_potential\_ARG.txt,
sequence\_clean\_file.txt, bam\_clean\_file.bam, sam\_clean\_file.sam,
bam\_clean\_sorted\_file.bam, daa\_clean\_align\_file.daa |
| dRep | 3.4.2 | quality\_and\_cluster\_summary.csv (Widb.csv) | Bdb.csv, Cdb.csv, Chdb.csv, Mdb.csv, Ndb.csv, Sdb.csv, Wdb.csv,
winning\_genomes.pdf, cluster\_scoring.pdf, clustering\_scatterplots.pdf,
primary\_clustering\_dendrogram.pdf, secondary\_clustering\_dendrogram.pdf,
secondary\_clustering\_MDS.pdf, log\_file.txt  |
| EggNOG-mapper | 2.1.12 | annotation\_report.tsv | seed\_orthologs.tsv, orthologs.tsv |
| Fastp | 0.23.2 | output.json | |
| Fastqc | 0.12.1 | report.txt | report.html |
| Filtlong | 0.2.1 | input.fastq | |
| Flye | 2.9.1 | contig.fasta | contig.gfa, infos.tsv |
| Groot | 1.1.2 | report.tsv | groot.log, groot.bam |
| GTDB-tk | 2.4.1 | taxonomy\_summary.tsv | classify.zip, align.zip, identify.zip, log\_file.txt |
| Integronfinder2 | 2.0.2 | output.integrons | output.summary |
| ISEScan | 1.7.2.3 | output.tsv | is.fna, orf.faa, orf.fna |
| Kraken2 | 2.1.2 | taxonomy.tsv | reads\_assignation.txt |
| MaxBin2 | 2.2.7 | bin\_summary.tsv | bin\_folder.zip, bin\_predicted\_markers.zip, too\_short\_sequences.fasta,
unclassified\_sequences.fasta, marker\_gene\_presence.tabular,
marker\_gene\_presence\_plot.pdf, log\_file.txt |
| Megahit | 1.2.9 | assembly.fasta | intermediate\_contigs.zip, log.txt |
| Metabat2 | 2.17 | cluster\_membership.tsv | bins\_folder.zip, too\_short.fa, unbinned.fa, low\_depth.fa |
| MMseqs2 linclust | 17-b804f | rep\_seqs.fasta | all\_seqs.fasta, cluster.tsv |
| MMseqs2 taxonomy | 17-b804f | tax\_output.tsv | kraken\_report.txt, krona\_report.txt |
| MultiQC | 1.11 | report.html | |
| Plasmidfinder | 2.1.6 | output.json | genome\_hits.fasta, plasmid\_hits.fasta |
| Polypolish | 0.5.0 | contig.fasta | |
| Prodigal | 2.6.3 | output.fnn | output.faa, output.start, output.gbk, output.gff, output.sco |
| Quast | 5.2.0 | output.tsv | |
| Recentrifuge | 1.10.0 | data.tsv | report.html, stat.tsv |
| Refseqmasher | 0.1.2 | output.tsv | |
| Shovill | 1.1.0 | contigs.fasta | alignment.bam, contigs.gfa |
| StarAMR | 0.9.1 | resfinder.tsv | mlst.tsv, pointfinder.tsv, plasmidfinder.tsv, settings.tsv |
| Sylph | 0.8.1 | report.tsv | |
| Sylph-tax | 1.2.0 | merge\_report.tsv | taxprof\_folder.zip |
| tabular\_file | 0 | output.tsv | |
## Abricate
```console
$ tooldistillator abricate --help
usage: tooldistillator.py abricate
Extract information from output(s) of abricate (OUTPUT.tsv)
positional arguments:
report Path to report(s)
options:
-h, --help show this help message and exit
-o OUTPUT, --output OUTPUT
Output location
--analysis\_software\_version ANALYSIS\_SOFTWARE\_VERSION
abricate version for abricate
--reference\_database\_version REFERENCE\_DATABASE\_VERSION
DB version for abricate
--hid HID historic ID for abricate file from galaxy for abricate
```
## AMRFinderPlus
```console
$ tooldistillator amrfinderplus --help
usage: tooldistillator.py amrfinderplus
Extract information from output(s) of amrfinderplus (report.tsv)
positional arguments:
report Path to report(s)
options:
-h, --help show this help message and exit
-o OUTPUT, --output OUTPUT
Output location
--analysis\_software\_version ANALYSIS\_SOFTWARE\_VERSION
amrfinderplus version number for amrfinderplus
--hid HID historic ID for amrfinderplus file from galaxy for amrfinderplus
--reference\_database\_version REFERENCE\_DATABASE\_VERSION
DB version for amrfinderplus
--point\_mutation\_report\_path POINT\_MUTATION\_REPORT\_PATH
point mutation report file for amrfinderplus
--point\_mutation\_report\_hid POINT\_MUTATION\_REPORT\_HID
historic ID for point mutation report file from galaxy for amrfinderplus
--nucleotide\_sequence\_path NUCLEOTIDE\_SEQUENCE\_PATH
nucleotide identified sequence fasta file for amrfinderplus
--nucleotide\_sequence\_hid NUCLEOTIDE\_SEQUENCE\_HID
historic ID for nucleotide sequence fasta file from galaxy f
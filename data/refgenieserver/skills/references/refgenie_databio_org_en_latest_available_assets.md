[![](../img/refgenie_logo_light.svg)](..)

* [Refgenomes server](../servers)

* Search
* [Manuscripts](../manuscripts)
* [GitHub](https://github.com/databio/refgenie/)
* [PyPI](https://pypi.org/project/refgenie)
* [Databio.org](http://databio.org)

* #### Getting Started

+ [Introduction](..)

+ [Demo videos](../demo_videos/)

+ [Overview](../overview/)

+ [Install and configure](../install/)

+ [Basic tutorial](../tutorial/)

+ [Citing refgenie](../manuscripts/)

* #### How-to guides

+ [Refer to assets](../asset_registry_paths/)

+ [Download pre-built assets](../pull/)

+ [Build assets](../build/)

+ [Add custom assets](../custom_assets/)

+ [Retrieve paths to assets](../seek/)

+ [Use asset tags](../tag/)

+ [Use aliases](../aliases/)

+ [Populate refgenie paths](../populate/)

+ [Compare genomes](../compare/)

+ [Run my own asset server](../refgenieserver/)

+ [Use refgenie from Python](../refgenconf/)

+ [Use refgenie in your pipeline](../code_snippets/)

+ [Use refgenie on the cloud](../remote/)

+ [Use refgenie with iGenomes](../igenomes/)

+ [Upgrade from config 0.3 to 0.4](../config_upgrade_03_to_04/)

* #### Reference

+ [Studies using refgenie](../uses_refgenie/)

+ [Genome configuration file](../genome_config/)

+ [Glossary](../glossary/)

+ [Buildable assets](./)

+ [Usage](../usage/)

+ [Python API](../autodoc_build/refgenconf/)

+ [FAQ](../faq/)

+ [Support](https://github.com/databio/refgenie/issues)

+ [Contributing](../contributing/)

+ [Changelog](../changelog/)

# Buildable assets

`Refgenie` can build a handful of assets for which we have already created building recipes. `refgenie list` lists all assets refegenie can build:

```
$ refgenie list

Local recipes: bismark_bt1_index, bismark_bt2_index, bowtie2_index, bwa_index, dbnsfp, ensembl_gtf, ensembl_rb, epilog_index, fasta, feat_annotation, gencode_gtf, hisat2_index, kallisto_index, refgene_anno, salmon_index, star_index, suffixerator_index, tallymer_index
```

If you want to add a new asset, you'll have to work with us to provide a script that can build it, and we can incorporate it into `refgenie`. If you have assets that cannot be scripted, or you want to add some other custom asset you may [manually add custom assets](../custom_assets/) and still have them managed by `refgenie`. We expect this will get much easier in the future.

Below, we go through the assets you can build and how to build them.

## Top-level assets you can build

### fasta

required files: `--files fasta=/path/to/fasta_file` (*e.g.* [example\_genome.fa.gz](http://big.databio.org/example_data/rCRS.fa.gz))
 required parameters: *none*
 required asset: *none*
 required software: [samtools](http://www.htslib.org/)

We recommend for every genome, you first build the `fasta` asset, because it's a starting point for building a lot of other assets.

Example fasta files:

* [hg19 fasta](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/hg19.fa.gz)
* [hg38 fasta](http://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz)
* mm10 fasta
* [rCRS fasta](http://big.databio.org/example_data/rCRS.fa.gz)

```
wget http://big.databio.org/example_data/rCRS.fa.gz
refgenie build rCRS/fasta --files fasta=rCRS.fa.gz
refgenie seek rCRS/fasta
```

### blacklist

required files: `--files blacklist=/path/to/blacklist_file` (*e.g.* [hg38-blacklist.v2.bed.gz](https://github.com/Boyle-Lab/Blacklist/tree/master/lists))
 required parameters: *none*
 required asset: *none*
 required software: *none*

The `blacklist` asset represents regions that should be excluded from sequencing experiments. The ENCODE blacklist represents a comprehensive listing of these regions for several model organisms [^Amemiya2019].

Example blacklist files:

* [hg19 blacklist](https://github.com/Boyle-Lab/Blacklist/blob/master/lists/hg19-blacklist.v2.bed.gz)
* [hg38 blacklist](https://github.com/Boyle-Lab/Blacklist/blob/master/lists/hg38-blacklist.v2.bed.gz)
* [mm10 blacklist](https://github.com/Boyle-Lab/Blacklist/blob/master/lists/mm10-blacklist.v2.bed.gz)
* [dm6 blacklist](https://github.com/Boyle-Lab/Blacklist/blob/master/lists/dm6-blacklist.v2.bed.gz)

```
wget https://github.com/Boyle-Lab/Blacklist/blob/master/lists/hg38-blacklist.v2.bed.gz
refgenie build hg38/blacklist --files blacklist=hg38-blacklist.v2.bed.gz
```

### refgene\_anno

required files: `--files refgene=/path/to/refGene_file` (*e.g.* [refGene.txt.gz](http://varianttools.sourceforge.net/Annotation/RefGene))
 required parameters: *none*
 required asset: *none*
 required software: *none*

The `refgene_anno` asset is used to produce derived assets including transcription start sites (TSSs), exons, introns, and premature mRNA sequences.

Example refGene annotation files:

* [hg19 refGene](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/refGene.txt.gz)
* [hg38 refGene](http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database/refGene.txt.gz)
* [mm10 refGene](http://hgdownload.cse.ucsc.edu/goldenPath/mm10/database/refGene.txt.gz)
* [rn6 refGene](http://hgdownload.cse.ucsc.edu/goldenPath/rn6/database/refGene.txt.gz)

```
wget http://hgdownload.soe.ucsc.edu/goldenPath/hg38/database/refGene.txt.gz
refgenie build hg38/refgene_anno --files refgene=refGene.txt.gz
```

### gencode\_gtf

required files: `--files gencode_gtf=/path/to/gencode_file` (*e.g.* gencode.gtf.gz)
 required parameters: *none*
 required asset: *none*
 required software: *none*

The `gencode_gtf` asset contains all annotated transcripts.

Example gencode files:

* hg19 comprehensive gene annotation
* hg38 comprehensive gene annotation
* mm10 comprehensive gene annotation

```
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M23/gencode.vM23.annotation.gtf.gz
refgenie build mm10/gencode_gtf --files gencode_gtf=gencode.vM23.annotation.gtf.gz
```

### ensembl\_gtf

required files: `--files ensembl_gtf=/path/to/ensembl_file` (*e.g.* [ensembl.gtf.gz](https://useast.ensembl.org/info/genome/genebuild/genome_annotation.html))
 required parameters: *none*
 required asset: *none*
 required software: *none*

The `ensembl_gtf` asset is used to build other derived assets including a comprehensive TSS annotation and gene body annotation.

Example Ensembl files:

* hg38 ensembl annotations
* hg19 ensembl annotations
* mm10 ensembl annotations
* rn6 ensembl annotations

```
wget ftp://ftp.ensembl.org/pub/release-97/gtf/homo_sapiens/Homo_sapiens.GRCh38.97.gtf.gz
refgenie build hg38/ensembl-gtf --files ensembl_gtf=Homo_sapiens.GRCh38.97.gtf.gz
```

### ensembl\_rb

required files: `--files gff=/path/to/gff_file` (*e.g.* [regulatory\_features.ff.gz](http://useast.ensembl.org/info/genome/funcgen/regulatory_build.html))
 required parameters: *none*
 required asset: *none*
 required software: *none*

The `ensembl_rb` asset is used to produce derived assets including feature annotations.

Example Ensembl files:

* hg38 regulatory build
* hg19 regulatory build
* mm10 regulatory build

```
wget ftp://ftp.ensembl.org/pub/current_regulation/homo_sapiens/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20190329.gff.gz
refgenie build hg38/ensembl_rb --files gff=homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20190329.gff.gz
```

### dbnsfp

required files: `--files dbnsfp=/path/to/dbnsfp_file` (*e.g.* [dbNSFP4.0a.zip](http://varianttools.sourceforge.net/Annotation/dbNSFP))
 required parameters: *none*
 required asset: *none*
 required software: *none*

The `dbnsfp` asset is the annotation database for non-synonymous SNPs.

```
wget ftp://dbnsfp:[email protected]/dbNSFP4.0a.zip
refgenie build test/dbnsfp --files dbnsfp=dbNSFP4.0a.zip
```

## Derived assets you can build

For many of the following derived assets, you will need the corresponding software to build the asset. You can either [install software on a case-by-case basis natively](../build/#install-building-software-natively), or you can [build the assets using `docker`](../build/#building-assets-with-docker).

### bowtie2\_index

required files: *none*
 required parameters: *none*
 required asset: [`fasta`](./#fasta)
 required software: [bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)

```
refgenie build test/bowtie2_index
```

### bismark\_bt1\_index and bismark\_bt2\_index

required files: *none*
 required parameters: *none*
 required asset: [`fasta`](./#fasta)
 required software: [bismark](https://www.bioinformatics.babraham.ac.uk/projects/bismark/)

```
refgenie build test/bismark_bt1_index
refgenie build test/bismark_bt2_index
```

### bwa\_index

required files: *none*
 required parameters: *none*
 required asset: [`fasta`](./#fasta)
 required software: [bwa](http://bio-bwa.sourceforge.net/)

```
refgenie build test/bwa_index
```

### hisat2\_index

required files: *none*
 required asset: [`fasta`](./#fasta)
 required software: [hisat2](https://ccb.jhu.edu/software/hisat2/index.shtml)

```
refgenie build test/hisat2_index
```

### epilog\_index

required files: *none*
 required parameters: `--params context=CG` (Default)
 required asset: [`fasta`](./#fasta)
 required software: [epilog](https://github.com/databio/epilog)

```
refgenie build test/epilog_index --params context=CG
```

### kallisto\_index

required files: *none*
 required parameters: *none*
 required asset: [`fasta`](./#fasta)
 required software: [kallisto](https://pachterlab.github.io/kallisto/)

```
refgenie build test/kallisto_index
```

### salmon\_index

required files: *none*
 required parameters: *none*
 required asset: [`fasta`](./#fasta)
 required software: [salmon](https://salmon.readthedocs.io/en/latest/salmon.html)

```
refgenie build test/salmon_index
```

### star\_index

required files: *none*
 required parameters: *none*
 required asset: [`fasta`](./#fasta)
 required software: [star](https://github.com/alexdobin/STAR)

```
refgenie build test/star_index
```

### suffixerator\_index

required files: *none*
 required parameters: `--params memlimit=8GB` (Default)
 required asset: [`fasta`](./#fasta)
 required software: [GenomeTools](http://genometools.org/)

```
refgenie build test/suffixerator_index --params memlimit=8GB
```

### tallymer\_index

required files: *none*
 required parameters: `--params mersize=30 minocc=2` (Default)
 required asset: [`fasta`](./#fasta)
 required software: [GenomeTools](http://genometools.org/)

```
refgenie build test/tallymer_index --params mersize=30 minocc=2
```

### feat\_annotation

required files: *none*
 required parameters: *none*
 required asset: [`ensembl_gtf`](../build/#ensembl-gtf), [`ensembl_rb`](../build/#ensembl-rb)
 required software: *none*

The `feat_annotation` asset includes the following genomic feature annotations: enhancers, promoters, promoter flanking regions, 5' UTR, 3' UTR, exons, and introns.

```
refgenie build test/feat_annotation
```

[^Amemiya2019]: Amemiya HM, Kundaje A, Boyle AP. The ENCODE Blacklist: Identification of Problematic Regions of the Genome. *Sci Rep* 2019;9, 9354. doi:10.1038/s41598-019-45839-z

* [Previous](../glossary/)
* [Next](../usage/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/available_assets.md)

[Sheffield Computational Biology Lab](http://databio.org/)

##### Search

×Close

From here you can search these documents. Enter
your search terms below.

#### Keyboard Shortcuts

×Close

| Keys | Action |
| --- | --- |
| `?` | Open this help |
| `n` | Next page |
| `p` | Previous page |
| `s` | Search |
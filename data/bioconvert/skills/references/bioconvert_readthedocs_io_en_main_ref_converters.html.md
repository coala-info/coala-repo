[bioconvert
![Logo](_static/logo.png)](index.html)

* [1. Installation](installation.html)
* [2. User Guide](user_guide.html)
* [3. Tutorial](tutorial.html)
* [4. Developer guide](developer_guide.html)
* [5. Benchmarking](benchmarking.html)
* [6. Gallery](auto_examples/index.html)
* [7. References](references.html)
  + [7.1. Core functions](ref_core.html)
  + 7.2. Reference converters
    - [7.2.1. Summary](#summary)
    - [7.2.2. All converters documentation](#module-bioconvert.abi2fasta)
      * [`ABI2FASTA`](#bioconvert.abi2fasta.ABI2FASTA)
      * [`ABI2FASTQ`](#bioconvert.abi2fastq.ABI2FASTQ)
      * [`ABI2QUAL`](#bioconvert.abi2qual.ABI2QUAL)
      * [`BAM2BEDGRAPH`](#bioconvert.bam2bedgraph.BAM2BEDGRAPH)
      * [`BAM2COV`](#bioconvert.bam2cov.BAM2COV)
      * [`BAM2BIGWIG`](#bioconvert.bam2bigwig.BAM2BIGWIG)
      * [`BAM2CRAM`](#bioconvert.bam2cram.BAM2CRAM)
      * [`BAM2FASTA`](#bioconvert.bam2fasta.BAM2FASTA)
      * [`BAM2FASTQ`](#bioconvert.bam2fastq.BAM2FASTQ)
      * [`BAM2JSON`](#bioconvert.bam2json.BAM2JSON)
      * [`BAM2SAM`](#bioconvert.bam2sam.BAM2SAM)
      * [`BAM2TSV`](#bioconvert.bam2tsv.BAM2TSV)
      * [`BAM2WIGGLE`](#bioconvert.bam2wiggle.BAM2WIGGLE)
      * [`BCF2VCF`](#bioconvert.bcf2vcf.BCF2VCF)
      * [`BCF2WIGGLE`](#bioconvert.bcf2wiggle.BCF2WIGGLE)
      * [`BED2WIGGLE`](#bioconvert.bed2wiggle.BED2WIGGLE)
      * [`BEDGRAPH2COV`](#bioconvert.bedgraph2cov.BEDGRAPH2COV)
      * [`BEDGRAPH2BIGWIG`](#bioconvert.bedgraph2bigwig.BEDGRAPH2BIGWIG)
      * [`BEDGRAPH2WIGGLE`](#bioconvert.bedgraph2wiggle.BEDGRAPH2WIGGLE)
      * [`BIGBED2WIGGLE`](#bioconvert.bigbed2wiggle.BIGBED2WIGGLE)
      * [`BIGBED2BED`](#bioconvert.bigbed2bed.BIGBED2BED)
      * [`BIGWIG2BEDGRAPH`](#bioconvert.bigwig2bedgraph.BIGWIG2BEDGRAPH)
      * [`BIGWIG2WIGGLE`](#bioconvert.bigwig2wiggle.BIGWIG2WIGGLE)
      * [`BPLINK2PLINK`](#bioconvert.bplink2plink.BPLINK2PLINK)
      * [`BZ22GZ`](#bioconvert.bz22gz.BZ22GZ)
      * [`CLUSTAL2FASTA`](#bioconvert.clustal2fasta.CLUSTAL2FASTA)
      * [`CLUSTAL2PHYLIP`](#bioconvert.clustal2phylip.CLUSTAL2PHYLIP)
      * [`CLUSTAL2STOCKHOLM`](#bioconvert.clustal2stockholm.CLUSTAL2STOCKHOLM)
      * [`CRAM2BAM`](#bioconvert.cram2bam.CRAM2BAM)
      * [`CRAM2FASTA`](#bioconvert.cram2fasta.CRAM2FASTA)
      * [`CRAM2FASTQ`](#bioconvert.cram2fastq.CRAM2FASTQ)
      * [`CRAM2SAM`](#bioconvert.cram2sam.CRAM2SAM)
      * [`CSV2TSV`](#bioconvert.csv2tsv.CSV2TSV)
      * [`CSV2XLS`](#bioconvert.csv2xls.CSV2XLS)
      * [`DSRC2GZ`](#bioconvert.dsrc2gz.DSRC2GZ)
      * [`EMBL2FASTA`](#bioconvert.embl2fasta.EMBL2FASTA)
      * [`EMBL2GENBANK`](#bioconvert.embl2genbank.EMBL2GENBANK)
      * [`FASTA_QUAL2FASTQ`](#bioconvert.fasta_qual2fastq.FASTA_QUAL2FASTQ)
      * [`FASTA2CLUSTAL`](#bioconvert.fasta2clustal.FASTA2CLUSTAL)
      * [`FASTA2FAA`](#bioconvert.fasta2faa.FASTA2FAA)
      * [`FASTA2FASTQ`](#bioconvert.fasta2fastq.FASTA2FASTQ)
      * [`FASTA2GENBANK`](#bioconvert.fasta2genbank.FASTA2GENBANK)
      * [`FASTA2NEXUS`](#bioconvert.fasta2nexus.FASTA2NEXUS)
      * [`FASTA2PHYLIP`](#bioconvert.fasta2phylip.FASTA2PHYLIP)
      * [`FASTA2TWOBIT`](#bioconvert.fasta2twobit.FASTA2TWOBIT)
      * [`FASTQ2FASTA`](#bioconvert.fastq2fasta.FASTQ2FASTA)
      * [`GENBANK2EMBL`](#bioconvert.genbank2embl.GENBANK2EMBL)
      * [`GENBANK2FASTA`](#bioconvert.genbank2fasta.GENBANK2FASTA)
      * [`GENBANK2GFF3`](#bioconvert.genbank2gff3.GENBANK2GFF3)
      * [`GFF22GFF3`](#bioconvert.gff22gff3.GFF22GFF3)
      * [`GFF32GFF2`](#bioconvert.gff32gff2.GFF32GFF2)
      * [`GFA2FASTA`](#bioconvert.gfa2fasta.GFA2FASTA)
      * [`GZ2BZ2`](#bioconvert.gz2bz2.GZ2BZ2)
      * [`GZ2DSRC`](#bioconvert.gz2dsrc.GZ2DSRC)
      * [`JSON2YAML`](#bioconvert.json2yaml.JSON2YAML)
      * [`MAF2SAM`](#bioconvert.maf2sam.MAF2SAM)
      * [`NEWICK2NEXUS`](#bioconvert.newick2nexus.NEWICK2NEXUS)
      * [`NEWICK2PHYLOXML`](#bioconvert.newick2phyloxml.NEWICK2PHYLOXML)
      * [`NEXUS2FASTA`](#bioconvert.nexus2fasta.NEXUS2FASTA)
      * [`NEXUS2NEWICK`](#bioconvert.nexus2newick.NEXUS2NEWICK)
      * [`NEXUS2PHYLIP`](#bioconvert.nexus2phylip.NEXUS2PHYLIP)
      * [`NEXUS2PHYLOXML`](#bioconvert.nexus2phyloxml.NEXUS2PHYLOXML)
      * [`ODS2CSV`](#bioconvert.ods2csv.ODS2CSV)
      * [`PHYLIP2CLUSTAL`](#bioconvert.phylip2clustal.PHYLIP2CLUSTAL)
      * [`PHYLIP2FASTA`](#bioconvert.phylip2fasta.PHYLIP2FASTA)
      * [`PHYLIP2NEXUS`](#bioconvert.phylip2nexus.PHYLIP2NEXUS)
      * [`PHYLIP2STOCKHOLM`](#bioconvert.phylip2stockholm.PHYLIP2STOCKHOLM)
      * [`PHYLIP2XMFA`](#bioconvert.phylip2xmfa.PHYLIP2XMFA)
      * [`PHYLOXML2NEWICK`](#bioconvert.phyloxml2newick.PHYLOXML2NEWICK)
      * [`PHYLOXML2NEXUS`](#bioconvert.phyloxml2nexus.PHYLOXML2NEXUS)
      * [`PLINK2BPLINK`](#bioconvert.plink2bplink.PLINK2BPLINK)
      * [`SAM2BAM`](#bioconvert.sam2bam.SAM2BAM)
      * [`SAM2CRAM`](#bioconvert.sam2cram.SAM2CRAM)
      * [`SAM2PAF`](#bioconvert.sam2paf.SAM2PAF)
      * [`SCF2FASTA`](#bioconvert.scf2fasta.SCF2FASTA)
      * [`SCF2FASTQ`](#bioconvert.scf2fastq.SCF2FASTQ)
      * [`SRA2FASTQ`](#bioconvert.sra2fastq.SRA2FASTQ)
      * [`STOCKHOLM2CLUSTAL`](#bioconvert.stockholm2clustal.STOCKHOLM2CLUSTAL)
      * [`STOCKHOLM2PHYLIP`](#bioconvert.stockholm2phylip.STOCKHOLM2PHYLIP)
      * [`TSV2CSV`](#bioconvert.tsv2csv.TSV2CSV)
      * [`TWOBIT2FASTA`](#bioconvert.twobit2fasta.TWOBIT2FASTA)
      * [`VCF2BCF`](#bioconvert.vcf2bcf.VCF2BCF)
      * [`VCF2BED`](#bioconvert.vcf2bed.VCF2BED)
      * [`VCF2WIGGLE`](#bioconvert.vcf2wiggle.VCF2WIGGLE)
      * [`XLS2CSV`](#bioconvert.xls2csv.XLS2CSV)
      * [`XLSX2CSV`](#bioconvert.xlsx2csv.XLSX2CSV)
      * [`XMFA2PHYLIP`](#bioconvert.xmfa2phylip.XMFA2PHYLIP)
      * [`YAML2JSON`](#bioconvert.yaml2json.YAML2JSON)
  + [7.3. IO functions](ref_io.html)
* [8. Formats](formats.html)
* [9. Glossary](glossary.html)
* [10. Faqs](faqs.html)
* [11. Bibliography](bibliography.html)

[bioconvert](index.html)

* [7. References](references.html)
* 7.2. Reference converters
* [View page source](_sources/ref_converters.rst.txt)

---

# 7.2. Reference converters[](#reference-converters "Link to this heading")

## 7.2.1. Summary[](#summary "Link to this heading")

|  |  |
| --- | --- |
| [`bioconvert.abi2fasta`](#module-bioconvert.abi2fasta "bioconvert.abi2fasta") | Convert [ABI](glossary.html#term-ABI) format to [FASTA](glossary.html#term-FASTA) format |
| [`bioconvert.abi2fastq`](#module-bioconvert.abi2fastq "bioconvert.abi2fastq") | Convert [ABI](glossary.html#term-ABI) format to [FASTQ](glossary.html#term-FASTQ) format |
| [`bioconvert.abi2qual`](#module-bioconvert.abi2qual "bioconvert.abi2qual") | Convert [ABI](glossary.html#term-ABI) format to [QUAL](glossary.html#term-QUAL) format |
| [`bioconvert.bam2bedgraph`](#module-bioconvert.bam2bedgraph "bioconvert.bam2bedgraph") | Convert [BAM](glossary.html#term-BAM) format to [BEDGRAPH](glossary.html#term-BEDGRAPH) format |
| [`bioconvert.bam2cov`](#module-bioconvert.bam2cov "bioconvert.bam2cov") | Convert [BAM](glossary.html#term-BAM) format to [COV](glossary.html#term-COV) format |
| [`bioconvert.bam2bigwig`](#module-bioconvert.bam2bigwig "bioconvert.bam2bigwig") | Convert [BAM](glossary.html#term-BAM) file to [BIGWIG](glossary.html#term-BIGWIG) format |
| [`bioconvert.bam2cram`](#module-bioconvert.bam2cram "bioconvert.bam2cram") | Convert [BAM](glossary.html#term-BAM) file to [CRAM](glossary.html#term-CRAM) format |
| [`bioconvert.bam2fasta`](#module-bioconvert.bam2fasta "bioconvert.bam2fasta") | Convert [BAM](glossary.html#term-BAM) format to [FASTA](glossary.html#term-FASTA) format |
| [`bioconvert.bam2fastq`](#module-bioconvert.bam2fastq "bioconvert.bam2fastq") | Convert [BAM](glossary.html#term-BAM) format to [FASTQ](glossary.html#term-FASTQ) foarmat |
| [`bioconvert.bam2json`](#module-bioconvert.bam2json "bioconvert.bam2json") | Convert [BAM](glossary.html#term-BAM) format to [JSON](glossary.html#term-JSON) format |
| [`bioconvert.bam2sam`](#module-bioconvert.bam2sam "bioconvert.bam2sam") | Convert [SAM](glossary.html#term-SAM) file to [BAM](glossary.html#term-BAM) format |
| [`bioconvert.bam2tsv`](#module-bioconvert.bam2tsv "bioconvert.bam2tsv") | Convert [BAM](glossary.html#term-BAM) file to [TSV](glossary.html#term-TSV) format |
| [`bioconvert.bam2wiggle`](#module-bioconvert.bam2wiggle "bioconvert.bam2wiggle") | Convert [BAM](glossary.html#term-BAM) to [WIGGLE](glossary.html#term-WIGGLE) format |
| [`bioconvert.bcf2vcf`](#module-bioconvert.bcf2vcf "bioconvert.bcf2vcf") | Convert [BCF](glossary.html#term-BCF) file to [VCF](glossary.html#term-VCF) format |
| [`bioconvert.bcf2wiggle`](#module-bioconvert.bcf2wiggle "bioconvert.bcf2wiggle") | Convert [BCF](glossary.html#term-BCF) format to [WIGGLE](glossary.html#term-WIGGLE) format |
| [`bioconvert.bed2wiggle`](#module-bioconvert.bed2wiggle "bioconvert.bed2wiggle") | Convert [BED](glossary.html#term-BED) format to [WIGGLE](glossary.html#term-WIGGLE) format |
| [`bioconvert.bedgraph2cov`](#module-bioconvert.bedgraph2cov "bioconvert.bedgraph2cov") | Convert [BEDGRAPH](glossary.html#term-BEDGRAPH) file to [COV](glossary.html#term-COV) format |
| [`bioconvert.bedgraph2bigwig`](#module-bioconvert.bedgraph2bigwig "bioconvert.bedgraph2bigwig") | Convert [BEDGRAPH](glossary.html#term-BEDGRAPH) to [BIGWIG](glossary.html#term-BIGWIG) format |
| [`bioconvert.bedgraph2wiggle`](#module-bioconvert.bedgraph2wiggle "bioconvert.bedgraph2wiggle") | Convert [BEDGRAPH](glossary.html#term-BEDGRAPH) format to [WIGGLE](glossary.html#term-WIGGLE) format |
| [`bioconvert.bigbed2wiggle`](#module-bioconvert.bigbed2wiggle "bioconvert.bigbed2wiggle") | Convert [BIGBED](glossary.html#term-BIGBED) format to [WIGGLE](glossary.html#term-WIGGLE) format |
| [`bioconvert.bigbed2bed`](#module-bioconvert.bigbed2bed "bioconvert.bigbed2bed") | Convert [BIGBED](glossary.html#term-BIGBED) format to [BED](glossary.html#term-BED) format |
| [`bioconvert.bigwig2bedgraph`](#module-bioconvert.bigwig2bedgraph "bioconvert.bigwig2bedgraph") | Convert [BIGWIG](glossary.html#term-BIGWIG) to [BEDGRAPH](glossary.html#term-BEDGRAPH) format |
| [`bioconvert.bigwig2wiggle`](#module-bioconvert.bigwig2wiggle "bioconvert.bigwig2wiggle") | Convert [BIGWIG](glossary.html#term-BIGWIG) format to [WIGGLE](glossary.html#term-WIGGLE) format |
| [`bioconvert.bplink2plink`](#module-bioconvert.bplink2plink "bioconvert.bplink2plink") | Convert [BPLINK](glossary.html#term-BPLINK) to [PLINK](glossary.html#term-PLINK) format |
| [`bioconvert.bz22gz`](#module-bioconvert.bz22gz "bioconvert.bz22gz") | Convert [BZ2](glossary.html#term-BZ2) to [GZ](glossary.html#term-GZ) format |
| [`bioconvert.clustal2fasta`](#module-bioconvert.clustal2fasta "bioconvert.clustal2fasta") | Convert [CLUSTAL](glossary.html#term-CLUSTAL) to [FASTA](glossary.html#term-FASTA) format |
| [`bioconvert.clustal2phylip`](#module-bioconvert.clustal2phylip "bioconvert.clustal2phylip") | Convert [CLUSTAL](glossary.html#term-CLUSTAL) to [PHYLIP](glossary.html#term-PHYLIP) format |
| [`bioconvert.clustal2stockholm`](#module-bioconvert.clustal2stockholm "bioconvert.clustal2stockholm") | Convert [CLUSTAL](glossary.html#term-CLUSTAL) to [STOCKHOLM](glossary.html#term-STOCKHOLM) format |
| [`bioconvert.cram2bam`](#module-bioconvert.cram2bam "bioconvert.cram2bam") | Convert [CRAM](glossary.html#term-CRAM) file to [BAM](glossary.html#term-BAM) format |
| [`bioconvert.cram2fasta`](#module-bioconvert.cram2fasta "bioconvert.cram2fasta") | Convert [CRAM](glossary.html#term-CRAM) file to [FASTQ](glossary.html#term-FASTQ) format |
| [`bioconvert.cram2fastq`](#module-bioconvert.cram2fastq "bioconvert.cram2fastq") | Convert [CRAM](glossary.html#term-CRAM) file to [FASTQ](glossary.html#term-FASTQ) format |
| [`bioconvert.cram2sam`](#module-bioconvert.cram2sam "bioconvert.cram2sam") | Convert [CRAM](glossary.html#term-CRAM) file to [SAM](glossary.html#term-SAM) format |
| [`bioconvert.csv2tsv`](#module-bioconvert.csv2tsv "bioconvert.csv2tsv") | Convert [CSV](glossary.html#term-CSV) format to [TSV](glossary.html#term-TSV) format |
| [`bioconvert.csv2xls`](#module-bioconvert.csv2xls "bioconvert.csv2xls") | convert [CSV](glossary.html#term-CSV) to [XLS](glossary.html#term-XLS) format |
| [`bioconvert.dsrc2gz`](#module-bioconvert.dsrc2gz "bioconvert.dsrc2gz") | Convert a compressed [FASTQ](glossary.html#term-FASTQ) from [DSRC](glossary.html#term-DSRC) to [FASTQ](glossary.html#term-FASTQ) format |
| [`bioconvert.embl2fasta`](#module-bioconvert.embl2fasta "bioconvert.embl2fasta") | Convert [EMBL](glossary.html#term-EMBL) file to [FASTA](glossary.html#term-FASTA) format |
| [`bioconvert.embl2genbank`](#module-bioconvert.embl2genbank "bioconvert.embl2genbank") | Convert [EMBL](glossary.html#term-EMBL) file to [GENBANK](glossary.html#term-GENBANK) format |
| [`bioconvert.fasta_qual2fastq`](#module-bioconvert.fasta_qual2fastq "bioconvert.fasta_qual2fastq") | Convert [FASTA](glossary.html#term-FASTA) format to [FASTQ](glossary.html#term-FASTQ) format |
| [`bioconvert.fasta2clustal`](#module-bioconvert.fasta2clustal "bioconvert.fasta2clustal") | Convert [FASTA](glossary.html#term-FASTA) to [CLUSTAL](glossary.html#term-CLUSTAL) format |
| [`bioconvert.fasta2faa`](#module-bioconvert.fasta2faa "bioconvert.fasta2faa") | Convert [FASTA](glossary.html#term-FASTA) format to [FAA](glossary.html#term-FAA) format |
| `bioconvert.fasta2fasta_agp` | Convert [FASTA](glossary.html#term-FASTA) (scaffold) to [FASTA](glossary.html#term-FASTA) (contig) and AGP formats |
| [`bioconvert.fasta2fastq`](#module-bioconvert.fasta2fastq "bioconvert.fasta2fastq") | Convert [FASTA](glossary.html#term-FASTA) format to [FASTQ](glossary.html#term-FASTQ) format |
| [`bioconvert.fasta2genbank`](#module-bioconvert.fasta2genbank "bioconvert.fasta2genbank") | Convert [FASTA](glossary.html#term-FASTA) to [GENBANK](glossary.html#term-GENBANK) format |
| [`bioconvert.fasta2nexus`](#module-bioconvert.fasta2nexus "bioconvert.fasta2nexus") | Convert [FASTA](glossary.html#term-FASTA) to [NEXUS](glossary.html#term-NEXUS) format |
| [`bioconvert.fasta2phylip`](#module-bioconvert.fasta2phylip "bioconvert.fasta2phylip") | Convert [FASTA](glossary.html#term-FASTA) to [PHYLIP](glossary.html#term-PHYLIP) format |
| [`bioconvert.fasta2twobit`](#module-bioconvert.fasta2twobit "bioconvert.fasta2twobit") | Convert [FASTA](glossary.html#term-FASTA) to [TWOBIT](glossary.html#term-TWOBIT) format |
| [`bioconvert.fastq2fasta`](#module-bioconvert.fastq2fasta "bioconvert.fastq2fasta") | Convert [FASTQ](glossary.html#term-FASTQ) to [FASTA](glossary.html#term-FASTA) format |
| [`bioconvert.genbank2embl`](#module-bioconvert.genbank2embl "bioconvert.genbank2embl") | Convert [GENBANK](glossary.html#term-GENBANK) to [EMBL](glossary.html#term-EMBL) format |
| [`bioconvert.genbank2fasta`](#module-bioconvert.genbank2fasta "bioconvert.genbank2fasta") | Convert [GENBANK](glossary.html#term-GENBANK) to [EMBL](glossary.html#term-EMBL) format |
| [`bioconvert.genbank2gff3`](#module-bioconvert.genbank2gff3 "bioconvert.gen
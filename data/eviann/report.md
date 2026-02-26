# eviann CWL Generation Report

## eviann_eviann.sh

### Tool Description
EviAnn: A tool for genome annotation using RNA-seq, protein, and transcript evidence.

### Metadata
- **Docker Image**: quay.io/biocontainers/eviann:2.0.5--pl5321haf24da9_1
- **Homepage**: https://github.com/alekseyzimin/EviAnn_release
- **Package**: https://anaconda.org/channels/bioconda/packages/eviann/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/eviann/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2026-01-16
- **GitHub**: https://github.com/alekseyzimin/EviAnn_release
- **Stars**: N/A
### Original Help Text
```text
Usage: eviann.sh [options]
Options:
 -t INT           number of threads, default: 1
 -g FILE          MANDATORY:genome fasta file default: none
 -r FILE          file containing list of filenames of reads from transcriptome sequencing experiments, default: none
 
  FORMAT OF THIS FILE:
  Each line in the file must refer to sequencing data from a single experiment.
  Please combine runs so that one file/pair/triplet of files contains a single sample.  
  The lines are in the following format:
 
 /path/filename /path/filename /path/filename tag
  or
 /path/filename /path/filename tag
  or
 /path/filename tag

  Fields are space-separated, no leading space. "tag" indicates type of data referred to in the preceding fields.  Possible values are:
 
  fastq -- indicates the data is Illumina RNA-seq in fastq format, expects one or a pair of /path/filename.fastq before the tag
  fasta -- indicates the data is Illumina RNA-seq in fasta format, expects one or a pair of /path/filename.fasta before the tag
  bam -- indicates the data is aligned Illumina RNA-seq reads, expects one /path/filename.bam before the tag
  bam_isoseq -- indicates the data is aligned PacBio Iso-seq reads, expects one /path/filename.bam before the tag
  isoseq -- indicates the data is PacBio Iso-seq reads in fasta or fastq format, expects one /path/filename.(fasta or fastq) before the tag
  mix -- indicates the data is from the sample sequenced with both Illumina RNA-seq provided in fastq format and long reads (Iso-seq or Oxford Nanopore) in fasta/fastq format, expects three /path/filename before the tag
  bam_mix -- indicates the data is from the same sample sequenced with both Illumina RNA-seq provided in bam format and long reads (Iso-seq or Oxford Nanopore) in bam format, expects two /path/filename.bam before the tag
 
  Absense of a tag assumes fastq tag and expects one or a pair of /path/filename.fastq on the line.
 
 -e FILE               fasta file with assembled transcripts from related species, default: none
 -p FILE               fasta file with protein sequences from (preferrably multiple) related species, uniprot proteins are used of this file is not provided, default: none
 -s FILE               fasta file with UniProt-SwissProt proteins to use in functional annotation or if proteins from close relatives are not available. 
                         EviAnn will download the most recent version of this database automatically.
                         To use a different version, supply it with this switch. The database is available at:
                         https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
 -m INT                max intron size, default: auto-determined as sqrt(genome size in kb)*1000; this setting will override automatically estimated value
 --partial             include transcripts with partial (mising start or stop codon) CDS in the output
 -d INT                set ploidy for the genome, this value is used in estimating the maximum intron size, default 2
 -c FILE               GFF file with CDS sequences for THIS genome to be used in annotations. Each CDS must have gene/transcript/mRNA AND exon AND CDS attributes
 --lncrnamintpm FLOAT  minimum TPM to include non-coding transcript into the annotation as lncRNA, default: 1.0
 --min_prot            minimum protein length (in amino-acids) for ab initio ORF detection without homology evidence, default: 75
 -f|--functional       perform functional annotation, default: not set
 --mito_contigs FILE   file with the list of input contigs to be treated as mitochondrial with different genetic code (stop is AGA,AGG,TAA,TAG)
 --extra FILE          extra features to add from an external GFF file.  Feautures MUST have gene records.  Any features that overlap with existing annotations will be ignored
 --debug               keep intermediate output files, default: not set
 --verbose             verbose run, default: not set
 --version             report version and exit.
 --help                display this message and exit.

 IMPORTANT!!! -r or -e MUST be supplied.
```


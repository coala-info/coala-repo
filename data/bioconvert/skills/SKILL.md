---
name: bioconvert
description: Bioconvert is a utility that converts bioinformatics data between various file formats by wrapping existing high-performance tools and native Python implementations. Use when user asks to convert genomic file formats, transform data between formats like BAM and FASTQ, or benchmark different conversion methods for performance.
homepage: http://bioconvert.readthedocs.io/
---


# bioconvert

## Overview

Bioconvert is a collaborative utility designed to simplify the often-complex task of format conversion in life sciences. It serves as a common interface that wraps existing high-performance tools (such as samtools, bedtools, and UCSC utilities) while providing native Python implementations for other formats. This skill allows for efficient data transformation within genomic pipelines, supporting transparent decompression/compression and performance benchmarking across different conversion methods.

## Command Line Usage

### Basic Conversion
Bioconvert supports both explicit and implicit conversion modes.

**Explicit mode:**
Specify the conversion direction using the `<input_format>2<output_format>` syntax.
```bash
bioconvert fastq2fasta input.fastq output.fasta
```

**Implicit mode:**
If the file extensions are standard, Bioconvert can infer the conversion.
```bash
bioconvert input.fastq output.fasta
```

### Handling Compression
Bioconvert handles compressed files transparently. You can change the compression format during conversion by changing the output extension.
```bash
# Convert and change compression from gzip to bzip2
bioconvert fastq2fasta input.fq.gz output.fasta.bz2
```

### Optimization and Threading
For large-scale data, use the `--threads` (or `-t`) option to parallelize the process where the underlying method supports it.
```bash
bioconvert bam2fastq input.bam output.fastq --threads 8
```

## Expert Tips

### Selecting Conversion Methods
Many conversions offer multiple "methods" (e.g., using a pure Python library vs. a compiled tool like `awk` or `samtools`).
- **List available methods:** `bioconvert fastq2fasta --show-methods`
- **Force a specific method:** `bioconvert fastq2fasta input.fastq output.fasta --method awk`

### Benchmarking
If you are processing massive datasets and want to find the fastest engine for your specific environment:
```bash
bioconvert fastq2fasta input.fastq output.fasta --benchmark
```
This will run the available methods and report performance statistics.

### Common Converters Reference
| Input | Output | Default Method |
|-------|--------|----------------|
| BAM   | SAM    | SAMBAMBA       |
| BAM   | FASTQ  | SAMTOOLS       |
| SAM   | BAM    | SAMTOOLS       |
| VCF   | BED    | BIOCONVERT     |
| FASTQ | FASTA  | BIOCONVERT     |
| ABI   | FASTQ  | BIOPYTHON      |

## Python API Usage
For integration into Python scripts, you can call converters directly:
```python
from bioconvert.fastq2fasta import FASTQ2FASTA

convert = FASTQ2FASTA("input.fastq", "output.fasta")
convert()
```



## Subcommands

| Command | Description |
|---------|-------------|
| bcf2vcf | Convert file from '('BCF',)' to '('VCF',)' format. See bioconvert.readthedocs.io for details |
| bcf2wiggle | Convert file from '('BCF',)' to '('WIGGLE',)' format. See bioconvert.readthedocs.io for details |
| bedgraph2wiggle | Convert file from ('BEDGRAPH',) to ('WIGGLE',) format. See bioconvert.readthedocs.io for details |
| bigbed2bed | Convert file from ('BIGBED',) to ('BED',) format. See bioconvert.readthedocs.io for details |
| bigbed2wiggle | Convert file from '('BIGBED',)' to '('WIGGLE',)' format. See bioconvert.readthedocs.io for details |
| bigwig2bedgraph | Convert file from '('BIGWIG',)' to '('BEDGRAPH',)' format. See bioconvert.readthedocs.io for details |
| bigwig2wiggle | Convert file from '('BIGWIG',)' to '('WIGGLE',)' format. See bioconvert.readthedocs.io for details |
| bioconvert abi2fasta | Convert file from (ABI,) to (FASTA,) format. See bioconvert.readthedocs.io for details |
| bioconvert abi2fastq | Convert file from '('ABI',)' to '('FASTQ',)' format. See bioconvert.readthedocs.io for details |
| bioconvert abi2qual | Convert file from '('ABI',)' to '('QUAL',)' format. See bioconvert.readthedocs.io for details |
| bioconvert bam2bedgraph | Convert file from '('BAM',)' to '('BEDGRAPH',)' format. See bioconvert.readthedocs.io for details |
| bioconvert bam2bigwig | Convert file from ('BAM',) to ('BIGWIG',) format. See bioconvert.readthedocs.io for details |
| bioconvert bam2cov | Convert file from '('BAM',)' to '('COV',)' format. See bioconvert.readthedocs.io for details |
| bioconvert bam2cram | Convert file from '('BAM',)' to '('CRAM',)' format. See bioconvert.readthedocs.io for details |
| bioconvert bam2fasta | Convert file from ('BAM',) to ('FASTA',) format. See bioconvert.readthedocs.io for details |
| bioconvert bam2fastq | Convert file from '('BAM',)' to '('FASTQ',)' format. See bioconvert.readthedocs.io for details |
| bioconvert bam2json | Convert file from '('BAM',)' to '('JSON',)' format. See bioconvert.readthedocs.io for details |
| bioconvert bam2sam | Convert file from '('BAM',)' to '('SAM',)' format. See bioconvert.readthedocs.io for details |
| bioconvert bam2tsv | Convert file from ('BAM',) to ('TSV',) format. See bioconvert.readthedocs.io for details |
| bioconvert bam2wiggle | Convert file from '('BAM',)' to '('WIGGLE',)' format. See bioconvert.readthedocs.io for details |
| bioconvert bed2wiggle | Convert file from '('BED',)' to '('WIGGLE',)' format. See bioconvert.readthedocs.io for details |
| bioconvert bedgraph2bigwig | Convert file from '('BEDGRAPH',)' to '('BIGWIG',)' format. See bioconvert.readthedocs.io for details |
| bioconvert bedgraph2cov | Convert file from ('BEDGRAPH',) to ('COV',) format. See bioconvert.readthedocs.io for details |
| bioconvert clustal2phylip | Convert file from '('CLUSTAL',)' to '('PHYLIP',)' format. See bioconvert.readthedocs.io for details |
| bioconvert cram2bam | Convert file from '('CRAM',)' to '('BAM',)' format. See bioconvert.readthedocs.io for details |
| bioconvert cram2fasta | Convert file from '('CRAM',)' to '('FASTA',)' format. See bioconvert.readthedocs.io for details |
| bioconvert cram2fastq | Convert file from '('CRAM',)' to '('FASTQ',)' format. See bioconvert.readthedocs.io for details |
| bioconvert cram2sam | Convert file from '('CRAM',)' to '('SAM',)' format. See bioconvert.readthedocs.io for details |
| bioconvert csv2tsv | Convert file from '('CSV',)' to '('TSV',)' format. See bioconvert.readthedocs.io for details |
| bioconvert csv2xls | Convert file from '('CSV',)' to '('XLS',)' format. See bioconvert.readthedocs.io for details |
| bioconvert fasta2fastq | Convert file from '('FASTA',)' to '('FASTQ',)' format. See bioconvert.readthedocs.io for details |
| bioconvert fastq2fasta | Convert file from (FASTQ,) to (FASTA,) format. See bioconvert.readthedocs.io for details |
| bioconvert gz2bz2 | Convert file from '('GZ',)' to '('BZ2',)' format. See bioconvert.readthedocs.io for details |
| bioconvert gz2dsrc | Convert file from '('GZ',)' to '('DSRC',)' format. See bioconvert.readthedocs.io for details |
| bioconvert nexus2clustal | Convert file from '(NEXUS,)' to '(CLUSTAL,)' format. See bioconvert.readthedocs.io for details |
| bioconvert nexus2fasta | Convert file from '('NEXUS',)' to '('FASTA',)' format. See bioconvert.readthedocs.io for details |
| bioconvert nexus2newick | Convert file from '('NEXUS',)' to '('NEWICK',)' format. See bioconvert.readthedocs.io for details |
| bioconvert nexus2phylip | Convert file from (NEXUS,) to (PHYLIP,) format. See bioconvert.readthedocs.io for details |
| bioconvert pdb2faa | Convert file from '('PDB',)' to '('FAA',)' format. See bioconvert.readthedocs.io for details |
| bioconvert wig2bed | Convert file from '('WIG',)' to '('BED',)' format. See bioconvert.readthedocs.io for details |
| bioconvert xls2csv | Convert file from '('XLS',)' to '('CSV',)' format. See bioconvert.readthedocs.io for details |
| bioconvert_maf2sam | Convert file from '('MAF',)' to '('SAM',)' format. See bioconvert.readthedocs.io for details |
| bplink2plink | Convert file from '('BPLINK',)' to '('PLINK',)' format. See bioconvert.readthedocs.io for details |
| bplink2vcf | Convert file from '('BPLINK',)' to '('VCF',)' format. See bioconvert.readthedocs.io for details |
| bz22gz | Convert file from '('BZ2',)' to '('GZ',)' format. See bioconvert.readthedocs.io for details |
| clustal2stockholm | Convert file from '('CLUSTAL',)' to '('STOCKHOLM',)' format. See bioconvert.readthedocs.io for details |
| dsrc2gz | Convert file from '('DSRC',)' to '('GZ',)' format. See bioconvert.readthedocs.io for details |
| embl2fasta | Convert file from '('EMBL',)' to '('FASTA',)' format. See bioconvert.readthedocs.io for details |
| embl2genbank | Convert file from ('EMBL',) to ('GENBANK',) format. See bioconvert.readthedocs.io for details |
| fast52pod5 | Convert file from '('FAST5',)' to '('POD5',)' format. See bioconvert.readthedocs.io for details |
| fasta2clustal | Convert file from '('FASTA',)' to '('CLUSTAL',)' format. See bioconvert.readthedocs.io for details |
| fasta2faa | Convert file from '('FASTA',)' to '('FAA',)' format. See bioconvert.readthedocs.io for details |
| fasta2fasta_agp | Convert file from '('FASTA',)' to '('FASTA', 'AGP')' format. See bioconvert.readthedocs.io for details |
| fasta2genbank | Convert file from '('FASTA',)' to '('GENBANK',)' format. See bioconvert.readthedocs.io for details |
| fasta2nexus | Convert file from '('FASTA',)' to '('NEXUS',)' format. See bioconvert.readthedocs.io for details |
| fasta2phylip | Convert file from '('FASTA',)' to '('PHYLIP',)' format. See bioconvert.readthedocs.io for details |
| fasta2twobit | Convert file from '('FASTA',)' to '('TWOBIT',)' format. See bioconvert.readthedocs.io for details |
| fasta_qual2fastq | Convert file from '(FASTA', 'QUAL')' to '(FASTQ',)' format. See bioconvert.readthedocs.io for details |
| fastq2fasta_qual | Convert file from '('FASTQ',)' to '('FASTA', 'QUAL')' format. See bioconvert.readthedocs.io for details |
| genbank2embl | Convert file from '('GENBANK',)' to '('EMBL',)' format. See bioconvert.readthedocs.io for details |
| gff32gff2 | Convert file from '('GFF3',)' to '('GFF2',)' format. See bioconvert.readthedocs.io for details |
| gff32gtf | Convert file from ('GFF3',) to ('GTF',) format. See bioconvert.readthedocs.io for details |
| json2yaml | Convert file from '('JSON',)' to '('YAML',)' format. See bioconvert.readthedocs.io for details |
| newick2nexus | Convert file from '('NEWICK',)' to '('NEXUS',)' format. See bioconvert.readthedocs.io for details |
| newick2phyloxml | Convert file from '('NEWICK',)' to '('PHYLOXML',)' format. See bioconvert.readthedocs.io for details |
| nexus2phyloxml | Convert file from '('NEXUS',)' to '('PHYLOXML',)' format. See bioconvert.readthedocs.io for details |
| ods2csv | Convert file from '('ODS',)' to '('CSV',)' format. See bioconvert.readthedocs.io for details |
| phylip2clustal | Convert file from '('PHYLIP',)' to '('CLUSTAL',)' format. See bioconvert.readthedocs.io for details |
| phylip2fasta | Convert file from '('PHYLIP',)' to '('FASTA',)' format. See bioconvert.readthedocs.io for details |
| phylip2nexus | Convert file from '('PHYLIP',)' to '('NEXUS',)' format. See bioconvert.readthedocs.io for details |
| phylip2stockholm | Convert file from '('PHYLIP',)' to '('STOCKHOLM',)' format. See bioconvert.readthedocs.io for details |
| phylip2xmfa | Convert file from '('PHYLIP',)' to '('XMFA',)' format. See bioconvert.readthedocs.io for details |
| phyloxml2newick | Convert file from '('PHYLOXML',)' to '('NEWICK',)' format. See bioconvert.readthedocs.io for details |
| phyloxml2nexus | Convert file from '('PHYLOXML',)' to '('NEXUS',)' format. See bioconvert.readthedocs.io for details |
| plink2bplink | Convert file from '('PLINK',)' to '('BPLINK',)' format. See bioconvert.readthedocs.io for details |
| plink2vcf | Convert file from '('PLINK',)' to '('VCF',)' format. See bioconvert.readthedocs.io for details |
| sam2bam | Convert file from '('SAM',)' to '('BAM',)' format. See bioconvert.readthedocs.io for details |
| sam2cram | Convert file from '('SAM',)' to '('CRAM',)' format. See bioconvert.readthedocs.io for details |
| sam2paf | Convert file from '('SAM',)' to '('PAF',)' format. See bioconvert.readthedocs.io for details |
| scf2fasta | Convert file from '('SCF',)' to '('FASTA',)' format. See bioconvert.readthedocs.io for details |
| scf2fastq | Convert file from '('SCF',)' to '('FASTQ',)' format. See bioconvert.readthedocs.io for details |
| sra2fastq | Convert file from '('SRA',)' to '('FASTQ',)' format. See bioconvert.readthedocs.io for details |
| stockholm2clustal | Convert file from '(STOCKHOLM,)' to '(CLUSTAL,)' format. See bioconvert.readthedocs.io for details |
| stockholm2phylip | Convert file from '(STOCKHOLM,)' to '(PHYLIP,)' format. See bioconvert.readthedocs.io for details |
| tsv2csv | Convert file from '('TSV',)' to '('CSV',)' format. See bioconvert.readthedocs.io for details |
| twobit2fasta | Convert file from '('TWOBIT',)' to '('FASTA',)' format. See bioconvert.readthedocs.io for details |
| vcf2bcf | Convert file from '('VCF',)' to '('BCF',)' format. See bioconvert.readthedocs.io for details |
| vcf2bed | Convert file from '('VCF',)' to '('BED',)' format. See bioconvert.readthedocs.io for details |
| vcf2bplink | Convert file from '('VCF',)' to '('BPLINK',)' format. See bioconvert.readthedocs.io for details |
| vcf2plink | Convert file from '('VCF',)' to '('PLINK',)' format. See bioconvert.readthedocs.io for details |
| vcf2wiggle | Convert file from '('VCF',)' to '('WIGGLE',)' format. See bioconvert.readthedocs.io for details |
| xlsx2csv | Convert file from '('XLSX',)' to '('CSV',)' format. See bioconvert.readthedocs.io for details |
| xmfa2phylip | Convert file from '('XMFA',)' to '('PHYLIP',)' format. See bioconvert.readthedocs.io for details |

## Reference documentation
- [Bioconvert Main Documentation](./references/bioconvert_readthedocs_io_en_main.md)
- [User Guide](./references/bioconvert_readthedocs_io_en_main_user_guide.html.md)
- [Supported Formats](./references/bioconvert_readthedocs_io_en_main_formats.html.md)
- [Available Converters Reference](./references/bioconvert_readthedocs_io_en_main_ref_converters.html.md)
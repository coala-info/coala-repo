# dsh-bio CWL Generation Report

## dsh-bio_bin-fastq-quality-scores

### Tool Description
Calculate quality scores for FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Total Downloads**: 170.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/heuermh/dishevelled-bio
- **Stars**: N/A
### Original Help Text
```text
usage:
dsh-bin-fastq-quality-scores [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fastq-path [interface java.nio.file.Path]  input FASTQ path, default stdin [optional]
   -o, --output-fastq-file [class java.io.File]  output FASTQ file, default stdout [optional]
```


## dsh-bio_compress-bed

### Tool Description
Compresses a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-compress-bed [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-bed-path [interface java.nio.file.Path]  input BED path, default stdin [optional]
   -o, --output-bed-file [class java.io.File]  output BED file, default stdout [optional]
```


## dsh-bio_compress-fasta

### Tool Description
Compresses a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
org.biojava.bio.BioException: Could not read sequence
	at org.biojava.bio.seq.io.StreamReader.nextSequence(StreamReader.java:108)
	at org.dishevelled.bio.tools.CompressFasta.call(CompressFasta.java:134)
	at org.dishevelled.bio.tools.CompressFasta.main(CompressFasta.java:209)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)
Caused by: java.io.IOException: Premature stream end
	at org.biojava.bio.seq.io.FastaFormat.readSequence(FastaFormat.java:125)
	at org.biojava.bio.seq.io.StreamReader.nextSequence(StreamReader.java:105)
	... 6 more
```


## dsh-bio_compress-fastq

### Tool Description
Compresses FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-compress-fastq [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fastq-path [interface java.nio.file.Path]  input FASTQ path, default stdin [optional]
   -o, --output-fastq-file [class java.io.File]  output FASTQ file, default stdout [optional]
```


## dsh-bio_compress-gaf

### Tool Description
Compresses a GAF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-compress-gaf [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gaf-path [interface java.nio.file.Path]  input GAF path, default stdin [optional]
   -o, --output-gaf-file [class java.io.File]  output GAF file, default stdout [optional]
```


## dsh-bio_compress-gfa1

### Tool Description
Compresses a GFA 1.0 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-compress-gfa1 [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-gfa1-file [class java.io.File]  output GFA 1.0 file, default stdout [optional]
```


## dsh-bio_compress-gfa2

### Tool Description
Compresses a GFA 2.0 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-compress-gfa2 [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa2-path [interface java.nio.file.Path]  input GFA 2.0 path, default stdin [optional]
   -o, --output-gfa2-file [class java.io.File]  output GFA 2.0 file, default stdout [optional]
```


## dsh-bio_compress-gff3

### Tool Description
Compresses GFF3 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-compress-gff3 [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gff3-path [interface java.nio.file.Path]  input GFF3 path, default stdin [optional]
   -o, --output-gff3-file [class java.io.File]  output GFF3 file, default stdout [optional]
```


## dsh-bio_compress-paf

### Tool Description
Compresses a PAF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-compress-paf [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-paf-path [interface java.nio.file.Path]  input PAF path, default stdin [optional]
   -o, --output-paf-file [class java.io.File]  output PAF file, default stdout [optional]
```


## dsh-bio_compress-rgfa

### Tool Description
Compresses an rGFA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-compress-rgfa [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-rgfa-path [interface java.nio.file.Path]  input rGFA path, default stdin [optional]
   -o, --output-rgfa-file [class java.io.File]  output rGFA file, default stdout [optional]
```


## dsh-bio_compress-sam

### Tool Description
Compresses a SAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-compress-sam [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-sam-path [interface java.nio.file.Path]  input SAM path, default stdin [optional]
   -o, --output-sam-file [class java.io.File]  output SAM file, default stdout [optional]
```


## dsh-bio_compress-vcf

### Tool Description
Compresses a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-compress-vcf [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-vcf-path [interface java.nio.file.Path]  input VCF path, default stdin [optional]
   -o, --output-vcf-file [class java.io.File]  output VCF file, default stdout [optional]
```


## dsh-bio_count-fastq

### Tool Description
Count FASTQ reads

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-count-fastq [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fastq-path [interface java.nio.file.Path]  input FASTQ path, default stdin [optional]
   -o, --output-count-file [class java.io.File]  output count file, default stdout [optional]
```


## dsh-bio_create-sequence-dictionary

### Tool Description
Creates a sequence dictionary from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-create-sequence-dictionary [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -u, --url [class java.net.URL]  URL, default input FASTA path [optional]
   -i, --input-fasta-path [interface java.nio.file.Path]  input FASTA path, default stdin [optional]
   -o, --output-sequence-dictionary-file [class java.io.File]  output SequenceDictionary .dict file, default stdout [optional]
```


## dsh-bio_disinterleave-fastq

### Tool Description
Disinterleaves a FASTQ file into paired and unpaired files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-disinterleave-fastq -p foo.paired.fq.gz [-u foo.unpaired.fq.gz] -1 foo_1.fq.gz -2 foo_2.fq.gz

org.dishevelled.commandline.CommandLineParseException: required argument -p, --paired-path not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.DisinterleaveFastq.main(DisinterleaveFastq.java:216)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -p, --paired-path [interface java.nio.file.Path]  interleaved paired FASTQ input path [required]
   -u, --unpaired-path [interface java.nio.file.Path]  unpaired FASTQ input path [optional]
   -1, --first-fastq-file [class java.io.File]  first FASTQ output file [required]
   -2, --second-fastq-file [class java.io.File]  second FASTQ output file [required]
```


## dsh-bio_downsample-fastq

### Tool Description
Downsample FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-downsample-fastq -p 0.5 [args]

org.dishevelled.commandline.CommandLineParseException: required argument -p, --probability not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.DownsampleFastq.main(DownsampleFastq.java:166)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fastq-path [interface java.nio.file.Path]  input FASTQ path, default stdin [optional]
   -o, --output-fastq-file [class java.io.File]  output FASTQ file, default stdout [optional]
   -p, --probability [class java.lang.Double]  probability a FASTQ record will be removed, [0.0-1.0] [required]
   -z, --seed [class java.lang.Integer]  random number seed, default relates to current time [optional]
```


## dsh-bio_downsample-interleaved-fastq

### Tool Description
Downsample interleaved FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-downsample-interleaved-fastq -p 0.5 [args]

org.dishevelled.commandline.CommandLineParseException: required argument -p, --probability not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.DownsampleInterleavedFastq.main(DownsampleInterleavedFastq.java:167)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fastq-path [interface java.nio.file.Path]  input interleaved FASTQ path, default stdin [optional]
   -o, --output-fastq-file [class java.io.File]  output interleaved FASTQ file, default stdout [optional]
   -p, --probability [class java.lang.Double]  probability a FASTQ record will be removed, [0.0-1.0] [required]
   -z, --seed [class java.lang.Integer]  random number seed, default relates to current time [optional]
```


## dsh-bio_export-segments

### Tool Description
Export segments from a GFA file to FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-export-segments [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-fasta-file [class java.io.File]  output FASTA file, default stdout [optional]
   -w, --line-width [class java.lang.Integer]  line width, default 70 [optional]
```


## dsh-bio_extract-fasta

### Tool Description
Extracts sequences from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
org.biojava.bio.BioException: Could not read sequence
	at org.biojava.bio.seq.io.StreamReader.nextSequence(StreamReader.java:108)
	at org.dishevelled.bio.tools.ExtractFasta.call(ExtractFasta.java:188)
	at org.dishevelled.bio.tools.ExtractFasta.main(ExtractFasta.java:273)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)
Caused by: java.io.IOException: Premature stream end
	at org.biojava.bio.seq.io.FastaFormat.readSequence(FastaFormat.java:125)
	at org.biojava.bio.seq.io.StreamReader.nextSequence(StreamReader.java:105)
	... 6 more
```


## dsh-bio_extract-fasta-kmers

### Tool Description
Extract kmers from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-extract-fasta-kmers [args]

org.dishevelled.commandline.CommandLineParseException: required argument -k, --kmer-length not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.ExtractFastaKmers.main(ExtractFastaKmers.java:218)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fasta-path [interface java.nio.file.Path]  input FASTA path, default stdin [optional]
   -o, --output-kmer-file [class java.io.File]  output kmer file, default stdout [optional]
   -e, --alphabet [class java.lang.String]  input FASTA alphabet { dna, protein }, default dna [optional]
   -k, --kmer-length [class java.lang.Integer]  kmer length [required]
   -n, --include-ns  for DNA sequences, include kmers containing Ns [optional]
   -u, --upstream-length [class java.lang.Integer]  upstream length, default 0 [optional]
   -d, --downstream-length [class java.lang.Integer]  downstream length, default 0 [optional]
```


## dsh-bio_extract-fasta-kmers-to-parquet

### Tool Description
Extracts kmers from FASTA files and outputs them to a Parquet file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-extract-fasta-kmers-to-parquet [args]

org.dishevelled.commandline.CommandLineParseException: required argument -o, --output-kmer-file not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.ExtractFastaKmersToParquet.main(ExtractFastaKmersToParquet.java:267)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fasta-path [interface java.nio.file.Path]  input FASTA path, default stdin [optional]
   -o, --output-kmer-file [class java.io.File]  output kmer file [required]
   -e, --alphabet [class java.lang.String]  input FASTA alphabet { dna, protein }, default dna [optional]
   -k, --kmer-length [class java.lang.Integer]  kmer length [required]
   -n, --include-ns  for DNA sequences, include kmers containing Ns [optional]
   -u, --upstream-length [class java.lang.Integer]  upstream length, default 0 [optional]
   -d, --downstream-length [class java.lang.Integer]  downstream length, default 0 [optional]
```


## dsh-bio_extract-fasta-kmers-to-parquet3

### Tool Description
Extracts kmers from FASTA files and outputs them to a Parquet file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-extract-fasta-kmers-to-parquet3 [args]

org.dishevelled.commandline.CommandLineParseException: required argument -o, --output-kmer-file not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.ExtractFastaKmersToParquet3.main(ExtractFastaKmersToParquet3.java:293)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fasta-path [interface java.nio.file.Path]  input FASTA path, default stdin [optional]
   -o, --output-kmer-file [class java.io.File]  output kmer file [required]
   -e, --alphabet [class java.lang.String]  input FASTA alphabet { dna, protein }, default dna [optional]
   -k, --kmer-length [class java.lang.Integer]  kmer length [required]
   -n, --include-ns  for DNA sequences, include kmers containing Ns [optional]
   -u, --upstream-length [class java.lang.Integer]  upstream length, default 0 [optional]
   -d, --downstream-length [class java.lang.Integer]  downstream length, default 0 [optional]
```


## dsh-bio_extract-fastq

### Tool Description
Extracts sequences from a FASTQ file based on name or description.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-extract-fastq [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fastq-path [interface java.nio.file.Path]  input FASTQ path, default stdin [optional]
   -o, --output-fastq-file [class java.io.File]  output FASTQ file, default stdout [optional]
   -n, --name [class java.lang.String]  exact sequence name to match [optional]
   -d, --description [class java.lang.String]  FASTQ description regex pattern to match [optional]
```


## dsh-bio_extract-fastq-by-length

### Tool Description
Extract FASTQ reads by sequence length.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-extract-fastq-by-length [args]

org.dishevelled.commandline.CommandLineParseException: required argument -m, --minimum-length not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.ExtractFastqByLength.main(ExtractFastqByLength.java:163)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fastq-path [interface java.nio.file.Path]  input FASTQ path, default stdin [optional]
   -o, --output-fastq-file [class java.io.File]  output FASTQ file, default stdout [optional]
   -m, --minimum-length [class java.lang.Integer]  minimum sequence length, inclusive [required]
   -x, --maximum-length [class java.lang.Integer]  maximum sequence length, exclusive [required]
```


## dsh-bio_extract-uniprot-features

### Tool Description
Extracts features from UniProt XML entries.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
[Fatal Error] :1:1: Premature end of file.
java.io.IOException: could not read UniProt XML
	at org.dishevelled.bio.protein.uniprot.UniprotEntryFeatureReader.stream(UniprotEntryFeatureReader.java:90)
	at org.dishevelled.bio.tools.ExtractUniprotFeatures.call(ExtractUniprotFeatures.java:141)
	at org.dishevelled.bio.tools.ExtractUniprotFeatures.main(ExtractUniprotFeatures.java:202)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)
Caused by: org.xml.sax.SAXParseException; lineNumber: 1; columnNumber: 1; Premature end of file.
	at java.xml/com.sun.org.apache.xerces.internal.parsers.AbstractSAXParser.parse(AbstractSAXParser.java:1252)
	at java.xml/com.sun.org.apache.xerces.internal.jaxp.SAXParserImpl$JAXPSAXParser.parse(SAXParserImpl.java:643)
	at org.dishevelled.bio.protein.uniprot.UniprotEntryFeatureReader.stream(UniprotEntryFeatureReader.java:87)
	... 6 more
```


## dsh-bio_extract-uniprot-features-to-parquet

### Tool Description
Extracts features from UniProt XML files and saves them to a Parquet file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-extract-uniprot-features-to-parquet [args]

org.dishevelled.commandline.CommandLineParseException: required argument -o, --output-feature-file not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.ExtractUniprotFeaturesToParquet.main(ExtractUniprotFeaturesToParquet.java:228)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-uniprot-xml-path [interface java.nio.file.Path]  input UniProt XML path, default stdin [optional]
   -o, --output-feature-file [class java.io.File]  output feature Parquet file [required]
   -g, --row-group-size [class java.lang.Integer]  row group size, default 122880 [optional]
```


## dsh-bio_extract-uniprot-features-to-partitioned-parquet

### Tool Description
Extracts UniProt features to a partitioned Parquet file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-extract-uniprot-features-to-partitioned-parquet [args]

org.dishevelled.commandline.CommandLineParseException: required argument -o, --output-feature-file not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.ExtractUniprotFeaturesToPartitionedParquet.main(ExtractUniprotFeaturesToPartitionedParquet.java:275)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-uniprot-xml-path [interface java.nio.file.Path]  input UniProt XML path, default stdin [optional]
   -o, --output-feature-file [class java.io.File]  output feature Parquet file [required]
   -g, --row-group-size [class java.lang.Integer]  row group size, default 122880 [optional]
   -p, --partition-size [class java.lang.Long]  partition size, default 1228800 [optional]
```


## dsh-bio_extract-uniprot-sequences

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[Fatal Error] :1:1: Premature end of file.
java.io.IOException: could not read UniProt XML
	at org.dishevelled.bio.protein.uniprot.UniprotEntrySequenceReader.stream(UniprotEntrySequenceReader.java:85)
	at org.dishevelled.bio.tools.ExtractUniprotSequences.call(ExtractUniprotSequences.java:104)
	at org.dishevelled.bio.tools.ExtractUniprotSequences.main(ExtractUniprotSequences.java:165)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)
Caused by: org.xml.sax.SAXParseException; lineNumber: 1; columnNumber: 1; Premature end of file.
	at java.xml/com.sun.org.apache.xerces.internal.parsers.AbstractSAXParser.parse(AbstractSAXParser.java:1252)
	at java.xml/com.sun.org.apache.xerces.internal.jaxp.SAXParserImpl$JAXPSAXParser.parse(SAXParserImpl.java:643)
	at org.dishevelled.bio.protein.uniprot.UniprotEntrySequenceReader.stream(UniprotEntrySequenceReader.java:82)
	... 6 more
```


## dsh-bio_fasta-index-to-pangenome

### Tool Description
Converts a FASTA index to a pangenome file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fasta-index-to-pangenome [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fasta-index-path [interface java.nio.file.Path]  input FASTA index (.fai) path, default stdin [optional]
   -o, --output-pangenome-file [class java.io.File]  output pangenome file, default stdout [optional]
   -s, --sort  sort pangenome samples, haplotypes, and scaffolds before writing [optional]
```


## dsh-bio_fasta-index-to-pangenome-tree

### Tool Description
Converts a FASTA index to a pangenome tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fasta-index-to-pangenome-tree [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fasta-index-path [interface java.nio.file.Path]  input FASTA index (.fai) path, default stdin [optional]
   -o, --output-pangenome-file [class java.io.File]  output pangenome tree file, default stdout [optional]
   -s, --sort  sort pangenome samples, haplotypes, and scaffolds before writing [optional]
```


## dsh-bio_fasta-to-fastq

### Tool Description
Converts FASTA sequences to FASTQ format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
org.biojava.bio.BioException: Could not read sequence
	at org.biojava.bio.seq.io.StreamReader.nextSequence(StreamReader.java:108)
	at org.dishevelled.bio.tools.FastaToFastq.call(FastaToFastq.java:118)
	at org.dishevelled.bio.tools.FastaToFastq.main(FastaToFastq.java:190)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)
Caused by: java.io.IOException: Premature stream end
	at org.biojava.bio.seq.io.FastaFormat.readSequence(FastaFormat.java:125)
	at org.biojava.bio.seq.io.StreamReader.nextSequence(StreamReader.java:105)
	... 6 more
```


## dsh-bio_fasta-to-pangenome

### Tool Description
Converts FASTA files to a pangenome representation.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fasta-to-pangenome [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fasta-path [interface java.nio.file.Path]  input FASTA path, default stdin [optional]
   -o, --output-pangenome-file [class java.io.File]  output pangenome file, default stdout [optional]
   -s, --sort  sort pangenome samples, haplotypes, and scaffolds before writing [optional]
```


## dsh-bio_fasta-to-pangenome-tree

### Tool Description
Converts FASTA files to a pangenome tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fasta-to-pangenome-tree [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fasta-path [interface java.nio.file.Path]  input FASTA path, default stdin [optional]
   -o, --output-pangenome-file [class java.io.File]  output pangenome tree file, default stdout [optional]
   -s, --sort  sort pangenome samples, haplotypes, and scaffolds before writing [optional]
```


## dsh-bio_fasta-to-parquet

### Tool Description
Converts FASTA files to Parquet format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fasta-to-parquet [args]

org.dishevelled.commandline.CommandLineParseException: required argument -o, --output-parquet-file not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.FastaToParquet.main(FastaToParquet.java:198)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fasta-path [interface java.nio.file.Path]  input FASTA path, default stdin [optional]
   -o, --output-parquet-file [class java.io.File]  output Parquet file [required]
   -e, --alphabet [class java.lang.String]  input FASTA alphabet { dna, protein }, default dna [optional]
   -g, --row-group-size [class java.lang.Integer]  row group size, default 122880 [optional]
```


## dsh-bio_fasta-to-parquet2

### Tool Description
Converts FASTA files to Parquet format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fasta-to-parquet2 [args]

org.dishevelled.commandline.CommandLineParseException: required argument -o, --output-parquet-file not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.FastaToParquet2.main(FastaToParquet2.java:219)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fasta-path [interface java.nio.file.Path]  input FASTA path, default stdin [optional]
   -o, --output-parquet-file [class java.io.File]  output Parquet file [required]
   -e, --alphabet [class java.lang.String]  input FASTA alphabet { dna, protein }, default dna [optional]
   -g, --row-group-size [class java.lang.Integer]  row group size, default 122880 [optional]
   -t, --transaction-size [class java.lang.Long]  transaction size, default 1228800 [optional]
```


## dsh-bio_fasta-to-parquet3

### Tool Description
Converts FASTA files to Parquet format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fasta-to-parquet3 [args]

org.dishevelled.commandline.CommandLineParseException: required argument -o, --output-parquet-file not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.FastaToParquet3.main(FastaToParquet3.java:232)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fasta-path [interface java.nio.file.Path]  input FASTA path, default stdin [optional]
   -o, --output-parquet-file [class java.io.File]  output Parquet file, will be created as a directory, overwriting if necessary [required]
   -e, --alphabet [class java.lang.String]  input FASTA alphabet { dna, protein }, default dna [optional]
   -g, --row-group-size [class java.lang.Integer]  row group size, default 122880 [optional]
   -p, --partition-size [class java.lang.Long]  partition size, default 1228800 [optional]
```


## dsh-bio_fasta-to-parquet4

### Tool Description
Converts FASTA files to Parquet format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fasta-to-parquet4 [args]

org.dishevelled.commandline.CommandLineParseException: required argument -o, --output-parquet-file not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.FastaToParquet4.main(FastaToParquet4.java:213)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fasta-path [interface java.nio.file.Path]  input FASTA path, default stdin [optional]
   -o, --output-parquet-file [class java.io.File]  output Parquet file [required]
   -e, --alphabet [class java.lang.String]  input FASTA alphabet { dna, protein }, default dna [optional]
   -g, --row-group-size [class java.lang.Integer]  row group size, default 122880 [optional]
   -f, --flush-after [class java.lang.Long]  flush appender after each rows, default 1228800 [optional]
```


## dsh-bio_fasta-to-parquet5

### Tool Description
Converts FASTA files to Parquet format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fasta-to-parquet5 [args]

org.dishevelled.commandline.CommandLineParseException: required argument -o, --output-parquet-file not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.FastaToParquet5.main(FastaToParquet5.java:198)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fasta-path [interface java.nio.file.Path]  input FASTA path, default stdin [optional]
   -o, --output-parquet-file [class java.io.File]  output Parquet file [required]
   -e, --alphabet [class java.lang.String]  input FASTA alphabet { dna, protein }, default dna [optional]
   -g, --row-group-size [class java.lang.Integer]  row group size, default 122880 [optional]
```


## dsh-bio_fasta-to-parquet6

### Tool Description
Converts FASTA files to Parquet format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fasta-to-parquet6 [args]

org.dishevelled.commandline.CommandLineParseException: required argument -o, --output-parquet-file not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.FastaToParquet6.main(FastaToParquet6.java:198)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fasta-path [interface java.nio.file.Path]  input FASTA path, default stdin [optional]
   -o, --output-parquet-file [class java.io.File]  output Parquet file [required]
   -e, --alphabet [class java.lang.String]  input FASTA alphabet { dna, protein }, default dna [optional]
   -g, --row-group-size [class java.lang.Integer]  row group size, default 122880 [optional]
```


## dsh-bio_fasta-to-text

### Tool Description
Converts FASTA sequences to plain text.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
org.biojava.bio.BioException: Could not read sequence
	at org.biojava.bio.seq.io.StreamReader.nextSequence(StreamReader.java:108)
	at org.dishevelled.bio.tools.FastaToText.call(FastaToText.java:91)
	at org.dishevelled.bio.tools.FastaToText.main(FastaToText.java:167)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)
Caused by: java.io.IOException: Premature stream end
	at org.biojava.bio.seq.io.FastaFormat.readSequence(FastaFormat.java:125)
	at org.biojava.bio.seq.io.StreamReader.nextSequence(StreamReader.java:105)
	... 6 more
```


## dsh-bio_fastq-description

### Tool Description
Display description lines from a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fastq-description [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --fastq-path [interface java.nio.file.Path]  input FASTQ path, default stdin [optional]
   -o, --description-file [class java.io.File]  output file of description lines, default stdout [optional]
```


## dsh-bio_fastq-sequence-length

### Tool Description
Calculates the sequence length for each read in a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fastq-sequence-length [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --fastq-path [interface java.nio.file.Path]  input FASTQ path, default stdin [optional]
   -o, --sequence-length-file [class java.io.File]  output file of sequence lengths, default stdout [optional]
```


## dsh-bio_fastq-to-fasta

### Tool Description
Converts FASTQ format to FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fastq-to-fasta [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fastq-path [interface java.nio.file.Path]  input FASTQ path, default stdin [optional]
   -o, --output-fasta-file [class java.io.File]  output FASTA file, default stdout [optional]
```


## dsh-bio_fastq-to-text

### Tool Description
Converts FASTQ files to a text format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-fastq-to-text [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-fastq-path [interface java.nio.file.Path]  input FASTQ path, default stdin [optional]
   -o, --output-text-file [class java.io.File]  output text file, default stdout [optional]
```


## dsh-bio_filter-bed

### Tool Description
Filter BED files based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-filter-bed --score 20.0 -i input.bed.bgz -o output.bed.bgz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -r, --range [class java.lang.String]  filter by range, specify as chrom:start-end in 0-based coordindates [optional]
   -s, --score [class java.lang.Integer]  filter by score [optional]
   -e, --script [class java.lang.String]  filter by script, eval against r [optional]
   -i, --input-bed-path [interface java.nio.file.Path]  input BED path, default stdin [optional]
   -o, --output-bed-file [class java.io.File]  output BED file, default stdout [optional]
```


## dsh-bio_filter-fasta

### Tool Description
Filters FASTA files based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
org.biojava.bio.BioException: Could not read sequence
	at org.biojava.bio.seq.io.StreamReader.nextSequence(StreamReader.java:108)
	at org.dishevelled.bio.tools.FilterFasta.call(FilterFasta.java:170)
	at org.dishevelled.bio.tools.FilterFasta.main(FilterFasta.java:338)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)
Caused by: java.io.IOException: Premature stream end
	at org.biojava.bio.seq.io.FastaFormat.readSequence(FastaFormat.java:125)
	at org.biojava.bio.seq.io.StreamReader.nextSequence(StreamReader.java:105)
	... 6 more
```


## dsh-bio_filter-fastq

### Tool Description
Filter FASTQ files based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-filter-fastq --length 2000 -i input.fastq.bgz -o output.fastq.bgz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -n, --length [class java.lang.Integer]  filter by length [optional]
   -e, --script [class java.lang.String]  filter by script, eval against r [optional]
   -i, --input-fastq-path [interface java.nio.file.Path]  input FASTQ path, default stdin [optional]
   -o, --output-fastq-file [class java.io.File]  output FASTQ file, default stdout [optional]
```


## dsh-bio_filter-gaf

### Tool Description
Filter GAF files based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-filter-gaf --mapping-quality 30 -i input.gaf.bgz -o output.gaf.bgz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -r, --query [class java.lang.String]  filter by query range, specify as queryName:start-end in 0-based coordindates [optional]
   -q, --mapping-quality [class java.lang.Integer]  filter by mapping quality [optional]
   -e, --script [class java.lang.String]  filter by script, eval against r [optional]
   -i, --input-gaf-path [interface java.nio.file.Path]  input GAF path, default stdin [optional]
   -o, --output-gaf-file [class java.io.File]  output GAF file, default stdout [optional]
```


## dsh-bio_filter-gfa1

### Tool Description
Filter GFA1 files based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-filter-gfa1 --read-count 40 -i input.gfa1.bgz -o output.gfa1.bgz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -g, --invalid-segment-references  filter containments, links, and paths that reference missing segments [optional]
   -n, --length [class java.lang.Integer]  filter segments by length [optional]
   -f, --fragment-count [class java.lang.Integer]  filter segments and links by fragment count [optional]
   -k, --kmer-count [class java.lang.Integer]  filter segments and links by k-mer count [optional]
   -m, --mapping-quality [class java.lang.Integer]  filter links by mapping quality [optional]
   -s, --mismatch-count [class java.lang.Integer]  filter links by mismatch count [optional]
   -r, --read-count [class java.lang.Integer]  filter segments and links by read count [optional]
   -e, --script [class java.lang.String]  filter by script, eval against r [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-gfa1-file [class java.io.File]  output GFA 1.0 file, default stdout [optional]
```


## dsh-bio_filter-gfa2

### Tool Description
Filter GFA2 files

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-filter-gfa2 -i input.gfa2.bgz -o output.gfa2.bgz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -e, --script [class java.lang.String]  filter by script, eval against r [optional]
   -i, --input-gfa2-path [interface java.nio.file.Path]  input GFA 2.0 path, default stdin [optional]
   -o, --output-gfa2-file [class java.io.File]  output GFA 2.0 file, default stdout [optional]
```


## dsh-bio_filter-gff3

### Tool Description
Filter GFF3 files based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-filter-gff3 --score 20.0 -i input.gff3.bgz -o output.gff3.bgz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -r, --range [class java.lang.String]  filter by range, specify as chrom:start-end in 0-based coordindates [optional]
   -s, --score [class java.lang.Integer]  filter by score [optional]
   -e, --script [class java.lang.String]  filter by script, eval against r [optional]
   -i, --input-gff3-path [interface java.nio.file.Path]  input GFF3 path, default stdin [optional]
   -o, --output-gff3-file [class java.io.File]  output GFF3 file, default stdout [optional]
```


## dsh-bio_filter-paf

### Tool Description
Filters a PAF file based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-filter-paf --mapping-quality 30 -i input.paf.bgz -o output.paf.bgz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -r, --query [class java.lang.String]  filter by query range, specify as queryName:start-end in 0-based coordindates [optional]
   -t, --target [class java.lang.String]  filter by target range, specify as targetName:start-end in 0-based coordindates [optional]
   -q, --mapping-quality [class java.lang.Integer]  filter by mapping quality [optional]
   -e, --script [class java.lang.String]  filter by script, eval against r [optional]
   -i, --input-paf-path [interface java.nio.file.Path]  input PAF path, default stdin [optional]
   -o, --output-paf-file [class java.io.File]  output PAF file, default stdout [optional]
```


## dsh-bio_filter-rgfa

### Tool Description
Filter rGFA graphs.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-filter-rgfa --read-count 40 -i input.rGFA.gfa.bgz -o output.rGFA.gfa.bgz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -g, --invalid-segment-references  filter containments, links, and paths that reference missing segments [optional]
   -n, --length [class java.lang.Integer]  filter segments by length [optional]
   -f, --fragment-count [class java.lang.Integer]  filter segments and links by fragment count [optional]
   -k, --kmer-count [class java.lang.Integer]  filter segments and links by k-mer count [optional]
   -m, --mapping-quality [class java.lang.Integer]  filter links by mapping quality [optional]
   -s, --mismatch-count [class java.lang.Integer]  filter links by mismatch count [optional]
   -r, --read-count [class java.lang.Integer]  filter segments and links by read count [optional]
   -e, --script [class java.lang.String]  filter by script, eval against r [optional]
   -i, --input-rgfa-path [interface java.nio.file.Path]  input rGFA path, default stdin [optional]
   -o, --output-rgfa-file [class java.io.File]  output rGFA file, default stdout [optional]
```


## dsh-bio_filter-sam

### Tool Description
Filter SAM/BAM files based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-filter-sam --mapq 30 -i input.sam.bgz -o output.sam.bgz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -r, --range [class java.lang.String]  filter by range, specify as chrom:start-end in 0-based coordindates [optional]
   -q, --mapq [class java.lang.Integer]  filter by mapq [optional]
   -e, --script [class java.lang.String]  filter by script, eval against r [optional]
   -i, --input-sam-path [interface java.nio.file.Path]  input SAM path, default stdin [optional]
   -o, --output-sam-file [class java.io.File]  output SAM file, default stdout [optional]
```


## dsh-bio_filter-vcf

### Tool Description
Filter VCF file based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-filter-vcf -d rs149201999 -i input.vcf.gz -o output.vcf.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -d, --id [java.util.List<java.lang.String>]  filter by id, specify as id1,id2,id3 [optional]
   -r, --range [class java.lang.String]  filter by range, specify as chrom:start-end in 0-based coordindates [optional]
   -q, --qual [class java.lang.Double]  filter by quality score [optional]
   -f, --filter  filter to records that have passed all filters [optional]
   -e, --script [class java.lang.String]  filter by script, eval against r [optional]
   -i, --input-vcf-path [interface java.nio.file.Path]  input VCF path, default stdin [optional]
   -o, --output-vcf-file [class java.io.File]  output VCF file, default stdout [optional]
```


## dsh-bio_gfa1-to-gfa2

### Tool Description
Converts GFA 1.0 format to GFA 2.0 format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-gfa1-to-gfa2 -i input.gfa1.gz -o output.gfa2.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-gfa2-file [class java.io.File]  output GFA 2.0 file, default stdout [optional]
```


## dsh-bio_gff3-to-bed

### Tool Description
Converts GFF3 format to BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-gff3-to-bed [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gff3-path [interface java.nio.file.Path]  input GFF3 path, default stdin [optional]
   -o, --output-bed-file [class java.io.File]  output BED file, default stdout [optional]
```


## dsh-bio_identify-gfa1

### Tool Description
Identify GFA 1.0 files

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-identify-gfa1 [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-gfa1-file [class java.io.File]  output GFA 1.0 file, default stdout [optional]
```


## dsh-bio_interleave-fastq

### Tool Description
Interleaves two FASTQ files into a single paired FASTQ file, with unpaired reads written to a separate file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-interleave-fastq -1 foo_1.fq.gz -2 foo_2.fq.gz -p foo.paired.fq.gz -u foo.unpaired.fq.gz

org.dishevelled.commandline.CommandLineParseException: required argument -1, --first-fastq-path not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.InterleaveFastq.main(InterleaveFastq.java:197)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -1, --first-fastq-path [interface java.nio.file.Path]  first FASTQ input path [required]
   -2, --second-fastq-path [interface java.nio.file.Path]  second FASTQ input path [required]
   -p, --paired-file [class java.io.File]  output interleaved paired FASTQ file [required]
   -u, --unpaired-file [class java.io.File]  output unpaired FASTQ file [required]
```


## dsh-bio_links-to-cytoscape-edges

### Tool Description
Converts GFA graph to Cytoscape edge list format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-links-to-cytoscape-edges -i input.gfa.gz -o edges.txt.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-edges-file [class java.io.File]  output Cytoscape edges.txt format file, default stdout [optional]
```


## dsh-bio_links-to-property-graph

### Tool Description
Converts GFA graph data to a property graph format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-links-to-property-graph -i input.gfa.gz -o link-edges.csv.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-edges-file [class java.io.File]  output property graph CSV format file, default stdout [optional]
```


## dsh-bio_list-filesystems

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Installed filesystem providers:
  file	sun.nio.fs.LinuxFileSystemProvider
  jar	jdk.nio.zipfs.ZipFileSystemProvider
  jrt	jdk.internal.jrtfs.JrtFileSystemProvider
  gs	com.google.cloud.storage.contrib.nio.CloudStorageFileSystemProvider
  s3	software.amazon.nio.spi.s3.S3FileSystemProvider
  s3x	software.amazon.nio.spi.s3.S3XFileSystemProvider
```


## dsh-bio_reassemble-paths

### Tool Description
Reassemble paths from a GFA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-reassemble-paths [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-gfa1-file [class java.io.File]  output GFA 1.0 file, default stdout [optional]
```


## dsh-bio_remap-dbsnp

### Tool Description
Remaps dbSNP IDs in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-remap-dbsnp -i input.vcf.gz -o output.vcf.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-vcf-path [interface java.nio.file.Path]  input VCF path, default stdin [optional]
   -o, --output-vcf-file [class java.io.File]  output VCF file, default stdout [optional]
```


## dsh-bio_remap-phase-set

### Tool Description
Remaps phase sets in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-remap-phase-set -i input.vcf.gz -o output.vcf.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-vcf-path [interface java.nio.file.Path]  input VCF path, default stdin [optional]
   -o, --output-vcf-file [class java.io.File]  output VCF file, default stdout [optional]
```


## dsh-bio_rename-bed-references

### Tool Description
Rename chromosome references in a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-rename-bed-references [--chr] -i input.bed.gz -o output.bed.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -c, --chr  add "chr" to chromosome reference names [optional]
   -i, --input-bed-path [interface java.nio.file.Path]  input BED path, default stdin [optional]
   -o, --output-bed-file [class java.io.File]  output BED file, default stdout [optional]
```


## dsh-bio_rename-gff3-references

### Tool Description
Rename chromosome references in a GFF3 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-rename-references [--chr] -i input.gff3.gz -o output.gff3.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -c, --chr  add "chr" to chromosome reference names [optional]
   -i, --input-gff3-path [interface java.nio.file.Path]  input GFF3 path, default stdin [optional]
   -o, --output-gff3-file [class java.io.File]  output GFF3 file, default stdout [optional]
```


## dsh-bio_rename-vcf-references

### Tool Description
Rename chromosome reference names in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-rename-vcf-references [--chr] -i input.vcf.gz -o output.vcf.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -c, --chr  add "chr" to chromosome reference names [optional]
   -i, --input-vcf-path [interface java.nio.file.Path]  input VCF path, default stdin [optional]
   -o, --output-vcf-file [class java.io.File]  output VCF file, default stdout [optional]
```


## dsh-bio_segments-to-cytoscape-nodes

### Tool Description
Converts GFA graph segments to Cytoscape nodes.txt format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-segments-to-cytoscape-nodes -i input.gfa.gz -o nodes.txt.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-nodes-file [class java.io.File]  output Cytoscape nodes.txt format file, default stdout [optional]
```


## dsh-bio_segments-to-property-graph

### Tool Description
Converts GFA files to a property graph format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-segments-to-property-graph -i input.gfa.gz -o nodes.csv.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-nodes-file [class java.io.File]  output property graph CSV format file, default stdout [optional]
```


## dsh-bio_split-bed

### Tool Description
Splits a BED file into smaller files based on byte count or record count.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-split-bed -r 100 -i foo.bed.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-path [interface java.nio.file.Path]  input BED path, default stdin [optional]
   -b, --bytes [class java.lang.String]  split input path at next record after each n bytes [optional]
   -r, --records [class java.lang.Long]  split input path after each n records [optional]
   -p, --prefix [class java.lang.String]  output file prefix [optional]
   -d, --left-pad [class java.lang.Integer]  left pad split index in output file name [optional]
   -s, --suffix [class java.lang.String]  output file suffix, e.g. .bed.gz [optional]
```


## dsh-bio_split-fasta

### Tool Description
Splits a FASTA file into multiple smaller files based on specified criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-split-fasta -r 100 -i foo.fa.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-path [interface java.nio.file.Path]  input FASTA path, default stdin [optional]
   -e, --alphabet [class java.lang.String]  input FASTA alphabet { dna, protein }, default dna [optional]
   -b, --bytes [class java.lang.String]  split input path at next record after each n bytes [optional]
   -r, --records [class java.lang.Long]  split input path after each n records [optional]
   -p, --prefix [class java.lang.String]  output file prefix [optional]
   -d, --left-pad [class java.lang.Integer]  left pad split index in output file name [optional]
   -s, --suffix [class java.lang.String]  output file suffix, e.g. .fa.gz [optional]
   -w, --line-width [class java.lang.Integer]  line width, default 70 [optional]
```


## dsh-bio_split-fastq

### Tool Description
Splits a FASTQ file into multiple smaller files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-split-fastq -r 100 -i foo.fq.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-path [interface java.nio.file.Path]  input FASTQ path, default stdin [optional]
   -b, --bytes [class java.lang.String]  split input path at next record after each n bytes [optional]
   -r, --records [class java.lang.Long]  split input path after each n records [optional]
   -p, --prefix [class java.lang.String]  output file prefix [optional]
   -d, --left-pad [class java.lang.Integer]  left pad split index in output file name [optional]
   -s, --suffix [class java.lang.String]  output file suffix, e.g. .fq.gz [optional]
```


## dsh-bio_split-gaf

### Tool Description
Split a GAF file into smaller files based on records or bytes.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-split-gaf -r 100 -i foo.gaf.bgz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-path [interface java.nio.file.Path]  input GAF path, default stdin [optional]
   -b, --bytes [class java.lang.String]  split input path at next record after each n bytes [optional]
   -r, --records [class java.lang.Long]  split input path after each n records [optional]
   -p, --prefix [class java.lang.String]  output file prefix [optional]
   -d, --left-pad [class java.lang.Integer]  left pad split index in output file name [optional]
   -s, --suffix [class java.lang.String]  output file suffix, e.g. .gaf.bgz [optional]
```


## dsh-bio_split-gff3

### Tool Description
Splits a GFF3 file into smaller files based on byte count or record count.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-split-gff3 -r 100 -i foo.gff3.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-path [interface java.nio.file.Path]  input GFF3 path, default stdin [optional]
   -b, --bytes [class java.lang.String]  split input path at next record after each n bytes [optional]
   -r, --records [class java.lang.Long]  split input path after each n records [optional]
   -p, --prefix [class java.lang.String]  output file prefix [optional]
   -d, --left-pad [class java.lang.Integer]  left pad split index in output file name [optional]
   -s, --suffix [class java.lang.String]  output file suffix, e.g. .gff3.gz [optional]
```


## dsh-bio_split-interleaved-fastq

### Tool Description
Splits an interleaved FASTQ file into multiple files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-split-interleaved-fastq -r 100 -i foo.ifq.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-path [interface java.nio.file.Path]  input interleaved FASTQ path, default stdin [optional]
   -b, --bytes [class java.lang.String]  split input path at next pair of records after each n bytes [optional]
   -r, --records [class java.lang.Long]  split input path after each n records, respecting pairs [optional]
   -p, --prefix [class java.lang.String]  output file prefix [optional]
   -d, --left-pad [class java.lang.Integer]  left pad split index in output file name [optional]
   -s, --suffix [class java.lang.String]  output file suffix, e.g. .ifq.gz [optional]
```


## dsh-bio_split-paf

### Tool Description
Split a PAF file into smaller files based on byte count or record count.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-split-paf -r 100 -i foo.paf.bgz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-path [interface java.nio.file.Path]  input PAF path, default stdin [optional]
   -b, --bytes [class java.lang.String]  split input path at next record after each n bytes [optional]
   -r, --records [class java.lang.Long]  split input path after each n records [optional]
   -p, --prefix [class java.lang.String]  output file prefix [optional]
   -d, --left-pad [class java.lang.Integer]  left pad split index in output file name [optional]
   -s, --suffix [class java.lang.String]  output file suffix, e.g. .paf.bgz [optional]
```


## dsh-bio_split-sam

### Tool Description
Splits a SAM/BAM/CRAM file into smaller files based on record count or byte size.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-split-sam -r 100 -i foo.sam.bgz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-path [interface java.nio.file.Path]  input SAM path, default stdin [optional]
   -b, --bytes [class java.lang.String]  split input path at next record after each n bytes [optional]
   -r, --records [class java.lang.Long]  split input path after each n records [optional]
   -p, --prefix [class java.lang.String]  output file prefix [optional]
   -d, --left-pad [class java.lang.Integer]  left pad split index in output file name [optional]
   -s, --suffix [class java.lang.String]  output file suffix, e.g. .sam.bgz [optional]
```


## dsh-bio_split-vcf

### Tool Description
Splits a VCF file into smaller files based on records or bytes.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-split-vcf -r 100 -i foo.vcf.bgz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-path [interface java.nio.file.Path]  input VCF path, default stdin [optional]
   -b, --bytes [class java.lang.String]  split input path at next record after each n bytes [optional]
   -r, --records [class java.lang.Long]  split input path after each n records [optional]
   -p, --prefix [class java.lang.String]  output file prefix [optional]
   -d, --left-pad [class java.lang.Integer]  left pad split index in output file name [optional]
   -s, --suffix [class java.lang.String]  output file suffix, e.g. .vcf.bgz [optional]
```


## dsh-bio_summarize-uniprot-entries

### Tool Description
Summarizes UniProt entries from XML files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
[Fatal Error] :1:1: Premature end of file.
java.io.IOException: could not read UniProt XML
	at org.dishevelled.bio.protein.uniprot.UniprotEntrySummaryReader.stream(UniprotEntrySummaryReader.java:90)
	at org.dishevelled.bio.tools.SummarizeUniprotEntries.call(SummarizeUniprotEntries.java:102)
	at org.dishevelled.bio.tools.SummarizeUniprotEntries.main(SummarizeUniprotEntries.java:163)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)
Caused by: org.xml.sax.SAXParseException; lineNumber: 1; columnNumber: 1; Premature end of file.
	at java.xml/com.sun.org.apache.xerces.internal.parsers.AbstractSAXParser.parse(AbstractSAXParser.java:1252)
	at java.xml/com.sun.org.apache.xerces.internal.jaxp.SAXParserImpl$JAXPSAXParser.parse(SAXParserImpl.java:643)
	at org.dishevelled.bio.protein.uniprot.UniprotEntrySummaryReader.stream(UniprotEntrySummaryReader.java:87)
	... 6 more
```


## dsh-bio_summarize-uniprot-entries-to-parquet

### Tool Description
Summarize UniProt entries to Parquet

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-summarize-uniprot-entries-to-parquet [args]

org.dishevelled.commandline.CommandLineParseException: required argument -o, --output-summary-parquet-file not found
	at org.dishevelled.commandline.CommandLineParser.parse(CommandLineParser.java:91)
	at org.dishevelled.bio.tools.SummarizeUniprotEntriesToParquet.main(SummarizeUniprotEntriesToParquet.java:196)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-uniprot-xml-path [interface java.nio.file.Path]  input UniProt XML path, default stdin [optional]
   -o, --output-summary-parquet-file [class java.io.File]  output summary Parquet file [required]
   -g, --row-group-size [class java.lang.Integer]  row group size, default 122880 [optional]
```


## dsh-bio_text-to-fasta

### Tool Description
Converts text input to FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-text-to-fasta [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-text-path [interface java.nio.file.Path]  input text path, default stdin [optional]
   -o, --output-fasta-file [class java.io.File]  output FASTA file, default stdout [optional]
   -e, --alphabet [class java.lang.String]  output FASTA alphabet { dna, protein }, default dna [optional]
   -w, --line-width [class java.lang.Integer]  output line width, default 70 [optional]
```


## dsh-bio_text-to-fastq

### Tool Description
Converts a text file to a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-text-to-fastq [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-text-path [interface java.nio.file.Path]  input text path, default stdin [optional]
   -o, --output-fastq-file [class java.io.File]  output FASTQ file, default stdout [optional]
```


## dsh-bio_traversals-to-cytoscape-edges

### Tool Description
Converts traversals from a GFA file to Cytoscape edge list format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-traversals-to-cytoscape-edges -i input.gfa.gz -o edges.txt.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-edges-file [class java.io.File]  output Cytoscape edges.txt format file, default stdout [optional]
```


## dsh-bio_traversals-to-property-graph

### Tool Description
Converts GFA traversals to a property graph format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-traversals-to-property-graph -i input.gfa.gz -o traversal-edges.csv.gz

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-edges-file [class java.io.File]  output property graph CSV format file, default stdout [optional]
```


## dsh-bio_traverse-paths

### Tool Description
Traverse paths in a GFA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-traverse-paths [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-gfa1-file [class java.io.File]  output GFA 1.0 file, default stdout [optional]
```


## dsh-bio_truncate-fasta

### Tool Description
Truncates FASTA sequences to a specified length.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
org.biojava.bio.BioException: Could not read sequence
	at org.biojava.bio.seq.io.StreamReader.nextSequence(StreamReader.java:108)
	at org.dishevelled.bio.tools.TruncateFasta.call(TruncateFasta.java:159)
	at org.dishevelled.bio.tools.TruncateFasta.main(TruncateFasta.java:236)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.dishevelled.bio.tools.Tools.call(Tools.java:79)
	at org.dishevelled.bio.tools.Tools.main(Tools.java:327)
Caused by: java.io.IOException: Premature stream end
	at org.biojava.bio.seq.io.FastaFormat.readSequence(FastaFormat.java:125)
	at org.biojava.bio.seq.io.StreamReader.nextSequence(StreamReader.java:105)
	... 6 more
```


## dsh-bio_truncate-paths

### Tool Description
Truncates paths in a GFA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-truncate-paths [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-gfa1-path [interface java.nio.file.Path]  input GFA 1.0 path, default stdin [optional]
   -o, --output-gfa1-file [class java.io.File]  output GFA 1.0 file, default stdout [optional]
```


## dsh-bio_variant-table-to-vcf

### Tool Description
Converts an Ensembl variant table to VCF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-variant-table-to-vcf [args]

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-variant-table-path [interface java.nio.file.Path]  input Ensembl variant table path, default stdin [optional]
   -o, --output-vcf-file [class java.io.File]  output VCF file, default stdout [optional]
```


## dsh-bio_vcf-pedigree

### Tool Description
Generates a pedigree file from a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-vcf-pedigree -i input.vcf.gz -o pedigree.txt

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-vcf-path [interface java.nio.file.Path]  input VCF path, default stdin [optional]
   -o, --output-pedigree-file [class java.io.File]  output pedigree file, default stdout [optional]
```


## dsh-bio_vcf-samples

### Tool Description
Extracts sample names from a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
- **Homepage**: https://github.com/heuermh/dishevelled-bio
- **Package**: https://anaconda.org/channels/bioconda/packages/dsh-bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
dsh-vcf-samples -i input.vcf.gz -o samples.txt

arguments:
   -a, --about  display about message [optional]
   -h, --help  display help message [optional]
   -i, --input-vcf-path [interface java.nio.file.Path]  input VCF path, default stdin [optional]
   -o, --output-sample-file [class java.io.File]  output sample file, default stdout [optional]
```


## Metadata
- **Skill**: generated

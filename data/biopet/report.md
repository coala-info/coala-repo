# biopet CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| biopet_tool_AnnotateVcfWithBed | Failed | tool bug: the new INFO field holds the Scala Option text (region=Some(regionX)) instead of the BED region name |
| biopet_tool_BamStats | PASS |  |
| biopet_tool_BaseCounter | PASS |  |
| biopet_tool_BastyGenerateFasta | PASS |  |
| biopet_tool_BedtoolsCoverageToCounts | PASS |  |
| biopet_tool_BiopetFlagstat | PASS |  |
| biopet_tool_CheckAllelesVcfInBam | PASS |  |
| biopet_tool_DownloadNcbiAssembly | PASS |  |
| biopet_tool_ExtractAlignedFastq | PASS |  |
| biopet_tool_FastqFilter | PASS |  |
| biopet_tool_FastqSplitter | PASS |  |
| biopet_tool_FastqSync | PASS |  |
| biopet_tool_FindOverlapMatch | PASS |  |
| biopet_tool_FindRepeatsPacBio | PASS |  |
| biopet_tool_GvcfToBed | PASS |  |
| biopet_tool_MergeAlleles | PASS |  |
| biopet_tool_MergeTables | PASS |  |
| biopet_tool_MpileupToVcf | PASS |  |
| biopet_tool_PipelineStatus | Not completed | Needs the output folder of a finished Biopet Queue pipeline run with its job dependency file; no such run is available. |
| biopet_tool_PrefixFastq | PASS |  |
| biopet_tool_SageCountFastq | PASS |  |
| biopet_tool_SamplesTsvToConfig | PASS |  |
| biopet_tool_SeqStat | PASS |  |
| biopet_tool_SquishBed | PASS |  |
| biopet_tool_SummaryToTsv | PASS |  |
| biopet_tool_ValidateFastq | PASS |  |
| biopet_tool_ValidateVcf | PASS |  |
| biopet_tool_VcfFilter | PASS |  |
| biopet_tool_VcfStats | PASS |  |
| biopet_tool_VcfToTsv | PASS |  |
| biopet_tool_VcfWithVcf | PASS |  |
| biopet_tool_VepNormalizer | PASS |  |

## biopet_tool_AnnotateVcfWithBed

### Tool Description
Annotate a VCF file with the names of overlapping BED regions as a new INFO field.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: AnnotateVcfWithBed [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputFile <vcf file>
                           Input VCF file. Mandatory field
  -B, --bedFile <bed file>
                           Input Bed file. Mandatory field
  -o, --output <vcf file>  Output VCF file. Mandatory field
  -f, --fieldName <name of field in vcf file>
                           Name of info field in new vcf file
  -d, --fieldDescription <description of field in vcf file>
                           Description of field in new vcf file
  -t, --fieldType <type of field in vcf file>
                           Type of field in new vcf file. Can be 'Integer', 'Flag', 'Character', 'Float'
```

## biopet_tool_BamStats

### Tool Description
Generate statistics (flagstat, insert size, mapping quality, clipping) from a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: BamStats [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -R, --reference <file>   Fasta file of reference
  -o, --outputDir <directory>
                           Output directory
  -b, --bam <file>         Input bam file
  --binSize <int>          Bin size of stats (beta)
  --threadBinSize <int>    Size of region per thread
  --tsvOutputs             Also output tsv files, default there is only a json
```

## biopet_tool_BaseCounter

### Tool Description
Count bases per gene, transcript and exon from a BAM file and a refFlat annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: BaseCounter [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -r, --refFlat <file>     refFlat file. Mandatory
  -o, --outputDir <directory>
                           Output directory. Mandatory
  -b, --bam <file>         Bam file. Mandatory
  -p, --prefix <prefix>    
```

## biopet_tool_BastyGenerateFasta

### Tool Description
Generate variant and consensus FASTA sequences from a VCF and/or BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: BastyGenerateFasta [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -V, --inputVcf <file>    vcf file, needed for outputVariants and outputConsensusVariants
  --bamFile <file>         bam file, needed for outputConsensus and outputConsensusVariants
  --outputVariants <file>  fasta with only variants from vcf file
  --outputConsensus <file>
                           Consensus fasta from bam, always reference bases else 'N'
  --outputConsensusVariants <file>
                           Consensus fasta from bam with variants from vcf file, always reference bases else 'N'
  --snpsOnly               Only use snps from vcf file
  --sampleName <value>     Sample name in vcf file
  --outputName <value>     Output name in fasta file header
  --minAD <value>          min AD value in vcf file for sample. Defaults to: 8
  --minDepth <value>       min depth in bam file. Defaults to: 8
  --reference <value>      Indexed reference fasta file
```

## biopet_tool_BedtoolsCoverageToCounts

### Tool Description
Sum bedtools coverage counts per feature name.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: BedtoolsCoverageToCounts [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --input <file>       Coverage file produced with bedtools
  -o, --output <file>      Output file name
```

## biopet_tool_BiopetFlagstat

### Tool Description
Compute flag statistics for a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: BiopetFlagstat [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputFile <file>   input bam file
  -o, --outputFile <file>  output file
  -s, --summaryFile <file>
                           summary output file
  -r, --region <chr:start-stop>
                           
```

## biopet_tool_CheckAllelesVcfInBam

### Tool Description
Check which alleles of VCF records are present in reads of BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: CheckAllelesVcfInBam [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputFile <file>   VCF file
  -o, --outputFile <file>  output VCF file name
  -s, --sample <value>     sample name
  -b, --bam <value>        bam file, from which the variants (VCF files) were called
  -m, --min_mapping_quality <value>
                           minimum mapping quality score for a read to be taken into account
```

## biopet_tool_DownloadNcbiAssembly

### Tool Description
Download the contigs of an NCBI assembly report into one FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: DownloadNcbiAssembly [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -a, --assembly_report <file>
                           refseq ID from NCBI
  -o, --output <file>      output Fasta file
  --report <file>          where to write report from ncbi
  --nameHeader <string>    
 What column to use from the NCBI report for the name of the contigs.
 All columns in the report can be used but this are the most common field to choose from:
 - 'Sequence-Name': Name of the contig within the assembly
 - 'UCSC-style-name': Name of the contig used by UCSC ( like hg19 )
 - 'RefSeq-Accn': Unique name of the contig at RefSeq (default for NCBI)
  --mustHaveOne:<key>=<column_name=regex>
                           This can be used to filter based on the NCBI report, multiple conditions can be given, at least 1 should be true
  --mustNotHave:<key>=<column_name=regex>
                           This can be used to filter based on the NCBI report, multiple conditions can be given, all should be false
```

## biopet_tool_ExtractAlignedFastq

### Tool Description
Select FASTQ records whose reads map to the given alignment intervals.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text

ExtractAlignedFastq - Select aligned FASTQ records
      
Usage: ExtractAlignedFastq [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --input_file <bam>   Input BAM file
  -r, --interval <interval>
                           Interval strings (e.g. chr1:1-100)
  -i, --in1 <fastq>        Input FASTQ file 1
  -j, --in2 <fastq>        Input FASTQ file 2 (default: none)
  -o, --out1 <fastq>       Output FASTQ file 1
  -p, --out2 <fastq>       Output FASTQ file 2 (default: none)
  -Q, --min_mapq <value>   Minimum MAPQ of reads in target region to remove (default: 0)
  -s, --read_suffix_length <value>
                           Length of suffix mark from each read pair (default: 0). This is used for distinguishing read pairs with
         different suffices. For example, if your FASTQ records end with `/1` for the first pair and `/2` for the
         second pair, the value of `read_suffix_length` should be 2."
      

This tool creates FASTQ file(s) containing reads mapped to the given alignment intervals.
      
```

## biopet_tool_FastqFilter

### Tool Description
Filter FASTQ records by read ID regex.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: FastqFilter [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputFile <file>   Path to input file
  -o, --output <file>      Path to output file
  --idRegex <file>         Regex to match ID
```

## biopet_tool_FastqSplitter

### Tool Description
Split a FASTQ file into several output files.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: FastqSplitter [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputFile <file>   Path to input file
  -o, --output <file>      Path to output file
```

## biopet_tool_FastqSync

### Tool Description
Sync paired-end FASTQ files to a reference FASTQ.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text

FastqSync - Sync paired-end FASTQ files.

This tool works with gzipped or non-gzipped FASTQ files. The output
file will be gzipped when the input is also gzipped.
      
Usage: FastqSync [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -r, --ref <fastq>        Reference FASTQ file
  -i, --in1 <fastq>        Input FASTQ file 1
  -j, --in2 <fastq[.gz]>   Input FASTQ file 2
  -o, --out1 <fastq[.gz]>  Output FASTQ file 1
  -p, --out2 <fastq>       Output FASTQ file 2
```

## biopet_tool_FindOverlapMatch

### Tool Description
Report sample pairs in an overlap table whose value passes a cutoff.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: FindOverlapMatch [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --input <file>       Input should be a table where the first row and column have the ID's, those can be different
  -o, --output <file>      default to stdout
  -c, --cutoff <value>     minimum value to report it as pair
  --use_same_names         Do not compare samples with the same name
  --rowSampleRegex <regex>
                           Samples in the row should match this regex
  --columnSampleRegex <regex>
                           Samples in the column should match this regex
```

## biopet_tool_FindRepeatsPacBio

### Tool Description
Find repeat regions of a BED file in PacBio reads of a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: FindRepeatsPacBio [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputBam <file>    Path to input file
  -o, --outputFile <file>  Path to input file
  -b, --inputBed <file>    Path to bed file
```

## biopet_tool_GvcfToBed

### Tool Description
Write the regions of a gVCF that pass a genome quality cutoff as BED.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: GvcfToBed [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputVcf <file>    Input vcf file
  -O, --outputBed <file>   Output bed file
  --invertedOutputBed <file>
                           Output bed file
  -S, --sample <sample>    Sample to consider. Will take first sample on alphabetical order by default
  --minGenomeQuality <int>
                           Minimum genome quality to consider
```

## biopet_tool_MergeAlleles

### Tool Description
Merge the alleles of several VCF files into one VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: MergeAlleles [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputVcf <file>    
  -o, --outputVcf <file>   
  -R, --reference <file>   
```

## biopet_tool_MergeTables

### Tool Description
Merge tab-delimited files on feature ID equality into one table.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text

MergeTables - Tabular file merging based on feature ID equality.
      
Usage: MergeTables [options] [<input_tables> ...]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --id_column_index <idx1>,<idx2>, ...
                           Index of feature ID column from each input file (1-based)
  -a, --value_column_index <idx>
                           Index of column from each input file containing the value to merge (1-based)
  -o, --output <path>      Path to output file (default: '-' <stdout>)
  -n, --id_column_name <name>
                           Name of feature ID column in the output merged file (default: feature)
  -N, --column_names <name>
                           Name of feature ID column in the output merged file (default: feature)
  -e, --strip_extension <ext>
                           Common extension of all input tables to strip (default: empty string)
  -m, --num_header_lines <value>
                           The number of header lines present in all input files (default: 0; no header)
  -f, --fallback <value>   The string to use when a value for a feature is missing in one or more sample(s) (default: '-')
  -d, --delimiter <value>  The character used for separating columns in the input files (default: '\t')
  <input_tables> ...       Input tables to merge

This tool merges multiple tab-delimited files and outputs a single
tab delimited file whose columns are the feature IDs and a single
column from each input files.

Note that in each input file there must not be any duplicate features.
If there are, the tool will only keep one and discard the rest.
      
```

## biopet_tool_MpileupToVcf

### Tool Description
Call variants from samtools mpileup output and write VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: MpileupToVcf [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --input <file>       input, default is stdin
  -o, --output <file>      out is a required file property
  -s, --sample <value>     
  --minDP <value>          
  --minAP <value>          
  --homoFraction <value>   
  --ploidy <value>         
  --seqError <value>       
  --refCalls               
```

## biopet_tool_PipelineStatus

### Tool Description
Report the job status of a Biopet (Queue) pipeline run from its output directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: PipelineStatus [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -d, --pipelineDir <file>
                           Output directory of the pipeline
  -o, --outputDir <file>   Output directory of this tool
  --depsFile <file>        Location of deps file, not required
  -f, --follow             This will follow a run
  --refresh <value>        Time to check again, default set on 30 seconds
  --completePlots          Add complete plots, this is disabled because of performance. Complete plots does show each job separated, while compressed plots collapse all jobs of the same type together.
  --skipCompressPlots      Disable compressed plots. By default compressed plots are enabled.
```

## biopet_tool_PrefixFastq

### Tool Description
Add a prefix sequence to every read of a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: PrefixFastq [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --input <file>       
  -o, --output <file>      
  -s, --seq <prefix seq>   
```

## biopet_tool_SageCountFastq

### Tool Description
Count the occurrence of each read sequence in a SAGE FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: SageCountFastq [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --input <file>       
  -o, --output <file>      
```

## biopet_tool_SamplesTsvToConfig

### Tool Description
Convert sample/library TSV files to a Biopet sample config (yaml or json).

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: SamplesTsvToConfig [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputFiles <file>  Input must be a tsv file, first line is seen as header and must at least have a 'sample' column, 'library' column is optional, multiple files allowed
  -t, --tagFiles <file>    
  -o, --outputFile <file>  
When the extension is .yml or .yaml the output is in yaml format, otherwise it is in json.
When no extension is given the output goes to stdout as yaml.
           
```

## biopet_tool_SeqStat

### Tool Description
Summarize a FASTQ file (base and quality statistics) as JSON.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text

SeqStat - Summarize FastQ
      
Usage: SeqStat [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --fastq <fastq>      FastQ file to generate stats from
  -o, --output <json>      File to write output to, if not supplied output go to stdout
```

## biopet_tool_SquishBed

### Tool Description
Remove overlapping parts of BED records so no region is covered twice.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: SquishBed [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --input <file>       
  -o, --output <file>      
  -s, --strandSensitive    
```

## biopet_tool_SummaryToTsv

### Tool Description
Extract values from a Biopet summary JSON into a TSV table.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: SummaryToTsv [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -s, --summary <file>     
  -o, --outputFile <file>  
  -p, --path <string>      
String that determines the values extracted from the summary. Should be of the format:
<header_name>=<namespace>:<lower_namespace>:<even_lower_namespace>...
      
  -m, --mode <root|sample|lib>
                           
Determines on what level to aggregate data.
root: at the root level
sample: at the sample level
lib: at the library level
      
```

## biopet_tool_ValidateFastq

### Tool Description
Validate one FASTQ file or a pair of FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ValidateFastq [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --fastq1 <file>      
  -j, --fastq2 <file>      
```

## biopet_tool_ValidateVcf

### Tool Description
Check a VCF file against a reference FASTA.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ValidateVcf [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputVcf <file>    Vcf file to check
  -R, --reference <file>   Reference fasta to check vcf file against
  --disableFail            Do not fail on error. The tool will still exit when encountering an error, but will do so with exit code 0
```

## biopet_tool_VcfFilter

### Tool Description
Filter VCF records on depth, quality, genotype and family (trio) rules.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: VcfFilter [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputVcf <file>    Input vcf file
  -o, --outputVcf <file>   Output vcf file
  --invertedOutputVcf <file>
                           inverted output vcf file
  --minSampleDepth <int>   Min value for DP in genotype fields
  --minTotalDepth <int>    Min value of DP field in INFO fields
  --minAlternateDepth <int>
                           Min value of AD field in genotype fields
  --minSamplesPass <int>   Min number off samples to pass --minAlternateDepth, --minBamAlternateDepth and --minSampleDepth
  --resToDom <child:father:mother>
                           Only shows variants where child is homozygous and both parants hetrozygous
  --trioCompound <child:father:mother>
                           Only shows variants where child is a compound variant combined from both parants
  --deNovoInSample <sample>
                           Only show variants that contain unique alleles in complete set for given sample
  --deNovoTrio <child:father:mother>
                           Only show variants that are denovo in the trio
  --trioLossOfHet <child:father:mother>
                           Only show variants where a loss of hetrozygosity is detected
  --mustHaveVariant <sample>
                           Given sample must have 1 alternative allele
  --calledIn <sample>      Must be called in this sample
  --mustHaveGenotype <sample:genotype>
                           Must have genotoype <genotype> for this sample. Genotype can be NO_CALL, HOM_REF, HET, HOM_VAR, UNAVAILABLE, MIXED
  --diffGenotype <sample:sample>
                           Given samples must have a different genotype
  --filterHetVarToHomVar <sample:sample>
                           If variants in sample 1 are heterogeneous and alternative alleles are homogeneous in sample 2 variants are filtered
  --filterRefCalls         Filter when there are only ref calls
  --filterNoCalls          Filter when there are only no calls
  --uniqueOnly             Filter when there more then 1 sample have this variant
  --sharedOnly             Filter when not all samples have this variant
  --minQualScore <value>   Min qual score
  --id <value>             Id that may pass the filter
  --idFile <value>         File that contain list of IDs to get from vcf file
  --minGenomeQuality <value>
                           
```

## biopet_tool_VcfStats

### Tool Description
Generate statistics (general, info and genotype tags, sample-to-sample) from a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: VcfStats [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputFile <file>   Input VCF file (required)
  -R, --referenceFile <file>
                           Fasta reference which was used to call input VCF (required)
  -o, --outputDir <file>   Path to directory for output (required)
  -i, --intervals <file>   Path to interval (BED) file (optional)
  --infoTag <tag>          Summarize these info tags. Default is (QUAL, general, AC, AF, AN, DP)
  --genotypeTag <tag>      Summarize these genotype tags. Default is (DP, GQ, AD, AD-ref, AD-alt, AD-used, AD-not_used, general)
  --allInfoTags            Summarize all info tags. Default false
  --allGenotypeTags        Summarize all genotype tags. Default false
  --binSize <value>        Binsize in estimated base pairs
  --writeBinStats          Write bin statistics. Default False
  --generalWiggle <value>  Create a wiggle track with bin size <binSize> for any of the following statistics:
Total, Biallelic, ComplexIndel, Filtered, FullyDecoded, Indel, Mixed, MNP, MonomorphicInSamples, NotFiltered, PointEvent, PolymorphicInSamples, SimpleDeletion, SimpleInsertion, SNP, StructuralIndel, Symbolic, SymbolicOrSV, Variant
  --genotypeWiggle <value>
                           Create a wiggle track with bin size <binSize> for any of the following genotype fields:
Total, Het, HetNonRef, Hom, HomRef, HomVar, Mixed, NoCall, NonInformative, Available, Called, Filtered, Variant
```

## biopet_tool_VcfToTsv

### Tool Description
Convert a VCF file to a tab-delimited table.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: VcfToTsv [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputFile <file>   Input vcf file
  -o, --outputFile <file>  output file, default to stdout
  -f, --field Genotype field name
                           Genotype field to use
  -i, --info_field Info field name
                           Info field to use
  --all_info               Use all info fields in the vcf header
  --all_format             Use all genotype fields in the vcf header
  -s, --sample_field <value>
                           Genotype fields to use in the tsv file
  -d, --disable_defaults   Don't output the default columns from the vcf file
  --separator <value>      Optional separator. Default is tab-delimited
  --list_separator <value>
                           Optional list separator. By default, lists are separated by a comma
  --max_decimals <value>   Number of decimal places for numbers. Default is 2
```

## biopet_tool_VcfWithVcf

### Tool Description
Annotate a VCF file with INFO fields from a second (indexed) VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: VcfWithVcf [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputFile <file>   
  -o, --outputFile <file>  
  -s, --secondaryVcf <file>
                           
  -R, --reference <file>   
  -f, --field <field> or <input_field:output_field> or <input_field:output_field:method>
                            If only <field> is given, the field's identifier in the output VCF will be identical to <field>.
 By default we will return all values found for a given field.
 For INFO fields with type R or A we will take the respective alleles present in the input file.
 If a <method> is supplied, a method will be applied over the contents of the field.
 In this case, all values will be considered.
 The following methods are available:
   - max   : takes maximum of found value, only works for numeric (integer/float) fields
   - min   : takes minimum of found value, only works for numeric (integer/float) fields
   - unique: takes only unique values 
  --match <Boolean>        Match alternative alleles; default true
```

## biopet_tool_VepNormalizer

### Tool Description
Parse a VEP-annotated VCF to standard VCF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet/overview
- **Validation**: PASS

### Original Help Text
```text
|VepNormalizer - Parse VEP-annotated VCF to standard VCF format 
Usage: VepNormalizer [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --InputFile <vcf>    Input VCF file. Required.
  -O, --OutputFile <vcf>   Output VCF file. Required.
  -m, --mode <mode>        Mode. Can choose between <standard> (generates standard vcf) and <explode> (generates new record for each transcript). Required.
  --do-not-remove          Do not remove CSQ tag. Optional
```

## Metadata
- **Skill**: generated

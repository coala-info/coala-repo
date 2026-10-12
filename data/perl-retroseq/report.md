# perl-retroseq CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| perl-retroseq_call | Not completed | runs but finds zero call regions on the small test BAM; needs a genome-wide BAM with several supporting reads per TE insertion |
| perl-retroseq_discover | PASS | synthetic data: the TE reference is the SARS-CoV-2 genome, so the 3 reads with unmapped mates are reported |

## perl-retroseq_discover

### Tool Description
Discovery stage of RetroSeq: calls candidate supporting read pairs from a BAM and reference TEs

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-retroseq:1.5--pl5321h7181c03_3
- **Homepage**: https://github.com/tk2/RetroSeq
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-retroseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/retroseq.pl -discover -bam <string> -eref <string> -output <string> [-q <int>] [-id <int>] [-len <int> -noclean]
    
    -bam        BAM file of paired reads mapped to reference genome
    -output     Output file to store candidate supporting reads (required for calling step)
    [-refTEs    Tab file with TE type and BED file of reference elements. These will be used to quickly assign discordant reads the TE types and avoid alignment. Using this will speed up discovery dramatically.]
    [-noclean   Do not remove intermediate output files. Default is to cleanup.]
    [-q         Minimum mapping quality for a read mate that anchors the insertion call. Default is 20. Parameter is optional.]
    [-id        Minimum percent ID for a match of a read to the transposon references. Default is 80.]
    [-rgs       Comma separated list of readgroups to operate on. Default is all.]
    [-exd       Fofn of BED files of regions where discordant mates falling into will be excluded e.g. simple repeats, centromeres, telomeres]
    [-align     Do the computational expensive exonerate PE discordant mate alignment step]
    [-eref      Tab file with list of transposon types and the corresponding fasta file of reference sequences (e.g. SINE   /home/me/refs/SINE.fasta). Required when the -align option is used.]
    [-len       Minimum length of a hit to the transposon references when using the -align option. Default is 36.]
    [-overlap   Fraction of read alignment that must overlap with ref TE elements to be considered. Default is 0.8.]
    

RetroSeq: A tool for discovery of transposable elements from short read alignments

Version: 1.5
Author: Thomas Keane (thomas.keane@sanger.ac.uk)
```

## perl-retroseq_call

### Tool Description
Calling stage of RetroSeq: outputs a VCF of TE calls from discovery output and a BAM

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-retroseq:1.5--pl5321h7181c03_3
- **Homepage**: https://github.com/tk2/RetroSeq
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-retroseq/overview
- **Validation**: PASS

### Original Help Text
```text

RetroSeq: A tool for discovery of transposable elements from short read alignments

Version: 1.5
Author: Thomas Keane (thomas.keane@sanger.ac.uk)

Usage: /usr/local/bin/retroseq.pl -call -bam <string> -input <string> -ref <string> -output <string> [ -filter <BED file> -cleanup -reads <int> -depth <int>]
    
    -bam            BAM file OR BAM fofn
    -input          Either a single output file from the PE discover stage OR a prefix of a set of files from discovery to be combined for calling OR a fofn of discovery stage output files
    -ref            Fasta of reference genome
    -output         Output file name (VCF)
    [-filter        Tab file with TE type and BED file of reference elements. These will be filtered out from the calling.]
    [-region        Call a particular chromosome only (chr) OR region (chr:start-end) only]
    [-depth         Max average depth of a region to be considered for calling. Default is 200.]
    [-reads         It is the minimum number of reads required to make a call. Default is 5.]
    [-q             Minimum mapping quality for a read mate that anchors the insertion call. Default is 30.]
    [-ignoreRGs     Single read group name OR a file of readgroups that should be ignored. Default is none.]
    [-soft          Include soft clipped reads when calling. HIGHLY RECOMMENDED for BWA-MEM alignments.]
    [-noclean       Do not remove intermediate output files. Default is to cleanup.]
```

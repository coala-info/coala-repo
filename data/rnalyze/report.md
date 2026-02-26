# rnalyze CWL Generation Report

## rnalyze

### Tool Description
RNA-Seq Analysis Pipeline: A comprehensive tool for RNA-Seq data processing, alignment, and analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnalyze:1.0.1--hdfd78af_1
- **Homepage**: https://github.com/MohamedElsisii/rnalyze
- **Package**: https://anaconda.org/channels/bioconda/packages/rnalyze/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnalyze/overview
- **Total Downloads**: 816
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MohamedElsisii/rnalyze
- **Stars**: N/A
### Original Help Text
```text
[2026-02-25 17:15:16] [INFO] 🔍 Validating required arguments...
[2026-02-25 17:15:16] [ERROR] Missing required arguments. Please specify: --pipeline, --tool, --data, --type, and --ref.

Usage: rnalyze [OPTIONS]

RNA-Seq Analysis Pipeline: A comprehensive tool for RNA-Seq data processing, alignment, and analysis.

Version: 1.0.1 [3/2025]

Command-Line Parameters:

┌───────────────────┬──────────────────────────────────────────────────────────────────────────────┐
│ Option            │ Description                                                                  │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -p, --pipeline    │ Specify the pipeline type:                                                   │
│                   │   - Full: Perform full analysis (trimming, alignment, counting).             │
│                   │   - Alignment: Perform only alignment (no  counting).                        │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -t, --tool        │ Specify the alignment tool:                                                  │
│                   │   - BWA: Burrows-Wheeler Aligner.                                            │
│                   │   - Bowtie2: Bowtie2 aligner.                                                │
│                   │   - HISAT2: Hierarchical Indexing for Spliced Transcripts.                   │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -d, --data        │ Specify how to handle input data:                                            │
│                   │   - Download: Download data using SRR accession numbers.                     │
│                   │   - Directory: Use data from a local directory.                              │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -s, --srr-path    │ Path to SRR_Acc_List.txt (required if --data Download).                      │
│                   │ This file should contain a list of SRR accession numbers.                    │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -D, --data-dir    │ Directory containing input data (required if --data Directory).              │
│                   │ The directory should contain .fastq.gz files.                                │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -y, --type        │ Specify the RNA-Seq data type:                                               │
│                   │   - SE: Single-End data.                                                     │
│                   │   - PE: Paired-End data.                                                     │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -r, --ref         │ Specify how to handle the reference genome:                                  │
│                   │   - UnindexedURL: Download and index an unindexed reference genome from URL. │
│                   │   - IndexedURL: Download a pre-indexed reference genome from URL.            │
│                   │   - IndexedPath: Use a pre-indexed reference genome from a local path.       │
│                   │   - UnindexedPath: Use an unindexed reference genome from a local path.      │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -u, --ref-url     │ URL for downloading the reference genome (required if --ref UnindexedURL or  │
│                   │ IndexedURL).                                                                 │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -R, --ref-path    │ Path to the reference genome files (required if --ref IndexedPath or         │
│                   │ UnindexedPath).                                                              │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -T, --trim        │ Enable or disable trimming:                                                  │
│                   │   - yes: Enable trimming.                                                    │
│                   │   - no: Disable trimming.                                                    │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -x, --trim-tool   │ Specify the trimming tool (required if --trim yes):                          │
│                   │   - Trimmomatic: Use Trimmomatic for trimming.                               │
│                   │   - Cutadapt: Use Cutadapt for trimming.                                     │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -l, --leading     │ Remove bases with quality below this threshold from the start of the read.   │
│                   │ Default: 3.                                                                  │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -L, --trailing    │ Remove bases with quality below this threshold from the end of the read.     │
│                   │ Default: 3.                                                                  │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -w, --sliding-win │ Perform sliding window trimming with window size and average quality.        │
│                   │ Format: WINDOW_SIZE:QUALITY_THRESHOLD (e.g., 4:25).                          │
│                   │ Default: 4:25.                                                               │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -m, --minlen      │ Discard reads shorter than this length after trimming.                       │
│                   │ Default: 36.                                                                 │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -a, --adapter-se  │ Adapter sequence for Single-End data (required if --type SE & --trim-tool    │
│                   │                                           trimmomatic):                      │                
│                   │   - TruSeq2-SE: TruSeq2 Single-End adapter.                                  │
│                   │   - TruSeq3-SE: TruSeq3 Single-End adapter.                                  │
│                   │                                                                              │
│                   │ 3' adapter sequence for Single-End data (required if --type SE & --trim-tool │
│                   │                                           cutadapt):                         │
│                   │   - Example: AGATCGGAAGAGC.                                                  │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -A, --adapter-pe  │ Adapter sequence for Paired-End data (required if --type PE & --trim-tool    │
│                   │                                           trimmomatic):                      │                                            
│                   │   - NexteraPE-PE: Nextera Paired-End adapter.                                │
│                   │   - TruSeq2-PE: TruSeq2 Paired-End adapter.                                  │
│                   │   - TruSeq3-PE: TruSeq3 Paired-End adapter.                                  │
│                   │   - TruSeq3-PE-2: TruSeq3 Paired-End adapter.                                │
│                   │                                                                              │
│                   │ 3' adapter sequence for Paired-End data (required if --type PE & --trim-tool │
│                   │                                           cutadapt):                         │
│                   │   - Example: AGATCGGAAGAGC.                                                  │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -g, --front-se    │ 5' adapter sequence for Single-End data (optional if --type SE & --trim-tool │
│                   │                                           cutadapt):                         │
│                   │   - Example: AGATCGGAAGAGC.                                                  │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -G, --front-pe    │ 5' adapter sequence for Paired-End data (optional if --type PE & --trim-tool │
│                   │                                           cutadapt):                         │
│                   │   - Example: AGATCGGAAGAGC.                                                  │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -q, --quality-cut │ Trim bases with quality below this threshold.                                │
│                   │ Default: 20.                                                                 │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -M, --min-read-len│ Discard reads shorter than this length after trimming.                       │
│                   │ Default: 30.                                                                 │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -f, --gtf         │ Specify how to handle the GTF file:                                          │
│                   │   - Download: Download the GTF file from a URL.                              │
│                   │   - Path: Use a GTF file from a local path.                                  │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -F, --gtf-url     │ URL for downloading the GTF file (required if --gtf Download).               │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -P, --gtf-path    │ Path to the GTF file (required if --gtf Path).                               │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -i, --identifier  │ Gene identifier attribute in the GTF file (default: gene_id).                │
│                   │ This is used for feature counting.                                           │
├───────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ -h, --help        │ Display this help message and exit.                                          │
└───────────────────┴──────────────────────────────────────────────────────────────────────────────┘

Examples:
 
1. Full Pipeline with Trimmomatic (Single-End Data)
   
   - Objective: Analyze single-end RNA-Seq data using the full pipeline (trimming, alignment, and counting).
  
   - Command:
     
     rnalyze -p Full -t HISAT2 -d Download -s /path/to/SRR_Acc_List.txt -y SE -r UnindexedURL -u http://example.com/ref.fna -T yes -x Trimmomatic -a TruSeq3-SE -l 5 -f Download -F http://example.com/annotation.gtf -i gene_id
   
   - Explanation:
     - Download single-end RNA-Seq data using SRR accession numbers.
     - Use HISAT2 for alignment.
     - Trim reads using Trimmomatic with the TruSeq3-SE adapter.
     - Download and index the reference genome from a URL.
     - Download the GTF file for annotation.
     - Perform feature counting using the gene_id attribute.


2. Alignment Pipeline with Cutadapt (Paired-End Data)
  
   - Objective: Analyze paired-end RNA-Seq data using the alignment pipeline (trimming and alignment only).
  
   - Command:
    
     rnalyze -p Alignment -t BWA -d Directory -D /path/to/data -y PE -r IndexedPath -R /path/to/indexed_genome -T yes -x Cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -q 20 -M 30
   
   - Explanation:
     - Use paired-end RNA-Seq data from a local directory.
     - Use BWA for alignment.
     - Trim reads using Cutadapt with 3' adapters for both reads.
     - Use a pre-indexed reference genome from a local path.
     - Set a quality cutoff of 20 and a minimum read length of 30 after trimming.


3. Full Pipeline with Cutadapt (Paired-End Data)
   
   - Objective: Analyze paired-end RNA-Seq data using the full pipeline (trimming, alignment, and counting).
   
   - Command:
    
     rnalyze -p Full -t HISAT2 -d Directory -D /path/to/data -y PE -r UnindexedPath -R /path/to/ref_genome.fna -T yes -x Cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -g AGATCGGAAGAGC -G AGATCGGAAGAGC -q 20 -M 30 -f Path -P /path/to/annotation.gtf -i gene_id
  
   - Explanation:
     - Use paired-end RNA-Seq data from a local directory.
     - Use HISAT2 for alignment.
     - Trim reads using Cutadapt with both 3' and 5' adapters for both reads.
     - Use an unindexed reference genome from a local path and index it.
     - Use a GTF file from a local path for annotation.
     - Perform feature counting using the gene_id attribute.


4. Alignment Pipeline with Trimmomatic (Single-End Data)
   
   - Objective: Analyze single-end RNA-Seq data using the alignment pipeline (trimming and alignment only).
   
   - Command:
     
     rnalyze -p Alignment -t Bowtie2 -d Download -s /path/to/SRR_Acc_List.txt -y SE -r IndexedURL -u http://example.com/indexed_genome.tar.gz -T yes -x Trimmomatic -a TruSeq3-SE -l 5
   
   - Explanation:
     - Download single-end RNA-Seq data using SRR accession numbers.
     - Use Bowtie2 for alignment.
     - Trim reads using Trimmomatic with the TruSeq3-SE adapter.
     - Use a pre-indexed reference genome downloaded from a URL.
```


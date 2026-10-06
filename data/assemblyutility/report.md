# assemblyutility CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| assemblyutility_AssemblyStatistics | PASS |  |
| assemblyutility_SelectLongestReads | PASS |  |

## Metadata
- **Skill**: generated

## assemblyutility_AssemblyStatistics

### Tool Description
A tool to calculate assembly statistics for a given contigs file with a specified length cutoff.

### Metadata
- **Docker Image**: quay.io/biocontainers/assemblyutility:20160209--h077b44d_9
- **Homepage**: https://github.com/yechengxi/AssemblyUtility
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Command:  ProgramFile contigs contigs_filename LenTh cut_off_length
Loading...
```

## assemblyutility_SelectLongestReads

### Tool Description
A tool to select the longest reads from FASTA/FASTQ files until a specified total length is reached.

### Metadata
- **Docker Image**: quay.io/biocontainers/assemblyutility:20160209--h077b44d_9
- **Homepage**: https://github.com/yechengxi/AssemblyUtility
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Command:  ProgramFile sum total_length longest 0 o outfile f fa/fq_file f fa/fq_file 
Total bases: 0
```


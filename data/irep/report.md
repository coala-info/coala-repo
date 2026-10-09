# irep CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| irep_bPTR | Not completed | runs and gives plausible PTR 1.906, but differs from the repo sample output (ORI/TER and PTR 1.887), which may be outdated |
| irep_iRep | PASS |  |

## Metadata
- **Skill**: generated

## irep_bPTR

### Tool Description
Calculate peak-to-trough ratio (PTR) to estimate microbial growth rates from metagenomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/irep:1.1.7--pyh24bf2e0_1
- **Homepage**: https://github.com/christophertbrown/iRep
- **Package**: https://anaconda.org/channels/bioconda/packages/irep/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/irep:1.1.7--pyh24bf2e0_1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3306167285: no space left on device
```

## irep_iRep

### Tool Description
Calculate the Index of Replication (iRep) of bacteria from draft-quality genomes and sorted SAM mapping files.

### Metadata
- **Docker Image**: quay.io/biocontainers/irep:1.1.7--pyh24bf2e0_1
- **Homepage**: https://github.com/christophertbrown/iRep
- **Package**: https://anaconda.org/channels/bioconda/packages/irep/overview
- **Validation**: PASS

### Original Help Text
```text
[help] iRep: ok via iRep --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=usage_only)
usage: iRep [-h] -f [F [F ...]] -s [S [S ...]] -o O [--pickle] [-mm MM]
            [--sort] [-M M] [--no-plot] [--no-gc-correction] [-ff] [-t T]

# calculate the Index of Replication (iRep)

optional arguments:
  -h, --help          show this help message and exit
  -f [F [F ...]]      fasta(s)
  -s [S [S ...]]      sorted sam file(s) for each sample (e.g.: bowtie2
                      --reorder)
  -o O                prefix for output files (table and plots)
  --pickle            save pickle file (optional)
  -mm MM              max. # of read mismatches allowed (default: 1)
  --sort              optional - sort the sam file
  -M M                max. memory (GB) for sorting sam (default: 100)
  --no-plot           do not plot output
  --no-gc-correction  do not correct coverage for GC bias before calculating
                      iRep
  -ff                 overwrite files
  -t T                threads (default: 6)
```

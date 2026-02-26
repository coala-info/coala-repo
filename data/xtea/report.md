# xtea CWL Generation Report

## xtea

### Tool Description
xTea is a tool for detecting transposable element insertions.

### Metadata
- **Docker Image**: quay.io/biocontainers/xtea:0.1.9--hdfd78af_0
- **Homepage**: https://github.com/parklab/xTea
- **Package**: https://anaconda.org/channels/bioconda/packages/xtea/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/xtea/overview
- **Total Downloads**: 19.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/parklab/xTea
- **Stars**: N/A
### Original Help Text
```text
Usage: xtea [options]

Options:
  -h, --help            show this help message and exit
  -D, --decompress      Decompress the rep lib and reference file
  -M, --mosaic          Calling mosaic events from high coverage data
  -C, --case_control    Run in case control mode
  --denovo              Run in de novo mode
  -U, --user            Use user specific parameters instead of automatically
                        calculated ones
  --force               Force to start from the very beginning
  --hard                This is hard-cut for fitering out coverage abnormal
                        candidates
  --tumor               Working on tumor samples
  --purity=PURITY       Tumor purity
  --lsf                 Indiates submit to LSF system
  --slurm               Indiates submit to slurm system
  --resume              Resume the running, which will skip the step if output
                        file already exists!
  -V, --version         Print xTea version
  -i FILE, --id=FILE    sample id list file
  -a FILE, --par=FILE   parameter file
  -l FILE, --lib=FILE   TE lib config file
  -b FILE, --bam=FILE   Input bam file
  -x FILE, --x10=FILE   Input 10X bam file
  -n CORES, --cores=CORES
                        number of cores
  -m MEMORY, --memory=MEMORY
                        Memory limit in GB
  -q PARTITION, --partition=PARTITION
                        Which queue to run the job
  -t TIME, --time=TIME  Time limit
  -p WFOLDER, --path=WFOLDER
                        Working folder
  -r REF, --ref=REF     reference genome
  -g GENE, --gene=GENE  Gene annotation file
  --xtea=XTEA           xTEA folder
  -f FLAG, --flag=FLAG  Flag indicates which step to run (1-clip, 2-disc,
                        4-barcode, 8-xfilter, 16-filter, 32-asm)
  -y REP_TYPE, --reptype=REP_TYPE
                        Type of repeats working on: 1-L1, 2-Alu, 4-SVA,
                        8-HERV, 16-Mitochondrial
  --flklen=FLKLEN       flank region file
  --nclip=NCLIP         cutoff of minimum # of clipped reads
  --cr=CLIPREP          cutoff of minimum # of clipped reads whose mates map
                        in repetitive regions
  --nd=NDISC            cutoff of minimum # of discordant pair
  --nfclip=NFILTERCLIP  cutoff of minimum # of clipped reads in filtering step
  --nfdisc=NFILTERDISC  cutoff of minimum # of discordant pair of each sample
                        in filtering step
  --teilen=TEILEN       minimum length of the insertion for future analysis
  -o FILE, --output=FILE
                        The output file
  --blacklist=FILE      Reference panel database for filtering, or a blacklist
                        region
```


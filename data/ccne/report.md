# ccne CWL Generation Report

## ccne_ccne-fast

### Tool Description
Carbapenemase-encoding gene copy number estimator (fast screener)

### Metadata
- **Docker Image**: quay.io/biocontainers/ccne:1.1.2--hdfd78af_0
- **Homepage**: https://github.com/biojiang/ccne
- **Package**: https://anaconda.org/channels/bioconda/packages/ccne/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ccne/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biojiang/ccne
- **Stars**: N/A
### Original Help Text
```text
[19:48:09] Appending to PATH: /usr/local/bin
[19:48:09] Loading configure infomation
[19:48:09] Check for dependent tools
[19:48:09] Looking for 'bedtools' - found /usr/local/bin/bedtools
[19:48:09] Determined bedtools version is 002030 from 'Version:   v2.30.0'
[19:48:09] Looking for 'bwa' - found /usr/local/bin/bwa
[19:48:09] Determined bwa version is 000007 from 'Version: 0.7.17-r1188'
[19:48:09] Looking for 'hts_AdapterTrimmer' - found /usr/local/bin/hts_AdapterTrimmer
[19:48:09] Determined hts_AdapterTrimmer version is 001003 from '1.3.2'
[19:48:09] Looking for 'hts_PolyATTrim' - found /usr/local/bin/hts_PolyATTrim
[19:48:09] Determined hts_PolyATTrim version is 001003 from '1.3.2'
[19:48:09] Looking for 'hts_SeqScreener' - found /usr/local/bin/hts_SeqScreener
[19:48:09] Determined hts_SeqScreener version is 001003 from '1.3.2'
[19:48:09] Looking for 'hts_SuperDeduper' - found /usr/local/bin/hts_SuperDeduper
[19:48:09] Determined hts_SuperDeduper version is 001003 from '1.3.2'
[19:48:09] Looking for 'samtools' - found /usr/local/bin/samtools
[19:48:09] Determined samtools version is 001015 from 'Version: 1.15.1 (using htslib 1.15.1)'
Name:
  Ccne-fast 1.1.2 by Jianping Jiang <jiangjianping@fudan.edu.cn>
Synopsis:
  Carbapenemase-encoding gene copy number estimator (fast screener)
Usage:
  ccne-fast --amr KPC-2 --sp Kpn --in File.list --out result.txt
General:
  --help             This help
  --version          Print version and exit
  --quiet            No screen output (default OFF)
Setup:
  --dbdir [X]        CCNE database root folders (default '/usr/local/db')
  --listdb           List all configured AMRs
  --listsp           List all configured species and housekeeping genes
  --fmtdb            Format all the bwa index
Input:
  --amr [X]          AMR gene name, such as KPC-2, NDM-1, etc or AMR ID. Please refer to --listdb (required)
  --sp [X]           Species name[Kp|Ec|Ab|Pa|Pls](required)
  --ref [X]          Reference gene defalut(Kp:rpoB Ab:rpoB Ec:polB Pa:ppsA), please refer to --listsp.Note: When --sp is set to Pls, this parameter should be set to replicon type.
  --in [X]           Input file name (required)
Outputs:
  --out [X]          Output file name (required)
Computation:
  --flank [N]        The flanking length of sequence to be excluded (default '0')
  --cpus [N]         Number of CPUs to use (default '1')
  --multiref         Use the reads depth of all the available sequences (default OFF)
```


## ccne_ccne-acc

### Tool Description
Carbapenemase-encoding gene copy number estimator (accurate estimator)

### Metadata
- **Docker Image**: quay.io/biocontainers/ccne:1.1.2--hdfd78af_0
- **Homepage**: https://github.com/biojiang/ccne
- **Package**: https://anaconda.org/channels/bioconda/packages/ccne/overview
- **Validation**: PASS

### Original Help Text
```text
[19:48:49] Appending to PATH: /usr/local/bin
[19:48:49] Loading configure infomation
[19:48:49] Check for dependent tools
[19:48:49] Looking for 'bedtools' - found /usr/local/bin/bedtools
[19:48:49] Determined bedtools version is 002030 from 'Version:   v2.30.0'
[19:48:49] Looking for 'blastn' - found /usr/local/bin/blastn
[19:48:49] Determined blastn version is 002012 from 'blastn: 2.12.0+'
[19:48:49] Looking for 'bwa' - found /usr/local/bin/bwa
[19:48:49] Determined bwa version is 000007 from 'Version: 0.7.17-r1188'
[19:48:49] Looking for 'computeGCBias' - found /usr/local/bin/computeGCBias
[19:48:50] Determined computeGCBias version is 003005 from 'computeGCBias 3.5.1'
[19:48:50] Looking for 'correctGCBias' - found /usr/local/bin/correctGCBias
[19:48:50] Determined correctGCBias version is 003005 from 'correctGCBias 3.5.1'
[19:48:50] Looking for 'faToTwoBit' - found /usr/local/bin/faToTwoBit
[19:48:50] Looking for 'hts_AdapterTrimmer' - found /usr/local/bin/hts_AdapterTrimmer
[19:48:50] Determined hts_AdapterTrimmer version is 001003 from '1.3.2'
[19:48:50] Looking for 'hts_PolyATTrim' - found /usr/local/bin/hts_PolyATTrim
[19:48:50] Determined hts_PolyATTrim version is 001003 from '1.3.2'
[19:48:50] Looking for 'hts_SeqScreener' - found /usr/local/bin/hts_SeqScreener
[19:48:50] Determined hts_SeqScreener version is 001003 from '1.3.2'
[19:48:50] Looking for 'hts_SuperDeduper' - found /usr/local/bin/hts_SuperDeduper
[19:48:50] Determined hts_SuperDeduper version is 001003 from '1.3.2'
[19:48:50] Looking for 'makeblastdb' - found /usr/local/bin/makeblastdb
[19:48:50] Determined makeblastdb version is 002012 from 'makeblastdb: 2.12.0+'
[19:48:50] Looking for 'samtools' - found /usr/local/bin/samtools
[19:48:50] Determined samtools version is 001015 from 'Version: 1.15.1 (using htslib 1.15.1)'
Name:
  ccne-acc 1.1.2 by Jianping Jiang <jiangjianping@fudan.edu.cn>
Synopsis:
  Carbapenemase-encoding gene copy number estimator (accurate estimator)
Usage:
  ccne-acc --amr KPC-2 --in File.list --out result.txt
General:
  --help             This help
  --version          Print version and exit
  --quiet            No screen output (default OFF)
Setup:
  --dbdir [X]        CCNE database root folders (default '/usr/local/db')
  --listdb           List all configured AMRs
  --fmtdb            Format all the bwa index
Input:
  --amr [X]          AMR gene name, such as KPC-2, NDM-1, etc or AMR ID. Please refer to --listdb (required)
  --in [X]           Input file name (required)
Outputs:
  --out [X]          Output file name (required)
Computation:
  --cpus [N]         Number of CPUs to use (default '1')
```


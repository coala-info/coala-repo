# anglerfish CWL Generation Report

## anglerfish_explore

### Tool Description
This is an advanced samplesheet-free version of anglerfish.

### Metadata
- **Docker Image**: quay.io/biocontainers/anglerfish:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/remiolsen/anglerfish
- **Package**: https://anaconda.org/channels/bioconda/packages/anglerfish/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/anglerfish/overview
- **Total Downloads**: 10.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/remiolsen/anglerfish
- **Stars**: 0
### Original Help Text
```text
Usage: anglerfish explore [OPTIONS]                                            
                                                                                
 This is an advanced samplesheet-free version of anglerfish.                    
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --fastq                 -f      TEXT     Fastq file to align              │
│                                             [default: None]                  │
│                                             [required]                       │
│ *  --outdir                -o      TEXT     Output directory [default: None] │
│                                             [required]                       │
│    --threads               -t      INTEGER  Number of threads specified to   │
│                                             minimap2                         │
│                                             [default: 4]                     │
│    --use-existing          -e               Use existing alignments if found │
│                                             in the specified output          │
│                                             directory.                       │
│    --good_hit_threshold    -g      FLOAT    Fraction of adaptor bases        │
│                                             immediately before and           │
│                                             immediately after index insert   │
│                                             required to match perfectly for  │
│                                             a hit to be considered a good    │
│                                             hit                              │
│                                             [default: 0.9]                   │
│    --insert_thres_low      -i      INTEGER  Lower threshold for index(+UMI)  │
│                                             insert length, with value        │
│                                             included.                        │
│                                             [default: 4]                     │
│    --insert_thres_high     -j      INTEGER  Upper threshold for index(+UMI)  │
│                                             insert length, with value        │
│                                             included.                        │
│                                             [default: 30]                    │
│    --minimap_b             -B      INTEGER  Minimap2 -B parameter, mismatch  │
│                                             penalty.                         │
│                                             [default: 4]                     │
│    --min_hits_per_adaptor  -m      INTEGER  Minimum number of good hits for  │
│                                             an adaptor to be included in the │
│                                             analysis.                        │
│                                             [default: 50]                    │
│    --umi_threshold         -u      FLOAT    Minimum number of bases in       │
│                                             insert to perform entropy        │
│                                             calculation.                     │
│                                             [default: 11]                    │
│    --kmer_length           -k      INTEGER  Kmer length for entropy          │
│                                             calculation.                     │
│                                             [default: 2]                     │
│    --version               -v               Print version and quit           │
│    --help                                   Show this message and exit.      │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## anglerfish_run

### Tool Description
Run anglerfish. This is the main command for anglerfish

### Metadata
- **Docker Image**: quay.io/biocontainers/anglerfish:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/remiolsen/anglerfish
- **Package**: https://anaconda.org/channels/bioconda/packages/anglerfish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: anglerfish run [OPTIONS]                                                
                                                                                
 Run anglerfish. This is the main command for anglerfish                        
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --samplesheet     -s      TEXT                    CSV formatted list of   │
│                                                      samples and barcodes    │
│                                                      [default: None]         │
│                                                      [required]              │
│    --out_fastq       -o      TEXT                    Analysis output folder  │
│                                                      [default: .]            │
│    --threads         -t      INTEGER                 Number of threads to    │
│                                                      use                     │
│                                                      [default: 4]            │
│    --skip_demux      -c                              Only do BC counting and │
│                                                      not demuxing            │
│    --max-distance    -m      INTEGER                 Manually set maximum    │
│                                                      allowed edit distance   │
│                                                      for index matching,by   │
│                                                      default this is set to  │
│                                                      0, 1 or 2 based on the  │
│                                                      minimum detectedindex   │
│                                                      distance in the         │
│                                                      samplesheet.            │
│                                                      [default: 2]            │
│    --max-unknowns    -u      INTEGER                 Maximum number of       │
│                                                      unknown indices to show │
│                                                      in the output. default  │
│                                                      is length of            │
│                                                      samplesheet + 10        │
│                                                      [default: 0]            │
│    --run_name        -r      TEXT                    Run name                │
│                                                      [default: anglerfish]   │
│    --lenient         -l                              Will try reverse        │
│                                                      complementing the I5    │
│                                                      and/or I7 indices and   │
│                                                      choose the best match.  │
│    --lenient_factor  -x      FLOAT                   If lenient is set, this │
│                                                      is the minimum factor   │
│                                                      of additional matches   │
│                                                      required to reverse     │
│                                                      complement the index    │
│                                                      [default: 4.0]          │
│    --force_rc        -p      [i7|i5|i7+i5|original]  Force reverse           │
│                                                      complementing the I5    │
│                                                      and/or I7 indices. If   │
│                                                      set to anything other   │
│                                                      than 'original' this    │
│                                                      will disregard lenient  │
│                                                      mode.                   │
│                                                      [default: original]     │
│    --ont_barcodes    -n                              Will assume the         │
│                                                      samplesheet refers to a │
│                                                      single ONT run prepped  │
│                                                      with a barcoding kit.   │
│                                                      And will treat each     │
│                                                      barcode separately      │
│    --debug           -d                              Debug mode              │
│    --version         -v                              Print version and quit  │
│    --help                                            Show this message and   │
│                                                      exit.                   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## Metadata
- **Skill**: generated

# jaffa CWL Generation Report

## jaffa_jaffa-direct

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/jaffa:2.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/JAFFA
- **Package**: https://anaconda.org/channels/bioconda/packages/jaffa/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/jaffa/overview
- **Total Downloads**: 22.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Oshlack/JAFFA
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
=========================================== Bpipe Error ============================================

An error occurred executing your pipeline:

                            Cannot invoke method getAt() on null object                             


Please see the details below for more information.

========================================== Error Details ===========================================

java.lang.NullPointerException: Cannot invoke method getAt() on null object
	at JAFFA_direct.groovy.run(JAFFA_direct.groovy:23)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)


====================================================================================================

More details about why this error occurred may be available in the full log file .bpipe/bpipe.log
```


## jaffa_jaffa-assembly

### Tool Description
JAFFA is a tool for detecting gene fusions from RNA-Seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/jaffa:2.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/JAFFA
- **Package**: https://anaconda.org/channels/bioconda/packages/jaffa/overview
- **Validation**: PASS

### Original Help Text
```text
╒══════════════════════════════════════════════════════════════════════════════════════════════════╕
|                              Starting Pipeline at 2026-02-25 04:15                               |
╘══════════════════════════════════════════════════════════════════════════════════════════════════╛

========================================= Stage run_check ==========================================
Running JAFFA version 2.3
Checking for required data files...
CAN'T FIND null/hg38_genCode22.fa...
PLEASE DOWNLOAD and/or FIX PATH... STOPPING NOW
ERROR: stage run_check failed: Command in stage run_check failed with exit status = 1 : 

echo "Running JAFFA version 2.3" ;             echo "Checking for required data files..." ;             for i in null/hg38_genCode22.fa null/hg38_genCode22.tab /tmp/tmp.VvSPq6kiKE/known_fusions.txt null/hg38.fa null/Masked_hg38.1.bt2 null/hg38_genCode22.1.bt2 ;                   do ls $i 2>/dev/null || { echo "CAN'T FIND $i..." ;              echo "PLEASE DOWNLOAD and/or FIX PATH... STOPPING NOW" ; exit 1  ; } ; done ;             echo "All looking good" ;             echo "running JAFFA version 2.3.. checks passed" > checks 


========================================= Pipeline Failed ==========================================

In stage run_check: Command in stage run_check failed with exit status = 1 : 

echo "Running JAFFA version 2.3" ;             echo "Checking for required data files..." ;             for i in null/hg38_genCode22.fa null/hg38_genCode22.tab /tmp/tmp.VvSPq6kiKE/known_fusions.txt null/hg38.fa null/Masked_hg38.1.bt2 null/hg38_genCode22.1.bt2 ;                   do ls $i 2>/dev/null || { echo "CAN'T FIND $i..." ;              echo "PLEASE DOWNLOAD and/or FIX PATH... STOPPING NOW" ; exit 1  ; } ; done ;             echo "All looking good" ;             echo "running JAFFA version 2.3.. checks passed" > checks

Use 'bpipe errors' to see output from failed commands.
```


## jaffa_jaffa-hybrid

### Tool Description
JAFFA is a tool for detecting fusion sequences in next-generation sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/jaffa:2.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/JAFFA
- **Package**: https://anaconda.org/channels/bioconda/packages/jaffa/overview
- **Validation**: PASS

### Original Help Text
```text
╒══════════════════════════════════════════════════════════════════════════════════════════════════╕
|                              Starting Pipeline at 2026-02-25 04:16                               |
╘══════════════════════════════════════════════════════════════════════════════════════════════════╛

========================================= Stage run_check ==========================================
Running JAFFA version 2.3
Checking for required data files...
CAN'T FIND null/hg38_genCode22.fa...
PLEASE DOWNLOAD and/or FIX PATH... STOPPING NOW
ERROR: stage run_check failed: Command in stage run_check failed with exit status = 1 : 

echo "Running JAFFA version 2.3" ;             echo "Checking for required data files..." ;             for i in null/hg38_genCode22.fa null/hg38_genCode22.tab /tmp/tmp.M0LOvV2mfD/known_fusions.txt null/hg38.fa null/Masked_hg38.1.bt2 null/hg38_genCode22.1.bt2 ;                   do ls $i 2>/dev/null || { echo "CAN'T FIND $i..." ;              echo "PLEASE DOWNLOAD and/or FIX PATH... STOPPING NOW" ; exit 1  ; } ; done ;             echo "All looking good" ;             echo "running JAFFA version 2.3.. checks passed" > checks 


========================================= Pipeline Failed ==========================================

In stage run_check: Command in stage run_check failed with exit status = 1 : 

echo "Running JAFFA version 2.3" ;             echo "Checking for required data files..." ;             for i in null/hg38_genCode22.fa null/hg38_genCode22.tab /tmp/tmp.M0LOvV2mfD/known_fusions.txt null/hg38.fa null/Masked_hg38.1.bt2 null/hg38_genCode22.1.bt2 ;                   do ls $i 2>/dev/null || { echo "CAN'T FIND $i..." ;              echo "PLEASE DOWNLOAD and/or FIX PATH... STOPPING NOW" ; exit 1  ; } ; done ;             echo "All looking good" ;             echo "running JAFFA version 2.3.. checks passed" > checks

Use 'bpipe errors' to see output from failed commands.
```


## Metadata
- **Skill**: generated

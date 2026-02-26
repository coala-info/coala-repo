# bbmapy CWL Generation Report

## bbmapy_bbmapy-test

### Tool Description
BBMapy test suite, demonstrating various BBMap tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/bbmapy:0.0.51--pyhdfd78af_0
- **Homepage**: https://github.com/urineri/bbmapy
- **Package**: https://anaconda.org/channels/bioconda/packages/bbmapy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bbmapy/overview
- **Total Downloads**: 336
- **Last updated**: 2025-08-28
- **GitHub**: https://github.com/urineri/bbmapy
- **Stars**: N/A
### Original Help Text
```text
/usr/local/lib/python3.13/site-packages/bbmapy/vendor/bbmap
prefix path: /usr/local from CONDA_PREFIX
Java not found in PATH, installing...
Java adoptium JRE 11 installed to /usr/local/jdk-11.0.30+7-jre
Trying to add to conda environment PATH...
Java added to this conda environment PATH, testing...
testing if java is in PATH
Java executable found in PATH: /usr/local/bin/java
java -ea -Xmx240m -cp 
/usr/local/lib/python3.13/site-packages/bbmapy/vendor/bbmap/current/ 
synth.RandomGenome out=ref.fasta len=700 -Xmx240m
Executing synth.RandomGenome [out=ref.fasta, len=700, -Xmx240m]

java -ea -Xmx240m -cp 
/usr/local/lib/python3.13/site-packages/bbmapy/vendor/bbmap/current/ 
synth.RandomReads3 build=1 out1=input_1.fastq out2=input_2.fastq paired=true 
ref=ref.fasta reads=50 -Xmx240m
Executing synth.RandomReads3 [build=1, out1=input_1.fastq, out2=input_2.fastq, 
paired=true, ref=ref.fasta, reads=50, -Xmx240m]

Writing reference.
Executing dna.FastaToChromArrays2 [ref.fasta, 1, writeinthread=false, 
genscaffoldinfo=true, retain, waitforwriting=false, gz=true, maxlen=536670912, 
writechroms=true, minscaf=1, midpad=500, nodisk=false]

Set genScaffoldInfo=true
Writing chunk 1
Waiting for writing to finish.
Finished.
snpRate=0.0, max=0, unique=true
insRate=0.0, max=0, len=(0-0)
delRate=0.0, max=0, len=(0-0)
subRate=0.0, max=0, len=(0-0)
nRate  =0.0, max=0, len=(0-0)
genome=1
PERFECT_READ_RATIO=0.0
ADD_ERRORS_FROM_QUALITY=true
REPLACE_NOREF=false
paired=true
read length=150
reads=50
insert size=100-450
Wrote input_1.fastq
Wrote input_2.fastq
Time:   0.131 seconds.
java -ea -Xmx200m -cp 
/usr/local/lib/python3.13/site-packages/bbmapy/vendor/bbmap/current/ 
synth.RandomReads3 build=1 out=test_input.fastq ref=ref.fasta reads=50 -Xmx200m
Executing synth.RandomReads3 [build=1, out=test_input.fastq, ref=ref.fasta, 
reads=50, -Xmx200m]

Writing reference.
Executing dna.FastaToChromArrays2 [ref.fasta, 1, writeinthread=false, 
genscaffoldinfo=true, retain, waitforwriting=false, gz=true, maxlen=536670912, 
writechroms=true, minscaf=1, midpad=500, nodisk=false]

Set genScaffoldInfo=true
Deleting chr1.chrom.gz
Writing chunk 1
Waiting for writing to finish.
Finished.
snpRate=0.0, max=0, unique=true
insRate=0.0, max=0, len=(0-0)
delRate=0.0, max=0, len=(0-0)
subRate=0.0, max=0, len=(0-0)
nRate  =0.0, max=0, len=(0-0)
genome=1
PERFECT_READ_RATIO=0.0
ADD_ERRORS_FROM_QUALITY=true
REPLACE_NOREF=false
paired=false
read length=150
reads=50
Wrote test_input.fastq
Time:   0.070 seconds.
java -ea -Xmx240m -cp 
/usr/local/lib/python3.13/site-packages/bbmapy/vendor/bbmap/current/ 
synth.RandomGenome out=ref.fasta len=700 -Xmx240m
Executing synth.RandomGenome [out=ref.fasta, len=700, -Xmx240m]

java -ea -Xmx240m -cp 
/usr/local/lib/python3.13/site-packages/bbmapy/vendor/bbmap/current/ 
synth.RandomReads3 build=1 out1=input_1.fastq out2=input_2.fastq paired=true 
ref=ref.fasta reads=50 -Xmx240m
Executing synth.RandomReads3 [build=1, out1=input_1.fastq, out2=input_2.fastq, 
paired=true, ref=ref.fasta, reads=50, -Xmx240m]

Writing reference.
Executing dna.FastaToChromArrays2 [ref.fasta, 1, writeinthread=false, 
genscaffoldinfo=true, retain, waitforwriting=false, gz=true, maxlen=536670912, 
writechroms=true, minscaf=1, midpad=500, nodisk=false]

Set genScaffoldInfo=true
Deleting chr1.chrom.gz
Writing chunk 1
Waiting for writing to finish.
Finished.
snpRate=0.0, max=0, unique=true
insRate=0.0, max=0, len=(0-0)
delRate=0.0, max=0, len=(0-0)
subRate=0.0, max=0, len=(0-0)
nRate  =0.0, max=0, len=(0-0)
genome=1
PERFECT_READ_RATIO=0.0
ADD_ERRORS_FROM_QUALITY=true
REPLACE_NOREF=false
paired=true
read length=150
reads=50
insert size=100-450
Wrote input_1.fastq
Wrote input_2.fastq
Time:   0.062 seconds.
java -ea -Xmx200m -cp 
/usr/local/lib/python3.13/site-packages/bbmapy/vendor/bbmap/current/ 
synth.RandomReads3 build=1 out=test_input.fastq ref=ref.fasta reads=50 -Xmx200m
Executing synth.RandomReads3 [build=1, out=test_input.fastq, ref=ref.fasta, 
reads=50, -Xmx200m]

Writing reference.
Executing dna.FastaToChromArrays2 [ref.fasta, 1, writeinthread=false, 
genscaffoldinfo=true, retain, waitforwriting=false, gz=true, maxlen=536670912, 
writechroms=true, minscaf=1, midpad=500, nodisk=false]

Set genScaffoldInfo=true
Deleting chr1.chrom.gz
Writing chunk 1
Waiting for writing to finish.
Finished.
snpRate=0.0, max=0, unique=true
insRate=0.0, max=0, len=(0-0)
delRate=0.0, max=0, len=(0-0)
subRate=0.0, max=0, len=(0-0)
nRate  =0.0, max=0, len=(0-0)
genome=1
PERFECT_READ_RATIO=0.0
ADD_ERRORS_FROM_QUALITY=true
REPLACE_NOREF=false
paired=false
read length=150
reads=50
Wrote test_input.fastq
Time:   0.084 seconds.
java -ea -Xmx800m -Xms800m -cp 
/usr/local/lib/python3.13/site-packages/bbmapy/vendor/bbmap/current/ 
align2.BBMap build=1 overwrite=true fastareadlen=500 in=test_input.fastq 
ref=ref.fasta out_file=output.sam -Xmx800m
Executing align2.BBMap [build=1, overwrite=true, fastareadlen=500, 
in=test_input.fastq, ref=ref.fasta, out_file=output.sam, -Xmx800m]
Version 39.33

Retaining first best site only for ambiguous mappings.
NOTE:   Ignoring reference file because it already appears to have been 
processed.
NOTE:   If you wish to regenerate the index, please manually delete 
ref/genome/1/summary.txt
Set genome to 1

Loaded Reference:       0.009 seconds.
Loading index for chunk 1-1, build 1
No index available; generating from reference genome: 
/test/ref/index/1/chr1_index_k13_c16_b1.block
Indexing threads started for block 0-1
Indexing threads finished for block 0-1
Generated Index:        0.704 seconds.
Analyzed Index:         1.739 seconds.
Cleared Memory:         0.111 seconds.

Max Memory = 838 MB
Available Memory = 297 MB
Reducing threads from 20 to 3 due to low system memory.
Processing reads in single-ended mode.
Started read stream.
Started 3 mapping threads.
Detecting finished threads: 0, 1, 2

------------------   Results   ------------------

Genome:                 1
Key Length:             13
Max Indel:              16000
Minimum Score Ratio:    0.56
Mapping Mode:           normal
Reads Used:             50      (7500 bases)

Mapping:                0.100 seconds.
Reads/sec:              498.27
kBases/sec:             74.74


Read 1 data:            pct reads       num reads       pct bases          num 
bases

mapped:                 100.0000%              50       100.0000%               
7500
unambiguous:            100.0000%              50       100.0000%               
7500
ambiguous:                0.0000%               0         0.0000%               
0
low-Q discards:           0.0000%               0         0.0000%               
0

perfect best site:       64.0000%              32        64.0000%               
4800
semiperfect site:        64.0000%              32        64.0000%               
4800

Match Rate:                   NA               NA        99.6933%               
7477
Error Rate:              36.0000%              18         0.3067%               
23
Sub Rate:                36.0000%              18         0.3067%               
23
Del Rate:                 0.0000%               0         0.0000%               
0
Ins Rate:                 0.0000%               0         0.0000%               
0
N Rate:                   0.0000%               0         0.0000%               
0

Total time:             2.743 seconds.
bbmap test passed!
Testing bbmerge...
java -ea -Xmx240m -Xms240m 
-Djava.library.path=/usr/local/lib/python3.13/site-packages/bbmapy/vendor/bbmap/
jni/ -cp /usr/local/lib/python3.13/site-packages/bbmapy/vendor/bbmap/current/ 
jgi.BBMerge in1=input_1.fastq in2=input_2.fastq out=output_merged.fastq 
outu1=unmerged_1.fastq outu2=unmerged_2.fastq strict k=60 extend2=50 rem 
-Xmx240m
Executing jgi.BBMerge [in1=input_1.fastq, in2=input_2.fastq, 
out=output_merged.fastq, outu1=unmerged_1.fastq, outu2=unmerged_2.fastq, strict,
k=60, extend2=50, rem, -Xmx240m]
Version 39.33

Revised arguments: [maxbad=4, margin=3, minqo=8, qualiters=2, ratiomode=t, 
flatmode=f, minentropy=42, minoverlap0=7, minoverlap=11, maxratio=0.075, 
ratiomargin=7.5, ratiooffset=0.55, ratiominoverlapreduction=4, efilter=4, 
pfilter=0.0008, minsecondratio=0.12, minapproxoverlap=24, in1=input_1.fastq, 
in2=input_2.fastq, out=output_merged.fastq, outu1=unmerged_1.fastq, 
outu2=unmerged_2.fastq, k=60, extend2=50, rem]


***** WARNING *****
Using kmer counts uses a lot of memory, but only 235MB is available.
If this process crashes, run bbmerge-auto.sh instead of bbmerge.sh, or set the 
-Xmx flag.

Executing assemble.Tadpole2 [in=input_1.fastq, in2=input_2.fastq, branchlower=3,
branchmult1=20.0, branchmult2=3.0, mincountseed=3, mincountextend=2, 
minprob=0.5, k=60, prealloc=false, prefilter=0, ecctail=false, eccpincer=false, 
eccreassemble=true]
Version 39.33

Using 20 threads.
Executing ukmer.KmerTableSetU [in=input_1.fastq, in2=input_2.fastq, 
branchlower=3, branchmult1=20.0, branchmult2=3.0, mincountseed=3, 
mincountextend=2, minprob=0.5, k=60, prealloc=false, prefilter=0, ecctail=false,
eccpincer=false, eccreassemble=true]

Initial size set to 91515
Initial:
Ways=53, initialSize=91515, prefilter=f, prealloc=f
Memory: max=251m, total=251m, free=244m, used=7m

Estimated kmer capacity:        3620344
After table allocation:
Memory: max=251m, total=251m, free=120m, used=131m

After loading:
Memory: max=251m, total=251m, free=98m, used=153m

Input:                          100 reads               15000 bases.
Unique Kmers:                   1654
Load Time:                      0.065 seconds.

Writing mergable reads merged.
Started output threads.
Total time: 1.330 seconds.

Pairs:                  50
Joined:                 39              78.000%
Ambiguous:              11              22.000%
No Solution:            0               0.000%
Too Short:              0               0.000%
Fully Extended:         68              68.000%
Partly Extended:        7               7.000%
Not Extended:           25              25.000%

Avg Insert:             265.2
Standard Deviation:     49.7
Mode:                   288

Insert range:           149 - 377
90th percentile:        321
75th percentile:        297
50th percentile:        272
25th percentile:        215
10th percentile:        197
Testing output capture...
Captured stdout: None
Captured stderr: java -ea -Xmx240m -Xms240m -cp /usr/local/lib/python3.13/site-packages/bbmapy/vendor/bbmap/current/ ...
All tests completed.
```


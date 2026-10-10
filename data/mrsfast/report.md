# mrsfast CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mrsfast | Failed | tool bug: -u file is ignored (unmapped reads go to <out>.nohit) and paired mode with --seq1/--seq2 segfaults; single-end and interleaved --pe mapping work |
| mrsfast_index | PASS |  |

## mrsfast

### Tool Description
mrsFAST is a cache oblivious read mapping tool. mrsFAST capable of mapping single and paired end reads to the reference genome. Bisulfite treated sequences are not supported in this version.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrsfast:3.4.2--h7132678_2
- **Homepage**: https://github.com/sfu-compbio/mrsfast
- **Package**: https://anaconda.org/channels/bioconda/packages/mrsfast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mrsfast/overview
- **Total Downloads**: 10.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sfu-compbio/mrsfast
- **Stars**: N/A
### Original Help Text
```text
mrsFAST-Ultra(1)             mrsfast-Ultra Manual             mrsFAST-Ultra(1)



[1mNAME[0m
       mrsfast-ultra

[1mDESCRIPTION[0m
       mrsFAST is a cache oblivious read mapping tool. mrsFAST capable of map-
       ping single and paired end reads to  the  reference  genome.  Bisulfite
       treated  sequences are not supported in this version.


[1mINSTALLATION[0m
       To  install  mrsFAST-ultra, please download the source zip package from
       http://sourceforge.net/projects/mrsfast/.  After  unzipping  the  down-
       loaded  file "mrsfast-ultra-3.X.X.zip", change the current directory to
       the source directory "mrsfast-ultra-3.X.X", and run "make" in the  ter-
       minal.  The  binary  file  "mrsfast" will be created, which is ready to
       use.
       $ unzip mrsfast-ultra-3.X.X.zip
       $ cd mrsfast-ultra-3.X.X
       $ make


[1mSYNOPSIS[0m
       mrsfast --index [file] [OPTIONS]
       mrsfast --search [index] --seq [file] [OPTIONS]

[1mOPTIONS[0m
   [1mGENERAL OPTIONS[0m
       [1m-h     [22mPrints this help file.

       [1m-v, --version[0m
              Prints the version of software.

   [1mINDEXING OPTIONS[0m
       [1m--ws [4m[22mwindow_size[0m
              Index the reference genome with sliding a window  of  size  [4mwin-[0m
              [4mdow_size[24m (default: 12).


   [1mMAPPING OPTIONS[0m
       [1m--mem [4m[22mm[0m
              Use maximum [4mm[24m GB of memory (default: 4).


       [1m--threads [4m[22mt[0m
              Use  [4mt[24m  number  of cores for mapping the sequences (default: 1).
              Use [4m0[24m to use all the available cores in the system.


       [1m--seq [4m[22mfile[0m
              Set the input sequence to [4mfile.[24m  In paired-end mode, [4mfile[24m should
              be used if the read sequences are interleaved.


       [1m--seq1 [4m[22mfile[0m
              Set  the  input sequence (left mate) to [4mfile.[24m  Paired-end option
              only.


       [1m--seq2 [4m[22mfile[0m
              Set the input sequence (right mate) to [4mfile.[24m  Paired-end  option
              only.


       [1m--seqcomp[0m
              Input file is compressed through gzip.


       [1m-o [4m[22mfile[0m
              Output the mapping record into [4mfile[24m (default: output.sam)


       [1m--disable-sam-header[0m
              Do not generate SAM header.


       [1m-u [4m[22mfile[0m
              Output unmapped reads in [4mfile[24m (default: output.nohit). This file
              will be generated in all mapping mode.


       [1m--disable-nohits[0m
              Do not output unmapped reads.


       [1m--outcomp[0m
              Compress the output [4mfile[24m by gzip.


       [1m-n [4m[22mcut-off[0m
              Output the mapping for the read sequences that  have  less  than
              [4mcut-off[24m number of mappings. Cannot be used with [1m--best [22mor [1m--dis-[0m
              [1mcordant-vh [22moptions.



       [1m--crop [4m[22mn[0m
              Trim the reads to [4mn[24m base pairs from begining of the read.


       [1m--tail-crop [4m[22mn[0m
              Trim the reads to [4mn[24m base pairs from end of the read.


       [1m-e [4m[22merror-threshold[0m
              Allow up to [4merror-threshold[24m mismatches in the mappings.


       [1m--best [22mFind the best mapping location of given reads.


       [1m--pe   [22mMap the reads in Paired-End  mode.   [1mmin  [22mand  [1mmax  [22mof  template
              length  will  be calculated if not provided by corresponding op-
              tions.


       [1m--min [4m[22mmin-discordant-length[0m
              Use [4mmin-discordant-length[24m for minimum length of concordant  map-
              ping. Paired-end option only.


       [1m--max [4m[22mmax-discordant-length[0m
              Use  [4mmax-discordant-length[24m for maximum length of concordant map-
              ping. Paired-end option only.


       [1m--discordant-vh[0m
              Map the reads in discordant fashion that  can  be  processed  by
              Variation  Hunter / Common Law. Output will be generate in DIVET
              format.


       [1m--max-discordant-cutoff [4m[22mm[0m
              Allow [4mm[24m discordant mappings per read. Should be only  used  with
              [1m--discordant-vh [22moption.


       [1m--snp [4m[22msnp-file[0m
              Map the reads in SNP aware mode. In this mode mrsFAST-Ultra tol-
              erates the mismatches in known SNP  locations  reported  by  the
              provided SNP database. The SNP index [4msnp-file[0m
               should  be created from the dbSNP (.vcf) file using the snp_in-
              dexer binary.


       [1m--snp-qual [4m[22mquality-threshold[0m
              In SNP-aware mode, a mismatch at a reported SNP location will be
              ignored  only  if  the corresponding read location has a quality
              higher than or equal to the [4mquality-threshold[24m  [4mquality-threshold[0m
              is  a  Phred-Value  base  33. The default is 53 (base call error
              0.01).


[1mEXAMPLES[0m
       Indexing reference genome:
       $ ./mrsfast --index refgen.fasta
       $ ./mrsfast --index refgen.fasta --ws 14

       Single-end mapping:
       $ ./mrsfast --search refgen.fa --seq reads.fastq
       $ ./mrsfast --search refgen.fa --seq reads.fastq -e 3 -n 10 --threads 4
       $ ./mrsfast --search refgen.fa --seq reads.fastq -e 3 --best -o output

       Paired-end mapping:
       $ ./mrsfast --search refgen.fasta --pe --seq pe-reads.fastq  --min  100
       --max 400
       $  ./mrsfast --search refgen.fasta --pe --seq1 first-mates.fastq --seq2
       second-mates.fastq -e 3 --threads 4
       $ ./mrsfast --search refgen.fasta --pe --seq1 first-mates.fastq  --seq2
       second-mates.fastq --min 100 --max 400 --best -o output

       Discordant mapping:
       $   ./mrsfast   --search   refgen.fasta   --pe   --discordant-vh  --seq
       reads.fastq --min 100 --max 400



[1mBUGS[0m
       Please report the  bugs  through  mrsfast's  web  page  at  http://mrs-
       fast.sourceforge.net


[1mAuthors[0m
       Faraz Hach (fhach@sfu.ca)
       Iman Sarrafi (isarrafi@sfu.ca)



[1mReference[0m
       Please cite the following paper for publications if using mrsFAST:

       Faraz Hach, Fereydoun Hormozdiari, Can Alkan, Farhad Hormozdiari, Inanc
       Birol, Evan E Eichler and S Cenk Sahinalp, "mrsFAST: a  cache-oblivious
       algorithm for short-read mapping", Nature Methods 7, 576-577 (2010)

       Please  cite  the following paper for publications if using mrsFAST-Ul-
       tra:

       Faraz Hach, Iman Sarrafi, Farhad Hormozdiari, Can Alkan, Evan E.  Eich-
       ler,  S. Cenk Sahinalp, "mrsFAST-Ultra: a compact, SNP-aware mapper for
       high performance sequencing applications", Nucl.  Acids  Res.  (1  July
       2014) 42 (W1): W494-W500.



[1mCOPYRIGHT[0m
       Copyright (c) <2012-2020>, Simon Fraser University All rights reserved.

       Redistribution and use in source and binary forms, with or without mod-
       ification, are permitted provided that  the  following  conditions  are
       met:


       1      Redistributions  of  source code must retain the above copyright
              notice, this list of conditions and the following disclaimer.

       2      Redistributions in binary form must reproduce  the  above  copy-
              right  notice,  thislist  of  conditions  and the following dis-
              claimer in the documentation  and/or  other  materials  provided
              with the distribution.

       3      Neither the name of the Simon Fraser University nor the names of
              its contributors may be used to endorse or promote products  de-
              rived  from this software without specific prior written permis-
              sion.


       THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
       IS"  AND  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
       TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTIC-
       ULAR  PURPOSE  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
       CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,  INCIDENTAL,  SPECIAL,
       EXEMPLARY,  OR  CONSEQUENTIAL  DAMAGES  (INCLUDING, BUT NOT LIMITED TO,
       PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;  LOSS  OF  USE,  DATA,  OR
       PROFITS;  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
       LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,  OR  TORT  (INCLUDING
       NEGLIGENCE  OR  OTHERWISE)  ARISING  IN  ANY WAY OUT OF THE USE OF THIS
       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.




mrsFAST-Ultra             Last Updated: Nov 16, 2016          mrsFAST-Ultra(1)
```

## mrsfast_index

### Tool Description
Index a reference genome for mrsFAST (mrsfast --index).

### Metadata
- **Docker Image**: quay.io/biocontainers/mrsfast:3.4.2--h7132678_2
- **Homepage**: https://github.com/sfu-compbio/mrsfast
- **Package**: https://anaconda.org/channels/bioconda/packages/mrsfast/overview
- **Validation**: PASS

### Original Help Text
```text
mrsFAST-Ultra(1)             mrsfast-Ultra Manual             mrsFAST-Ultra(1)



NAME
       mrsfast-ultra

DESCRIPTION
       mrsFAST is a cache oblivious read mapping tool. mrsFAST capable of map-
       ping single and paired end reads to  the  reference  genome.  Bisulfite
       treated  sequences are not supported in this version.


INSTALLATION
       To  install  mrsFAST-ultra, please download the source zip package from
       http://sourceforge.net/projects/mrsfast/.  After  unzipping  the  down-
       loaded  file "mrsfast-ultra-3.X.X.zip", change the current directory to
       the source directory "mrsfast-ultra-3.X.X", and run "make" in the  ter-
       minal.  The  binary  file  "mrsfast" will be created, which is ready to
       use.
       $ unzip mrsfast-ultra-3.X.X.zip
       $ cd mrsfast-ultra-3.X.X
       $ make


SYNOPSIS
       mrsfast --index [file] [OPTIONS]
       mrsfast --search [index] --seq [file] [OPTIONS]

OPTIONS
   GENERAL OPTIONS
       -h     Prints this help file.

       -v, --version
              Prints the version of software.

   INDEXING OPTIONS
       --ws window_size
              Index the reference genome with sliding a window  of  size  win-
              dow_size (default: 12).


   MAPPING OPTIONS
       --mem m
              Use maximum m GB of memory (default: 4).


       --threads t
              Use  t  number  of cores for mapping the sequences (default: 1).
              Use 0 to use all the available cores in the system.


       --seq file
              Set the input sequence to file.  In paired-end mode, file should
              be used if the read sequences are interleaved.


       --seq1 file
              Set  the  input sequence (left mate) to file.  Paired-end option
              only.


       --seq2 file
              Set the input sequence (right mate) to file.  Paired-end  option
              only.


       --seqcomp
              Input file is compressed through gzip.


       -o file
              Output the mapping record into file (default: output.sam)


       --disable-sam-header
              Do not generate SAM header.


       -u file
              Output unmapped reads in file (default: output.nohit). This file
              will be generated in all mapping mode.


       --disable-nohits
              Do not output unmapped reads.


       --outcomp
              Compress the output file by gzip.


       -n cut-off
              Output the mapping for the read sequences that  have  less  than
              cut-off number of mappings. Cannot be used with --best or --dis-
              cordant-vh options.



       --crop n
              Trim the reads to n base pairs from begining of the read.


       --tail-crop n
              Trim the reads to n base pairs from end of the read.


       -e error-threshold
              Allow up to error-threshold mismatches in the mappings.


       --best Find the best mapping location of given reads.


       --pe   Map the reads in Paired-End  mode.   min  and  max  of  template
              length  will  be calculated if not provided by corresponding op-
              tions.


       --min min-discordant-length
              Use min-discordant-length for minimum length of concordant  map-
              ping. Paired-end option only.


       --max max-discordant-length
              Use  max-discordant-length for maximum length of concordant map-
              ping. Paired-end option only.


       --discordant-vh
              Map the reads in discordant fashion that  can  be  processed  by
              Variation  Hunter / Common Law. Output will be generate in DIVET
              format.


       --max-discordant-cutoff m
              Allow m discordant mappings per read. Should be only  used  with
              --discordant-vh option.


       --snp snp-file
              Map the reads in SNP aware mode. In this mode mrsFAST-Ultra tol-
              erates the mismatches in known SNP  locations  reported  by  the
              provided SNP database. The SNP index snp-file
               should  be created from the dbSNP (.vcf) file using the snp_in-
              dexer binary.


       --snp-qual quality-threshold
              In SNP-aware mode, a mismatch at a reported SNP location will be
              ignored  only  if  the corresponding read location has a quality
              higher than or equal to the quality-threshold  quality-threshold
              is  a  Phred-Value  base  33. The default is 53 (base call error
              0.01).


EXAMPLES
       Indexing reference genome:
       $ ./mrsfast --index refgen.fasta
       $ ./mrsfast --index refgen.fasta --ws 14

       Single-end mapping:
       $ ./mrsfast --search refgen.fa --seq reads.fastq
       $ ./mrsfast --search refgen.fa --seq reads.fastq -e 3 -n 10 --threads 4
       $ ./mrsfast --search refgen.fa --seq reads.fastq -e 3 --best -o output

       Paired-end mapping:
       $ ./mrsfast --search refgen.fasta --pe --seq pe-reads.fastq  --min  100
       --max 400
       $  ./mrsfast --search refgen.fasta --pe --seq1 first-mates.fastq --seq2
       second-mates.fastq -e 3 --threads 4
       $ ./mrsfast --search refgen.fasta --pe --seq1 first-mates.fastq  --seq2
       second-mates.fastq --min 100 --max 400 --best -o output

       Discordant mapping:
       $   ./mrsfast   --search   refgen.fasta   --pe   --discordant-vh  --seq
       reads.fastq --min 100 --max 400



BUGS
       Please report the  bugs  through  mrsfast's  web  page  at  http://mrs-
       fast.sourceforge.net


Authors
       Faraz Hach (fhach@sfu.ca)
       Iman Sarrafi (isarrafi@sfu.ca)



Reference
       Please cite the following paper for publications if using mrsFAST:

       Faraz Hach, Fereydoun Hormozdiari, Can Alkan, Farhad Hormozdiari, Inanc
       Birol, Evan E Eichler and S Cenk Sahinalp, "mrsFAST: a  cache-oblivious
       algorithm for short-read mapping", Nature Methods 7, 576-577 (2010)

       Please  cite  the following paper for publications if using mrsFAST-Ul-
       tra:

       Faraz Hach, Iman Sarrafi, Farhad Hormozdiari, Can Alkan, Evan E.  Eich-
       ler,  S. Cenk Sahinalp, "mrsFAST-Ultra: a compact, SNP-aware mapper for
       high performance sequencing applications", Nucl.  Acids  Res.  (1  July
       2014) 42 (W1): W494-W500.



COPYRIGHT
       Copyright (c) <2012-2020>, Simon Fraser University All rights reserved.

       Redistribution and use in source and binary forms, with or without mod-
       ification, are permitted provided that  the  following  conditions  are
       met:


       1      Redistributions  of  source code must retain the above copyright
              notice, this list of conditions and the following disclaimer.

       2      Redistributions in binary form must reproduce  the  above  copy-
              right  notice,  thislist  of  conditions  and the following dis-
              claimer in the documentation  and/or  other  materials  provided
              with the distribution.

       3      Neither the name of the Simon Fraser University nor the names of
              its contributors may be used to endorse or promote products  de-
              rived  from this software without specific prior written permis-
              sion.


       THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
       IS"  AND  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
       TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTIC-
       ULAR  PURPOSE  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
       CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,  INCIDENTAL,  SPECIAL,
       EXEMPLARY,  OR  CONSEQUENTIAL  DAMAGES  (INCLUDING, BUT NOT LIMITED TO,
       PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;  LOSS  OF  USE,  DATA,  OR
       PROFITS;  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
       LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,  OR  TORT  (INCLUDING
       NEGLIGENCE  OR  OTHERWISE)  ARISING  IN  ANY WAY OUT OF THE USE OF THIS
       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.




mrsFAST-Ultra             Last Updated: Nov 16, 2016          mrsFAST-Ultra(1)
```

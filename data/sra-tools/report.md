# sra-tools CWL Generation Report

## sra-tools_vdb-config

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
- **Homepage**: https://github.com/ncbi/sra-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/sra-tools/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/sra-tools/overview
- **Total Downloads**: 566.7K
- **Last updated**: 2025-06-18
- **GitHub**: https://github.com/ncbi/sra-tools
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
<VdbConfig>
<!-- Current configuration -->
<Config>
  <APPNAME>vdb-config</APPNAME>
  <APPPATH>/</APPPATH>
  <BUILD>RELEASE</BUILD>
  <HOME>/root</HOME>
  <HOST/>
  <LIBS>
    <GUID>af3eb2ba-c2f0-4dd9-b37b-9a09e28fd9cb</GUID>
  </LIBS>
  <NCBI_HOME>/root/.ncbi</NCBI_HOME>
  <NCBI_SETTINGS>/root/.ncbi/user-settings.mkfg</NCBI_SETTINGS>
  <OS>linux</OS>
  <PWD/>
  <USER/>
  <VDB_CONFIG/>
  <VDB_ROOT/>
  <config>
    <default>true</default>
  </config>
  <kfg>
    <arch>
      <bits>64</bits>
      <name>2404428fb4cf</name>
    </arch>
    <dir>/usr/local/bin/ncbi</dir>
    <name>default.kfg</name>
  </kfg>
  <libs>
    <cloud>
      <report_instance_identity>false</report_instance_identity>
    </cloud>
  </libs>
  <repository>
    <remote>
      <main>
        <SDL.2>
          <resolver-cgi>https://locate.ncbi.nlm.nih.gov/sdl/2/retrieve</resolver-cgi>
        </SDL.2>
      </main>
      <protected>
        <SDL.2>
          <resolver-cgi>https://locate.ncbi.nlm.nih.gov/sdl/2/retrieve</resolver-cgi>
        </SDL.2>
      </protected>
    </remote>
    <user>
      <ad>
        <public>
          <apps>
            <file>
              <volumes>
                <flat/>
                <flatAd>.</flatAd>
              </volumes>
            </file>
            <refseq>
              <volumes>
                <refseqAd>.</refseqAd>
              </volumes>
            </refseq>
            <sra>
              <volumes>
                <sraAd>.</sraAd>
              </volumes>
            </sra>
            <sraPileup>
              <volumes>
                <ad>.</ad>
              </volumes>
            </sraPileup>
            <sraRealign>
              <volumes>
                <ad>.</ad>
              </volumes>
            </sraRealign>
            <wgs>
              <volumes>
                <wgsAd>.</wgsAd>
              </volumes>
            </wgs>
          </apps>
          <root>.</root>
        </public>
      </ad>
      <main>
        <public>
          <apps>
            <file>
              <volumes>
                <flat>files</flat>
              </volumes>
            </file>
            <nakmer>
              <volumes>
                <nakmerFlat>nannot</nakmerFlat>
              </volumes>
            </nakmer>
            <nannot>
              <volumes>
                <nannotFlat>nannot</nannotFlat>
              </volumes>
            </nannot>
            <refseq>
              <volumes>
                <refseq>refseq</refseq>
              </volumes>
            </refseq>
            <sra>
              <volumes>
                <sraFlat>sra</sraFlat>
              </volumes>
            </sra>
            <sraPileup>
              <volumes>
                <withExtFlat>sra</withExtFlat>
              </volumes>
            </sraPileup>
            <sraRealign>
              <volumes>
                <withExtFlat>sra</withExtFlat>
              </volumes>
            </sraRealign>
            <wgs>
              <volumes>
                <wgsFlat>wgs</wgsFlat>
              </volumes>
            </wgs>
          </apps>
        </public>
      </main>
    </user>
  </repository>
  <sra>
    <quality_type>raw_scores</quality_type>
  </sra>
  <strings>
    <sdl>https://locate.ncbi.nlm.nih.gov/sdl/2/retrieve</sdl>
  </strings>
  <tls>
    <ca.crt>
      <ncbi1>-----BEGIN CERTIFICATE-----
MIIDrzCCApegAwIBAgIQCDvgVpBCRrGhdWrJWZHHSjANBgkqhkiG9w0BAQUFADBh
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBD
QTAeFw0wNjExMTAwMDAwMDBaFw0zMTExMTAwMDAwMDBaMGExCzAJBgNVBAYTAlVT
MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5j
b20xIDAeBgNVBAMTF0RpZ2lDZXJ0IEdsb2JhbCBSb290IENBMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4jvhEXLeqKTTo1eqUKKPC3eQyaKl7hLOllsB
CSDMAZOnTjC3U/dDxGkAV53ijSLdhwZAAIEJzs4bg7/fzTtxRuLWZscFs3YnFo97
nh6Vfe63SKMI2tavegw5BmV/Sl0fvBf4q77uKNd0f3p4mVmFaG5cIzJLv07A6Fpt
43C/dxC//AH2hdmoRBBYMql1GNXRor5H4idq9Joz+EkIYIvUX7Q6hL+hqkpMfT7P
T19sdl6gSzeRntwi5m3OFBqOasv+zbMUZBfHWymeMr/y7vrTC0LUq7dBMtoM1O/4
gdW7jVg/tRvoSSiicNoxBN33shbyTApOB6jtSj1etX+jkMOvJwIDAQABo2MwYTAO
BgNVHQ8BAf8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUA95QNVbR
TLtm8KPiGxvDl7I90VUwHwYDVR0jBBgwFoAUA95QNVbRTLtm8KPiGxvDl7I90VUw
DQYJKoZIhvcNAQEFBQADggEBAMucN6pIExIK+t1EnE9SsPTfrgT1eXkIoyQY/Esr
hMAtudXH/vTBH1jLuG2cenTnmCmrEbXjcKChzUyImZOMkXDiqw8cvpOp/2PV5Adg
06O/nVsJ8dWO41P0jmP6P6fbtGbfYmbW0W5BjfIttep3Sp+dWOIrWcBAI+0tKIJF
PnlUkiaY4IBIqDfv8NZ5YBberOgOzW6sRBc4L0na4UU+Krk2U886UAb3LujEV0ls
YSEY1QSteDwsOoBrp+uvFRTp2InBuThs4pFsiv9kuXclVzDAGySj4dzp30d8tbQk
CAUw7C29C79Fv1C5qfPrmAESrciIxpg0X40KPMbp1ZWVbd4wOTAeBggrBgEFBQcD
BAYIKwYBBQUHAwEGCCsGAQUFBwMDDBdEaWdpQ2VydCBHbG9iYWwgUm9vdCBDQQ==
-----END CERTIFICATE-----
</ncbi1>
      <ncbi2>-----BEGIN CERTIFICATE-----
MIIDxTCCAq2gAwIBAgIQAqxcJmoLQJuPC3nyrkYldzANBgkqhkiG9w0BAQUFADBs
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMSswKQYDVQQDEyJEaWdpQ2VydCBIaWdoIEFzc3VyYW5j
ZSBFViBSb290IENBMB4XDTA2MTExMDAwMDAwMFoXDTMxMTExMDAwMDAwMFowbDEL
MAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3
LmRpZ2ljZXJ0LmNvbTErMCkGA1UEAxMiRGlnaUNlcnQgSGlnaCBBc3N1cmFuY2Ug
RVYgUm9vdCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMbM5XPm
+9S75S0tMqbf5YE/yc0lSbZxKsPVlDRnogocsF9ppkCxxLeyj9CYpKlBWTrT3JTW
PNt0OKRKzE0lgvdKpVMSOO7zSW1xkX5jtqumX8OkhPhPYlG++MXs2ziS4wblCJEM
xChBVfvLWokVfnHoNb9Ncgk9vjo4UFt3MRuNs8ckRZqnrG0AFFoEt7oT61EKmEFB
Ik5lYYeBQVCmeVyJ3hlKV9Uu5l0cUyx+mM0aBhakaHPQNAQTXKFx01p8VdteZOE3
hzBWBOURtCmAEvF5OYiiAhF8J2a3iLd48soKqDirCmTCv2ZdlYTBoSUeh10aUAsg
EsxBu24LUTi4S8sCAwEAAaNjMGEwDgYDVR0PAQH/BAQDAgGGMA8GA1UdEwEB/wQF
MAMBAf8wHQYDVR0OBBYEFLE+w2kD+L9HAdSYJhoIAu9jZCvDMB8GA1UdIwQYMBaA
FLE+w2kD+L9HAdSYJhoIAu9jZCvDMA0GCSqGSIb3DQEBBQUAA4IBAQAcGgaX3Nec
nzyIZgYIVyHbIUf4KmeqvxgydkAQV8GK83rZEWWONfqe/EW1ntlMMUu4kehDLI6z
eM7b41N5cdblIZQB2lWHmiRk9opmzN6cN82oNLFpmyPInngiK3BD41VHMWEZ71jF
hS9OMPagMRYjyOfiZRYzy78aG6A9+MpeizGLYAiJLQwGXFK3xPkKmNEVX58Svnw2
Yzi9RKR/5CYrCsSXaQ3pjOLAEFe4yHYSkVXySGnYvCoCWw9E1CAx2/S6cCZdkGCe
vEsXCS+0yx5DaMkHJ8HSXPfqIbloEpw8nL+e/IBcm2PN7EeqJSdnoDfzAIJ9VNep
+OkuE6N36B9KMEQwHgYIKwYBBQUHAwQGCCsGAQUFBwMBBggrBgEFBQcDAwwiRGln
aUNlcnQgSGlnaCBBc3N1cmFuY2UgRVYgUm9vdCBDQQ==
-----END CERTIFICATE-----
</ncbi2>
    </ca.crt>
  </tls>
  <tools>
    <ascp>
      <max_rate>450m</max_rate>
    </ascp>
  </tools>
  <vdb>
    <lib>
      <paths>
        <kfg>/usr/local/bin</kfg>
      </paths>
    </lib>
    <schema>
      <version>2</version>
    </schema>
  </vdb>
</Config>

<ConfigurationFiles>
/usr/local/bin/ncbi/certs.kfg
/usr/local/bin/ncbi/default.kfg
</ConfigurationFiles>
<Environment>
</Environment>
</VdbConfig>
```


## sra-tools_prefetch

### Tool Description
Download SRA files and their dependencies

### Metadata
- **Docker Image**: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
- **Homepage**: https://github.com/ncbi/sra-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/sra-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  prefetch [options] <SRA accession> [...]
  Download SRA files and their dependencies

  prefetch [options] --perm <JWT cart file> <SRA accession> [...]
  Download SRA files and their dependencies from JWT cart

  prefetch [options] --cart <kart file>
  Download cart file

  prefetch [options] <URL> --output-file <FILE>
  Download URL to FILE

  prefetch [options] <URL> [...] --output-directory <DIRECTORY>
  Download URL or URL-s to DIRECTORY

  prefetch [options] <SRA file> [...]
  Check SRA file for missed dependencies and download them


Options:
  -T|--type <value>                Specify file type to download. Default: sra 
  -t|--transport <http|fasp|both>  Transport: one of: fasp; http; both 
                                   [default]. (fasp only; http only; first try 
                                   fasp (ascp), use http if cannot download 
                                   using fasp). 
  --location <value>               Location of data. 

  -N|--min-size <size>             Minimum file size to download in KB 
                                   (inclusive). 
  -X|--max-size <size>             Maximum file size to download in KB 
                                   (exclusive). Default: 20G 
  -f|--force <yes|no|all|ALL>      Force object download: one of: no, yes, 
                                   all, ALL. no [default]: skip download if the 
                                   object if found and complete; yes: download 
                                   it even if it is found and is complete; all: 
                                   ignore lock files (stale locks or it is 
                                   being downloaded by another process use 
                                   at your own risk!); ALL: ignore lock files, 
                                   restart download from beginning. 
  -r|--resume <yes|no>             Resume partial downloads: one of: no, yes 
                                   [default]. 
  -C|--verify <yes|no>             Verify after download: one of: no, yes 
                                   [default]. 
  -p|--progress                    Show progress. 
  -H|--heartbeat <value>           Time period in minutes to display download 
                                   progress. (0: no progress), default: 1 

  --eliminate-quals                Download SRA Lite files with simplified 
                                   base quality scores, or fail if not 
                                   available. 
  -c|--check-all                   Double-check all refseqs. 
  -S|--check-rs <yes|no|smart>     Check for refseqs in downloaded files: one 
                                   of: no, yes, smart [default]. Smart: skip 
                                   check for large encrypted non-sra files. 

  -l|--list                        List the content of kart file. 
  -n|--numbered-list               List the content of kart file with kart 
                                   row numbers. 
  -s|--list-sizes                  List the content of kart file with target 
                                   file sizes. 
  -o|--order <kart|size>           Kart prefetch order when downloading 
                                   kart: one of: kart, size. (in kart order, by 
                                   file size: smallest first), default: size. 
  -R|--rows <rows>                 Kart rows to download (default all). Row 
                                   list should be ordered. 
  --perm <PATH>                    PATH to jwt cart file. 
  --ngc <PATH>                     PATH to ngc file. 
  --cart <PATH>                    To read kart file. 

  -a|--ascp-path <ascp-binary|private-key-file>  Path to ascp program and 
                                   private key file (asperaweb_id_dsa.putty) 
  --ascp-options <value>           Arbitrary options to pass to ascp command 
                                   line. 

  -o|--output-file <FILE>          Write file to FILE when downloading 
                                   single file. 
  -O|--output-directory <DIRECTORY>  Save files to DIRECTORY/ 

  -h|--help                        Output brief explanation for the program. 
  -V|--version                     Display the version of the program then 
                                   quit. 
  -L|--log-level <level>           Logging level as number or enum string. One 
                                   of (fatal|sys|int|err|warn|info|debug) or 
                                   (0-6) Current/default is warn. 
  -v|--verbose                     Increase the verbosity of the program 
                                   status messages. Use multiple times for more 
                                   verbosity. Negates quiet. 
  -q|--quiet                       Turn off all status messages for the 
                                   program. Negated by verbose. 
  --option-file <file>             Read more options and parameters from the 
                                   file. 

prefetch : 3.2.1
```


## sra-tools_fasterq-dump

### Tool Description
Dump SRA data in FASTQ format

### Metadata
- **Docker Image**: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
- **Homepage**: https://github.com/ncbi/sra-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/sra-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  fasterq-dump <path> [options]
  fasterq-dump <accession> [options]

Options:
  -F|--format                      format (special, fastq, default=fastq) 
  -o|--outfile                     output-file 
  -O|--outdir                      output-dir 
  -b|--bufsize                     size of file-buffer dflt=1MB 
  -c|--curcache                    size of cursor-cache dflt=10MB 
  -m|--mem                         memory limit for sorting dflt=100MB 
  -t|--temp                        where to put temp. files dflt=curr dir 
  -e|--threads                     how many thread dflt=6 
  -p|--progress                    show progress 
  -x|--details                     print details 
  -s|--split-spot                  split spots into reads 
  -S|--split-files                 write reads into different files 
  -3|--split-3                     writes single reads in special file 
  --concatenate-reads              writes whole spots into one file 
  -Z|--stdout                      print output to stdout 
  -f|--force                       force to overwrite existing file(s) 
  --skip-technical                 skip technical reads 
  --include-technical              include technical reads 
  -M|--min-read-len                filter by sequence-len 
  --table                          which seq-table to use in case of pacbio 
  -B|--bases                       filter by bases 
  -A|--append                      append to output-file 
  --fasta                          produce FASTA output 
  --fasta-unsorted                 produce FASTA output, unsorted 
  --fasta-ref-tbl                  produce FASTA output from REFERENCE tbl 
  --fasta-concat-all               concatenate all rows and produce FASTA 
  --internal-ref                   extract only internal REFERENCEs 
  --external-ref                   extract only external REFERENCEs 
  --ref-name                       extract only these REFERENCEs 
  --ref-report                     enumerate references 
  --use-name                       print name instead of seq-id 
  --seq-defline                    custom defline for sequence:  $ac=accession, 
                                   $sn=spot-name,  $sg=spot-group, $si=spot-id,  
                                   $ri=read-id, $rl=read-length 
  --qual-defline                   custom defline for qualities:  same as 
                                   seq-defline 
  -U|--only-unaligned              process only unaligned reads 
  -a|--only-aligned                process only aligned reads 
  --disk-limit                     explicitly set disk-limit 
  --disk-limit-tmp                 explicitly set disk-limit for temp. files 
  --size-check                     switch to control: on=perform size-check 
                                   (default),  off=do not perform size-check,  
                                   only=perform size-check only 
  --ngc <PATH>                     PATH to ngc file 

  -h|--help                        Output brief explanation for the program. 
  -V|--version                     Display the version of the program then 
                                   quit. 
  -L|--log-level <level>           Logging level as number or enum string. One 
                                   of (fatal|sys|int|err|warn|info|debug) or 
                                   (0-6) Current/default is warn. 
  -v|--verbose                     Increase the verbosity of the program 
                                   status messages. Use multiple times for more 
                                   verbosity. Negates quiet. 
  -q|--quiet                       Turn off all status messages for the 
                                   program. Negated by verbose. 
  --option-file <file>             Read more options and parameters from the 
                                   file. 
for more information visit:
   https://github.com/ncbi/sra-tools/wiki/HowTo:-fasterq-dump
   https://github.com/ncbi/sra-tools/wiki/08.-prefetch-and-fasterq-dump

fasterq-dump : 3.2.1
```


## sra-tools_vdb-validate

### Tool Description
Examine directories, files and VDB objects, reporting any problems that can be detected.

### Metadata
- **Docker Image**: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
- **Homepage**: https://github.com/ncbi/sra-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/sra-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vdb-validate [options] path [ path... ]

  Examine directories, files and VDB objects,
  reporting any problems that can be detected.

Components md5s are always checked if present.

Options:
  -B|--BLOB-CRC <yes | no>         Check blobs CRC32 (default: no) 
  -I|--REFERENTIAL-INTEGRITY <yes | no>  Check data referential integrity for 
                                   databases (default: yes) 
  -C|--CONSISTENCY-CHECK <yes | no>  Deeply check data consistency for tables 
                                   (default: no) 
  -x|--exhaustive                  Continue checking object for all possible 
                                   errors (default: false) 
  --sdc:rows <rows>                Specify maximum amount of secondary 
                                   alignment table rows to look at before 
                                   saying accession is good, default 100000. 
                                   Specifying will iterate the whole table. 
                                   Can be in percent (e.g. 5%) 
  --sdc:seq-rows <rows>            Specify maximum amount of sequence table 
                                   rows to look at before saying accession is 
                                   good, default 100000. Specifying will 
                                   iterate the whole table. Can be in percent 
                                   (e.g. 5%) 
  --sdc:plen_thold <threshold>     Specify threshold for amount of secondary 
                                   alignment which are shorter (hard-clipped) 
                                   than corresponding primaries, default 1%. 
  --ngc <path>                     path to ngc file 
  --check-redact                   check if redaction of bases has been 
                                   correctly performed (default: false) 
  --require-blob-checksums         Require blob checksums (default: no) 

  -h|--help                        Output brief explanation for the program. 
  -V|--version                     Display the version of the program then 
                                   quit. 
  -L|--log-level <level>           Logging level as number or enum string. One 
                                   of (fatal|sys|int|err|warn|info|debug) or 
                                   (0-6) Current/default is warn. 
  -v|--verbose                     Increase the verbosity of the program 
                                   status messages. Use multiple times for more 
                                   verbosity. Negates quiet. 
  -q|--quiet                       Turn off all status messages for the 
                                   program. Negated by verbose. 
  --option-file <file>             Read more options and parameters from the 
                                   file. 

vdb-validate : 3.2.1
```


## sra-tools_sra-stat

### Tool Description
Display table statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
- **Homepage**: https://github.com/ncbi/sra-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/sra-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  sra-stat [options] table

Summary:
  Display table statistics

Options:
  -x|--xml                         Output as XML, default is text. 
  -b|--start <row-id>              Starting spot id, default is 1. 
  -e|--stop <row-id>               Ending spot id, default is max. 
  -m|--meta                        Print load metadata. 
  -q|--quick                       Quick mode: get statistics from metadata; do 
                                   not scan the table. 
  --member-stats <on | off>        Print member stats, default is on. 
  --archive-info                   Output archive info, default is off. 
  -s|--statistics                  Calculate READ_LEN average and standard 
                                   deviation. 
  -a|--alignment <on | off>        Print alignment info, default is on. 
  -l|--local-info                  Print the date, path, size and md5 of local 
                                   run. 
  -p|--show_progress               Show the percentage of completion. 
  --ngc <path>                     Path to ngc file. 
  -z|--xml-log <logfile>           Produce XML-formatted log file. 
  --repair-data                    Generate data for repair tool. 
  --info                           Print report for all fields examined for 
                                   mismatch even if the old value is correct. 

  -h|--help                        Output brief explanation for the program. 
  -V|--version                     Display the version of the program then 
                                   quit. 
  -L|--log-level <level>           Logging level as number or enum string. One 
                                   of (fatal|sys|int|err|warn|info|debug) or 
                                   (0-6) Current/default is warn. 
  -v|--verbose                     Increase the verbosity of the program 
                                   status messages. Use multiple times for more 
                                   verbosity. Negates quiet. 
  -q|--quiet                       Turn off all status messages for the 
                                   program. Negated by verbose. 
  --option-file <file>             Read more options and parameters from the 
                                   file. 

sra-stat : 3.2.1
```


## Metadata
- **Skill**: generated

# short-read-connector CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| short-read-connector_short_read_connector_counter.sh_index | PASS |  |
| short-read-connector_short_read_connector_counter.sh_query | PASS |  |
| short-read-connector_short_read_connector_linker.sh_index | PASS |  |
| short-read-connector_short_read_connector_linker.sh_query | PASS |  |

## short-read-connector_short_read_connector_counter.sh_index

### Tool Description
Index a read file (short_read_connector counter mode).

### Metadata
- **Docker Image**: quay.io/biocontainers/short-read-connector:1.2.0--h5ca1c30_3
- **Homepage**: https://github.com/GATB/short_read_connector
- **Package**: https://anaconda.org/channels/bioconda/packages/short-read-connector/overview
- **Validation**: PASS

### Original Help Text
```text
short_read_connector_counter.sh index - Index a read file
Usage: sh short_read_connector_counter.sh index -b read_file -i dumped_index_name [OPTIONS]
   -b read_files for bank
     Example: -b data/c1.fasta.gz
   -i <string>. File of the index file to be created. Example "my_index.dumped"
   -k <int> value (<32). Set the length of used kmers. Must fit the compiled value. Default=31
   -f <int> value. Fingerprint size. Size of the key associated to each indexed value, limiting false positives. Default=12
   -G <int> value. gamma value. MPHF expert users parameter - Default=2
   -a <int> kmer_abundance_min (kmer from bank seen less than this value both in the bank are not indexed). Default=2
   -l Keep low complexity regions (default false)
   -t <int> number of thread used. Default=0 (all)
```

## short-read-connector_short_read_connector_counter.sh_query

### Tool Description
Query an index with a file of read files (short_read_connector counter mode).

### Metadata
- **Docker Image**: quay.io/biocontainers/short-read-connector:1.2.0--h5ca1c30_3
- **Homepage**: https://github.com/GATB/short_read_connector
- **Package**: https://anaconda.org/channels/bioconda/packages/short-read-connector/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sh short_read_connector_counter.sh query -i indexed_file -q read_file_of_files [OPTIONS]
MANDATORY:
 -i index created by short_read_connector_counter.sh index (read only)
   Example: -i my_index.dumped
 -q read_file_of_files for query
   Example: -q data/fof.txt (with fof being a file of file descriptor)
OPTIONS:
   -w <int> window_size. See option -s. If the windows size is zero (default value), then the full read is considered. Default=0
   -s <int> kmer_threshold: Minimal percentage of shared kmer span for considering a query read as similar to a data set.  
            The kmer span is the number of bases from the read query covered by a kmer shared with the bank.
   -l Keep low complexity regions (default false)
            If a read of length 80 has a kmer-span of 60, then the percentage of shared kmer span is 75%. If a least a windows (of size "windows_size") contains at least kmer_threshold percent of positions covered by shared kmers, the read is output.
   -p <string> prefix. All out files will start with this prefix. Default="short_read_connector_res"
   -t <int> number of thread used. Default=0 (all)
```

## short-read-connector_short_read_connector_linker.sh_index

### Tool Description
Index a read file (short_read_connector linker mode).

### Metadata
- **Docker Image**: quay.io/biocontainers/short-read-connector:1.2.0--h5ca1c30_3
- **Homepage**: https://github.com/GATB/short_read_connector
- **Package**: https://anaconda.org/channels/bioconda/packages/short-read-connector/overview
- **Validation**: PASS

### Original Help Text
```text
short_read_connector_linker.sh index - Index a read file
Usage: sh short_read_connector_linker.sh index -b read_file  -i dumped_index_name [OPTIONS]
   -b read_files for bank
     Example: -b data/c1.fasta.gz
   -i <string>. File of the index file to be created. Example "my_index.dumped"
   -k <int> value (<32). Set the length of used kmers. Must fit the compiled value. Default=31
   -f <int> value. Fingerprint size. Size of the key associated to each indexed value, limiting false positives. Default=12
   -G <int> value. gamma value. MPHF expert users parameter - Default=2
   -a <int> kmer_abundance_min (kmer from bank seen less than this value both in the bank are not indexed). Default=2
   -l Keep low complexity regions (default false)
   -t <int> number of thread used. Default=0 (all)
```

## short-read-connector_short_read_connector_linker.sh_query

### Tool Description
Query an index with a file of read files (short_read_connector linker mode).

### Metadata
- **Docker Image**: quay.io/biocontainers/short-read-connector:1.2.0--h5ca1c30_3
- **Homepage**: https://github.com/GATB/short_read_connector
- **Package**: https://anaconda.org/channels/bioconda/packages/short-read-connector/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sh short_read_connector_linker.sh query -i indexed_file -q read_file_of_files [OPTIONS]
MANDATORY:
 -i index created by short_read_connector_linker.sh index (read only)
   Example: -i my_index.dumped
 -q read_file_of_files for query
   Example: -q data/fof.txt (with fof being a file of file descriptor)
OPTIONS:
   -w <int> window_size. See option -s. If the windows size is zero (default value), then the full read is considered. Default=0
   -s <int> kmer_threshold: Minimal percentage of shared kmer span for considering 2 reads as similar.  
            The kmer span is the number of bases from the read query covered by a kmer shared with the target read.
            If a read of length 80 has a kmer-span of 60 with another read (of unkonwn size) from the bank, then the percentage of shared kmer span is 75%. If a least a windows (of size "windows_size") contains at least kmer_threshold percent of position covered by shared kmers, the read couple is output.
                 TRICK: with kmer_threshold<=0 a single kmer is sufficient in the linker mode to link two reads. 
   -l Keep low complexity regions (default false)
   -p <string> prefix. All out files will start with this prefix. Default="short_read_connector_res"
   -t <int> number of thread used. Default=0 (all)
   -r do not output precision about pair of similar reads. Only ids of reads from queries similar to at least one read from bank are output.
```

## Metadata
- **Skill**: generated

# cdbtools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cdbtools_cdbfasta | PASS |  |
| cdbtools_cdbyank | PASS |  |

## cdbtools_cdbfasta

### Tool Description
Creates an index file for records from a multi-fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdbtools:0.99--h077b44d_12
- **Homepage**: https://github.com/gpertea/cdbfasta
- **Package**: https://anaconda.org/channels/bioconda/packages/cdbtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  cdbfasta <fastafile> [-o <index_file>] [-r <record_delimiter>]
   [-z <compressed_db>] [-i] [-m|-n <numkeys>|-f<LIST>]|-c|-C]
    [-w <stopwords_list>] [-s <stripendchars>] [-v]
   
   Creates an index file for records from a multi-fasta file.
   By default (without -m/-n/-c/-C option), only the first 
   space-delimited token from the defline is used as a key.
  
   <fastafile> is the multi-fasta file to index; 
   -o the index file will be named <index_file>; if not given,
      the index filename is database name plus the suffix '.cidx'
   -r <record_delimiter> a string of characters at the beginning of line
      marking the start of a record (default: '>')
   -Q treat input as fastq format, i.e. with '@' as record delimiter
      and with records expected to have at least 4 lines
   -z database is compressed into the file <compressed_db>
      before indexing (<fastafile> can be "-" or "stdin" 
      in order to get the input records from stdin)
   -s strip extraneous characters from *around* the space delimited
      tokens, for the multikey options below (-m,-n,-f);
      Default <stripendchars> set is: '",`.(){}/[]!:;~|><+-
   -m ("multi-key" option) create hash entries pointing to 
      the same record for all tokens found in
      the defline
   -n <numkeys> same as -m, but only takes the first <numkeys>
      tokens from the defline
   -f indexes *space* delimited tokens (fields) in the defline as given
      by LIST of fields or fields ranges (the same syntax as UNIX 'cut')
   -w <stopwordslist> exclude from indexing all the words found
      in the file <stopwordslist> (for options -m, -n and -k)
   -i do case insensitive indexing (i.e. create additional keys for 
      all-lowercase tokens used for indexing from the defline 
   -c for deflines in the format: db1|accession1|db2|accession2|...,
      only the first db-accession pair ('db1|accession1') is taken as key
   -C like -c, but also subsequent db|accession constructs are indexed,
      along with the full (default) token; additionally,
      all nrdb concatenated accessions found in the defline 
      are parsed and stored (assuming 0x01 or '^|^' as separators)
   -a accession mode: like -C option, but indexes the 'accession'
      part for all 'db|accession' constructs found
   -A like -a and -C together (both accessions and 'db|accession'
      constructs are used as keys
   -v show program version and exit
 Invalid argument: -h
```

## cdbtools_cdbyank

### Tool Description
Retrieves fasta records from a multi-fasta file using an index created with cdbfasta.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdbtools:0.99--h077b44d_12
- **Homepage**: https://github.com/gpertea/cdbfasta
- **Package**: https://anaconda.org/channels/bioconda/packages/cdbtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  cdbyank <index_file> [-d <fasta_file>] [-a <key>|-n|-l|-s]
      [-o <outfile>] [-q <char>|-Q][-F] [-R] [-P] [-x] [-w] 
      [-z <dbfasta.cdbz>

    <index_file> is the index file created previously with cdbfasta
       (usually having a ".cidx" suffix)
    -a <key> the sequence name (accession) for a fasta record to be
       retrieved; if not given, a list of accessions is expected
       at stdin
    -d <fasta_file> is the fasta file to pull records from; 
       if not specified, cdbyank will look in the same directory
       where <index_file> resides, for a file with the same name
       but without the ".cidx" suffix
    -o the records found are written to file <outfile> instead of stdout
    -x allows retrieval of multiple records per key, if the indexed 
       database had records with the same key (non-unique keys);
       (without -x only one record for a given key is retrieved)
    -i case insensitive query (expects the <index_file> to have been 
       created with cdbfasta -i option)
    -Q output the query key surrounded by character '%' before the
       corresponding record
    -q same as -Q but use character <char> instead of '%'
    -w enable warnings (sent to stderr) when a key is not found
    -F pulls only the defline for each record (discard the sequence)
    -P only displays the position(s) (file offset) within the 
       database file, for the requested record(s)
    -R sequence range extraction: expects the input <key(s)> to have 
       the format: '<seq_name> <start> <end>'
       and pulls only the specified sequence range
    -z decompress the entire file <dbfasta.cdbz>
       (assumes it was built using cdbfasta with '-z' option)
    -v show version number and exit
    
    Index file statistics (no database file needed):
    -n display the number of records indexed
    -l list all keys stored in <index_file>
    -s display indexing summary info

 Invalid argument: -h
```

## Metadata
- **Skill**: generated


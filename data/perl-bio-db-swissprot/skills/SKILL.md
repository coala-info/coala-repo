---
name: perl-bio-db-swissprot
description: This tool provides programmatic access to the UniProtKB/SwissProt database using the BioPerl interface to retrieve protein sequences and annotations. Use when user asks to fetch protein sequences by accession number, perform batch retrieval of SwissProt records, or parse UniProt data into BioPerl objects.
homepage: https://metacpan.org/release/Bio-DB-SwissProt
metadata:
  docker_image: "quay.io/biocontainers/perl-bio-db-swissprot:1.7.4--pl5321hdfd78af_0"
---

# perl-bio-db-swissprot

## Overview
This skill provides guidance on using the `Bio::DB::SwissProt` Perl module to programmatically access the UniProtKB/SwissProt database. It is primarily used by bioinformaticians to retrieve high-quality, manually annotated protein sequences. The tool handles the complexities of HTTP requests to UniProt servers and parses the resulting data into BioPerl objects for further analysis.

## Usage Patterns

### Basic Sequence Retrieval
To fetch a single protein sequence by its accession number, use the following Perl pattern:

```perl
use Bio::DB::SwissProt;

my $db = Bio::DB::SwissProt->new();

# Get a sequence object by accession
my $seq = $db->get_Seq_by_acc('P12345');

print "Display ID: ", $seq->display_id, "\n";
print "Sequence: ", $seq->seq, "\n";
```

### Batch Retrieval
For multiple sequences, it is more efficient to use a `SeqStream` to iterate through results:

```perl
my $stream = $db->get_Stream_by_acc(['P12345', 'Q98765', 'P54321']);

while (my $seq = $stream->next_seq) {
    print "Fetched: ", $seq->accession_number, " - ", $seq->desc, "\n";
}
```

### Configuring the Connection
By default, the module connects to the main UniProt server. You can specify different mirrors or change the retrieval mode (e.g., using the 'swiss' format for full records):

- **Server Selection**: Use `-server => 'http://www.expasy.org'` to point to specific mirrors.
- **Format**: Use `-retrievaltype => 'tempfile'` for very large datasets to save memory.

## Best Practices
- **Error Handling**: Always check if the sequence object is defined after a request, as network timeouts or invalid IDs will return `undef`.
- **Rate Limiting**: When performing bulk downloads, implement a small delay between requests to avoid being throttled by UniProt servers.
- **Object Methods**: Once retrieved, the object is a standard `Bio::Seq` object. Use `$seq->annotation` to access SwissProt-specific features like post-translational modifications or subcellular location.

## Reference documentation
- [Bio-DB-SwissProt Documentation](./references/metacpan_org_release_Bio-DB-SwissProt.md)
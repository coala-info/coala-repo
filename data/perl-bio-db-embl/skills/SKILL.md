---
name: perl-bio-db-embl
description: This tool provides a programmatic interface for querying and retrieving sequence records from the EMBL database using Perl. Use when user asks to retrieve sequences by accession number, fetch genomic data from the European Nucleotide Archive, or perform batch sequence downloads within a Perl script.
homepage: https://metacpan.org/release/Bio-DB-EMBL
metadata:
  docker_image: "quay.io/biocontainers/perl-bio-db-embl:1.7.4--pl5321hdfd78af_0"
---

# perl-bio-db-embl

## Overview
The `perl-bio-db-embl` tool provides a programmatic way to interact with the EMBL sequence database. It is primarily used within Perl scripts to query the database by accession number or display ID and retrieve full sequence records. This is essential for bioinformatics workflows that require up-to-date genomic or transcriptomic data directly from the European Nucleotide Archive (ENA) servers.

## Usage Patterns

### Basic Sequence Retrieval
To use this module, you must initialize a `Bio::DB::EMBL` object. By default, it connects to the remote EMBL database via the web.

```perl
use Bio::DB::EMBL;

my $db = Bio::DB::EMBL->new();

# Get a sequence by its accession number
my $seq = $db->get_Seq_by_acc('J02231');

# Print sequence details
print "Accession: ", $seq->accession_number, "\n";
print "Sequence: ", $seq->seq, "\n";
```

### Batch Retrieval
For multiple sequences, use a `SeqStream` to manage memory efficiently and handle multiple records.

```perl
my @ids = ('J02231', 'X00001');
my $stream = $db->get_Stream_by_acc(\@ids);

while (my $seq = $stream->next_seq) {
    print "ID: ", $seq->display_id, " Length: ", $seq->length, "\n";
}
```

### Configuration Options
When initializing the database object, you can specify the retrieval format and the specific database (e.g., 'embl' or 'swall').

- `-retrieval`: Set to 'web' (default) for remote access.
- `-format`: Set the return format, such as 'fasta' or 'embl'.

```perl
my $db = Bio::DB::EMBL->new(
    -retrieval => 'web',
    -format    => 'fasta'
);
```

## Best Practices
- **Error Handling**: Always check if the returned sequence object is defined, as network timeouts or invalid IDs will return `undef`.
- **Rate Limiting**: When performing large batch downloads, implement a small delay between requests to avoid being throttled by the EBI/EMBL servers.
- **Bio::Seq Methods**: Once a sequence is retrieved, it is a standard `Bio::Seq` object. You can use all standard BioPerl methods like `$seq->revcom()` for reverse complement or `$seq->translate()` for protein translation.

## Reference documentation
- [Bio-DB-EMBL Documentation](./references/metacpan_org_release_Bio-DB-EMBL.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-db-embl_overview.md)
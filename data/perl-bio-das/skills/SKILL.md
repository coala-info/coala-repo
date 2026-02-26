---
name: perl-bio-das
description: This tool provides a programmatic interface for querying and retrieving genomic sequences and annotations from Distributed Annotation System (DAS) servers. Use when user asks to access genomic data from DAS sources, retrieve biological features like genes or SNPs, or fetch raw DNA sequences from remote databases.
homepage: http://metacpan.org/pod/Bio::Das
---


# perl-bio-das

## Overview
This skill enables programmatic access to genomic sequencing and annotation data hosted on DAS servers. It provides a high-level interface for querying biological segments (like chromosomes or specific coordinates) and retrieving their associated features (genes, transcripts, SNPs) and raw DNA sequences. It is particularly useful for integrating data from multiple distributed sources like WormBase or other genome browsers that export data in DAS format.

## Usage Patterns

### Serial API (Simple Scripts)
Use the serial API when working with a single data source where performance is not the primary concern.

```perl
use Bio::Das;

# Initialize connection to a specific source
my $das = Bio::Das->new(
    -source      => 'http://www.wormbase.org/db/das',
    -dsn         => 'elegans',
    -aggregators => ['primary_transcript', 'clone']
);

# Define a genomic segment (e.g., Chromosome 1)
my $segment = $das->segment('Chr1');

# Retrieve DNA sequence
my $dna = $segment->dna;

# Retrieve features within the segment
my @features = $segment->features;
for my $f (@features) {
    print join("\t", $f->type, $f->start, $f->end, $f->score), "\n";
}
```

### Parallel API (High Performance)
Use the parallel API to query multiple servers or multiple segments simultaneously.

```perl
# Initialize with a 5-second timeout
my $das = Bio::Das->new(5);

# Request features from multiple DSNs and segments at once
my @requests = $das->features(
    -dsn     => ['http://server1.org/das/db1', 'http://server2.org/das/db2'],
    -segment => ['I:1,10000', 'II:20000,30000']
);

# Process results as they return
for my $req (@requests) {
    if ($req->is_success) {
        my $results = $req->results;
        # $results is a hash ref keyed by segment name
    } else {
        warn "Error from " . $req->dsn . ": " . $req->error;
    }
}
```

### Callback Pattern
For memory-efficient processing of large feature sets, use the callback mechanism to handle features as they are parsed.

```perl
$das->features(
    -dsn      => 'http://www.wormbase.org/db/das/elegans',
    -segment  => 'I:1,10000',
    -callback => sub {
        my $feature = shift;
        print "Found feature: ", $feature->display_name, " at ", $feature->start, "\n";
    }
);
```

## Expert Tips
- **Aggregators**: Use aggregators to group raw DAS features into higher-level biological objects (e.g., grouping exons into a transcript). The syntax is compatible with `Bio::DB::GFF`.
- **SSL Support**: To access `https://` DAS servers, ensure `IO::Socket::SSL` and `Net::SSLeay` are installed in your Perl environment.
- **Proxies**: If working behind a firewall, initialize the object with the `-proxy` argument: `Bio::Das->new(-source => $url, -proxy => 'http://proxy.example.com:8080')`.
- **Timeouts**: In parallel mode, set a fractional timeout (e.g., `1.5`) to prevent slow remote servers from hanging your script.

## Reference documentation
- [Bio::Das - Interface to Distributed Annotation System](./references/metacpan_org_pod_Bio__Das.md)
- [perl-bio-das Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-das_overview.md)
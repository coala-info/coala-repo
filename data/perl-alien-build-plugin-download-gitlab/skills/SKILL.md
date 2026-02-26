---
name: perl-alien-build-plugin-download-gitlab
description: This tool configures the Alien::Build system to download software assets or source code from GitLab repositories using the GitLab API. Use when user asks to download files from GitLab in an alienfile, configure GitLab asset filtering, or map GitLab tags to software versions.
homepage: https://metacpan.org/pod/Alien::Build::Plugin::Download::GitLab
---


# perl-alien-build-plugin-download-gitlab

## Overview
This skill provides guidance on configuring the `Alien::Build::Plugin::Download::GitLab` plugin within an `alienfile`. It enables Perl's `Alien::Build` system to interface with the GitLab API to identify and download specific versions of software, handling tasks like tag-to-version mapping and asset filtering.

## Usage Patterns

### Basic Configuration
To download the latest tag from a project on gitlab.com:

```perl
use alienfile;

plugin 'Download::GitLab' => (
  gitlab_user    => 'username',
  gitlab_project => 'project-name',
);
```

### Self-Hosted GitLab Instances
If the project is hosted on a private or corporate GitLab instance, specify the `gitlab_host`:

```perl
plugin 'Download::GitLab' => (
  gitlab_host    => 'https://gitlab.example.com',
  gitlab_user    => 'org-name',
  gitlab_project => 'repo-name',
);
```

### Version Handling and Conversion
By default, the plugin uses the `tag_name`. If the tags include a prefix (like `v1.0.0`), use `convert_version` to normalize it for Perl:

```perl
plugin 'Download::GitLab' => (
  gitlab_user     => 'plicease',
  gitlab_project  => 'dontpanic',
  version_from    => 'tag_name', # default
  convert_version => sub {
    my $version = shift;
    $version =~ s/^v//;
    return $version;
  },
);
```

### Selecting Asset Types
You can choose between downloading the source code or a specific uploaded link/binary:

- **Source (Default):** Downloads the source archive (tar.gz, zip, etc.).
- **Link:** Downloads a specific file attached to a release.

```perl
plugin 'Download::GitLab' => (
  gitlab_user    => 'plicease',
  gitlab_project => 'dontpanic',
  type           => 'link',
  link_name      => qr/\.tar\.gz$/, # Filter for specific extensions
);
```

## Best Practices
- **Format Specification:** While the default is `tar.gz`, ensure `Alien::Build::Plugin::Extract::Negotiate` is available to handle the archive format returned by GitLab.
- **Version Source:** If the GitLab release "name" differs from the "tag_name", toggle `version_from` between `name` and `tag_name` to ensure the Alien distribution records the correct version string.
- **Dependency Management:** Ensure `JSON::PP`, `Path::Tiny`, and `URI` are available in the build environment, as the plugin relies on these for API communication and path handling.

## Reference documentation
- [Alien::Build::Plugin::Download::GitLab - Metacpan](./references/metacpan_org_pod_Alien__Build__Plugin__Download__GitLab.md)
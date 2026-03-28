[ ]
[ ]

[![logo](../img/little_logo.svg)](.. "Nomadic")

Nomadic

FAQ

Initializing search

[GitHub](https://github.com/JasonAHendry/nomadic.git "Go to repository")

[![logo](../img/little_logo.svg)](.. "Nomadic")
Nomadic

[GitHub](https://github.com/JasonAHendry/nomadic.git "Go to repository")

* [Overview](..)
* [Installation](../installation/)
* [ ]

  Usage

  Usage
  + [Quick Start](../quick_start/)
  + [Basic Usage](../basic/)
  + [Sharing and Backing up](../share_backup/)
  + [Advanced Usage](../advanced/)
* [Understanding the Dashboard](../understand/)
* [Output Files](../output_files/)
* [ ]
  [FAQ](./)

# FAQ

**Can I stop and restart `nomadic realtime`?**

Yes, you can safely stop and restart `nomadic realtime`. The program keeps track of what FASTQ files have been processed, and will continue processing from where it left off.

**Can I run more than one instance of `nomadic` at once?**

Yes, just ensure you are not running nomadic multiple times using the same output folder, as those will interfere.
For `nomadic dashboard` or `nomadic realtime`, the dashboard will be opened using a free port.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
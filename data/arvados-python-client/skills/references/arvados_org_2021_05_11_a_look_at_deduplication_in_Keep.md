* [Skip to primary navigation](#nav-primary)
* [Skip to main content](#main)
* [Skip to footer](#site-footer)

* [Home](/)
* About
  + [Technology](/technology)
  + [Regulatory Compliance](/compliance)
  + [Standards](/standards)
  + [Releases](/releases)
* Development
  + [Developer Site](https://dev.arvados.org/)
  + [GitHub](https://github.com/arvados/arvados)
* [Community](/community)
* [Documentation](https://doc.arvados.org/)
* [Blog](/blog)

[![Arvados Logo](/images/arvados/logo.png)](/)

[![Arvados Logo](/images/arvados/logo.png)](/)

* [Home](/)
* About
  + [Technology](/technology)
  + [Regulatory Compliance](/compliance)
  + [Standards](/standards)
  + [Releases](/releases)
* Development
  + [Developer Site](https://dev.arvados.org/)
  + [GitHub](https://github.com/arvados/arvados)
* [Community](/community)
* [Documentation](https://doc.arvados.org/)
* [Blog](/blog)

# [A Look At Deduplication In Keep](/2021/05/11/a_look_at_deduplication_in_Keep/)

May 11, 2021
• by

[Ward Vandewege](/authors/wardv/)

## What is Keep?

Keep is the [Arvados](https://arvados.org) storage layer. All data in Arvados is stored in Keep.

Keep can be mounted as a regular filesystem on GNU/Linux via FUSE. It can also be accessed via HTTP, WebDAV, an S3-compatible interface, cli tools, and programmatically via the Arvados SDKs.

Keep is implemented as a content-addressed distributed storage system, backed by object storage (e.g. an S3-compatible object store) or POSIX file systems. Content addressing means that the data in Keep is referenced by a cryptographic hash of its contents. Content addressing provides a number of benefits which are described in more detail in the [Introduction to Keep](https://doc.arvados.org/architecture/storage.html).

Keep is a system with two layers: `collections` refer to a group of files and/or directories, and `blocks` contain the contents of those files and directories. In Arvados, users and programs interface only with collections; blocks are how those collections store their contents, but they are not directly accessible to the Arvados user.

Collections have a manifest, which can be thought of as an index that describes the content of the collection: the list of files and directories it contains. It is implemented as a list of paths, each of which is accompanied by a list of hashes of blocks stored in Keep.

Collections and their manifests are stored in the Arvados API. Collections have a UUID and a `portable data hash`, which is the hash of its manifest. Keep blocks are stored by the `keepstore` daemons.

The Keep architecture is described in more detail in the [documentation](https://doc.arvados.org/architecture/storage.html).

## Keep benefits: deduplication

Keep relies on content addressing to provide automatic, built-in data deduplication at the block level. This section shows how the deduplication works through an example. It also illustrates how the effectiveness of the deduplication can be measured.

As an experiment, we start by creating a new collection that contains 2 text files:

```
$ ls -lF

-rw-r--r--  1 ward ward     6 Jan 12 11:11 hello.txt

-rw-r--r--  1 ward ward     7 Jan 12 11:11 world.txt

$ cat *txt

hello

world!

$ arv-put *txt

0M / 0M 100.0% 2021-01-12 11:18:19 arvados.arv_put[1225347] INFO:

2021-01-12 11:18:19 arvados.arv_put[1225347] INFO: Collection saved as 'Saved at 2021-01-12 16:18:18 UTC by ward@countzero'

pirca-4zz18-46zcwbae8mkesob
```

The `arv-put` command returned the collection UUID `pirca-4zz18-46zcwbae8mkesob`. Let’s have a look at that collection object:

```
$ arv get pirca-4zz18-46zcwbae8mkesob

{

"created_at":"2021-01-12T16:18:19.313898000Z",

"current_version_uuid":"pirca-4zz18-46zcwbae8mkesob",

"delete_at":null,

"description":"",

"etag":"d7bwp7ib9d7e96r2esi96cdj6",

"file_count":2,

"file_size_total":13,

"is_trashed":false,

"kind":"arvados#collection",

"manifest_text":". 77fc3b646b70c5118ce358a9ef76b3b1+13+Ab4c280ce1400d0e94748522f3353fb8a4e76aaf0@60104148 0:6:hello.txt 6:7:world.txt\n",

"modified_at":"2021-01-12T16:18:19.315181000Z",

"modified_by_client_uuid":"",

"modified_by_user_uuid":"jutro-tpzed-9z6foyez9ydn2hl",

"name":"Saved at 2021-01-12 16:18:18 UTC by ward@countzero",

"owner_uuid":"jutro-tpzed-9z6foyez9ydn2hl",

"portable_data_hash":"291b1248abb8a975292ccd509a82ba7d+66",

"preserve_version":false,

"properties":{},

"replication_confirmed":null,

"replication_confirmed_at":null,

"replication_desired":null,

"storage_classes_confirmed":[],

"storage_classes_confirmed_at":null,

"storage_classes_desired":[

"default"

],

"trash_at":null,

"unsigned_manifest_text":"",

"uuid":"pirca-4zz18-46zcwbae8mkesob",

"version":1

}
```

The “manifest\_text” field contains the collection manifest:

```
. 77fc3b646b70c5118ce358a9ef76b3b1+13+Ab4c280ce1400d0e94748522f3353fb8a4e76aaf0@60104148 0:6:hello.txt 6:7:world.txt\n
```

The contents of the 2 files were combined in 1 block with hash 77fc3b646b70c5118ce358a9ef76b3b1 and size 13 bytes. The remainder of the block locator is the permission signature, which can be ignore in the context of this discussion. The filenames are preceded by the start position in the block, and their size. The manifest format is explained in greater detail in [the manifest format documentation](https://doc.arvados.org/architecture/manifest-format.html).

What would happen if we change one of the files and then create a new collection with the 2 files? For this example, I’ve uppercased the contents of the ‘hello.txt’ file.

```
$ cat *txt

HELLO

world!

$ arv-put *txt

0M / 0M 100.0% 2021-01-12 11:22:55 arvados.arv_put[1226188] INFO:

2021-01-12 11:22:55 arvados.arv_put[1226188] INFO: Collection saved as 'Saved at 2021-01-12 16:22:54 UTC by ward@countzero'

pirca-4zz18-2k41dgvxmoaprm5
```

Let’s have a look at the new collection:

```
$ arv get pirca-4zz18-2k41dgvxmoaprm5

{

"created_at":"2021-01-12T16:22:55.933597000Z",

"current_version_uuid":"pirca-4zz18-2k41dgvxmoaprm5",

"delete_at":null,

"description":"",

"etag":"ehextfe2y4vg1wlc5qiong5ua",

"file_count":2,

"file_size_total":13,

"is_trashed":false,

"kind":"arvados#collection",

"manifest_text":". 0084467710d2fc9d8a306e14efbe6d0f+6+A1556ac1a8d8a6e8cc5cdfacfde839ef6a61ace12@60104205 77fc3b646b70c5118ce358a9ef76b3b1+13+Ae501281d9a3f01f7a6606b08ef3fb347cc2c2135@60104205 0:6:hello.txt 12:7:world.txt\n",

"modified_at":"2021-01-12T16:22:55.935039000Z",

"modified_by_client_uuid":"",

"modified_by_user_uuid":"jutro-tpzed-9z6foyez9ydn2hl",

"name":"Saved at 2021-01-12 16:22:54 UTC by ward@countzero",

"owner_uuid":"jutro-tpzed-9z6foyez9ydn2hl",

"portable_data_hash":"5fdd5d7d41e3a656210597f492404e35+102",

"preserve_version":false,

"properties":{},

"replication_confirmed":null,

"replication_confirmed_at":null,

"replication_desired":null,

"storage_classes_confirmed":[],

"storage_classes_confirmed_at":null,

"storage_classes_desired":[

"default"

],

"trash_at":null,

"unsigned_manifest_text":"",

"uuid":"pirca-4zz18-2k41dgvxmoaprm5",

"version":1

}
```

We can compare the manifest text for both collections. This was the original manifest:

```
. 77fc3b646b70c5118ce358a9ef76b3b1+13+Ab4c280ce1400d0e94748522f3353fb8a4e76aaf0@60104148 0:6:hello.txt 6:7:world.txt\n
```

and this is the new manifest:

```
. 0084467710d2fc9d8a306e14efbe6d0f+6+A1556ac1a8d8a6e8cc5cdfacfde839ef6a61ace12@60104205 77fc3b646b70c5118ce358a9ef76b3b1+13+Ae501281d9a3f01f7a6606b08ef3fb347cc2c2135@60104205 0:6:hello.txt 12:7:world.txt\n
```

We see that an additional keep block is referenced, with hash 0084467710d2fc9d8a306e14efbe6d0f and size 6 bytes, which contains the new contents of ‘hello.txt’. The original block is reused for the ‘world.txt’ file, which didn’t change.

We can verify this by asking Arvados for a deduplication report for the 2 collections:

```
$ arvados-client deduplication-report pirca-4zz18-46zcwbae8mkesob pirca-4zz18-2k41dgvxmoaprm5

Collection pirca-4zz18-46zcwbae8mkesob: pdh 291b1248abb8a975292ccd509a82ba7d+66; nominal size 13 (13 B); file count 2

Collection pirca-4zz18-2k41dgvxmoaprm5: pdh 5fdd5d7d41e3a656210597f492404e35+102; nominal size 13 (13 B); file count 2

Collections:                               2

Nominal size of stored data:              26 bytes (26 B)

Actual size of stored data:               19 bytes (19 B)

Saved by Keep deduplication:               7 bytes (7 B)
```

Keep’s deduplication saved us 7 bytes of storage (27% of the nominal storage size).

### Conclusion

While the gains in this contrived example are quite small, in the real world the deduplication feature is quite powerful. It saves a ton of storage space and as a consequence, a lot of money. Here’s a real-world example, looking at how much data is saved by Keep’s deduplication in the top 100 largest collections on the [Arvados playground](https://playground.arvados.org)

```
$ arv collection list --order 'file_size_total desc' | \

jq -r '.items[] | [.portable_data_hash,.uuid] |@csv' | \

tail -n100 |sed -e 's/"//g'|tr '\n' ' ' | \

xargs arvados-client deduplication-report

...

Collections:                             100

Nominal size of stored data:  16917853747534 bytes (15.4 TiB)

Actual size of stored data:    1883376975847 bytes (1.7 TiB)

Saved by Keep deduplication:  15034476771687 bytes (13.7 TiB)
```

A storage system without deduplication would have stored 15.4 TiB. Because of Keep’s built-in deduplication, we store that data in 1.7 TiB, for a savings of about 89% of the nominal size.

This is a relatively small Arvados installation. On a bigger installation, the savings really add up. Here’s an example from a bigger Arvados cluster with roughly 5.5 million collections. The deduplication report was run on the top 5000 largest collections on the cluster:

```
Nominal size of stored data: 1818729030958058 bytes (1.6 PiB)

Actual size of stored data:  651510381139078 bytes (592 TiB)

Saved by Keep deduplication: 1167218649818980 bytes (1.0 PiB)
```

Keep saved about a petabyte of storage space (roughly 63% of the nominal size of the stored data).

If this data was stored on S3, the nominal storage cost would be around $37,250 per month ($0.022 per GiB). Because of Keep’s deduplication, the actual storage cost would only be $13,350 per month. That’s a savings of $23,900 per month!

### Try it yourself!

If you liked this experiment, feel free to replicate it with a free account on the [Arvados playground](https://playground.arvados.org), or have a look at [the documentation for installing Arvados](https://doc.arvados.org/install/index.html).

Alternatively, [Curii Corporation](https://curii.com) provides managed Arvados installations as well as commercial support for Arvados. Please contact info@curii.com for more information.

tags:
[keep](/tag/keep),
[arvados](/tag/arvados)

---

[Debugging CWL Workflows and Tools in Arvados →](/2021/12/07/debugging-cwl-in-arvados/)

## Contributors

* [![Author thumbnail for Peter Amstutz](https://www.curii.com/assets/img/team/amstutzpeter_500.png)](/authors/peter.amstutz/)
* [![Author thumbnail for Sarah Wait Zaranek](https://curii.com/assets/img/team/zaraneksarah_500.png)](/authors/swzaranek/)
* [![Author thumbnail for Ward Vandewege](https://2.gravatar.com/avatar/e8ab1efb4674f9004f57e0a1d024f3f1?s=144&d=https%3A%2F%2F2.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D48&r=G)](/authors/wardv/)

## Search

## Recent Posts

* [Arvados 3.1 Release Highlights](/2025/03/20/arvados-release-highlights/)
* [Arvados 3.0 Release Highlights](/2024/11/14/arvados-release-highlights/)
* [Scientific Workflow and Data Management with the Arvados Platform](/2022/10/05/workflow-data-management/)
* [Computing with GPUs: New GPU Support in Arvados 2.4](/2022/04/14/gpus-in-arvados/)
* [Debugging CWL Workflows and Tools in Arvados](/2021/12/07/debugging-cwl-in-arvados/)

## Archives

* [March 2025](/2025/03)
* [November 2024](/2024/11)
* [October 2022](/2022/10)
* [April 2022](/2022/04)
* [December 2021](/2021/12)
* [May 2021](/2021/05)

## Arvados

* [About](/about/)
* [Development](https://github.com/arvados/arvados)
* [Community](/community/)
* [Documentation](https://doc.arvados.org/)
* [Blog](/blog/)

[![Link to Arvados Github](/images/social/github.svg "Github icon")](https://github.com/arvados/arvados)
[![Link to Arvados Twitter](/images/social/twitter.svg "Twitter icon")](https://twitter.com/arvados)

©2024 Arvados Project. Unless otherwise noted, site content licensed under Creative Commons Attribution-ShareAlike 4.0 International licensed.

[Privacy Policy](/privacy)
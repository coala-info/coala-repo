# google-cloud-sdk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| google-cloud-sdk_gsutil_cat | PASS |  |
| google-cloud-sdk_gsutil_cp | PASS |  |
| google-cloud-sdk_gsutil_du | PASS |  |
| google-cloud-sdk_gsutil_hash | PASS |  |
| google-cloud-sdk_gsutil_ls | PASS |  |
| google-cloud-sdk_gsutil_mv | Not completed | needs a Google account: it changes objects in a bucket. |
| google-cloud-sdk_gsutil_rm | Not completed | needs a Google account: it changes objects in a bucket. |
| google-cloud-sdk_gsutil_rsync | PASS |  |

## google-cloud-sdk_gsutil_hash

### Tool Description
Calculate file hashes.

### google-cloud-sdk_gsutil_cat

### Tool Description
Concatenate object content to stdout.

### google-cloud-sdk_gsutil_ls

### Tool Description
List providers, buckets, or objects.

### google-cloud-sdk_gsutil_du

### Tool Description
Display object size usage.

### google-cloud-sdk_gsutil_cp

### Tool Description
Copy files and objects.

### google-cloud-sdk_gsutil_mv

### Tool Description
Move/rename objects and/or subdirectories.

### google-cloud-sdk_gsutil_rm

### Tool Description
Remove objects.

### google-cloud-sdk_gsutil_rsync

### Tool Description
Synchronize content of two buckets/directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
- **Homepage**: https://cloud.google.com/storage/docs/gsutil
- **Package**: https://anaconda.org/channels/bioconda/packages/google-cloud-sdk/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
  rsync - Synchronize content of two buckets/directories


SYNOPSIS

  gsutil rsync [-a] [-c] [-C] [-d] [-e] [-n] [-p] [-r] [-U] [-x] src_url dst_url



DESCRIPTION
  The gsutil rsync command makes the contents under dst_url the same as the
  contents under src_url, by copying any missing files/objects (or those whose
  data has changed), and (if the -d option is specified) deleting any extra
  files/objects. src_url must specify a directory, bucket, or bucket
  subdirectory. For example, to make gs://mybucket/data match the contents of
  the local directory "data" you could do:

    gsutil rsync -d data gs://mybucket/data

  To recurse into directories use the -r option:

    gsutil rsync -d -r data gs://mybucket/data

  To copy only new/changed files without deleting extra files from
  gs://mybucket/data leave off the -d option:

    gsutil rsync -r data gs://mybucket/data

  If you have a large number of objects to synchronize you might want to use the
  gsutil -m option, to perform parallel (multi-threaded/multi-processing)
  synchronization:

    gsutil -m rsync -d -r data gs://mybucket/data

  The -m option typically will provide a large performance boost if either the
  source or destination (or both) is a cloud URL. If both source and
  destination are file URLs the -m option will typically thrash the disk and
  slow synchronization down.

  To make the local directory "data" the same as the contents of
  gs://mybucket/data:

    gsutil rsync -d -r gs://mybucket/data data

  To make the contents of gs://mybucket2 the same as gs://mybucket1:

    gsutil rsync -d -r gs://mybucket1 gs://mybucket2

  You can also mirror data across local directories:

    gsutil rsync -d -r dir1 dir2

  To mirror your content across clouds:

    gsutil rsync -d -r gs://my-gs-bucket s3://my-s3-bucket

  Note: If you are synchronizing a large amount of data between clouds you might
  consider setting up a
  `Google Compute Engine <https://cloud.google.com/products/compute-engine>`_
  account and running gsutil there. Since cross-provider gsutil data transfers
  flow through the machine where gsutil is running, doing this can make your
  transfer run significantly faster than running gsutil on your local
  workstation.


BE CAREFUL WHEN USING -d OPTION!
  The rsync -d option is very useful and commonly used, because it provides a
  means of making the contents of a destination bucket or directory match those
  of a source bucket or directory. However, please exercise caution when you
  use this option: It's possible to delete large amounts of data accidentally
  if, for example, you erroneously reverse source and destination. For example,
  if you meant to synchronize a local directory from a bucket in the cloud but
  instead run the command:

    gsutil -m rsync -r -d ./your-dir gs://your-bucket

  and your-dir is currently empty, you will quickly delete all of the objects in
  gs://your-bucket.

  You can also cause large amounts of data to be lost quickly by specifying a
  subdirectory of the destination as the source of an rsync. For example, the
  command:

    gsutil -m rsync -r -d gs://your-bucket/data gs://your-bucket

  would cause most or all of the objects in gs://your-bucket to be deleted
  (some objects may survive if there are any with names that sort lower than
  "data" under gs://your-bucket/data).

  In addition to paying careful attention to the source and destination you
  specify with the rsync command, there are two more safety measures your can
  take when using gsutil rsync -d:

  1. Try running the command with the rsync -n option first, to see what it
     would do without actually performing the operations. For example, if
     you run the command:

       gsutil -m rsync -r -d -n gs://your-bucket/data gs://your-bucket

     it will be immediately evident that running that command without the -n
     option would cause many objects to be deleted.

  2. Enable object versioning in your bucket, which will allow you to restore
     objects if you accidentally delete them. For more details see
     "gsutil help versions".


IMPACT OF OBJECT LISTING EVENTUAL CONSISTENCY
  The rsync command operates by listing the source and destination URLs, and
  then performing copy and remove operations according to the differences
  between these listings. Because object listing is eventually (not strongly)
  consistent within multi-regional locations, if you upload new objects or
  delete objects from a bucket in a multi-regional location and then
  immediately run gsutil rsync with that bucket as the source or destination,
  it's possible the rsync command will not see the recent updates and thus
  synchronize incorrectly. For example, if you rsync to a ``US`` bucket
  immediately after uploading to or deleting objects from that bucket, it's
  possible gsutil will re-upload objects that have already been uploaded or
  attempt to delete objects that were already deleted. A more troublesome
  problem can occur if you run gsutil rsync, specifying a bucket as the
  source immediately after uploading to or deleting objects from that bucket.
  In that case it's possible rsync will miss copying objects to, or deleting
  objects from, the destination. If this happens you can rerun the rsync
  operation again later (after the object listing has "caught up"), to cause
  the missing objects to be copied and extra objects to be deleted.


CHECKSUM VALIDATION AND FAILURE HANDLING
  At the end of every upload or download, the gsutil rsync command validates
  that the checksum of the source file/object matches the checksum of the
  destination file/object. If the checksums do not match, gsutil will delete
  the invalid copy and print a warning message. This very rarely happens, but
  if it does, please contact gs-team@google.com.

  The rsync command will retry when failures occur, but if enough failures
  happen during a particular copy or delete operation the command will fail.

  If the -C option is provided, the command will instead skip the failing
  object and move on. At the end of the synchronization run if any failures
  were not successfully retried, the rsync command will report the count of
  failures, and exit with non-zero status. At this point you can run the rsync
  command again, and it will attempt any remaining needed copy and/or delete
  operations.

  Note that there are cases where retrying will never succeed, such as if you
  don't have write permission to the destination bucket or if the destination
  path for some objects is longer than the maximum allowed length.

  For more details about gsutil's retry handling, please see
  "gsutil help retries".


CHANGE DETECTION ALGORITHM
  To determine if a file or object has changed, gsutil rsync first checks
  whether the file modification time (mtime) of both the source and destination
  is available. If mtime is available at both source and destination, and the
  destination mtime is different than the source, or if the source and
  destination file size differ, gsutil rsync will update the destination. If the
  source is a cloud bucket and the destination is a local file system, and if
  mtime is not available for the source, gsutil rsync will use the time created
  for the cloud object as a substitute for mtime. Otherwise, if mtime is not
  available for either the source or the destination, gsutil rsync will fall
  back to using checksums. If the source and destination are both cloud buckets
  with checksums available, gsutil rsync will use these hashes instead of mtime.
  However, gsutil rsync will still update mtime at the destination if it is not
  present. If the source and destination have matching checksums and only the
  source has an mtime, gsutil rsync will copy the mtime to the destination. If
  neither mtime nor checksums are available, gsutil rsync will resort to
  comparing file sizes.

  Checksums will not be available when comparing composite Google Cloud Storage
  objects with objects at a cloud provider that does not support CRC32C (which
  is the only checksum available for composite objects). See 'gsutil help
  compose' for details about composite objects.


COPYING IN THE CLOUD AND METADATA PRESERVATION
  If both the source and destination URL are cloud URLs from the same provider,
  gsutil copies data "in the cloud" (i.e., without downloading to and uploading
  from the machine where you run gsutil). In addition to the performance and
  cost advantages of doing this, copying in the cloud preserves metadata (like
  Content-Type and Cache-Control). In contrast, when you download data from the
  cloud it ends up in a file, which has no associated metadata, other than file
  modification time (mtime). Thus, unless you have some way to hold on to or
  re-create that metadata, synchronizing a bucket to a directory in the local
  file system will not retain the metadata other than mtime.

  Note that by default, the gsutil rsync command does not copy the ACLs of
  objects being synchronized and instead will use the default bucket ACL (see
  "gsutil help defacl"). You can override this behavior with the -p option (see
  OPTIONS below).


SLOW CHECKSUMS
  If you find that CRC32C checksum computation runs slowly, this is likely
  because you don't have a compiled CRC32c on your system. Try running:

    gsutil ver -l

  If the output contains:

    compiled crcmod: False

  you are running a Python library for computing CRC32C, which is much slower
  than using the compiled code. For information on getting a compiled CRC32C
  implementation, see 'gsutil help crc32c'.


LIMITATIONS

  1. The gsutil rsync command will only allow non-negative file modification
     times to be used in its comparisons. This means gsutil rsync will resort to
     using checksums for any file with a timestamp before 1970-01-01 UTC.

  2. The gsutil rsync command considers only the current object generations in
     the source and destination buckets when deciding what to copy / delete. If
     versioning is enabled in the destination bucket then gsutil rsync's
     overwriting or deleting objects will end up creating versions, but the
     command doesn't try to make the archived generations match in the source
     and destination buckets.

  3. The gsutil rsync command does not support copying special file types
     such as sockets, device files, named pipes, or any other non-standard
     files intended to represent an operating system resource. If you run
     gsutil rsync on a source directory that includes such files (for example,
     copying the root directory on Linux that includes /dev ), you should use
     the -x flag to exclude these files. Otherwise, gsutil rsync may fail or
     hang.

  4. The gsutil rsync command copies changed files in their entirety and does
     not employ the
     `rsync delta-transfer algorithm <https://rsync.samba.org/tech_report/>`_
     to transfer portions of a changed file. This is because cloud objects are
     immutable and no facility exists to read partial cloud object checksums or
     perform partial overwrites.

OPTIONS
  -a canned_acl Sets named canned_acl when uploaded objects created. See
                "gsutil help acls" for further details. Note that rsync will
                decide whether or not to perform a copy based only on object size
                and modification time, not current ACL state. Also see the -p
                option below.

  -c            Causes the rsync command to compute and compare checksums
                (instead of comparing mtime) for files if the size of source and
                destination as well as mtime (if available) match. This option
                increases local disk I/O and run time if either src_url or
                dst_url are on the local file system.

  -C            If an error occurs, continue to attempt to copy the remaining
                files. If errors occurred, gsutil's exit status will be non-zero
                even if this flag is set. This option is implicitly set when
                running "gsutil -m rsync...".  Note: -C only applies to the
                actual copying operation. If an error occurs while iterating
                over the files in the local directory (e.g., invalid Unicode
                file name) gsutil will print an error message and abort.

  -d            Delete extra files under dst_url not found under src_url. By
                default extra files are not deleted. Note: this option can
                delete data quickly if you specify the wrong source/destination
                combination. See the help section above,
                "BE CAREFUL WHEN USING -d OPTION!".

  -e            Exclude symlinks. When specified, symbolic links will be
                ignored. Note that gsutil does not follow directory symlinks,
                regardless of whether -e is specified.

  -n            Causes rsync to run in "dry run" mode, i.e., just outputting
                what would be copied or deleted without actually doing any
                copying/deleting.

  -p            Causes ACLs to be preserved when objects are copied. Note that
                rsync will decide whether or not to perform a copy based only
                on object size and modification time, not current ACL state.
                Thus, if the source and destination differ in size or
                modification time and you run gsutil rsync -p, the file will be
                copied and ACL preserved. However, if the source and destination
                don't differ in size or checksum but have different ACLs,
                running gsutil rsync -p will have no effect.

                Note that this option has performance and cost implications when
                using the XML API, as it requires separate HTTP calls for
                interacting with ACLs. The performance issue can be mitigated to
                some degree by using gsutil -m rsync to cause parallel
                synchronization. Also, this option only works if you have OWNER
                access to all of the objects that are copied.

                You can avoid the additional performance and cost of using
                rsync -p if you want all objects in the destination bucket to
                end up with the same ACL by setting a default object ACL on that
                bucket instead of using rsync -p. See 'gsutil help defacl'.

  -P            Causes POSIX attributes to be preserved when objects are copied.
                With this feature enabled, gsutil rsync will copy fields
                provided by stat. These are the user ID of the owner, the group
                ID of the owning group, the mode (permissions) of the file, and
                the access/modification time of the file. For downloads, these
                attributes will only be set if the source objects were uploaded
                with this flag enabled.

                On Windows, this flag will only set and restore access time and
                modification time. This is because Windows doesn't have a notion
                of POSIX uid/gid/mode.

  -R, -r        The -R and -r options are synonymous. Causes directories,
                buckets, and bucket subdirectories to be synchronized
                recursively. If you neglect to use this option gsutil will make
                only the top-level directory in the source and destination URLs
                match, skipping any sub-directories.

  -U            Skip objects with unsupported object types instead of failing.
                Unsupported object types are Amazon S3 Objects in the GLACIER
                storage class.

  -x pattern    Causes files/objects matching pattern to be excluded, i.e., any
                matching files/objects will not be copied or deleted. Note that
                the pattern is a Python regular expression, not a wildcard (so,
                matching any string ending in "abc" would be specified using
                ".*abc$" rather than "*abc"). Note also that the exclude path is
                always relative (similar to Unix rsync or tar exclude options).
                For example, if you run the command:

                  gsutil rsync -x "data./.*\.txt$" dir gs://my-bucket

                it will skip the file dir/data1/a.txt.

                You can use regex alternation to specify multiple exclusions,
                for example:

                  gsutil rsync -x ".*\.txt$|.*\.jpg$" dir gs://my-bucket

                NOTE: While it will work to surround the regular expression with
                either single or double quotes on Linux and MacOS, on Windows
                you need to use double quotes.
```


## Metadata
- **Docker Image**: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
- **Homepage**: https://cloud.google.com/storage/docs/gsutil
- **Package**: https://anaconda.org/channels/bioconda/packages/google-cloud-sdk/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
  rm - Remove objects


SYNOPSIS

  gsutil rm [-f] [-r] url...
  gsutil rm [-f] [-r] -I



DESCRIPTION
  The gsutil rm command removes objects.
  For example, the command:

    gsutil rm gs://bucket/subdir/*

  will remove all objects in gs://bucket/subdir, but not in any of its
  sub-directories. In contrast:

    gsutil rm gs://bucket/subdir/**

  will remove all objects under gs://bucket/subdir or any of its
  subdirectories.

  You can also use the -r option to specify recursive object deletion. Thus, for
  example, either of the following two commands will remove gs://bucket/subdir
  and all objects and subdirectories under it:

    gsutil rm gs://bucket/subdir**
    gsutil rm -r gs://bucket/subdir

  The -r option will also delete all object versions in the subdirectory for
  versioning-enabled buckets, whereas the ** command will only delete the live
  version of each object in the subdirectory.

  Running gsutil rm -r on a bucket will delete all versions of all objects in
  the bucket, and then delete the bucket:

    gsutil rm -r gs://bucket

  If you want to delete all objects in the bucket, but not the bucket itself,
  this command will work:

    gsutil rm gs://bucket/**

  If you have a large number of objects to remove you might want to use the
  gsutil -m option, to perform parallel (multi-threaded/multi-processing)
  removes:

    gsutil -m rm -r gs://my_bucket/subdir

  You can pass a list of URLs (one per line) to remove on stdin instead of as
  command line arguments by using the -I option. This allows you to use gsutil
  in a pipeline to remove objects identified by a program, such as:

    some_program | gsutil -m rm -I

  The contents of stdin can name cloud URLs and wildcards of cloud URLs.

  Note that gsutil rm will refuse to remove files from the local
  file system. For example this will fail:

    gsutil rm *.txt

  WARNING: Object removal cannot be undone. Google Cloud Storage is designed
  to give developers a high amount of flexibility and control over their data,
  and Google maintains strict controls over the processing and purging of
  deleted data. To protect yourself from mistakes, you can configure object
  versioning on your bucket(s). See 'gsutil help versions' for details.


DATA RESTORATION FROM ACCIDENTAL DELETION OR OVERWRITES
Google Cloud Storage does not provide support for restoring data lost
or overwritten due to customer errors. If you have concerns that your
application software (or your users) may at some point erroneously delete or
overwrite data, you can protect yourself from that risk by enabling Object
Versioning (see "gsutil help versioning"). Doing so increases storage costs,
which can be partially mitigated by configuring Lifecycle Management to delete
older object versions (see "gsutil help lifecycle").


OPTIONS
  -f          Continues silently (without printing error messages) despite
              errors when removing multiple objects. If some of the objects
              could not be removed, gsutil's exit status will be non-zero even
              if this flag is set. Execution will still halt if an inaccessible
              bucket is encountered. This option is implicitly set when running
              "gsutil -m rm ...".

  -I          Causes gsutil to read the list of objects to remove from stdin.
              This allows you to run a program that generates the list of
              objects to remove.

  -R, -r      The -R and -r options are synonymous. Causes bucket or bucket
              subdirectory contents (all objects and subdirectories that it
              contains) to be removed recursively. If used with a bucket-only
              URL (like gs://bucket), after deleting objects and subdirectories
              gsutil will delete the bucket. This option implies the -a option
              and will delete all object versions.

  -a          Delete all versions of an object.
```


## Metadata
- **Docker Image**: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
- **Homepage**: https://cloud.google.com/storage/docs/gsutil
- **Package**: https://anaconda.org/channels/bioconda/packages/google-cloud-sdk/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
  mv - Move/rename objects and/or subdirectories


SYNOPSIS

  gsutil mv [-p] src_url dst_url
  gsutil mv [-p] src_url... dst_url
  gsutil mv [-p] -I dst_url



DESCRIPTION
  The gsutil mv command allows you to move data between your local file
  system and the cloud, move data within the cloud, and move data between
  cloud storage providers. For example, to move all objects from a
  bucket to a local directory you could use:

    gsutil mv gs://my_bucket/* dir

  Similarly, to move all objects from a local directory to a bucket you could
  use:

    gsutil mv ./dir gs://my_bucket


RENAMING BUCKET SUBDIRECTORIES
  You can use the gsutil mv command to rename subdirectories. For example,
  the command:

    gsutil mv gs://my_bucket/olddir gs://my_bucket/newdir

  would rename all objects and subdirectories under gs://my_bucket/olddir to be
  under gs://my_bucket/newdir, otherwise preserving the subdirectory structure.

  If you do a rename as specified above and you want to preserve ACLs, you
  should use the -p option (see OPTIONS).

  Note that when using mv to rename bucket subdirectories you cannot specify
  the source URL using wildcards. You need to spell out the complete name:

    gsutil mv gs://my_bucket/olddir gs://my_bucket/newdir

  If you have a large number of files to move you might want to use the
  gsutil -m option, to perform a multi-threaded/multi-processing move:

    gsutil -m mv gs://my_bucket/olddir gs://my_bucket/newdir


NON-ATOMIC OPERATION
  Unlike the case with many file systems, the gsutil mv command does not
  perform a single atomic operation. Rather, it performs a copy from source
  to destination followed by removing the source for each object.


CHARGES FOR MOVING NEARLINE OBJECTS
  If you move a Nearline storage class object, deletion and data retrieval
  charges apply, because gsutil actually copies the original object and deletes
  the original. See the `documentation
  <https://cloud.google.com/storage/pricing>`_ for pricing details.


OPTIONS
  All options that are available for the gsutil cp command are also available
  for the gsutil mv command (except for the -R flag, which is implied by the
  gsutil mv command). Please see the OPTIONS sections of "gsutil help cp"
  for more information.
```


## Metadata
- **Docker Image**: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
- **Homepage**: https://cloud.google.com/storage/docs/gsutil
- **Package**: https://anaconda.org/channels/bioconda/packages/google-cloud-sdk/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
  cp - Copy files and objects


SYNOPSIS

  gsutil cp [OPTION]... src_url dst_url
  gsutil cp [OPTION]... src_url... dst_url
  gsutil cp [OPTION]... -I dst_url



DESCRIPTION
  The gsutil cp command allows you to copy data between your local file
  system and the cloud, copy data within the cloud, and copy data between
  cloud storage providers. For example, to copy all text files from the
  local directory to a bucket you could do:

    gsutil cp *.txt gs://my-bucket

  Similarly, you can download text files from a bucket by doing:

    gsutil cp gs://my-bucket/*.txt .

  If you want to copy an entire directory tree you need to use the -r option:

    gsutil cp -r dir gs://my-bucket

  If you have a large number of files to transfer you might want to use the
  gsutil -m option, to perform a parallel (multi-threaded/multi-processing)
  copy:

    gsutil -m cp -r dir gs://my-bucket

  You can pass a list of URLs (one per line) to copy on stdin instead of as
  command line arguments by using the -I option. This allows you to use gsutil
  in a pipeline to upload or download files / objects as generated by a program,
  such as:

    some_program | gsutil -m cp -I gs://my-bucket

  or:

    some_program | gsutil -m cp -I ./download_dir

  The contents of stdin can name files, cloud URLs, and wildcards of files
  and cloud URLs.



HOW NAMES ARE CONSTRUCTED
  The gsutil cp command strives to name objects in a way consistent with how
  Linux cp works, which causes names to be constructed in varying ways depending
  on whether you're performing a recursive directory copy or copying
  individually named objects; and whether you're copying to an existing or
  non-existent directory.

  When performing recursive directory copies, object names are constructed that
  mirror the source directory structure starting at the point of recursive
  processing. For example, if dir1/dir2 contains the file a/b/c then the
  command:

    gsutil cp -r dir1/dir2 gs://my-bucket

  will create the object gs://my-bucket/dir2/a/b/c.

  In contrast, copying individually named files will result in objects named by
  the final path component of the source files. For example, again assuming
  dir1/dir2 contains a/b/c, the command:

    gsutil cp dir1/dir2/** gs://my-bucket

  will create the object gs://my-bucket/c.

  The same rules apply for downloads: recursive copies of buckets and
  bucket subdirectories produce a mirrored filename structure, while copying
  individually (or wildcard) named objects produce flatly named files.

  Note that in the above example the '**' wildcard matches all names
  anywhere under dir. The wildcard '*' will match names just one level deep. For
  more details see "gsutil help wildcards".

  There's an additional wrinkle when working with subdirectories: the resulting
  names depend on whether the destination subdirectory exists. For example,
  if gs://my-bucket/subdir exists as a subdirectory, the command:

    gsutil cp -r dir1/dir2 gs://my-bucket/subdir

  will create the object gs://my-bucket/subdir/dir2/a/b/c. In contrast, if
  gs://my-bucket/subdir does not exist, this same gsutil cp command will create
  the object gs://my-bucket/subdir/a/b/c.

  Note: If you use the
  `Google Cloud Platform Console <https://console.cloud.google.com>`_
  to create folders, it does so by creating a "placeholder" object that ends
  with a "/" character. gsutil skips these objects when downloading from the
  cloud to the local file system, because attempting to create a file that
  ends with a "/" is not allowed on Linux and MacOS. Because of this, it is
  recommended that you not create objects that end with "/" (unless you don't
  need to be able to download such objects using gsutil).



COPYING TO/FROM SUBDIRECTORIES; DISTRIBUTING TRANSFERS ACROSS MACHINES
  You can use gsutil to copy to and from subdirectories by using a command
  like:

    gsutil cp -r dir gs://my-bucket/data

  This will cause dir and all of its files and nested subdirectories to be
  copied under the specified destination, resulting in objects with names like
  gs://my-bucket/data/dir/a/b/c. Similarly you can download from bucket
  subdirectories by using a command like:

    gsutil cp -r gs://my-bucket/data dir

  This will cause everything nested under gs://my-bucket/data to be downloaded
  into dir, resulting in files with names like dir/data/a/b/c.

  Copying subdirectories is useful if you want to add data to an existing
  bucket directory structure over time. It's also useful if you want
  to parallelize uploads and downloads across multiple machines (potentially
  reducing overall transfer time compared with simply running gsutil -m
  cp on one machine). For example, if your bucket contains this structure:

    gs://my-bucket/data/result_set_01/
    gs://my-bucket/data/result_set_02/
    ...
    gs://my-bucket/data/result_set_99/

  you could perform concurrent downloads across 3 machines by running these
  commands on each machine, respectively:

    gsutil -m cp -r gs://my-bucket/data/result_set_[0-3]* dir
    gsutil -m cp -r gs://my-bucket/data/result_set_[4-6]* dir
    gsutil -m cp -r gs://my-bucket/data/result_set_[7-9]* dir

  Note that dir could be a local directory on each machine, or it could be a
  directory mounted off of a shared file server; whether the latter performs
  acceptably will depend on a number of factors, so we recommend experimenting
  to find out what works best for your computing environment.



COPYING IN THE CLOUD AND METADATA PRESERVATION
  If both the source and destination URL are cloud URLs from the same
  provider, gsutil copies data "in the cloud" (i.e., without downloading
  to and uploading from the machine where you run gsutil). In addition to
  the performance and cost advantages of doing this, copying in the cloud
  preserves metadata (like Content-Type and Cache-Control). In contrast,
  when you download data from the cloud it ends up in a file, which has
  no associated metadata. Thus, unless you have some way to hold on to
  or re-create that metadata, downloading to a file will not retain the
  metadata.

  Copies spanning locations and/or storage classes cause data to be rewritten
  in the cloud, which may take some time (but still will be faster than
  downloading and re-uploading). Such operations can be resumed with the same
  command if they are interrupted, so long as the command parameters are
  identical.

  Note that by default, the gsutil cp command does not copy the object
  ACL to the new object, and instead will use the default bucket ACL (see
  "gsutil help defacl"). You can override this behavior with the -p
  option (see OPTIONS below).

  One additional note about copying in the cloud: If the destination bucket has
  versioning enabled, by default gsutil cp will copy only live versions of the
  source object(s). For example:

    gsutil cp gs://bucket1/obj gs://bucket2

  will cause only the single live version of gs://bucket1/obj to be copied to
  gs://bucket2, even if there are archived versions of gs://bucket1/obj. To also
  copy archived versions, use the -A flag:

    gsutil cp -A gs://bucket1/obj gs://bucket2

  The gsutil -m flag is disallowed when using the cp -A flag, to ensure that
  version ordering is preserved.



CHECKSUM VALIDATION
  At the end of every upload or download the gsutil cp command validates that
  the checksum it computes for the source file/object matches the checksum
  the service computes. If the checksums do not match, gsutil will delete the
  corrupted object and print a warning message. This very rarely happens, but
  if it does, please contact gs-team@google.com.

  If you know the MD5 of a file before uploading you can specify it in the
  Content-MD5 header, which will cause the cloud storage service to reject the
  upload if the MD5 doesn't match the value computed by the service. For
  example:

    % gsutil hash obj
    Hashing     obj:
    Hashes [base64] for obj:
            Hash (crc32c):          lIMoIw==
            Hash (md5):             VgyllJgiiaRAbyUUIqDMmw==

    % gsutil -h Content-MD5:VgyllJgiiaRAbyUUIqDMmw== cp obj gs://your-bucket/obj
    Copying file://obj [Content-Type=text/plain]...
    Uploading   gs://your-bucket/obj:                                182 b/182 B

    If the checksum didn't match the service would instead reject the upload and
    gsutil would print a message like:

    BadRequestException: 400 Provided MD5 hash "VgyllJgiiaRAbyUUIqDMmw=="
    doesn't match calculated MD5 hash "7gyllJgiiaRAbyUUIqDMmw==".

  Even if you don't do this gsutil will delete the object if the computed
  checksum mismatches, but specifying the Content-MD5 header has several
  advantages:

      1. It prevents the corrupted object from becoming visible at all, whereas
      otherwise it would be visible for 1-3 seconds before gsutil deletes it.

      2. If an object already exists with the given name, specifying the
      Content-MD5 header will cause the existing object never to be replaced,
      whereas otherwise it would be replaced by the corrupted object and then
      deleted a few seconds later.

      3. It will definitively prevent the corrupted object from being left in
      the cloud, whereas the gsutil approach of deleting after the upload
      completes could fail if (for example) the gsutil process gets ^C'd
      between upload and deletion request.

      4. It supports a customer-to-service integrity check handoff. For example,
      if you have a content production pipeline that generates data to be
      uploaded to the cloud along with checksums of that data, specifying the
      MD5 computed by your content pipeline when you run gsutil cp will ensure
      that the checksums match all the way through the process (e.g., detecting
      if data gets corrupted on your local disk between the time it was written
      by your content pipeline and the time it was uploaded to GCS).

  Note: The Content-MD5 header is ignored for composite objects, because such
  objects only have a CRC32C checksum.



RETRY HANDLING
  The cp command will retry when failures occur, but if enough failures happen
  during a particular copy or delete operation the cp command will skip that
  object and move on. At the end of the copy run if any failures were not
  successfully retried, the cp command will report the count of failures, and
  exit with non-zero status.

  Note that there are cases where retrying will never succeed, such as if you
  don't have write permission to the destination bucket or if the destination
  path for some objects is longer than the maximum allowed length.

  For more details about gsutil's retry handling, please see
  "gsutil help retries".



RESUMABLE TRANSFERS
  gsutil automatically performs a resumable upload whenever you use the cp
  command to upload an object that is larger than 8 MiB. You do not need to
  specify any special command line options to make this happen. If your upload
  is interrupted you can restart the upload by running the same cp command that
  you ran to start the upload. Until the upload has completed successfully, it
  will not be visible at the destination object and will not replace any
  existing object the upload is intended to overwrite. However, see the section
  on PARALLEL COMPOSITE UPLOADS, which may leave temporary component objects in
  place during the upload process.

  Similarly, gsutil automatically performs resumable downloads (using standard
  HTTP Range GET operations) whenever you use the cp command, unless the
  destination is a stream. In this case, a partially downloaded temporary file
  will be visible in the destination directory. Upon completion, the original
  file is deleted and overwritten with the downloaded contents.

  Resumable uploads and downloads store state information in files under
  ~/.gsutil, named by the destination object or file. If you attempt to resume a
  transfer from a machine with a different directory, the transfer will start
  over from scratch.

  See also "gsutil help prod" for details on using resumable transfers
  in production.



STREAMING TRANSFERS
  Use '-' in place of src_url or dst_url to perform a streaming
  transfer. For example:

    long_running_computation | gsutil cp - gs://my-bucket/obj

  Streaming uploads using the JSON API (see "gsutil help apis") are buffered in
  memory part-way back into the file and can thus retry in the event of network
  or service problems.

  Streaming transfers using the XML API do not support resumable
  uploads/downloads. If you have a large amount of data to upload (say, more
  than 100 MiB) it is recommended that you write the data to a local file and
  then copy that file to the cloud rather than streaming it (and similarly for
  large downloads).

  WARNING: When performing streaming transfers gsutil does not compute a
  checksum of the uploaded or downloaded data. Therefore, we recommend that
  users either perform their own validation of the data or use non-streaming
  transfers (which perform integrity checking automatically).



SLICED OBJECT DOWNLOADS
  gsutil uses HTTP Range GET requests to perform "sliced" downloads in parallel
  when downloading large objects from Google Cloud Storage. This means that disk
  space for the temporary download destination file will be pre-allocated and
  byte ranges (slices) within the file will be downloaded in parallel. Once all
  slices have completed downloading, the temporary file will be renamed to the
  destination file. No additional local disk space is required for this
  operation.

  This feature is only available for Google Cloud Storage objects because it
  requires a fast composable checksum (CRC32C) that can be used to verify the
  data integrity of the slices. And because it depends on CRC32C, using sliced
  object downloads also requires a compiled crcmod (see "gsutil help crcmod") on
  the machine performing the download. If compiled crcmod is not available,
  a non-sliced object download will instead be performed.

  Note: since sliced object downloads cause multiple writes to occur at various
  locations on disk, this mechanism can degrade performance for disks with slow
  seek times, especially for large numbers of slices. While the default number
  of slices is set small to avoid this problem, you can disable sliced object
  download if necessary by setting the "sliced_object_download_threshold"
  variable in the .boto config file to 0.





PARALLEL COMPOSITE UPLOADS
  gsutil can automatically use
  `object composition <https://cloud.google.com/storage/docs/composite-objects>`_
  to perform uploads in parallel for large, local files being uploaded to Google
  Cloud Storage. If enabled (see below), a large file will be split into
  component pieces that are uploaded in parallel and then composed in the cloud
  (and the temporary components finally deleted). A file can be broken into as
  many as 32 component pieces; until this piece limit is reached, the maximum
  size of each component piece is determined by the variable
  "parallel_composite_upload_component_size," specified in the [GSUtil] section
  of your .boto configuration file (for files that are otherwise too big,
  components are as large as needed to fit into 32 pieces). No additional local
  disk space is required for this operation.

  Using parallel composite uploads presents a tradeoff between upload
  performance and download configuration: If you enable parallel composite
  uploads your uploads will run faster, but someone will need to install a
  compiled crcmod (see "gsutil help crcmod") on every machine where objects are
  downloaded by gsutil or other Python applications. Note that for such uploads,
  crcmod is required for downloading regardless of whether the parallel
  composite upload option is on or not. For some distributions this is easy
  (e.g., it comes pre-installed on MacOS), but in other cases some users have
  found it difficult. Because of this, at present parallel composite uploads are
  disabled by default. Google is actively working with a number of the Linux
  distributions to get crcmod included with the stock distribution. Once that is
  done we will re-enable parallel composite uploads by default in gsutil.

  Warning: Parallel composite uploads should not be used with NEARLINE or
  COLDLINE storage class buckets, because doing so incurs an early deletion
  charge for each component object.

  To try parallel composite uploads you can run the command:

    gsutil -o GSUtil:parallel_composite_upload_threshold=150M cp bigfile gs://your-bucket

  where bigfile is larger than 150 MiB. When you do this notice that the upload
  progress indicator continuously updates for several different uploads at once
  (corresponding to each of the sections of the file being uploaded in
  parallel), until the parallel upload completes. If after trying this you want
  to enable parallel composite uploads for all of your future uploads
  (notwithstanding the caveats mentioned earlier), you can uncomment and set the
  "parallel_composite_upload_threshold" config value in your .boto configuration
  file to this value.

  Note that the crcmod problem only impacts downloads via Python applications
  (such as gsutil). If all users who need to download the data using gsutil or
  other Python applications can install crcmod, or if no Python users will
  need to download your objects, it makes sense to enable parallel composite
  uploads (see above). For example, if you use gsutil to upload video assets,
  and those assets will only ever be served via a Java application, it would
  make sense to enable parallel composite uploads on your machine (there are
  efficient CRC32C implementations available in Java).

  If a parallel composite upload fails prior to composition, re-running the
  gsutil command will take advantage of resumable uploads for the components
  that failed, and the component objects will be deleted after the first
  successful attempt. Any temporary objects that were uploaded successfully
  before gsutil failed will still exist until the upload is completed
  successfully. The temporary objects will be named in the following fashion:

    <random ID>/gsutil/tmp/parallel_composite_uploads/for_details_see/gsutil_help_cp/<hash>

  where <random ID> is a numerical value, and <hash> is an MD5 hash (not related
  to the hash of the contents of the file or object).

  To avoid leaving temporary objects around, you should make sure to check the
  exit status from the gsutil command.  This can be done in a bash script, for
  example, by doing:

    if ! gsutil cp ./local-file gs://your-bucket/your-object; then
      << Code that handles failures >>
    fi

  Or, for copying a directory, use this instead:

    if ! gsutil cp -c -L cp.log -r ./dir gs://bucket; then
      << Code that handles failures >>
    fi

  One important caveat is that files uploaded using parallel composite uploads
  are subject to a maximum number of components limit. For example, if you
  upload a large file that gets split into 10 components, and try to compose it
  with another object with 1015 components, the operation will fail because it
  exceeds the 1024 component limit. If you wish to compose an object later and the
  component limit is a concern, it is recommended that you disable parallel
  composite uploads for that transfer.

  Also note that an object uploaded using parallel composite uploads will have a
  CRC32C hash, but it will not have an MD5 hash (and because of that, users who
  download the object must have crcmod installed, as noted earlier). For details
  see "gsutil help crc32c".

  Parallel composite uploads can be disabled by setting the
  "parallel_composite_upload_threshold" variable in the .boto config file to 0.



CHANGING TEMP DIRECTORIES
  gsutil writes data to a temporary directory in several cases:

  - when compressing data to be uploaded (see the -z and -Z options)
  - when decompressing data being downloaded (when the data has
    Content-Encoding:gzip, e.g., as happens when uploaded using gsutil cp -z
    or gsutil cp -Z)
  - when running integration tests (using the gsutil test command)

  In these cases it's possible the temp file location on your system that
  gsutil selects by default may not have enough space. If gsutil runs out of
  space during one of these operations (e.g., raising
  "CommandException: Inadequate temp space available to compress <your file>"
  during a gsutil cp -z operation), you can change where it writes these
  temp files by setting the TMPDIR environment variable. On Linux and MacOS
  you can do this either by running gsutil this way:

    TMPDIR=/some/directory gsutil cp ...

  or by adding this line to your ~/.bashrc file and then restarting the shell
  before running gsutil:

    export TMPDIR=/some/directory

  On Windows 7 you can change the TMPDIR environment variable from Start ->
  Computer -> System -> Advanced System Settings -> Environment Variables.
  You need to reboot after making this change for it to take effect. (Rebooting
  is not necessary after running the export command on Linux and MacOS.)



COPYING SPECIAL FILES
  gsutil cp does not support copying special file types such as sockets, device
  files, named pipes, or any other non-standard files intended to represent an
  operating system resource. You should not run gsutil cp with sources that
  include such files (for example, recursively copying the root directory on
  Linux that includes /dev ). If you do, gsutil cp may fail or hang.



OPTIONS
  -a canned_acl  Sets named canned_acl when uploaded objects created. See
                 "gsutil help acls" for further details.

  -A             Copy all source versions from a source buckets/folders.
                 If not set, only the live version of each source object is
                 copied. Note: this option is only useful when the destination
                 bucket has versioning enabled.

  -c             If an error occurs, continue to attempt to copy the remaining
                 files. If any copies were unsuccessful, gsutil's exit status
                 will be non-zero even if this flag is set. This option is
                 implicitly set when running "gsutil -m cp...". Note: -c only
                 applies to the actual copying operation. If an error occurs
                 while iterating over the files in the local directory (e.g.,
                 invalid Unicode file name) gsutil will print an error message
                 and abort.

  -D             Copy in "daisy chain" mode, i.e., copying between two buckets
                 by hooking a download to an upload, via the machine where
                 gsutil is run. This stands in contrast to the default, where
                 data are copied between two buckets "in the cloud", i.e.,
                 without needing to copy via the machine where gsutil runs.

                 By default, a "copy in the cloud" when the source is a
                 composite object will retain the composite nature of the
                 object. However, Daisy chain mode can be used to change a
                 composite object into a non-composite object. For example:

                     gsutil cp -D -p gs://bucket/obj gs://bucket/obj_tmp
                     gsutil mv -p gs://bucket/obj_tmp gs://bucket/obj

                 Note: Daisy chain mode is automatically used when copying
                 between providers (e.g., to copy data from Google Cloud Storage
                 to another provider).

  -e             Exclude symlinks. When specified, symbolic links will not be
                 copied.

  -I             Causes gsutil to read the list of files or objects to copy from
                 stdin. This allows you to run a program that generates the list
                 of files to upload/download.

  -L <file>      Outputs a manifest log file with detailed information about
                 each item that was copied. This manifest contains the following
                 information for each item:

                 - Source path.
                 - Destination path.
                 - Source size.
                 - Bytes transferred.
                 - MD5 hash.
                 - UTC date and time transfer was started in ISO 8601 format.
                 - UTC date and time transfer was completed in ISO 8601 format.
                 - Upload id, if a resumable upload was performed.
                 - Final result of the attempted transfer, success or failure.
                 - Failure details, if any.

                 If the log file already exists, gsutil will use the file as an
                 input to the copy process, and will also append log items to
                 the existing file. Files/objects that are marked in the
                 existing log file as having been successfully copied (or
                 skipped) will be ignored. Files/objects without entries will be
                 copied and ones previously marked as unsuccessful will be
                 retried. This can be used in conjunction with the -c option to
                 build a script that copies a large number of objects reliably,
                 using a bash script like the following:

                   until gsutil cp -c -L cp.log -r ./dir gs://bucket; do
                     sleep 1
                   done

                 The -c option will cause copying to continue after failures
                 occur, and the -L option will allow gsutil to pick up where it
                 left off without duplicating work. The loop will continue
                 running as long as gsutil exits with a non-zero status (such a
                 status indicates there was at least one failure during the
                 gsutil run).

                 Note: If you're trying to synchronize the contents of a
                 directory and a bucket (or two buckets), see
                 "gsutil help rsync".

  -n             No-clobber. When specified, existing files or objects at the
                 destination will not be overwritten. Any items that are skipped
                 by this option will be reported as being skipped. This option
                 will perform an additional GET request to check if an item
                 exists before attempting to upload the data. This will save
                 retransmitting data, but the additional HTTP requests may make
                 small object transfers slower and more expensive.

  -p             Causes ACLs to be preserved when copying in the cloud. Note
                 that this option has performance and cost implications when
                 using  the XML API, as it requires separate HTTP calls for
                 interacting with ACLs. (There are no such performance or cost
                 implications when using the -p option with the JSON API.) The
                 performance issue can be mitigated to some degree by using
                 gsutil -m cp to cause parallel copying. Note that this option
                 only works if you have OWNER access to all of the objects that
                 are copied.

                 You can avoid the additional performance and cost of using
                 cp -p if you want all objects in the destination bucket to end
                 up with the same ACL by setting a default object ACL on that
                 bucket instead of using cp -p. See "gsutil help defacl".

                 Note that it's not valid to specify both the -a and -p options
                 together.

  -P             Causes POSIX attributes to be preserved when objects are
                 copied. With this feature enabled, gsutil cp will copy fields
                 provided by stat. These are the user ID of the owner, the group
                 ID of the owning group, the mode (permissions) of the file, and
                 the access/modification time of the file. For downloads, these
                 attributes will only be set if the source objects were uploaded
                 with this flag enabled.

                 On Windows, this flag will only set and restore access time and
                 modification time. This is because Windows doesn't have a
                 notion of POSIX uid/gid/mode.

  -R, -r         The -R and -r options are synonymous. Causes directories,
                 buckets, and bucket subdirectories to be copied recursively.
                 If you neglect to use this option for an upload, gsutil will
                 copy any files it finds and skip any directories. Similarly,
                 neglecting to specify this option for a download will cause
                 gsutil to copy any objects at the current bucket directory
                 level, and skip any subdirectories.

  -s <class>     The storage class of the destination object(s). If not
                 specified, the default storage class of the destination bucket
                 is used. Not valid for copying to non-cloud destinations.

  -U             Skip objects with unsupported object types instead of failing.
                 Unsupported object types are Amazon S3 Objects in the GLACIER
                 storage class.

  -v             Requests that the version-specific URL for each uploaded object
                 be printed. Given this URL you can make future upload requests
                 that are safe in the face of concurrent updates, because Google
                 Cloud Storage will refuse to perform the update if the current
                 object version doesn't match the version-specific URL. See
                 "gsutil help versions" for more details.

  -z <ext,...>   Applies gzip content-encoding to any file upload whose
                 extension matches the -z extension list. This is useful when
                 uploading files with compressible content (such as .js, .css,
                 or .html files) because it saves network bandwidth and space
                 in Google Cloud Storage, which in turn reduces storage costs.

                 When you specify the -z option, the data from your files is
                 compressed before it is uploaded, but your actual files are
                 left uncompressed on the local disk. The uploaded objects
                 retain the Content-Type and name of the original files but are
                 given a Content-Encoding header with the value "gzip" to
                 indicate that the object data stored are compressed on the
                 Google Cloud Storage servers.

                 For example, the following command:

                   gsutil cp -z html -a public-read \
                     cattypes.html tabby.jpeg gs://mycats

                 will do all of the following:

                 - Upload the files cattypes.html and tabby.jpeg to the bucket
                   gs://mycats (cp command)
                 - Set the Content-Type of cattypes.html to text/html and
                   tabby.jpeg to image/jpeg (based on file extensions)
                 - Compress the data in the file cattypes.html (-z option)
                 - Set the Content-Encoding for cattypes.html to gzip
                   (-z option)
                 - Set the ACL for both files to public-read (-a option)
                 - If a user tries to view cattypes.html in a browser, the
                   browser will know to uncompress the data based on the
                   Content-Encoding header and to render it as HTML based on
                   the Content-Type header.

                 Note that if you download an object with Content-Encoding:gzip
                 gsutil will decompress the content before writing the local
                 file.

  -Z             Applies gzip content-encoding to file uploads. This option
                 works like the -z option described above, but it applies to
                 all uploaded files, regardless of extension.

                 Warning: If you use this option and some of the source files
                 don't compress well (e.g., that's often true of binary data),
                 this option may result in files taking up more space in the
                 cloud than they would if left uncompressed.
```


## Metadata
- **Docker Image**: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
- **Homepage**: https://cloud.google.com/storage/docs/gsutil
- **Package**: https://anaconda.org/channels/bioconda/packages/google-cloud-sdk/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
  du - Display object size usage


SYNOPSIS

  gsutil du url...



DESCRIPTION
  The du command displays the amount of space (in bytes) being used by the
  objects in the file or object hierarchy under a given URL. The syntax emulates
  the Linux du command (which stands for disk usage). For example, the command:

  gsutil du -s gs://your-bucket/dir

  will report the total space used by all objects under gs://your-bucket/dir and
  any sub-directories.


OPTIONS
  -0          Ends each output line with a 0 byte rather than a newline. This
              can be useful to make the output more easily machine-readable.

  -a          Includes non-current object versions / generations in the listing
              (only useful with a versioning-enabled bucket). Also prints
              generation and metageneration for each listed object.

  -c          Includes a grand total at the end of the output.

  -e          A pattern to exclude from reporting. Example: -e "*.o" would
              exclude any object that ends in ".o". Can be specified multiple
              times.

  -h          Prints object sizes in human-readable format (e.g., 1 KiB,
              234 MiB, 2GiB, etc.)

  -s          Displays only the grand total for each argument.

  -X          Similar to -e, but excludes patterns from the given file. The
              patterns to exclude should be one per line.


EXAMPLES
  To list the size of all objects in a bucket:

    gsutil du gs://bucketname

  To list the size of all objects underneath a prefix:

    gsutil du gs://bucketname/prefix/*

  To print the total number of bytes in a bucket, in human-readable form:

    gsutil du -ch gs://bucketname

  To see a summary of the total bytes in the two given buckets:

    gsutil du -s gs://bucket1 gs://bucket2

  To list the size of all objects in a versioned bucket, including objects that
  are not the latest:

    gsutil du -a gs://bucketname

  To list all objects in a bucket, except objects that end in ".bak",
  with each object printed ending in a null byte:

    gsutil du -e "*.bak" -0 gs://bucketname

  To get a total of all buckets in a project with a grand total for an entire
  project:

      gsutil -o GSUtil:default_project_id=project-name du -shc
```


## Metadata
- **Docker Image**: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
- **Homepage**: https://cloud.google.com/storage/docs/gsutil
- **Package**: https://anaconda.org/channels/bioconda/packages/google-cloud-sdk/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
  ls - List providers, buckets, or objects


SYNOPSIS

  gsutil ls [-a] [-b] [-d] [-l] [-L] [-r] [-p proj_id] url...



LISTING PROVIDERS, BUCKETS, SUBDIRECTORIES, AND OBJECTS
  If you run gsutil ls without URLs, it lists all of the Google Cloud Storage
  buckets under your default project ID:

    gsutil ls

  (For details about projects, see "gsutil help projects" and also the -p
  option in the OPTIONS section below.)

  If you specify one or more provider URLs, gsutil ls will list buckets at
  each listed provider:

    gsutil ls gs://

  If you specify bucket URLs, gsutil ls will list objects at the top level of
  each bucket, along with the names of each subdirectory. For example:

    gsutil ls gs://bucket

  might produce output like:

    gs://bucket/obj1.htm
    gs://bucket/obj2.htm
    gs://bucket/images1/
    gs://bucket/images2/

  The "/" at the end of the last 2 URLs tells you they are subdirectories,
  which you can list using:

    gsutil ls gs://bucket/images*

  If you specify object URLs, gsutil ls will list the specified objects. For
  example:

    gsutil ls gs://bucket/*.txt

  will list all files whose name matches the above wildcard at the top level
  of the bucket.

  See "gsutil help wildcards" for more details on working with wildcards.


DIRECTORY BY DIRECTORY, FLAT, and RECURSIVE LISTINGS
  Listing a bucket or subdirectory (as illustrated near the end of the previous
  section) only shows the objects and names of subdirectories it contains. You
  can list all objects in a bucket by using the -r option. For example:

    gsutil ls -r gs://bucket

  will list the top-level objects and buckets, then the objects and
  buckets under gs://bucket/images1, then those under gs://bucket/images2, etc.

  If you want to see all objects in the bucket in one "flat" listing use the
  recursive ("**") wildcard, like:

    gsutil ls -r gs://bucket/**

  or, for a flat listing of a subdirectory:

    gsutil ls -r gs://bucket/dir/**

  If you want to see only the subdirectory itself, use the -d option:

    gsutil ls -d gs://bucket/dir


LISTING OBJECT DETAILS
  If you specify the -l option, gsutil will output additional information
  about each matching provider, bucket, subdirectory, or object. For example:

    gsutil ls -l gs://bucket/*.txt

  will print the object size, creation time stamp, and name of each matching
  object, along with the total count and sum of sizes of all matching objects:

       2276224  2012-03-02T19:25:17Z  gs://bucket/obj1
       3914624  2012-03-02T19:30:27Z  gs://bucket/obj2
    TOTAL: 2 objects, 6190848 bytes (5.9 MiB)

  Note that the total listed in parentheses above is in mebibytes (or gibibytes,
  tebibytes, etc.), which corresponds to the unit of billing measurement for
  Google Cloud Storage.

  You can get a listing of all the objects in the top-level bucket directory
  (along with the total count and sum of sizes) using a command like:

    gsutil ls -l gs://bucket

  To print additional detail about objects and buckets use the gsutil ls -L
  option. For example:

    gsutil ls -L gs://bucket/obj1

  will print something like:

    gs://bucket/obj1:
            Creation time:                    Fri, 21 Oct 2016 19:25:17 GMT
            Update time:                      Fri, 21 Oct 2016 21:17:59 GMT
            Storage class update time:        Fri, 21 Oct 2016 22:12:32 GMT
            Size:                             2276224
            Cache-Control:                    private, max-age=0
            Content-Type:                     application/x-executable
            ETag:                             5ca6796417570a586723b7344afffc81
            Generation:                       1378862725952000
            Metageneration:                   1
            ACL:
    [
      {
        "entity": "group-00b4903a97163d99003117abe64d292561d2b4074fc90ce5c0e35ac45f66ad70",
        "entityId": "00b4903a97163d99003117abe64d292561d2b4074fc90ce5c0e35ac45f66ad70",
        "role": "OWNER"
      }
    ]
    TOTAL: 1 objects, 2276224 bytes (2.17 MiB)

  Note that some fields above (time updated, storage class update time) are
  not available with the (non-default) XML API.

  Also note that the Storage class update time field does not display unless it
  differs from Creation time.

  See also "gsutil help acl" for getting a more readable version of the ACL.


LISTING BUCKET DETAILS
  If you want to see information about the bucket itself, use the -b
  option. For example:

    gsutil ls -L -b gs://bucket

  will print something like:

    gs://bucket/ :
            Storage class:                MULTI_REGIONAL
            Location constraint:          US
            Versioning enabled:           True
            Logging configuration:        None
            Website configuration:        None
            CORS configuration:           Present
            Lifecycle configuration:      None
            Labels:                       None
            Time created:                 Fri, 21 Oct 2016 19:25:17 GMT
            Time updated:                 Fri, 21 Oct 2016 21:17:59 GMT
            Metageneration:               1
            ACL:
    [
      {
        "entity": "group-00b4903a97163d99003117abe64d292561d2b4074fc90ce5c0e35ac45f66ad70",
        "entityId": "00b4903a97163d99003117abe64d292561d2b4074fc90ce5c0e35ac45f66ad70",
        "role": "OWNER"
      }
    ]
            Default ACL:
    [
      {
        "entity": "group-00b4903a97163d99003117abe64d292561d2b4074fc90ce5c0e35ac45f66ad70",
        "entityId": "00b4903a97163d99003117abe64d292561d2b4074fc90ce5c0e35ac45f66ad70",
        "role": "OWNER"
      }
    ]

  Note that some fields above (time created, time updated, metageneration) are
  not available with the (non-default) XML API.


OPTIONS
  -l          Prints long listing (owner, length).

  -L          Prints even more detail than -l.  Note: If you use this option
              with the (non-default) XML API it will generate an additional
              request per object being listed, which makes the -L option run
              much more slowly (and cost more) using the XML API than the
              default JSON API.

  -d          List matching subdirectory names instead of contents, and do not
              recurse into matching subdirectories even if the -R option is
              specified.

  -b          Prints info about the bucket when used with a bucket URL.

  -h          When used with -l, prints object sizes in human readable format
              (e.g., 1 KiB, 234 MiB, 2 GiB, etc.)

  -p proj_id  Specifies the project ID to use for listing buckets.

  -R, -r      Requests a recursive listing, performing at least one listing
              operation per subdirectory. If you have a large number of
              subdirectories and do not require recursive-style output ordering,
              you may be able to instead use wildcards to perform a flat
              listing, e.g.  `gsutil ls gs://mybucket/**`, which will generally
              perform fewer listing operations.

  -a          Includes non-current object versions / generations in the listing
              (only useful with a versioning-enabled bucket). If combined with
              -l option also prints metageneration for each listed object.

  -e          Include ETag in long listing (-l) output.
```


## Metadata
- **Docker Image**: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
- **Homepage**: https://cloud.google.com/storage/docs/gsutil
- **Package**: https://anaconda.org/channels/bioconda/packages/google-cloud-sdk/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
  cat - Concatenate object content to stdout


SYNOPSIS

  gsutil cat [-h] url...



DESCRIPTION
  The cat command outputs the contents of one or more URLs to stdout.
  While the cat command does not compute a checksum, it is otherwise
  equivalent to doing:

    gsutil cp url... -

  (The final '-' causes gsutil to stream the output to stdout.)


WARNING: DATA INTEGRITY CHECKING NOT DONE
  The gsutil cat command does not compute a checksum of the downloaded data.
  Therefore, we recommend that users either perform their own validation of the
  output of gsutil cat or use gsutil cp or rsync (both of which perform
  integrity checking automatically).


OPTIONS
  -h          Prints short header for each object. For example:

                gsutil cat -h gs://bucket/meeting_notes/2012_Feb/*.txt

              This would print a header with the object name before the contents
              of each text object that matched the wildcard.

  -r range    Causes gsutil to output just the specified byte range of the
              object. Ranges are can be of these forms:

                start-end (e.g., -r 256-5939)
                start-    (e.g., -r 256-)
                -numbytes (e.g., -r -5)

              where offsets start at 0, start-end means to return bytes start
              through end (inclusive), start- means to return bytes start
              through the end of the object, and -numbytes means to return the
              last numbytes of the object. For example:

                gsutil cat -r 256-939 gs://bucket/object

              returns bytes 256 through 939, while:

                gsutil cat -r -5 gs://bucket/object

              returns the final 5 bytes of the object.
```


## Metadata
- **Docker Image**: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
- **Homepage**: https://cloud.google.com/storage/docs/gsutil
- **Package**: https://anaconda.org/channels/bioconda/packages/google-cloud-sdk/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
  hash - Calculate file hashes


SYNOPSIS

  gsutil hash [-c] [-h] [-m] filename...



DESCRIPTION
  The hash command calculates hashes on a local file that can be used to compare
  with gsutil ls -L output. If a specific hash option is not provided, this
  command calculates all gsutil-supported hashes for the file.

  Note that gsutil automatically performs hash validation when uploading or
  downloading files, so this command is only needed if you want to write a
  script that separately checks the hash for some reason.

  If you calculate a CRC32c hash for the file without a precompiled crcmod
  installation, hashing will be very slow. See "gsutil help crcmod" for details.

OPTIONS
  -c          Calculate a CRC32c hash for the file.

  -h          Output hashes in hex format. By default, gsutil uses base64.

  -m          Calculate a MD5 hash for the file.
```


## Metadata
- **Skill**: generated

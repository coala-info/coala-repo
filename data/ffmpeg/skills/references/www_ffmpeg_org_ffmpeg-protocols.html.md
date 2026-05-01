* [![FFmpeg](img/ffmpeg3d_white_20.png)
  FFmpeg](.)
* [About](about.html)
* [News](index.html#news)
* [Download](download.html)
* [Documentation](documentation.html)
* [Community](community.html)
  + [Code of Conduct](community.html#Code-of-Conduct)
  + [Mailing Lists](contact.html#MailingLists)
  + [IRC](contact.html#IRCChannels)
  + [Forums](contact.html#Forums)
  + [Bug Reports](bugreports.html)
  + [Wiki](https://trac.ffmpeg.org)
  + [Conferences](https://trac.ffmpeg.org/wiki/Conferences)
* [Developers](developer.html)
  + [Source Code](download.html#get-sources)+ [Contribute](developer.html#Introduction)
    + [FATE](http://fate.ffmpeg.org)
    + [Code Coverage](http://coverage.ffmpeg.org)
    + [Funding through SPI](spi.html)
* More
  + [Donate](donations.html)
  + [Hire Developers](consulting.html)
  + [Contact](contact.html)
  + [Security](security.html)
  + [Legal](legal.html)

# FFmpeg Protocols Documentation

## Table of Contents

* [1 Description](#Description)
* [2 Protocol Options](#Protocol-Options)
* [3 Protocols](#Protocols)
  + [3.1 amqp](#amqp)
  + [3.2 async](#async)
  + [3.3 bluray](#bluray)
  + [3.4 cache](#cache)
  + [3.5 concat](#concat)
  + [3.6 concatf](#concatf)
  + [3.7 crypto](#crypto)
  + [3.8 data](#data)
  + [3.9 fd](#fd)
  + [3.10 file](#file)
  + [3.11 ftp](#ftp)
  + [3.12 gopher](#gopher)
  + [3.13 gophers](#gophers)
  + [3.14 http](#http)
    - [3.14.1 HTTP Cookies](#HTTP-Cookies)
  + [3.15 Icecast](#Icecast)
  + [3.16 ipfs](#ipfs)
  + [3.17 mmst](#mmst)
  + [3.18 mmsh](#mmsh)
  + [3.19 md5](#md5)
  + [3.20 pipe](#pipe)
  + [3.21 prompeg](#prompeg)
  + [3.22 rist](#rist)
  + [3.23 rtmp](#rtmp)
  + [3.24 rtmpe](#rtmpe)
  + [3.25 rtmps](#rtmps)
  + [3.26 rtmpt](#rtmpt)
  + [3.27 rtmpte](#rtmpte)
  + [3.28 rtmpts](#rtmpts)
  + [3.29 libsmbclient](#libsmbclient)
  + [3.30 libssh](#libssh)
  + [3.31 librtmp rtmp, rtmpe, rtmps, rtmpt, rtmpte](#librtmp-rtmp_002c-rtmpe_002c-rtmps_002c-rtmpt_002c-rtmpte)
  + [3.32 rtp](#rtp)
  + [3.33 rtsp](#rtsp)
    - [3.33.1 Muxer](#Muxer)
    - [3.33.2 Demuxer](#Demuxer)
    - [3.33.3 Examples](#Examples)
  + [3.34 sap](#sap)
    - [3.34.1 Muxer](#Muxer-1)
    - [3.34.2 Demuxer](#Demuxer-1)
  + [3.35 sctp](#sctp)
  + [3.36 srt](#srt)
  + [3.37 srtp](#srtp)
  + [3.38 subfile](#subfile)
  + [3.39 tee](#tee)
  + [3.40 tcp](#tcp)
  + [3.41 tls](#tls)
  + [3.42 dtls](#dtls)
  + [3.43 udp](#udp)
    - [3.43.1 Examples](#Examples-1)
  + [3.44 unix](#unix)
  + [3.45 zmq](#zmq)
* [4 See Also](#See-Also)
* [5 Authors](#Authors)

## [1 Description](#toc-Description)

This document describes the input and output protocols provided by the
libavformat library.

## [2 Protocol Options](#toc-Protocol-Options)

The libavformat library provides some generic global options, which
can be set on all the protocols. In addition each protocol may support
so-called private options, which are specific for that component.

Options may be set by specifying -option value in the
FFmpeg tools, or by setting the value explicitly in the
`AVFormatContext` options or using the `libavutil/opt.h` API
for programmatic use.

The list of supported options follows:

`protocol_whitelist list (input)`
:   Set a ","-separated list of allowed protocols. "ALL" matches all protocols. Protocols
    prefixed by "-" are disabled.
    All protocols are allowed by default but protocols used by an another
    protocol (nested protocols) are restricted to a per protocol subset.

## [3 Protocols](#toc-Protocols)

Protocols are configured elements in FFmpeg that enable access to
resources that require specific protocols.

When you configure your FFmpeg build, all the supported protocols are
enabled by default. You can list all available ones using the
configure option "–list-protocols".

You can disable all the protocols using the configure option
"–disable-protocols", and selectively enable a protocol using the
option "–enable-protocol=PROTOCOL", or you can disable a
particular protocol using the option
"–disable-protocol=PROTOCOL".

The option "-protocols" of the ff\* tools will display the list of
supported protocols.

All protocols accept the following options:

`rw_timeout`
:   Maximum time to wait for (network) read/write operations to complete,
    in microseconds.

A description of the currently available protocols follows.

### [3.1 amqp](#toc-amqp)

Advanced Message Queueing Protocol (AMQP) version 0-9-1 is a broker based
publish-subscribe communication protocol.

FFmpeg must be compiled with –enable-librabbitmq to support AMQP. A separate
AMQP broker must also be run. An example open-source AMQP broker is RabbitMQ.

After starting the broker, an FFmpeg client may stream data to the broker using
the command:

```
ffmpeg -re -i input -f mpegts amqp://[[user]:[password]@]hostname[:port][/vhost]
```

Where hostname and port (default is 5672) is the address of the broker. The
client may also set a user/password for authentication. The default for both
fields is "guest". Name of virtual host on broker can be set with vhost. The
default value is "/".

Multiple subscribers may stream from the broker using the command:

```
ffplay amqp://[[user]:[password]@]hostname[:port][/vhost]
```

In RabbitMQ all data published to the broker flows through a specific exchange,
and each subscribing client has an assigned queue/buffer. When a packet arrives
at an exchange, it may be copied to a client’s queue depending on the exchange
and routing\_key fields.

The following options are supported:

`exchange`
:   Sets the exchange to use on the broker. RabbitMQ has several predefined
    exchanges: "amq.direct" is the default exchange, where the publisher and
    subscriber must have a matching routing\_key; "amq.fanout" is the same as a
    broadcast operation (i.e. the data is forwarded to all queues on the fanout
    exchange independent of the routing\_key); and "amq.topic" is similar to
    "amq.direct", but allows for more complex pattern matching (refer to the RabbitMQ
    documentation).

`routing_key`
:   Sets the routing key. The default value is "amqp". The routing key is used on
    the "amq.direct" and "amq.topic" exchanges to decide whether packets are written
    to the queue of a subscriber.

`pkt_size`
:   Maximum size of each packet sent/received to the broker. Default is 131072.
    Minimum is 4096 and max is any large value (representable by an int). When
    receiving packets, this sets an internal buffer size in FFmpeg. It should be
    equal to or greater than the size of the published packets to the broker. Otherwise
    the received message may be truncated causing decoding errors.

`connection_timeout`
:   The timeout in seconds during the initial connection to the broker. The
    default value is rw\_timeout, or 5 seconds if rw\_timeout is not set.

`delivery_mode mode`
:   Sets the delivery mode of each message sent to broker.
    The following values are accepted:

    ‘`persistent`’
    :   Delivery mode set to "persistent" (2). This is the default value.
        Messages may be written to the broker’s disk depending on its setup.

    ‘`non-persistent`’
    :   Delivery mode set to "non-persistent" (1).
        Messages will stay in broker’s memory unless the broker is under memory
        pressure.

### [3.2 async](#toc-async)

Asynchronous data filling wrapper for input stream.

Fill data in a background thread, to decouple I/O operation from demux thread.

```
async:URL
async:http://host/resource
async:cache:http://host/resource
```

### [3.3 bluray](#toc-bluray)

Read BluRay playlist.

The accepted options are:

`angle`
:   BluRay angle

`chapter`
:   Start chapter (1...N)

`playlist`
:   Playlist to read (BDMV/PLAYLIST/?????.mpls)

Examples:

Read longest playlist from BluRay mounted to /mnt/bluray:

```
bluray:/mnt/bluray
```

Read angle 2 of playlist 4 from BluRay mounted to /mnt/bluray, start from chapter 2:

```
-playlist 4 -angle 2 -chapter 2 bluray:/mnt/bluray
```

### [3.4 cache](#toc-cache)

Caching wrapper for input stream.

Cache the input stream to temporary file. It brings seeking capability to live streams.

The accepted options are:

`read_ahead_limit`
:   Amount in bytes that may be read ahead when seeking isn’t supported. Range is -1 to INT\_MAX.
    -1 for unlimited. Default is 65536.

URL Syntax is

```
cache:URL
```

### [3.5 concat](#toc-concat)

Physical concatenation protocol.

Read and seek from many resources in sequence as if they were
a unique resource.

A URL accepted by this protocol has the syntax:

```
concat:URL1|URL2|...|URLN
```

where URL1, URL2, ..., URLN are the urls of the
resource to be concatenated, each one possibly specifying a distinct
protocol.

For example to read a sequence of files `split1.mpeg`,
`split2.mpeg`, `split3.mpeg` with `ffplay` use the
command:

```
ffplay concat:split1.mpeg\|split2.mpeg\|split3.mpeg
```

Note that you may need to escape the character "|" which is special for
many shells.

### [3.6 concatf](#toc-concatf)

Physical concatenation protocol using a line break delimited list of
resources.

Read and seek from many resources in sequence as if they were
a unique resource.

A URL accepted by this protocol has the syntax:

```
concatf:URL
```

where URL is the url containing a line break delimited list of
resources to be concatenated, each one possibly specifying a distinct
protocol. Special characters must be escaped with backslash or single
quotes. See [(ffmpeg-utils)the "Quoting and escaping"
section in the ffmpeg-utils(1) manual](ffmpeg-utils.html#quoting_005fand_005fescaping).

For example to read a sequence of files `split1.mpeg`,
`split2.mpeg`, `split3.mpeg` listed in separate lines within
a file `split.txt` with `ffplay` use the command:

```
ffplay concatf:split.txt
```

Where `split.txt` contains the lines:

```
split1.mpeg
split2.mpeg
split3.mpeg
```

### [3.7 crypto](#toc-crypto)

AES-encrypted stream reading protocol.

The accepted options are:

`key`
:   Set the AES decryption key binary block from given hexadecimal representation.

`iv`
:   Set the AES decryption initialization vector binary block from given hexadecimal representation.

Accepted URL formats:

```
crypto:URL
crypto+URL
```

### [3.8 data](#toc-data)

Data in-line in the URI. See <http://en.wikipedia.org/wiki/Data_URI_scheme>.

For example, to convert a GIF file given inline with `ffmpeg`:

```
ffmpeg -i "data:image/gif;base64,R0lGODdhCAAIAMIEAAAAAAAA//8AAP//AP///////////////ywAAAAACAAIAAADF0gEDLojDgdGiJdJqUX02iB4E8Q9jUMkADs=" smiley.png
```

### [3.9 fd](#toc-fd)

File descriptor access protocol.

The accepted syntax is:

```
fd: -fd file_descriptor
```

If `fd` is not specified, by default the stdout file descriptor will be
used for writing, stdin for reading. Unlike the pipe protocol, fd protocol has
seek support if it corresponding to a regular file. fd protocol doesn’t support
pass file descriptor via URL for security.

This protocol accepts the following options:

`blocksize`
:   Set I/O operation maximum block size, in bytes. Default value is
    `INT_MAX`, which results in not limiting the requested block size.
    Setting this value reasonably low improves user termination request reaction
    time, which is valuable if data transmission is slow.

`fd`
:   Set file descriptor.

### [3.10 file](#toc-file)

File access protocol.

Read from or write to a file.

A file URL can have the form:

```
file:filename
```

where filename is the path of the file to read.

An URL that does not have a protocol prefix will be assumed to be a
file URL. Depending on the build, an URL that looks like a Windows
path with the drive letter at the beginning will also be assumed to be
a file URL (usually not the case in builds for unix-like systems).

For example to read from a file `input.mpeg` with `ffmpeg`
use the command:

```
ffmpeg -i file:input.mpeg output.mpeg
```

This protocol accepts the following options:

`truncate`
:   Truncate existing files on write, if set to 1. A value of 0 prevents
    truncating. Default value is 1.

`blocksize`
:   Set I/O operation maximum block size, in bytes. Default value is
    `INT_MAX`, which results in not limiting the requested block size.
    Setting this value reasonably low improves user termination request reaction
    time, which is valuable for files on slow medium.

`follow`
:   If set to 1, the protocol will retry reading at the end of the file, allowing
    reading files that still are being written. In order for this to terminate,
    you either need to use the rw\_timeout option, or use the interrupt callback
    (for API users).

`seekable`
:   Controls if seekability is advertised on the file. 0 means non-seekable, -1
    means auto (seekable for normal files, non-seekable for named pipes).

    Many demuxers handle seekable and non-seekable resources differently,
    overriding this might speed up opening certain files at the cost of losing some
    features (e.g. accurate seeking).

`pkt_size`
:   Set the maximum packet size used for file I/O. A smaller value may reduce
    memory usage. A higher value may increase throughput especially with networked
    filesystems.

    For reading, if explicitly set, it overrides the default internal buffer size
    (32 KB) and limits the maximum amount of data read per operation.

    For writing, this sets the size of each write operation. The default is 256 KB
    for regular files, 32 KB otherwise.

### [3.11 ftp](#toc-ftp)

FTP (File Transfer Protocol).

Read from or write to remote resources using FTP protocol.

Following syntax is required.

```
ftp://[user[:password]@]server[:port]/path/to/remote/resource.mpeg
```

This protocol accepts the following options.

`timeout`
:   Set timeout in microseconds of socket I/O operations used by the underlying low level
    operation. By default it is set to -1, which means that the timeout is
    not specified.

`ftp-user`
:   Set a user to be used for authenticating to the FTP server. This is overridden by the
    user in the FTP URL.

`ftp-password`
:   Set a password to be used for authenticating to the FTP server. This is overridden by
    the password in the FTP URL, or by `ftp-anonymous-password` if no user is set.

`ftp-anonymous-password`
:   Password used when login as anonymous user. Typically an e-mail address
    should be used.

`ftp-write-seekable`
:   Control seekability of connection during encoding. If set to 1 the
    resource is supposed to be seekable, if set to 0 it is assumed not
    to be seekable. Default value is 0.

NOTE: Protocol can be used as output, but it is recommended to not do
it, unless special care is taken (tests, customized server configuration
etc.). Different FTP servers behave in different way during seek
operation. ff\* tools may produce incomplete content due to server limitations.

### [3.12 gopher](#toc-gopher)

Gopher protocol.

### [3.13 gophers](#toc-gophers)

Gophers protocol.

The Gopher protocol with TLS encapsulation.

### [3.14 http](#toc-http)

HTTP (Hyp
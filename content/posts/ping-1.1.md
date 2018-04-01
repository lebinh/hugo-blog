---
title: "ping 1.1 is the fastest ping"
date: 2018-04-01T10:09:59-07:00
---

[Today](https://en.wikipedia.org/wiki/April_Fools%27_Day)
seems like a good day to announce something, start something,
or just do anything a bit more "unusual".
So I decided to start writing for this forgotten blog.
Also, some company also launching
[something with a lot of 1](https://blog.cloudflare.com/announcing-1111/) too.
And while reading news around it, a little command surprised me:

```shell
$ ping 1.1
PING 1.1 (1.0.0.1): 56 data bytes
64 bytes from 1.0.0.1: icmp_seq=0 ttl=55 time=5.586 ms
64 bytes from 1.0.0.1: icmp_seq=1 ttl=55 time=5.877 ms
```

I know an IP address can either be specified in a dotted format (`a.b.c.d`)
or as a 32 bits integer (like `16777217`). But this is the first time I ever seen
one in this form, with just one `dot`. And being just `1.1`, this must be
the shorted looking IP address out there. Is it a `ping` only thing? Nope.

```shell
$ python
>>> import socket
>>> socket.gethostbyname('1.1')
'1.0.0.1'

$ dig @1.1 thisisbinh.me +short
104.27.176.141
104.27.177.141
```

Turn out, [at least  on Linux](http://man7.org/linux/man-pages/man3/inet_addr.3.html),
an IPv4 address can be specified in 4 ways:

<dl>
    <dt>
        a.b.c.d
    </dt>
    <dd>
        The "normal", most common one, each byte is specified by each of the four numbers.
    </dd>

    <dt>a.b.c</dt>
    <dd>
        The <code>a.b</code> part specify the first 2 bytes as normal
        but <code>c</code> is interpreted as a 16 bits value for the last 2 bytes.
    </dd>

    <dt>a.b</dt>
    <dd>
        Similarly, <code>a</code> specify the first byte and <code>b</code> is interpreted as a 24 bits value
        for the last 3 bytes.
    </dd>

    <dt>a</dt>
    <dd>
        The value is interpreted as a 32 bits value.
    </dd>
</dl>

So that how `1.1` is interpreted as the same as `1.0.1` or `1.0.0.1` for `ping` as well as other utilities. Also, try `ping 127.1`.

But that doesn't mean it can be used for the address everywhere you can type an IP address though. For example:

```shell
$ dig -x 1.0.0.1 +short
1dot1dot1dot1.cloudflare-dns.com.

$ dig -x 1.1 +short
# nothing
```

The subtle difference here is `1.1` is not being used, hence interpreted, as an IP address.
It is just a value used directly in a DNS query for the `PTR` record of `<IP address>.in-addr.arpa.`.
And a value in a DNS query is not being interpreted the same as an IP address.

```shell
$ dig -x 1.1 | grep -iA1 question
;; QUESTION SECTION:
;1.1.in-addr.arpa.      IN  PTR
```

Anyway, from now `ping 1.1` is my fastest (*to type*) command to test for Internet connectivity.

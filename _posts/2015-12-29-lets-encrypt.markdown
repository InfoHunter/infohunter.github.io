---
layout: post
title: 用Let’s Encrypt获取免费证书
date: 2015-12-29 22:00:00
---

# 什么是Let’s Encrypt

Let’s Encrypt是由ISRG提供的免费CA服务。ISRG，即Internet Security Research Group，是一个由多个组织和公司共同资助的、旨在提高互联网通信安全的非营利性公益组织。Let’s Encrypt的功能简单来说，就是基于ACME协议提供了一套自动化的证书管理服务，包括证书的签发、更新、撤销等功能，而且这一切还都是免费的。


# 什么是ACME

ACME是Automated Certificate Management Environment的缩写，是一种在证书申请者和CA之间进行自动认证域名有效性并执行DV级别证书签发/作废等操作的网络协议，ACME协议的通信格式使用JSON，并完全基于HTTPS在client和server之间。该协议正在标准化的进程当中，目前还并不是十分完善，最新的draft可以在如下地址查看：[https://github.com/ietf-wg-acme/acme](https://github.com/ietf-wg-acme/acme)

ACME协议本身比较独立，不仅仅是Let’s Encrypt在使用，也可以考虑和web服务器紧密集成，例如与tengine集成之后，就可以实现服务器主动发起证书新签发/过期续签的完全自动化，也就是获取到签发的证书之后，可以直接动态应用到tengine中，当然目前是没有此等功能的，后续如有机会也许能在tengine里实现一下。

# Let’s Encrypt的使用方法

使用起来非常简单，首先下载letsencrypt客户端：

~~~~~~~~~~
git clone https://github.com/letsencrypt/letsencrypt.git
~~~~~~~~~~

然后在源码目录中执行letsencrypt-auto命令，这个具体的执行方法可以自由选择，以本站为例，申请了两个域名：www.paulyang.cn和paulyang.cn的证书，使用的是指定web服务器html目录的方法。

~~~~
./letsencrypt-auto certonly -a webroot \
  --webroot-path /path/to/my/html/root \
    -d paulyang.cn -d www.paulyang.cn
~~~~

执行成功之后，会在

~~~~
/etc/letsencrypt/live/域名/
~~~~

目录中找到签发下来的证书连接和私钥连接，一般会有4个文件，分别是：

1. 域名证书文件
2. 签发域名证书的证书链文件
3. 域名证书+证书链文件
4. 私钥文件

所有文件均为PEM格式。

例如本站的情况是：

<span id="img1"><img src="images/certs_x.png" alt="certs" /></span>

N的名字，同时会用X509v3的SAN扩展添加多个域名，例如本站是两个：

<span id="img2"><img src="images/san_x.png" alt="san" /></span>

我们使用的时候需要的是3和4，将其配置在对应的web服务器中即可，例如我使用的是tengine，因此只需要在tengine的配置文件中添加对证书和私钥的私用即可：

~~~~
ssl_certificate /etc/letsencrypt/live/paulyang.cn/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/paulyang.cn/privkey.pem;
~~~~

letsencrypt-auto的其他用发可以用-h或者-h [topic]的方式查看，主要有如下几种方式：

* 使用apache插件进行自动的证书签发和安装
* 使用nginx插件自动进行证书签发和安装，这个目前是experimental，比较不稳定
* 使用standalone模式由letsencrypt客户端启动独立webserver完成认证
* 使用指定html根目录的方式完成认证

目前letsencrypt还处于beta阶段，可能会有不稳定的情况，不过鉴于签发证书也不是频率奇高之事，因此还是可以正常使用的，签发的证书的有效期是3个月。

国内DNS问题

根据国内DNS服务器提供商的差别，可能会出现使用某些DNS服务器导致从Let’s Encrypt服务器上无法解析网站域名的问题，我目前了解到的是DNSPod没问题，但是万网不行。

# Let’s Encrypt的原理

说到原理，因为Let’s Encrypt只验证域名的归属是否有效，而不关注线下的实体是否存在，所以Let’s Encrypt的本质上就是一个自动化了的证明域名控制权的过程。

大概的流程是这样：

1. letsencrypt客户端在要申请证书的域名所指向的web服务器上先生成一个公私钥对儿
2. letsencrypt客户端连接Let’s Encrypt的server端，就是连接CA申请开始认证
3. Let’s Encrypt的server端会发给letsencrypt客户端一些“任务”，由客户端完成以证明其有权控制域名，基本上是这样：
   <span id="img3"><img src="images/Screenshot-from-2016-01-10-001136.png" alt="s1" /></span>
   要求有两点，一个是用客户端生成的私钥对一个server指定的数据进行签名（上图中的9cf0b331），二是将server指定的内容放在服务器的指定位置上。

4. 在客户端按照server的要求完成上述任务后，通知server开始校验，如下图所示：
   <span id="img4"><img src="images/Screenshot-from-2016-01-10-001151.png" alt="s2" /></span>
   server端会首先使用letsencrypt客户端生成的公钥校验签名是否有效，之后再尝试下载待签发域名的指定位置下的内容并进行判断，如果全都没问题，则通知client验证通过
5. 之后就是证书的签发，letsencrypt客户端会发送给server端CSR，然后server端签发证书并发回给client，这些流程和普通CA都是相同的

Let’s Encrypt的网站是：[https://letsencrypt.org](https://letsencrypt.org)
代码托管位于GitHub：[https://github.com/letsencrypt/letsencrypt](https://github.com/letsencrypt/letsencrypt)

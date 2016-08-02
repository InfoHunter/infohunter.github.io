---
layout: post
title: 用Let’s Encrypt获取免费证书
date: 2015-12-29 22:00:00
---

# 什么是Let’s Encrypt

Let’s Encrypt是由ISRG提供的免费CA服务。ISRG，即Internet Security Research Group，是一个由多个组织和公司共同资助的、旨在提高互联网通信安全的非营利性公益组织。Let’s Encrypt的功能简单来说，就是基于ACME协议提供了一套自动化的证书管理服务，包括证书的签发、更新、撤销等功能，而且这一切还都是免费的。


# 什么是ACME

ACME是Automated Certificate Management Environment的缩写，是一种在证书申请者和CA之间进行自动认证域名有效性并执行DV级别证书签发/作废等操作的网络协议，ACME协议的通信格式使用JSON，并完全基于HTTPS在client和server之间。该协议正在标准化的进程当中，目前还并不是十分完善，最新的draft可以在如下地址查看：[https://github.com/ietf-wg-acme/acme](https://github.com/ietf-wg-acme/acme)

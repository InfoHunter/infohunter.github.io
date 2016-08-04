---
layout: post
title: Use CDN to provide HTTPS ability
date: 2016-08-04 22:00:00
---

Since GitHub Pages does not support HTTPS for custom domains, which means you cannot use your domain's certificate and this resutls in a 'common name' mismatch problem in the browsers.

I decide to use CDN to do the SSL offload job to solve this problem:

1. find a CDN provider who supports HTTPS
2. Get a SSL certificate for yourself, there are some vendors who provide FREE certificates, for instance, Alibaba Cloud and Let's Encrypt.
3. Upload Certificate and Private Key to your CDN provider
4. set username.github.io as origin of your domain

Everything is fine, except it might cost you a little money for CDN service.

I have asked GitHub when it could support HTTPS for custom domains, their staff answered as 'no recent plans', that's sad...

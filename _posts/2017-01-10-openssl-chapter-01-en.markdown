---
layout: post
title: Chapter 01 - A Brief History of OpenSSL
date: 2017-01-10 12:00:00
---

# A Brief History of OpenSSL

## SSL Protocol

When people talk about the history of Internet, a famous legacy name will be always mentioned, Netscape. This company, whose headquarters were located in California, made a huge contribution to the technical evolution of humanity, including JavaScript, Gecho, Project Mozilla and of course SSL protocol. Back in 1995, Netscape released the first production-ready version of SSL, SSL 2.0. In 1996, Netscape released the SSL 3.0 specification. At that point the era of encrypted Web traffic has begun. Taher Elgamal, who worked for Netscape as 'Chief Scientist' at that time, is recognized as 'father of SSL'.

> Taher Elgamal
> Dr. Taher Elgamal is the creator of the famous ElGamal asymmetric key encryption and signature algorithm  The widely used DSA algorithm is a variant of ElGamal signature algorithm. Dr. Taher Elgamal's Doctoral advisor was Martin Hellman, the 'H' in DH algorithm, and ElGammal alogorithm is based on DH key exchange algorithm. Dr. Taher Elgamal serves as CTO of Security at Salesforce.com.

Netscape has supported the SSL protocol in its own product line, including Netscape Navigator and FastTrack, Enterprise web server etc. on the server side. But since Netscape was an U.S. based company, due to limits on the export of cryptography from the U.S., Netscape's product could not be used outside the U.S. with strong encryption. For instance, at that time, Netscape's products were separated into a 'domestic version' and an 'international version'. For those 'international' products, symmetric key length was limited to 40-bit, the RSA private key was limited to 512-bit, and all of the above keys were easy to break even back in those days. Along with the rise of the Internet and open source software, many great cryptographic systems are widely used. Nowadays the effect of the cryptographic export limitations is greatly reduced, but those limits were indeed a problem back to the 1990s.

## SSLeay

In 1995 Tim Hudson, who worked for Bond University in Australia, had several projects which needed to use SSL. But, due to the export limits for cryptography from the U.S., the only way he could obtain SSL was to use the export version of Netscape products and purchase their license. According to Tim Hudson, that would have had some issues:

1. First, it required a patent license from RSA Data Security (now RSA Security LLC).
2. Second, it was expensive, USD 30,000 at that time.
3. Last, Netscape didn't offer strong encryption except weakened 40-bit export form.

From Tim Hudson's point of view, even though he used the expensive Netscape products, all he got was only weakened cryptography, which would not resolve the problems he met in his project, so at last he decided to implement a new SSL library from scratch and made it useful in his projects. Then Tim asked Eric Young, who was working for his Ph.D. in Bond University, to implement a new SSL library with him. Both Eric and Tim are Alumni of the University of Queensland. Since Eric had already implemented the DES cipher and had more spare time, they decided Eric would implement the new SSL library itself and Tim went to deal with application side compatibility, documentation and user issues. The new SSL library was named after Eric's full name 'Eric Andrew Young', SSLeay, read as S-S-L-E-A-Y. SSLeay supported SSLv2, SSLv3 and TLSv1, and most of its APIs are almost the same to today's OpenSSL. You can see some old documentation about SSLeay at http://www.umich.edu/~x509/ssleay/

In August 1998, Eric and Tim joined RSA Data Security, and developed SSL-C for RSA Data Security. SSL-C is an SSL SDK used in the BSAFE product of RSA Data Security. At the same time, SSLeay development stopped with no future releases. In 2007, Tim left RSA Data Security and returned to operate a company called Cryptsoft, which was started by Tim and Eric before they joined RSA Data Security. In 2012, Tim became a partner of the OpenSSL Foundation and a member of the core development team in 2014.

Previous to working for RSA Data Security, Eric and Tim worked at a company called C2Net for around one and a half years, developing SSLeay. This work experience led to the birth of OpenSSL.

## C2Net

C2Net was a company based in California that provided cryptographic software, founded in 1994. The products the company developed, including web browser, web server and proxy server software, etc, included full support for encryption to protect user's data. In 1997, C2Net opened a branch in Europe, C2Net Europe Ltd, with Mark J. Cox as the Managing Director. He was in charge of development of international products for C2Net. As the same time, Eric and Tim also joined C2Net in 1997, to develop SSLeay, which was used in those international products of C2Net to provide SSL and cryptographic functionality.

At that time, the primary product that C2Net offered was a web server named Stronghold which supported the SSL/TLS protocol and strong encryption alogorithms and competed with the Netscape web server software. Stronghold was the only one that provided strong encryption globally among commercial web server software products. That was because Stronghold was developed outside the United States (In Europe and Australia). Anyway, C2Net needed to pay for the RSA patent until it expired in 2000.

In 1998, Tim and Eric left C2Net, and joined RSA Data Security. In 2000, C2Net was acquired by Red Hat and Mark Cox worked as Senior Director of Product Security for Red Hat till now.

> C2Net
> C2Net played a very important role in the history of Internet security, read more at: https://awe.com/mark/history/c2net.html and more info about Stronghold at: https://awe.com/mark/history/stronghold.html

## OpenSSL

When Tim and Eric left C2Net in 1998, Mark decided to launch a new open source project to succeed SSLeay, OpenSSL. OpenSSL then replaced SSLeay in the C2Net products and was widely used as a successful open source software product.

From the first release 0.9.1c in 1998, to the latest 1.1.0 branch, the OpenSSL project has experinced ups and downs. The most significant event that ever influnced the project was the 'Heartbleed' vulnerability in 2014.

> Heartbleed
> http://heartbleed.com/, the impact is that attacker could read the memory data in HTTPS servers and eventually recover a lot of important information including private keys, user passwords etc.

After Heartbleed was disclosed, the Linux Foundation initiated a project named CII (Core Infrastructure Initiative), which aimed to help improve the quality of Internet infrastructure software. The CII project collaborated with companies including IBM, Microsoft, Intel, AWS, etc. to fund some key-role open source projects to help them be better and more secure. OpenSSL was among the first projects that were funded by CII undoubtedly and this ended the 'underfunded' status of OpenSSL, which  until then was receiving only about USD 2,000 per year in donations. CII sponsored two full-time OpenSSL core developers and with the goal of a well-developed OpenSSL.

At the time Heartbleed was disclosed, OpenSSL was independently forked by OpenBSD and Google, each pursuing their own SSL/TLS library. Their libraries were called LibreSSL (OpenBSD fork) and BoringSSL (Google fork). LibreSSL was forked from OpenSSL by OpenBSD in April 2014, with the goal of refactoring OpenSSL and enhancing security. The first release of LibreSSL was in July 2014 with the version 2.0.0. In LibreSSL, plenty of legacy and useless code were removed and some new features were introduced, such as ChaCha and Poly1305. In Jun 2014, Google forked OpenSSL as BoringSSL. BoringSSL didn't aim to replace OpenSSL as a generic SSL library, instead, it was more like a Google-customized SSL library to support Google's own requirements, and was primarily used in Chrome and Android.

According to Mark Cox, "OpenSSL is likely to be the most useful library for general purpose needs, and the changes post Heartbleed (having dedicated team members, responding to security issues, published policies, obtaining CII badging) should change the brand
impression to one which is positive". For LibreSSL and BoringSSL, OpenSSL likes to maintain good relationships with both teams and collaborates on security issues with them.

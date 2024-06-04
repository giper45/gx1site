+++
title = 'Web Application Hardening'
date = 2022-06-02T10:12:56+02:00
tags = ["sec", "hacking", "web security", "web"]
draft = true
+++


The problem of attacks on Web applications today is highly critical.
To understand it, simply observe the following diagram, which shows the number of Kaspersky web antivirus detections per second:

The average number of threats detected is about 200 per second! (You can see the threats in real time directly here.)
But what can we do to defend ourselves against attacks? In this whitepaper we explore a number of recommendations that may help you to increase the security level of your web applications.

## Recommendation #1: Know your enemy
My personal approach to security is an evil approach: my main activity (and passion) in security is that of Penetration Tester, that is to find vulnerabilities in a system. The knowledge of all threats allows me, when I wear the developer’s hat, to have a clear perception of what could happen if I don’t validate an input that interacts, for example, with a database (do you know which vulnerability I’m talking about right?).

Knowing one’s enemy practically means knowing vulnerabilities, preparing warriors (in our case web developers) for all possible attacks that the developed code could suffer in production, after the long efforts of code development. There are many useful sources for learning about the main vulnerabilities, but what I suggest is the following:


https://owasp.org/

**OWASP** is one of the most important security projects for web applications. An important source of reference is the so called OWASP Top 10, which illustrates the main web vulnerabilities over the years; the last 2 present on the site show a greater criticality due to the lack of logging and monitoring systems and deserialisation attacks.

A term widely used today in cybersecurity is **AWARENESS**, that is awareness, which corresponds to knowledge about the risks arising from a lack of attention to the use of security best practices. Security awareness is a corporate characteristic that should be imparted at every level of the company: manager, business area, development, etc..

In the case of vulnerabilities on web applications it is essential to organize lessons on the topic of computer security and secure code development for developers.
Is it enough to have a theoretical approach?
In our experience a full awareness of threats requires a practical approach to security. That is why in our training sessions we use [Docker Security Playground](https://github.com/DockerSecurityPlayground/DSP), open-source tool created by the undersigned to create network security scenarios. In this particular case we use DSP to create vulnerable web application scenarios and show developers the bad practices of code development.

## Recommendation #2: Know your code
As described in recommendation 1, it is essential to have a theoretical knowledge of the vulnerabilities that an attacker could exploit. Of course, it is equally essential for a web developer to have knowledge of secure code development practices.

This is a very important topic because many times, during programming courses, no reference is made to typical vulnerabilities such as XSS and SQL Injection. It would be important to create a manual with security rules for developers (internal or external vendors) that would be a guide during code development. The manual should be oriented to the technologies and frameworks used by the company. A good entrypoint is always OWASP: https://www.owasp.org/index.php/File:OWASP_Code_Review_Guide_v2.pdf

Here is a list of general rules to keep in mind at all times:


1. During Code Development:
  * Perform a full validation of the input coming from the user: if an input parameter interacts with a database, it should not contain quotes or characters that an SQL query could interpret, if an input parameter interacts with the file system, it should not contain ../ (why? If you can’t answer, you still need to learn the main issues about secure code development ! );
  * Use ORM to interact with database;
  * Use reference frameworks in the language you are using and follow the security best practices provided by the developers of the solution used. A comprehensive checklist of security controls can be found [here](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/)

  2. Strategies to decrease the risk of vulnerability in the code:
   * Create a company manual to train new developers on security issues. The best practice would be adopt courses of increasing complexity where a secure implementation of simple web components is required, but that interact with sensitive components of a system (database, network, file system).
  * Integrate Secure Code tools into your code development cycle. These tools use static source code analyzers to detect vulnerabilities before the code is released into production ( https://www.owasp.org/index.php/Source_Code_Analysis_Tools )
* Build a security team to perform Code Review on the code
Security Team should be indipendent from the Development team: look at this video:

![](https://www.youtube.com/watch?v=vJG698U2Mvo&t=3s)

Were you able to see something “particular”? If you haven’t, it’s completely normal! You were focused on the required lens, count the number of steps. It is called “selective attention”. When we are focused on a problem we cannot have a global view of a reality. The same is for development! Even the best developer may inadvertently insert vulnerabilities in the code, for different reasons. This is why best practice usually suggests having an independent security team to review the source code using static code scanning tools.


## Recommendation #3 Know other people’s code
You were looking for a Slideshow for your website and installed “WordPress Plugin Slideshow Gallery 1.4.6”. After a few days your website immediately undergoes a defacement … you wonder why?

The answer is here: https://www.exploit-db.com/exploits/34514

The plugin is vulnerable to “Arbitrary File Upload”: an attacker can compromise your web application by uploading arbitrary malicious php code!
The problem is that every day researchers, attackers and ethical hackers discover new vulnerabilities on third-party plugins and libraries. The main solution to this problem is to “know your code”, which means to stay constantly updated on the vulnerabilities in the libraries you use.

It is important:

1. Monitor the security of third-party libraries: there are known vulnerability databases (e.g. for WordPress https://wpvulndb.com/ ) that update and provide vulnerabilities of plugins and components used in web applications every day. To perform this activity it is essential to maintain a collection of libraries and components used by your code / framework. There are some tools that:
  * Allow you to create a taxonomy of third-party components used, such as [Fossa](https://fossa.com/).
  * Allow you to do an analysis of third-party libraries used by the source code and detect vulnerabilities, for example [OWASP Dependency Check](https://github.com/jeremylong/DependencyCheck)
  * Allow you to build an alert system when a new vulnerability is discovered; these systems usually integrate with code development processes, and allow you to block Continuous Integration builds if some third-party component is included in the code.
  * Build a collection of trusted third-party libraries that developers are bound to use. Where necessary, the developer may request to add a new library to the collection, but this will only be added after approval by a security team.
2. Minimize the number of third party components used in your application: the obsolete slideshow plugin is no longer needed for your application ? Uninstall! Remember that all that remains in your web application is an attack surface that exposes potential vulnerabilities. There are tools that will allow you to identify the unused plugin on your CMS. The same principle applies to developed code: if third-party libraries are no longer used, it is preferable to remove them.

3. Do not overlook security alerts provided by auditing tools, such as NPM:

These tools allow you to have a fundamental knowledge about the vulnerabilities recently detected in the modules.

## Recommendation #4: attack your code!
In a global security principle, the web application is one of the elements that make up a system. Therefore, it is essential to have a 360-degree view of security, and to carry out controls that also include system activities, regardless of the secure development of the code:

* Integrate Web Application Firewall into your web application. WAF systems identify malicious payloads and block requests containing these payloads. An effective open-source tool is https://modsecurity.org/
* Use a reliable service provider;
Minimize the number of publicly exposed TCP / UDP ports and services (to reduce the surface attack area).
* Implements the “minimum privilege principle” for services: a web service should NEVER run as root, but always as a low privilege user (e.g. apache, or tomcat). The same applies to the database service.
* Avoid using obsolete deployment systems like FTP, not secure by design, all traffic exchanged via ftp is completely clear, including credentials, so through Man In The Middle attacks you can easily get access to sensitive information. Rather use secure communication systems such as SFTP and SCP.
* If possible, disable write permission in the root folder of the web application: this will make it difficult for an attacker who has identified a vulnerability on your web application to exploit it.
* Implement Intrusion Detection Systems on your systems to detect traffic anomalies.
* If your system has an administrative interface used only by the owner of the portal, do not make it public, but filter access on an IP basis or through Virtual Private Network solutions. Why wp-login.php must be public if only a single person accesses it from the office?


## Conclusions
Here ends this brief overview on how to make a web application more secure. Obviously it is not possible to enclose in a few pages such a complex discourse as security, but I hope that this whitepaper can be useful to have an overview of security issues in the web and a clue to address them. The purpose of this reading was mainly to stimulate curiosity to generate knowledge (and awareness!), I hope I succeeded in doing so. 





























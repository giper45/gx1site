+++
title = 'Web Application Hacking - An introduction'
date = 2023-03-01T10:21:36+02:00
tags = ["sec", "hacking", "web security", "web"]
draft = false
+++


When trying to find a methodology for performing a Penetration Test against a Web Application (meaning those that are accessed using a browser to communicate with a web browser), one should keep in mind that Hackers’ activities to find new vulnerabilities always involve a great deal of creativity. It is possible, though, to explore all the regions of the application’s attack surface and gain some assurance to have found a large number of issues, according to the resources available.


## Web Hacker Methodology

This amazing image taken from [Web Application Hacker’s Handbook](https://portswigger.net/web-security/web-application-hackers-handbook) describe the process of attacking a web application:

![alt text](/images/hacking-steps.png)



It summarizes the methodology that a web application penetration tester adopts when approaching to the study of the target’s website.

Hacking Web application is divided in into two phases:

1. The penetration tester attempts to create a “footprint” of the web application.

  * This includes gathering its visible content, exploring public resources as well as discovering the information that appear to be hidden. It is also possible, even in this early stage, to identify those application functions that are accessed by passing an identifier of the function in a request parameter (for example /main.php?func=A21);
  * Analyze the application and identify its core functionalities, especially those the web application was designed for. The purpose is to have a map of all the possible Data Entry Points that the application exposes, which are the main flaw that a hacker recognizes in the target application. The penetration tester in this phase should also be able to recognize the technologies that concur to create a core functionality. At the end of this stage, the hacker usually has a clear idea of the path to follow in order to apply the attacks;

2. In the second phase, the penetration tester knows which road to take and whether to focus on the way the application handles the inputs or on probable flaws in its logic. To have a comprehensive understanding of the application’s holes it is however important to explore all the following areas:
  * Focusing on the application logic means studying the Client-Side Controls to find a way to bypass them. Usually an attacker with minimal skills and equipped with simple tools is enough to circumvent most controls. However, it is important to identify all data being transmitted via the client to understand the validation supplied and test how the server responds. All different matter is attacking the application’s logic, which involves a great amount of lateral thinking. There are some basic tests, which involve removing parameters from requests, using forced browsing to access functions out of sequence and submitting parameters to different locations within the application. How the application responds to these requests can be a sign of some defective behavior that can lead to a malicious effect.

  * The stage that involves analyzing how the application handles access to private functionalities might be the one to focus on immediately, because authentication and session management techniques are usually full of design and implementation flaws. Attacking authentication can be done systematically, for example checking for bad passwords, ways to find out usernames or vulnerability to brute-force attacks. The session management mechanism is often a rich source of potential vulnerabilities. Its role is to identify the same user among different requests. Breaking this mechanism means jumping into a user’s session. If that user has administrator privileges, this usually allows to compromise the entire application. Less systematic is attacking access controls, because they can manifest in different ways and arise from different sources. In many cases, finding a break in access controls can be done by simply requesting an administrative URL and gain direct access to the functionality. In other cases, it can be very hard, mostly because these kinds of errors can derive from deep application logic defects.
  * Input Handling attacking techniques are definitely the most well-known, because important categories of vulnerabilities are triggered by unexpected user input. The application can be probed by fuzzing the parameters passed in a request. See the next section for insights on this topic.

The website can represent an entry point that allows the attacker to have a complete understanding of the target’s network infrastructure. Defects and oversights within an application’s architecture often can enable the tester to escalate an attack, moving from one component to another to eventually compromise the entire application.
Shared hosting and ASP-based environments present a new range of difficult security problems, involving trust boundaries that do not arise within a single-hosted application. When attacking an application in a shared context, a key focus of the efforts should be the shared environment itself. One should try to ascertain whether it is possible to compromise that environment from within an individual application, or to leverage one vulnerable application to attack others.

Furthermore, the web server represents a significant area of attack surface via which an application may be compromised. Defects in an application server can often directly undermine an application’s security by giving access to directory listings, source code for executable pages, sensitive configuration and runtime data, and the ability to bypass input filters. This is an area where automated tools can become very useful, giving the great amount of web server implementations which require a long process of reconnaissance.

## How to learn Web Hacking?
You do not need to go to jail to learn Web Hacking!
1. Port Swigger Labs: When you talk about web hacking you cannot cite Port Swigger. Port Swigger offers some of the best training labs available for web applications;
2. Vulnerable Web Applications: There are a lot of vulnerable web application that can be used as source to train Web Application Hacking, for example bodgeit, webgoat, juice-shop
3. Docker Security Playground: Docker Security Playground is an open-source Platform to run Penetration Test Lab Scenarios. Available on github
4. Vulnhub: A complete list of vulnerable [virtual machines](https://www.vulnhub.com/) and [docker environments](https://github.com/vulhub/vulhub).
A great mind map about learning Hacking is [here](https://www.amanhardikar.com/mindmaps/Practice.html). The following resources are listed to learn Web Application Hacking:

|            Vulnerable Web App           |                                        Url                                       |
|:---------------------------------------:|:--------------------------------------------------------------------------------:|
| BadStore                                | http://www.badstore.net/                                                         |
| BodgeIt Store                           | http://code.google.com/p/bodgeit/                                                |
| Butterfly Security Project              | http://thebutterflytmp.sourceforge.net/                                          |
| bWAPP                                   | http://www.mmeit.be/bwapp/ http://sourceforge.net/projects/bwapp/files/bee-box/  |
| Commix                                  | https://github.com/stasinopoulos/commix-testbed                                  |
| CryptOMG                                | https://github.com/SpiderLabs/CryptOMG                                           |
| Damn Vulnerable Node Application (DVNA) | https://github.com/quantumfoam/DVNA/                                             |
| Damn Vulnerable Web App (DVWA)          | http://www.dvwa.co.uk/                                                           |
| Damn Vulnerable Web Services (DVWS)     | http://dvws.professionallyevil.com/                                              |
| Drunk Admin Web Hacking Challenge       | https://bechtsoudis.com/work-stuff/challenges/drunk-admin-web-hacking-challenge/ |
| Exploit KB Vulnerable Web App           | http://exploit.co.il/projects/vuln-web-app/                                      |
| Foundstone Hackme Bank                  | http://www.mcafee.com/us/downloads/free-tools/hacme-bank.aspx                    |
| Foundstone Hackme Books                 | http://www.mcafee.com/us/downloads/free-tools/hacmebooks.aspx                    |
| Foundstone Hackme Casino                | http://www.mcafee.com/us/downloads/free-tools/hacme-casino.aspx                  |
| Foundstone Hackme Shipping              | http://www.mcafee.com/us/downloads/free-tools/hacmeshipping.aspx                 |
| Foundstone Hackme Travel                | http://www.mcafee.com/us/downloads/free-tools/hacmetravel.aspx                   |
| GameOver                                | http://sourceforge.net/projects/null-gameover/                                   |
| hackxor                                 | http://hackxor.sourceforge.net/cgi-bin/index.pl                                  |
| Hackazon                                | https://github.com/rapid7/hackazon                                               |
| LAMPSecurity                            | http://sourceforge.net/projects/lampsecurity/                                    |
| Moth                                    | http://www.bonsai-sec.com/en/research/moth.php                                   |
| NOWASP / Mutillidae 2                   | http://sourceforge.net/projects/mutillidae/                                      |
| OWASP BWA                               | http://code.google.com/p/owaspbwa/                                               |
| OWASP Hackademic                        | http://hackademic1.teilar.gr/                                                    |
| OWASP SiteGenerator                     | https://www.owasp.org/index.php/Owasp_SiteGenerator                              |
| OWASP Bricks                            | http://sourceforge.net/projects/owaspbricks/                                     |
| OWASP Security Shepherd                 | https://www.owasp.org/index.php/OWASP_Security_Shepherd                          |
| PentesterLab                            | https://pentesterlab.com/                                                        |
| PHDays iBank CTF                        | http://blog.phdays.com/2012/05/once-again-about-remote-banking.html              |
| SecuriBench                             | http://suif.stanford.edu/~livshits/securibench/                                  |
| SentinelTestbed                         | https://github.com/dobin/SentinelTestbed                                         |
| SocketToMe                              | http://digi.ninja/projects/sockettome.php                                        |
| sqli-labs                               | https://github.com/Audi-1/sqli-labs                                              |
| MCIR (Magical Code Injection Rainbow)   | https://github.com/SpiderLabs/MCIR                                               |
| sqlilabs                                | https://github.com/himadriganguly/sqlilabs                                       |
| VulnApp                                 | http://www.nth-dimension.org.uk/blog.php?id=88                                   |
| PuzzleMall                              | http://code.google.com/p/puzzlemall/                                             |
| WackoPicko                              | https://github.com/adamdoupe/WackoPicko                                          |
| WAED                                    | http://www.waed.info                                                             |
| WebGoat.NET                             | https://github.com/jerryhoff/WebGoat.NET/                                        |
| WebSecurity Dojo                        | http://www.mavensecurity.com/web_security_dojo/                                  |
| XVWA                                    | https://github.com/s4n7h0/xvwa                                                   |
| Zap WAVE                                | http://code.google.com/p/zaproxy/downloads/detail?name=zap-wave-0.1.zip          |









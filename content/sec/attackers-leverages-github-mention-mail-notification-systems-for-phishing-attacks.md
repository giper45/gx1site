+++
title = 'Attackers Leverages Github Mention Mail Notification Systems for Phishing Attacks'
date = 2024-05-31T18:54:03+02:00
draft = false
tags = ["sec", "phishing"]
+++


This morning I woke up with an email from GitHub that seemed pretty accurate

![alt text](/bump.png)

It seemed a mail from GitHub, and at the first glance I did not realize that it was a phishing. However, (even when I recover from my sleep), I analyzed it better.

## Discover the phishing attempt
The “here” link pointed to:

```
https://githubtalentcommunity.githubcareers.online/ # THIS IS MALICIOUS
```
There are difference indicators of the presence of a phishing attack.

## Evidence #1: googling
By googling it is possible to observe that the real domain for Job careers at Github is **github.careers**.

Another indicator is looking for “Job fraud attacks via GitHub”. There are several relevant issue related to phishing attacks through fake GitHub job alerts.

{{< attr class="image-container">}}
<img src="/images/job-fraud.png">
<!-- ![alt text](/images/job-fraud.png) -->
{{< /attr >}}





## Evidence 2: domain lookup
A quick search of the domain let me to discover that the domain was hosted on a EC2 AWS instance subjected to several abuses

![](/ip-abuse.png)




GitHub does not use AWS but has its hosted servers.

Furthermore, if you perform a whois request at the GitHub domain, you can obtain a lot of relevant information about the organization:

[github.com](https://www.whois.com/whois/github.com)

![](/images/whois-github.png)

The malicious domain did not belong to GitHub.

[https://www.whois.com/whois/githubcareers.online](https://www.whois.com/whois/githubcareers.online)

![](/images/whois-githubcareers.png)

This confirms my suspects. After the discovery, I quickly notify the other users, then I analyzed the attack.


## Analyze the attack
The attack involves two steps:
* email issue notification mechanism that is able to send a mail from the real GitHub address “notifications@github.com” through the email issue notification mechanism that sends you an email when you are mentioned inside an issue.
* OAuth mechanism to obtain privileges on your personal GitHub account

## Phishing attack
By a quick analysis, the starting username was **vishalgupta1987**.

This user adds a comment to an automatic PR performed from autobot, a service to automate the update of packages on GitHub:

```
“Re: [adeelahmad/actionsflow-workflow-default] Bump moment-timezone from 0.5.34 to 0.5.43 (PR #2)”
```

The attackers added an issue to the pull request #2 that triggers an email notification against our accounts

![](/images/abuse-vishal.png)


## What happens if you have been phished?

GitHub quickly disabled the account, but the email is still present in our mailboxes, the domain is still active, and the impact can still be dangerous:

* **Integrity**: The most dangerous permission is DELETE REPO: by accepting, you allow to DELETE any of your repository
* **Authentication**: the application is able to create internal discussions in place of the real user by potentially compromising other users
* **Confidentiality**: the application can read each internal repository (even those related to the teams)

The attacker tries to obtain privileges on your GitHub account by using the OAuth mechanism, which is used to allow external applications to use resources on behalf of the user. It is a very useful approach to integrate external systems with another application, but it can be pretty dangerous if the external system is not trusted (such as in this case).


![](/images/oauth-attack.png)

After the attacker adds the issue in the pull request:

GitHub notifies the victim about the opened issues that were mentioned to you.
If the victim clicks on the link, he/she is redirected to the malicious website
The malicious website redirects the victim to the GitHub OAuth permission page
![alt text](githubcareersoauth.png)

1. GitHub asks to grant the following permissions:


![alt text](/images/authorizationgithub.png)

The request leverages the OAuth mechanism to obtain the following permissions from GitHub:

- repo user read:org
- read:discussion
- gist write:discussion
- delete_repo


1. If the victim clicks on “Authorize confirmautorizan” he/she is giving those permissions to the attacker
2. The attacker owns the personal repos of the victim.

## How did I responded to the incident?
Actually, I proceeded with the following steps:

- Notify GitHub to suggest to check the account that is has been using for performing phishing attacks
- Send a spam abuse to whois about the malicious domain
- Notify the GitHub users that they were victims of a phishing attack. The fastest approach to notify them is… using [GitHub](https://github.com/giper45/github-phishing-notifications/issues/1)! I have created a repository with an issue mentioning users under attack. In this way, through the same attacker mechanism, I have notified the users.


After an hour, GitHub removed the vishalgupta1987 account.

However, it seemed to be an active account; the attacker probably hacked the username and used it as an entry point for the phishing attack. Hope that GitHub will enable it after the incident response.


## Countermeasures
Unfortunately, it is impossible to protect ourselves against this attack because it exploits the flexible features of GitHub repositories. However, it is possible to use some countermeasures:


- Even if it does not protect against comments’ abuse, you can opt for a “signature check” for commits (see [Protected Branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches))
- If your projects are critical and sensitive for the company, you could opt for a local Git instance and use GitHub for public projects and personal projects. You can use several interesting alternatives, such as [GitLab](https://about.gitlab.com/) or [Gitea](https://about.gitea.com/)

- You can set up a SecDevOps process that checks for user commits and issues to respond to such incidents
Follow the best practices provided by [GitHub](https://docs.github.com/en/code-security/getting-started/github-security-features) to harden your account.
















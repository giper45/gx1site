+++
title = 'Leveraging Docker + VSCode to study web vulnerabilities'
date = 2024-06-04T08:26:31+02:00
tags = ["sec", "hacking", "web security", "web", "vscode", "docker"]
draft = false
+++


Have you ever studied Docker? If you are a passionate about web hacking, study it! In this Post I am going to persuade you that using Docker to study web vulnerabilities is a good thing! If you want to understand more about this post, please follow [Docker Documentation](https://www.docker.com/get-started/)

## How do you find vulnerabilities?
There are several techniques:

- Fuzzing
- Studying source code
- Run and debug source code

Regardless of the technical skill that you are going to use, you need to **reproduce a vulnerable environment**. To understand more about the vulnerability, you need to look at server logs (mysql, apache, etc.). In all these things, docker comes to you.


## Dockerhub + github: find your vulnerable environment

Docker is great for developers for several reasons. You can find everything … dockerhub is a public repository containing a thousand and more of docker images. We can look for docker vulnerable images of course. And you can also use github to look at vulnerable envrionment. You can search for CVE, vulnerability name, or service name. An interesting project that stores vulneable docker environments is https://github.com/vulhub/vulhub.




## VSCode and Docker
Depending on what you’re studying, you need to set breakpoints, or print debug instructions to see the result of your investigation . Docker can be fully integrated in VSCode, by using this extension:

![alt text](/images/docker-extension.png)


Once you have installed it, you will have an easy docker icon containing all your running containers:


![alt text](/images/wordpress-vscode-example.png)


As you can see in the Figure, I am studying a vulnerability in WordPress with php5.6. I have inserted an “error_log function” that prints “PIPPOZZO” and I am watching logs in the panel below. I can study my vulnerability with a full integrated IDE with Docker Support. Of course, you could also something like Portainer.


## When does docker support ends for the study of vulnerabilities?

Docker support ends when you are studying specific types of vulnerabilities, for example:


- Windows vulnerabilities.
- Low-level kernel vulnerabilities

If you need to overcome these limits, you can use hypervisor-level-2 virtualization techniques, such as Virtualbox and VmWare. I usually use [Vagrant](https://www.vagrantup.com/) to build vulnerability environments.

## Practical Example: PHP unserialize() Object Injection in Yet Another Stars Rating

I was going to study the unsafe deserialization vulnerability in Yet Another Stars Rating wordpress plugin https://wpscan.com/vulnerability/9207.


A great explanation about this vulnerability is present in https://dannewitz.ninja/posts/php-unserialize-object-injection-yet-another-stars-rating-wordpress

It just misses two bits of information:
- phpgcc serialization gadget does not work anymore. I think that something changes in Requests_Utility_FilteredIterator implementation
- WordPress core should be < 5.5.2 to exploit Requests_Utility_FilteredIterator: for a security update, WP removes deserialization for this class (https://www.wordfence.com/blog/2020/11/unpacking-the-wordpress-5-5-2-5-5-3-security-release/)

### Develop the core environment
I was looking for a wordpress docker environment. Of course, you can use official images from dockerhub:
https://hub.docker.com/_/wordpress
Anyway, I would like to have a php5.6 support to study the serialization vulnerability in this context.

A search for the following string in google:
```
wordpress php5.6 docker-compose
```

Gives me this interesting framework:

https://github.com/khaledsaikat/wordpress-php56-docker

This uses docker-compose. Docker-compose is a wonderful way to run multiples Docker services by configuring it in a single file, through an Infrastructure as Code approach. Take a look

I download it and try to execute it:

docker-compose up --build

Now I can see the environment present on the left in docker VSCode panel.


## Configure the environment
As I said, our vulnerable environment should contain a wordpress version < 5.5.2 . downloaded wordpress github uses latest version, so I need to apply some changes to reproduce the vulnerable environment:

![alt text](/images/colordiff-wp.png)

Now I restart WordPress:

```
docker-compose down && docker-compose up -d --build
```

As I repeat this command a million times, I put it in a Linux alias:

```
alias dcr="docker-compose down && docker-compose up -d --build"
```

Just type dcr to update the docker environment.

It is time to install the vulnerable plugin:

https://downloads.wordpress.org/plugin/yet-another-stars-rating.1.8.6.zip

Install and activate it in running environment.
### Logs and view source code in VS Code
I can view logs, or attach a shell inside the running WordPress container. Anyway, the first thing that I have to do is find a way to navigate files through VSCode: I am going to study the vulnerability, by printing information, by studying information taken from dannez post. For this reason, I want to bind docker volume in my host.

I copy the running environment in my host, then I map the local volume in the docker-compose:

![alt text](/images/binding.png)

Now I can change the source code of WordPress and I am able to see the changes in wordpress:


![alt text](/images/pippozzo.png)

I have written `error_log(“PIPPOZZO”)` in wordpress-php56-docker/website/wp-content/plugins/yet-another-stars-rating/lib/yasr-shortcode-functions.php file, inside shortcode_visitore_votes_callback.

It is a callback for [yasr_visitor_votes] wp shortcode . In order to reach the error_log instruction, put a shortcode in a page and navigate it with a simple GET request.

Attach to running wordpress container, and you can see the instruction:


```
[Mon Dec 14 07:26:06.113505 2020] [:error] [pid 27] [client 192.168.74.1:27879] PIPPOZZO192.168.74.1 - - [14/Dec/2020:07:26:05 +0000] "GET /?p=13 HTTP/1.1" 200 9074 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.66 Safari/537.36"[Mon Dec 14 07:26:24.284191 2020] [:error] [pid 25] [client 192.168.74.1:27886] PIPPOZZO192.168.74.1 - - [14/Dec/2020:07:26:23 +0000] "GET /?p=13 HTTP/1.1" 200 9205 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.66 Safari/537.36"[Mon Dec 14 07:26:43.209619 2020] [:error] [pid 18] [client 192.168.74.1:27887] PIPPOZZO
```































